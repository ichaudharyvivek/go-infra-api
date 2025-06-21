package router

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestHealthCheckMC2(t *testing.T) {
	r := NewRouter()

	req, err := http.NewRequest("GET", "/mc2/api/v1/healthcheck", nil)
	assert.NoError(t, err, "Failed to create request")

	rr := httptest.NewRecorder()
	r.ServeHTTP(rr, req)

	assert.Equal(t, http.StatusOK, rr.Code, "Handler returned wrong status code")

	var response map[string]interface{}
	err = json.Unmarshal(rr.Body.Bytes(), &response)
	assert.NoError(t, err, "Failed to unmarshal healthcheck response")

	// Assert specific fields of the JSON response
	assert.True(t, response["success"].(bool), "Healthcheck 'success' field should be true")
	assert.Equal(t, "The server is working as intended. Let's go....", response["msg"], "Healthcheck 'msg' field is incorrect")
	assert.Contains(t, response, "timestamp", "Healthcheck response should contain 'timestamp'")

	t.Logf("Health check passed for mc1 router: %s", rr.Body.String())
}

func TestRootEndpointMC2(t *testing.T) {
	r := NewRouter()

	req, err := http.NewRequest("GET", "/", nil)
	assert.NoError(t, err, "Failed to create request")

	rr := httptest.NewRecorder()
	r.ServeHTTP(rr, req)

	// Since your router only explicitly defines /mc1/api/v1/healthcheck,
	// the root "/" path should result in a 404 Not Found.
	assert.Equal(t, http.StatusNotFound, rr.Code, "Root endpoint returned unexpected status code")
}

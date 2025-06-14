package config

type Conf struct {
	Server *ConfServer
}

func New() *Conf {
	return &Conf{
		Server: NewConfServer(),
	}
}

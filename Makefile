REBAR=$(shell which rebar || echo ./rebar)

default: fast

all:    $(REBAR)
	$(REBAR) get-deps
	$(REBAR) compile

normal:
	$(REBAR) compile

fast:
	$(REBAR) compile skip_deps=true

clean:  $(REBAR)
	$(REBAR) clean
	make distclean

sh: normal
	erl -pa ebin/ -eval "c:m(sh)."

# Detect or download rebar

REBAR_URL=http://cloud.github.com/downloads/basho/rebar/rebar
./rebar:
	erl -noshell -s inets -s ssl \
	-eval 'httpc:request(get, {"$(REBAR_URL)", []}, [], [{stream, "./rebar"}])' \
		-s init stop
	chmod +x ./rebar

distclean:
	rm -f ./rebar

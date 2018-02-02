
.PHONY: test-rest
test-rest:
	sh rest/run-tests.sh

.PHONY: test-ui-chrome
test-ui-chrome:
	sh ui/run-tests.sh testChrome

.PHONY: test-ui-firefox
test-ui-firefox:
	sh ui/run-tests.sh testFirefox

.PHONY: test-ui
test-ui: | test-ui-chrome test-ui-firefox

.PHONY: test
test: | test-rest test-ui
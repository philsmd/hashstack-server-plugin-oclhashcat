all:

install:
	mkdir -p $(DESTDIR)/opt/hashstack/server/config
	mkdir -p $(DESTDIR)/opt/hashstack/server/files/scrapers
	install -m 0644 config/hashcat.json $(DESTDIR)/opt/hashstack/server/config/
	install -m 0755 scrapers/* $(DESTDIR)/opt/hashstack/server/files/scrapers/

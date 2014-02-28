From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Help running latest linux-omap kernel on Nokia N810
Date: Fri, 28 Feb 2014 09:00:41 +0200
Message-ID: <53103419.8080802@ti.com>
References: <c57950d5cfbbdcf952b9fceb4cd243d4@doppler.thel33t.co.uk> <20140226185331.GA17632@earth.universe> <20140226212927.GB671@drone.musicnaut.iki.fi> <530EE6F2.7040903@ti.com> <277ac9055a67992eb1c03e89788afebf@doppler.thel33t.co.uk> <20140227193802.GC671@drone.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="w1HTdt5ruG9dAEiKj0klkfQvrMrlTPrKV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38952 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbaB1HBA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Feb 2014 02:01:00 -0500
In-Reply-To: <20140227193802.GC671@drone.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Leigh Brown <leigh@solinno.co.uk>
Cc: Sebastian Reichel <sre@ring0.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--w1HTdt5ruG9dAEiKj0klkfQvrMrlTPrKV
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 27/02/14 21:38, Aaro Koskinen wrote:
> Hi,
>=20
> On Thu, Feb 27, 2014 at 08:19:06AM +0000, Leigh Brown wrote:
>> Did that driver work on the N810 at that point?  If I look at the kern=
el
>> tree at that point in time would all the components be there?  It woul=
d
>> make it easier if I had a starting point as I don't have any documenta=
tion
>> so reading the old source code is the only way I can figure out how th=
ings
>> work(ed).
>=20
> OpenWRT has patches to make the old blizzard driver work:
>=20
> http://git.openwrt.org/?p=3Dopenwrt.git;a=3Dtree;f=3Dtarget/linux/omap2=
4xx/patches-3.3;h=3Dc0cece34bf0a5f37496015c8e76c7eae636efe06;hb=3DHEAD
>=20
> See 310-n810-lcd.patch, and also you will need at least
> 312-no-hwmod-reset.patch, otherwise the HW won't respond at all.
>=20
> There is no known kernel tree with "new" (now deleted) panel-n8x0 that
> would work on N8x0.
>=20
> So probably the easiest route would be to take the old blizzard driver,=

> forward port it to current kernel (the old omapfb is still supported)

The old omapfb driver (drivers/video/omap/) only supports omap1. The
unused omap2 code was removed.

What I would probably do is get an old kernel that has working display.
Then add some hacks to get register dumps for RFBI, blizzard and the
panel, and see what gpios, regulators, etc are turned on and connected
to blizzard or the panel.

And then just start from scratch with the latest kernel, copy-pasting
parts of the driver.

That's more or less what I did when I made the N800 display work with
the new omapfb and omapdss (drivers/video/omap2/).

 Tomi



--w1HTdt5ruG9dAEiKj0klkfQvrMrlTPrKV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTEDQZAAoJEPo9qoy8lh718xgP/2XMp3Srd6NwBjMH/nAgeFGS
WDqs/YxrPPKW72sea5ARO+HOg6Mq+T7N9BroYt+w3HIgY5mssAwzxUUxeYxcyujP
kl+DaY/vQVSaKEO7aUoupRoJimJd4gIahWzpeIkitr68hezqiSylYOD3LKg8nSz5
PIffTo1nj0w4r4j5c1oGhi9MbvEqXlfddGxNckW5yDOChsmwObONyMOIPlgqz45x
dzgbm2nmikTcUyiVhMVs4VZ5R7qJRCpLytFo54ZWIpKLCwQmh8dAEsFjW/xTCjFL
qHLPntCy6vjz9I4354s7jLcv2rWMFM9UeynUwWzS+3Sv1XaDPSSyjL9WEqkirm3M
JPyoB0d0mcIGkOpAYJco+csRmk0B5vUlWPGAE7XjLJt3HtPr4kjbElvZgBCN5YJf
FBdRul74jTC+UmUXdeWYHI7tZ24uJUHVcs3rTDdbm7Tvd3VFGZNiF+kpUnm8ambT
NP2IJqs65kZoIboCUF6cYOUSOAq4YyvM45RoKKTEvs2esrkYUWjasP5dhpaN3bQX
2adq4sSyrdCUeQG8SnmV+4lJejMWgvsI3sW1R1sN3OpKU6k1bpky6FHpPXqw346Q
skyNX1hVX3/gEiRDgwQfgpgiiQ0rMZExAGtrGuflYhs4qFt6LLEfmyWTx4LF1F1j
+NoHr00kIOE994TGMmKV
=T9KC
-----END PGP SIGNATURE-----

--w1HTdt5ruG9dAEiKj0klkfQvrMrlTPrKV--

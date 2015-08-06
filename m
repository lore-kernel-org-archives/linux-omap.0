From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
Date: Thu, 6 Aug 2015 12:00:18 +0100
Message-ID: <20150806110018.GS20873@sirena.org.uk>
References: <55BEF4AF.5090704@ti.com>
 <20150804155148.GR20873@sirena.org.uk>
 <55C0FD98.1090107@ti.com>
 <20150805115013.GJ20873@sirena.org.uk>
 <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com>
 <20150805124412.GN20873@sirena.org.uk>
 <CAOMqctS9Y5FxpUCCJew6+cnjH5iTvbzkH3g-8yrXs4OuS2pSGA@mail.gmail.com>
 <20150806090202.GO20873@sirena.org.uk>
 <CAOMqctQZRZ4zG_yYy=CeX3DX4NVNWN1COP4Q-2YvMun9xYOA7g@mail.gmail.com>
 <20150806102225.GI7576@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4dezoEM3dweX1vMa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150806102225.GI7576@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Michal Suchanek <hramrach@gmail.com>, "R, Vignesh" <vigneshr@ti.com>, devicetree <devicetree@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, Huang Shijie <b32955@freescale.com>, MTD Maling List <linux-mtd@lists.infradead.org>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--4dezoEM3dweX1vMa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 06, 2015 at 11:22:25AM +0100, Russell King - ARM Linux wrote:

> If that's the case, then maybe you should consider whether using the SPI
> bus infrastructure is really the best way forward.  Would it make more
> sense instead to adopt a different software structure, something more
> high-level like:

>      +-------------------------------------------+
>      |          m25p80 high-level driver         |
>      +----------------------+--------------------+
>      |   SPI m25p80 driver  |                    |
>      +----------------------+                    |
>      |      SPI layer       |  Special driver    |
>      +----------------------+                    |
>      |    SPI bus driver    |                    |
>      +----------------------+--------------------+
>      |     SPI hardware     |  Special hardware  |
>      +----------------------+--------------------+

Yes, that's what's been talked about before - for some of these devices
they're sufficiently flash specialist that we just don't bother exposing
a SPI interface at all though AIUI they could be persuaded to do it.  It
isn't entirely clear that we want exactly that split, if the devices are
reasonable SPI controllers we will want to handle the case where they
have flash and non-flash devices on the same bus.  For that there is
going to be some generalisable work possible for managing switching
between memory mapped and SPI modes where those are mutually exclusive,
especially if the switch between them isn't free.

--4dezoEM3dweX1vMa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVwz5CAAoJECTWi3JdVIfQ6VAH/114XYi5VzW0D8sB+8ukrq/A
bkJ/eHqojBMErmudkznI8zyirx0/R9p6sv3v8bz70HnNtQbBGNfUBX7o+fxaWnH2
tyXMxr1f51ZwKuZqJKritN/HZ1nN4N1JFgkfeYQm+KK+DoOVNj+AQAAhCrm2zvwi
CrmTBcgupZYme/sRSm9kwf9lXcxUr3VFXoeHiHik4FN3Mbt7YxDvyxqz6H+fkEFn
6UWXSuEdg2O/SJ4x7MHH/GFehqCSwyHPzXwhbt+/oOR/r61xg/99VA4z3kWsImp+
yZBkUPWdS5ZR4a3HzswVt39/t7/utQ02GG4GL4gO5z4brnMN2hgmCI9v/v6Jja8=
=JvaZ
-----END PGP SIGNATURE-----

--4dezoEM3dweX1vMa--

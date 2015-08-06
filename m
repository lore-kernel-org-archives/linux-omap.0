From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
Date: Thu, 6 Aug 2015 17:03:50 +0100
Message-ID: <20150806160350.GX20873@sirena.org.uk>
References: <20150804155148.GR20873@sirena.org.uk>
 <55C0FD98.1090107@ti.com>
 <20150805115013.GJ20873@sirena.org.uk>
 <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com>
 <20150805124412.GN20873@sirena.org.uk>
 <CAOMqctS9Y5FxpUCCJew6+cnjH5iTvbzkH3g-8yrXs4OuS2pSGA@mail.gmail.com>
 <20150806090202.GO20873@sirena.org.uk>
 <CAOMqctQZRZ4zG_yYy=CeX3DX4NVNWN1COP4Q-2YvMun9xYOA7g@mail.gmail.com>
 <20150806112353.GT20873@sirena.org.uk>
 <CAOMqctQKc6f5Mbe_CSd-ghguUfZvf6v_BRvYxQJVqPne73iESA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7+SiJqgcYR1fH3/L"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctQKc6f5Mbe_CSd-ghguUfZvf6v_BRvYxQJVqPne73iESA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Suchanek <hramrach@gmail.com>
Cc: "R, Vignesh" <vigneshr@ti.com>, devicetree <devicetree@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, Huang Shijie <b32955@freescale.com>, MTD Maling List <linux-mtd@lists.infradead.org>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--7+SiJqgcYR1fH3/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 06, 2015 at 01:42:32PM +0200, Michal Suchanek wrote:
> On 6 August 2015 at 13:23, Mark Brown <broonie@kernel.org> wrote:

> > Sure, but at the end of the day it's just emitting standard SPI messages
> > which don't know anything about flash.  If those messages are a sensible
> > interface here then why bother with the flag, we can just pattern match
> > on the format of the message.  If that doesn't work then probably this
> > isn't a great interface and a separate, application specific interface
> > makes more sense.

> The messages are sensible interface for communicating with a device
> that interprets a particular part of the mesasge as address and
> another particular part of the message as command and sends same
> amount of junk before reply as the flash chip would. If your device

That's just a statement that it's possible to do things this way, it's
not clear to me that it's an explanation as to why it is sensible to do
so - the obvious thing to do there would be to specify the flash
operation as a flash operation rather than reverse engineer the flash
operation from the wire format.

> happens to send reply immediately part of it is trashed. If it happens
> to interpret address differently the data ends up in random part of
> your memory. So no, that is not something you can autodetect.

If this stuff doesn't appear in the spi_message in some observable form
then I'd expect that any existing flash support is broken since a SPI
controller that doesn't have any acceleration is just going to do what
the message says.

> At the end of the day you have valid SPI messages but the m25p80 layer
> adds interpretation to those messages which may not always give
> correct result.

Which comes back to the thing I keep saying about needing some sort of
information about what the flag means and the questions about why this
is a good interface...

> On the other hand, if you ever get to m25p80 or spi-nor you can assume
> any message you send goes to a flash chip and insist that the
> controller uses the flash-specific interface.

There's an awful lot of flashes out there connected to controllers that
don't implement any sort of acceleration for flash, I'm not convinced
that your assumption there is valid.

> If there is possibility of connecting different kind of devices to
> multiple chipselects on the same master then you probably want to
> select this option per message or per slave.

We definitely need to account for that.

--7+SiJqgcYR1fH3/L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVw4ViAAoJECTWi3JdVIfQbM4H/RY/VF5HAbtQ/1Ww6OtlMWLZ
nz4M4lYZY6ewHN29PQRX47yMovTe3ZPso9FZCUm2uHvbp1+SLhWTe4YIFev9CraA
+0kSyaNwHcPAEOc+MdGiDmu7XqNuqWL/eAWTafyzSpstDZ2bBziE0FXQvul3abss
XAszRbb5Jk0Rd5IGA+zL+Njnv54lQcEgMojkssWxDXi6Qb0GTK1VxDwvROuWazOK
FFUwi1NhSxK7+X6SH4xt4aKQqj4LKmX9zGGfQA+aeq4NpTwcHI339iWYDvSZaeaf
1TbevBGafIPcPy+FrVDzTEn0mf9sxzZV3jVJ6BBbhieRekau/s4tlKs2U1O8lxY=
=eX3o
-----END PGP SIGNATURE-----

--7+SiJqgcYR1fH3/L--

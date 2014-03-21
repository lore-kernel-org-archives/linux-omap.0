From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC] possible removal of omap-serial
Date: Thu, 20 Mar 2014 20:35:57 -0500
Message-ID: <20140321013557.GB29691@saruman.home>
References: <20140320235210.GB26964@saruman.home>
 <20140321001228.GA18131@kroah.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140321001228.GA18131@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-serial@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 20, 2014 at 05:12:28PM -0700, Greg KH wrote:
> On Thu, Mar 20, 2014 at 06:52:10PM -0500, Felipe Balbi wrote:
> > Hi folks,
> >=20
> > I've been toying with the idea of removing
> > drivers/tty/serial/omap-serial.c since that's, to put it bluntly, an
> > ungly copy of 8250 driver.
> >=20
> > The original concern was wrt suspend/resume but I think it'd be a far
> > better approach to implement runtime PM in 8250 and write a rather small
> > 8250-omap.c glue (much like 8250-acorn.c or 8250-dw.c) just to get the
> > OMAP-specific details out of the way.
> >=20
> > The question I have is: omap-serial.c calls the serial devnodes ttyO\d,
> > instead of ttyS\d so removing omap-serial.c would have a direct impact
> > in userland. I wonder if it's an acceptable "regression" considering
> > we'd be able to reuse 8250 gaining proper Flow Control support, proper
> > DMA support, years and years of bug-fixes, etc.
>=20
> Breaking device node names is a contentious issue for serial ports, I
> don't think you can do that :(

would an upstream udev rule creating a symbolic link from ttyO to ttyS
be enough ?

I didn't test this yet but I guess this is enough (?)

KERNEL=3D=3D"ttyO[0-9]", GROUP=3D"dialout", SYMLINK+=3D"ttyS"

--=20
balbi

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTK5d9AAoJEIaOsuA1yqRECkUP/R/S5/Pol15v1Vus/GDw1y5Y
pD9cwFlZVW/xKFaG2PlXzjR6Vo6PP3X6XqhB4Xn6PlQ9zkvDPnBeSsaF8j/1X8CZ
tdixqVRy6Y1Vjv1FipN2LF6ovfzu4VSAdCwI3M0GPc6aIOV23CmRw8O796/0CSNf
0HNE+t2Li2kQ9kSOxVnnAUyvXH2m2BEpdEB7l79J1OpmCnwYHYVyJuONhiNU8xUm
VoZ99tqbkk3z4PcYYKpKz4UykMItTtW5p8uTiPJSrT+9TCbNDv6B2FdxpYVn5XQL
JwZQSOSknJfn0SydmxTE3WsZmS1yIwlMpvZUqY097Kxt4MA7zH6Sen3FaaV4Ob0a
Px2p20Vk/NgW/cb04kQ6yAxwwMqjg8aHW/5H6aHU+NxMeN3uNuVYUt0Ta74sqjJo
Mjg9DV05or0nwGnojcSlT19w2otB8cKawj7+z0H2jTCMD9V4NaBXjoHcfq8RkX5J
OxknsQmwqpnSTpdkBE+9mf1tdM9zOrXpubZU1MC++Avufuxj0sNJZZqI3A3ws4z8
5eYYz43Yu3zBEjUppWQWI7340tnm3qWcyKVOTEF7LWXUnp0NUbgAB8dgVfuaMzJl
rNiTpZqtnxchsTgSPft2CDt9j3pP4nq5tb2X226gXCBtCotXL8/4MpgRv5DV88la
OHV6vQTq4zZq+uQ0WwHc
=4qZN
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--

From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/5] i2c: omap: remove omap_i2c_isr() hw irq handler
Date: Wed, 19 Jun 2013 22:44:46 +0300
Message-ID: <20130619194446.GG4779@arwen.pp.htv.fi>
References: <1370630768-4077-1-git-send-email-grygorii.strashko@ti.com>
 <1370630768-4077-6-git-send-email-grygorii.strashko@ti.com>
 <20130607190750.GF15295@arwen.pp.htv.fi>
 <51C1FBC5.1030109@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m972NQjnE83KvVa/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51C1FBC5.1030109-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--m972NQjnE83KvVa/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2013 at 09:43:17PM +0300, Grygorii Strashko wrote:
> Hi Felipe,
>=20
> On 06/07/2013 10:07 PM, Felipe Balbi wrote:
> >Hi,
> >
> >On Fri, Jun 07, 2013 at 09:46:08PM +0300, Grygorii Strashko wrote:
> >>The omap_i2c_isr() does the irq check and schedules threaded handler if=
 any of
> >>enabled IRQs is active, but currently the I2C IRQs are enabled just onc=
e,
> >>when I2C IP is enabling (transfer started) and they aren't changed afte=
r that.
> >>More over, now the I2C INTC IRQ is disabled when I2C IP is idled.
> >>Thus, I2C IRQs will start coming only when we want that, and there is
> >>no sense to have omap_i2c_isr() anymore:
> >so ? we still want to check if this device generated IRQs in hardirq
> >context. What if the IRQ line is shared ?
> >
> Pleas see, https://patchwork.kernel.org/patch/2689211/
> [1/5] i2c: omap: fix spurious IRQs: disable/enable IRQ at INTC when idle
>=20
> It covers shared IRQ problem

then you don't need $SUBJECT.

--=20
balbi

--m972NQjnE83KvVa/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRwgouAAoJEIaOsuA1yqREakAP/2WXc2sDuaXyC1ELVK7kCotf
L6yU5J1N2CcvEPtfuHmupHXAuwpkdilbF5q3HPDYbpQr1eRRQG0UfezkC4Thgeui
nYRDLjkO3SIJFgJqErkO9bsa+x4LK3k7dnUmLZiCPC+JszFIv6LNHtLgazAqQ+0M
HkOr9QX8aaM9CasesiayxWpXUbrsx10tCH7dTLzMu1vgepB2I+0ZcyBMPauEVwun
69U+C4+6HfC5iUezBhMneSqV+sbpaYvrWLWGjd//e2BZU8/E4GrW+2V5IDevr0e0
k0GiFJtPxc7J+g2Q7QQnqqVZuZV6gbjzpPgGd1ek3zQjdw2HkpQzIbwB7xzwRNwn
yEIVO4jvS/yDe0IWgug3bs4fntjInMLYXeYxItcu79Zonw2KCpfFRr7WEOxqkfyC
dywHrp/SaQwxy0LIg+bNtINsm78OLtDGEHlGFQdskqfGfpVMXfPNSO0hbA6P0ftE
tVERl0pnYrZvjXUgyHVBK1Ea9jtqxdyKm5ROKuOnPj0DktKO9Au6tplgY0rV4Ky2
6RJaYD3P8R8VrpFWx+gL3BgeydhTqQk576N98Dp2x4rw1SKMOhoc0qKdF3pb0eq4
ujR8o0hZeQ0iVfRnTvn0SHZBe1dinzHOLbszJA4hDFSVjPU2zio8vEhjkKor2BbC
FLqFd1pJ91aEBDRJX5tD
=EtuX
-----END PGP SIGNATURE-----

--m972NQjnE83KvVa/--

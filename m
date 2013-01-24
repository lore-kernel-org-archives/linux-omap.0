From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/6] i2c: omap: also complete() when stat becomes zero
Date: Thu, 24 Jan 2013 11:37:56 +0200
Message-ID: <20130124093756.GG27304@arwen.pp.htv.fi>
References: <20130123095813.GG3767@nekote.pengutronix.de>
 <1358936588-16375-1-git-send-email-balbi@ti.com>
 <1358936588-16375-3-git-send-email-balbi@ti.com>
 <20130124090511.GB23053@blackmetal.musicnaut.iki.fi>
 <20130124091339.GF27304@arwen.pp.htv.fi>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I3tAPq1Rm2pUxvsp"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130124091339.GF27304-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--I3tAPq1Rm2pUxvsp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 24, 2013 at 11:13:39AM +0200, Felipe Balbi wrote:
> On Thu, Jan 24, 2013 at 11:05:11AM +0200, Aaro Koskinen wrote:
> > On Wed, Jan 23, 2013 at 12:23:04PM +0200, Felipe Balbi wrote:
> > > In case we loop on IRQ handler until stat is
> > > finally zero, we would end up in a situation
> > > where all I2C transfers would misteriously
> > > timeout because we were not calling complete()
> > > in that situation.
> >=20
> > This is wrong, you may still have bytes to transfer,
> > but a new interrupt has not arrived yet.
> >=20
> > This patch also breaks bisection; if you just apply patches 1-2 of
> > this series the I2C does not work at all.
>=20
> probably another n900-thing. What I had seen is that we could endup in a
> situation where we wouldn't "break" out of the look, and rather would
> fall in the "goto out" when STAT register is zero. In that case, even if
> we had transferred all bytes, we wouldn't call complete() and, thus, our
> commands would timeout.
>=20
> Care to send console logs of the error you have seen ? I kinda doubt we
> can fall into the situation you described above where IRQ hasn't been
> updated to STAT register.

BTW, check what happens if you just revert that commit.

--=20
balbi

--I3tAPq1Rm2pUxvsp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRAQD0AAoJEIaOsuA1yqRENXcP/0YjBgWWeZTWkcKgbxt9PhO3
18zyaL51EbsoUi/1SOQS2+TFJLWw0xtU3kISDJ+8XThWXA4Xjtd0GRzSMZIGKX4c
j3nuMjyyV2BvwoJlgrNbTtwqzou8VZIoOkIcR35HBCACSejA6g9MJhP50ioaE4Tj
KwlvoebmRuEqGkTvCN7EpM6fzZmaKgyKwsYO+h+Ld6OPgUH56MMYn0Hb2p/QF6G7
fIlL3lVpu6sx8o5vWPQfutsfAwkzSvneZX+uzqrjPCpyoLrBVeO3xgH/TVBvulUt
MFyAtj9Gis11rGZYx5mcOHyV+O3NQrZRUOsiytc43RXaZMm8p3YaYzm/dKOjNp/1
sne5qoJqSYVSWk2TcY839vkuA1rfV/X4/ibWny3XxJ0PqnBLDq7e+8YthuA4Mdxc
+1Al7ZYpeEUazoor6w52TXfTmx4K8m+wcRpcsfpIhLI/cNKrS7RODSmkhbRl7JMJ
TL30az9/8+JWWkufZy6efdh5e+SYlj+8DJ8Ule1RQT/M0H6rJ9s5+8RaAVzSiD3F
zI95PEmwIq5lZBKzrF+TDB2SiOGm4Gmb5OeLKP+KMyjKMlSMtvjbdk2OR+b+cob3
0hMVuk/mAejXb0kpuIb61bv8XBxwQda42heFIOkQuhzDJh8qGmIsMcJX7I+uBgsc
QOvPZNueSeLe6ZoAW/WD
=MNGF
-----END PGP SIGNATURE-----

--I3tAPq1Rm2pUxvsp--

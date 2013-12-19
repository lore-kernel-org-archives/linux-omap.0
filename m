From: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/4] OMAPDSS: DT support for N900 panel
Date: Thu, 19 Dec 2013 14:56:09 +0100
Message-ID: <20131219135608.GA11654@earth.universe>
References: <1386958650-2404-1-git-send-email-sre@debian.org>
 <52AFFF3F.7020807@ti.com>
 <20131217171412.GA10442@earth.universe>
 <52B089FE.8060704@ti.com>
 <20131218215536.GA23674@earth.universe>
 <20131219005151.GA27928@earth.universe>
 <52B2848A.80807@ti.com>
 <20131219100840.GA923@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131219100840.GA923-SfvFxonMDyemK9LvCR3Hrw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2013 at 11:08:40AM +0100, Sebastian Reichel wrote:
> > Are you able to check if the bootloader muxes dat3 to SDI mode?
>=20
> The bootloader's source code is not available as far as i know.
>=20
> [...], but I get an external abort on non-linefetch.
> So I can't check it :(

Ok. This is fixed by applying [0] (Thanks for the hint, Tomi!).
This is the mux configuration from the bootloader:

=2E..
pin 96 (480020f0.0) 00000001 pinctrl-single     // sdi dat1n
pin 97 (480020f2.0) 00000001 pinctrl-single     // sdi dat1p
pin 98 (480020f4.0) 00000001 pinctrl-single     // sdi dat2n
pin 99 (480020f6.0) 00000001 pinctrl-single     // sdi dat2p
pin 100 (480020f8.0) 00000007 pinctrl-single    // sdi dat3n
pin 101 (480020fa.0) 00000007 pinctrl-single    // sdi dat3p
pin 102 (480020fc.0) 00000004 pinctrl-single=20
pin 103 (480020fe.0) 00000004 pinctrl-single=20
pin 104 (48002100.0) 00000004 pinctrl-single    // sdi vsync
pin 105 (48002102.0) 00004104 pinctrl-single    // sdi hsync
pin 106 (48002104.0) 00000004 pinctrl-single    // sdi den
pin 107 (48002106.0) 00000004 pinctrl-single    // sdi stp
pin 108 (48002108.0) 00000001 pinctrl-single    // sdi clkp
pin 109 (4800210a.0) 00000001 pinctrl-single    // sdi clkn
=2E..

I guess the following entry should be added to the omap3-n900.dts file:

	dss_sdi_pins: pinmux_dss_sdi_pins {
		pinctrl-single,pins =3D <
			0x0c0 (PIN_OUTPUT | MUX_MODE1)   /* dss_data10.sdi_dat1n */
			0x0c2 (PIN_OUTPUT | MUX_MODE1)   /* dss_data11.sdi_dat1p */
			0x0c4 (PIN_OUTPUT | MUX_MODE1)   /* dss_data12.sdi_dat2n */
			0x0c6 (PIN_OUTPUT | MUX_MODE1)   /* dss_data13.sdi_dat2p */
			0x0d8 (PIN_OUTPUT | MUX_MODE1)   /* dss_data22.sdi_clkp */
			0x0da (PIN_OUTPUT | MUX_MODE1)   /* dss_data23.sdi_clkn */
		>;
	};

[0] https://patchwork.kernel.org/patch/3283781/

-- Sebastian

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSsvr4AAoJENju1/PIO/qaEJwP/3IrY8rv8mYjj81OR9/S9j+T
h0+LyESGrjM+UNwl9iG5xKbq3S1/4MYfj13CdMDaLPpYtvtXZR+P5mi5Jkfn9Z4p
yaeXZqoo0PYStg+DYrcRNzpqJwFY9nQUcL+EnSX2pBhoNaSEbdPF/4gjF05I9H8d
tixxFkk/dFneDtYpZaE08mX5jKy/NAoer1kSVniILvTps/8x+YUF9bxvDdB/MPZo
Vp7qtpORyBBNYZ7DG56sgnqnt+BnfRK8jqHOq+AvayFT4nGcdzmKEXKtYo4J9CvA
XLOkdCYHn3KKMVRgoQRC3pj2xwG6RJB3G+lDoRpQEg3Mt4mLhiV2axqWhzblHrgC
O6+htgErNnBkoMfP96tg1y1rXfn7AlNd2UNMXuSPCz4bY5smN39UkB9889i1Q3iW
ZCEWigCpKtOvsaAvhPG7Fp0FufjXviCf3/KbV0i5VROHki60CTvyCTg7Mz+HuRed
3aboQGfZTah+HKgsw+YmGdvYRWpBM3vCOxvBoVq8gEXl6SdgWAE7G5l89DXc9M9f
ylH7BLwUXdKu8wYDItfhqTS3CFvrOemHqzuN0XZjIPgaghm6Myb2u5mFJsfKOzZG
svPVwhQx9BIpU7qarrjvDS0G2vrS4MWx4rHgpQBVpNY73GAw9ND2J3yjLXDBQ8wp
4GNMnEBqOwmzLxi1ZkK7
=JRaT
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

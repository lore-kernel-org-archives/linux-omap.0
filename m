From: Sebastian Reichel <sre@debian.org>
Subject: Re: [PATCH 0/4] OMAPDSS: DT support for N900 panel
Date: Thu, 19 Dec 2013 01:51:52 +0100
Message-ID: <20131219005151.GA27928@earth.universe>
References: <1386958650-2404-1-git-send-email-sre@debian.org>
 <52AFFF3F.7020807@ti.com>
 <20131217171412.GA10442@earth.universe>
 <52B089FE.8060704@ti.com>
 <20131218215536.GA23674@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:57673 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877Ab3LSAv7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Dec 2013 19:51:59 -0500
Content-Disposition: inline
In-Reply-To: <20131218215536.GA23674@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2013 at 10:55:37PM +0100, Sebastian Reichel wrote:
> On Tue, Dec 17, 2013 at 07:29:34PM +0200, Tomi Valkeinen wrote:
> > >> I added N900 display DT support on top of my v2 series, including
> > >> pinmuxing. Can you check if it looks right and works?
> > >>
> > >> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/d=
ss-dt
> > >=20
> > > I just tried it and it does not work. On a first look the pinmuxing
> > > looks fishy: 0x0d4 is muxed two times.
> >=20
> > Hmm, so it is.
> >=20
> > I'm not really familiar with SDI, I just muxed all the SDI pins, except
> > datapair3. I previously thought that there's only the data and clock
> > pairs for SDI, but the TRM revealed more sdi pins, so I included them.
> > It is well possible that these can be removed:
> >=20
> > 0x0d0 (PIN_OUTPUT | MUX_MODE1)   /* dss_data18.sdi_vsync */
> > 0x0d2 (PIN_OUTPUT | MUX_MODE1)   /* dss_data19.sdi_hsync */
> > 0x0d4 (PIN_OUTPUT | MUX_MODE1)   /* dss_data20.sdi_den */
> > 0x0d6 (PIN_OUTPUT | MUX_MODE1)   /* dss_data21.sdi_stp */
>=20
> Just removing the dss_data20.sdi_den pin was enough to get a working disp=
lay. I
> don't know if the other pins are needed, because the display pins are alr=
eady
> muxed correctly by the bootloader.

I just had a look in the leaked n900 schematics. According to it the
following pins are connected to the display:

DSS_DATA20 (E28)     GPIO 90         LCD_RST
DSS_DATA10 (AD28)    SDI_DAT1N       CDP 0
DSS_DATA11 (AD27)    SDI_DAT1P       CDP 1
DSS_DATA12 (AB28)    SDI_DAT2N       CDP 2
DSS_DATA13 (AB27)    SDI_DAT2P       CDP 3
DSS_DATA14 (AA28)    SDI_DAT3N       CDP 4
DSS_DATA15 (AA27)    SDI_DAT3P       CDP 5
DSS_DATA22 (AC27)    SDI_CLKP        CDP 6
DSS_DATA23 (AC28)    SDI_CLKN        CDP 7

I also noticed that dss_data19.sdi_hsync is used as gpio 89 for the
N900's proximity sensor. Thus I suggest the following SDI pin muxing:

	dss_sdi_pins: pinmux_dss_sdi_pins {
		pinctrl-single,pins =3D <
			0x0c0 (PIN_OUTPUT | MUX_MODE1)   /* dss_data10.sdi_dat1n */
			0x0c2 (PIN_OUTPUT | MUX_MODE1)   /* dss_data11.sdi_dat1p */
			0x0c4 (PIN_OUTPUT | MUX_MODE1)   /* dss_data12.sdi_dat2n */
			0x0c6 (PIN_OUTPUT | MUX_MODE1)   /* dss_data13.sdi_dat2p */
			0x0c8 (PIN_OUTPUT | MUX_MODE1)   /* dss_data14.sdi_dat3n */
			0x0ca (PIN_OUTPUT | MUX_MODE1)   /* dss_data15.sdi_dat3p */

			0x0d8 (PIN_OUTPUT | MUX_MODE1)   /* dss_data22.sdi_clkp */
			0x0da (PIN_OUTPUT | MUX_MODE1)   /* dss_data23.sdi_clkn */
		>;
	};

-- Sebastian

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSskMnAAoJENju1/PIO/qa8KkP/1H+MvRaRnJ5HMUMrHV2VEEB
CG34CHu5wUNCbqGRsUup11j/BqRJOTDRGAZp7Qu13KRp7gN7ZcmlI52TF/UlC35N
KKJWkaVSLA4I8y5q/1VwZlUIsD8sBVahDIzcBzZSd7T4LzpEGD8U+5mvXpwiB324
5CjSw10nJ6zS/5yJhya/VWILbhf4mSOBQsBONhMiiPoJUtEk4RHyDDG8ljI2xf9n
cyfaVlcPf/ftaZ0wXeozzdq3EVGmngMc698ZQmWxjnb9NklguJUQJVYpDQClTy5X
wVah3flyqG2d/32dLJJLGyIiaIqvEcVIXidWGqayHUtC208pNVHDVbSuyeVo0LAg
3iF5P99E2SwdnC9BOFQoo2KGppskv97MN7qXkp/MMM8DGYgi+gWj8jX8/LmVlZUd
T8CBS08AekLsf4UQr9lqh8INLWCRYoLwtsXqZ1OVjySshVayQJgoYWR+XVweuX52
LDGxBgHVG3SwxhFJxHZu2CkCVcM66xrQHDNynL+evXr614f6mZdzL8+qzmj0S6Dz
Cbrp+HGy9Hg1u37Rn8am73i3UsBgln/no49ggqC/3ntuLTZYu82xscrcWENs/7fd
3YrtlPZO4kqSvPJOgYecDk+Fpr5nbXuy5wcFVF1/IHn3yPMfG6mKWPQWH7k4lyZV
sP8Jdpc4jzFgnb0LsIxY
=JEsS
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--

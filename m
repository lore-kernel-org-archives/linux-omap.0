From: Sebastian Reichel <sre@debian.org>
Subject: Re: [PATCH 0/4] OMAPDSS: DT support for N900 panel
Date: Thu, 19 Dec 2013 11:08:40 +0100
Message-ID: <20131219100840.GA923@earth.universe>
References: <1386958650-2404-1-git-send-email-sre@debian.org>
 <52AFFF3F.7020807@ti.com>
 <20131217171412.GA10442@earth.universe>
 <52B089FE.8060704@ti.com>
 <20131218215536.GA23674@earth.universe>
 <20131219005151.GA27928@earth.universe>
 <52B2848A.80807@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:59644 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751463Ab3LSKIn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Dec 2013 05:08:43 -0500
Content-Disposition: inline
In-Reply-To: <52B2848A.80807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2013 at 07:30:50AM +0200, Tomi Valkeinen wrote:
> On 2013-12-19 02:51, Sebastian Reichel wrote:
> > On Wed, Dec 18, 2013 at 10:55:37PM +0100, Sebastian Reichel wrote:
> >> On Tue, Dec 17, 2013 at 07:29:34PM +0200, Tomi Valkeinen wrote:
> >>>>> I added N900 display DT support on top of my v2 series, including
> >>>>> pinmuxing. Can you check if it looks right and works?
> >>>>>
> >>>>> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/=
dss-dt
> >>>>
> >>>> I just tried it and it does not work. On a first look the pinmuxing
> >>>> looks fishy: 0x0d4 is muxed two times.
> >>>
> >>> Hmm, so it is.
> >>>
> >>> I'm not really familiar with SDI, I just muxed all the SDI pins, exce=
pt
> >>> datapair3. I previously thought that there's only the data and clock
> >>> pairs for SDI, but the TRM revealed more sdi pins, so I included them.
> >>> It is well possible that these can be removed:
> >>>
> >>> 0x0d0 (PIN_OUTPUT | MUX_MODE1)   /* dss_data18.sdi_vsync */
> >>> 0x0d2 (PIN_OUTPUT | MUX_MODE1)   /* dss_data19.sdi_hsync */
> >>> 0x0d4 (PIN_OUTPUT | MUX_MODE1)   /* dss_data20.sdi_den */
> >>> 0x0d6 (PIN_OUTPUT | MUX_MODE1)   /* dss_data21.sdi_stp */
> >>
> >> Just removing the dss_data20.sdi_den pin was enough to get a working d=
isplay. I
> >> don't know if the other pins are needed, because the display pins are =
already
> >> muxed correctly by the bootloader.
> >=20
> > I just had a look in the leaked n900 schematics. According to it the
> > following pins are connected to the display:
> >=20
> > DSS_DATA20 (E28)     GPIO 90         LCD_RST
> > DSS_DATA10 (AD28)    SDI_DAT1N       CDP 0
> > DSS_DATA11 (AD27)    SDI_DAT1P       CDP 1
> > DSS_DATA12 (AB28)    SDI_DAT2N       CDP 2
> > DSS_DATA13 (AB27)    SDI_DAT2P       CDP 3
> > DSS_DATA14 (AA28)    SDI_DAT3N       CDP 4
> > DSS_DATA15 (AA27)    SDI_DAT3P       CDP 5
> > DSS_DATA22 (AC27)    SDI_CLKP        CDP 6
> > DSS_DATA23 (AC28)    SDI_CLKN        CDP 7
> >=20
> > I also noticed that dss_data19.sdi_hsync is used as gpio 89 for the
> > N900's proximity sensor. Thus I suggest the following SDI pin muxing:
> >=20
> > 	dss_sdi_pins: pinmux_dss_sdi_pins {
> > 		pinctrl-single,pins =3D <
> > 			0x0c0 (PIN_OUTPUT | MUX_MODE1)   /* dss_data10.sdi_dat1n */
> > 			0x0c2 (PIN_OUTPUT | MUX_MODE1)   /* dss_data11.sdi_dat1p */
> > 			0x0c4 (PIN_OUTPUT | MUX_MODE1)   /* dss_data12.sdi_dat2n */
> > 			0x0c6 (PIN_OUTPUT | MUX_MODE1)   /* dss_data13.sdi_dat2p */
> > 			0x0c8 (PIN_OUTPUT | MUX_MODE1)   /* dss_data14.sdi_dat3n */
> > 			0x0ca (PIN_OUTPUT | MUX_MODE1)   /* dss_data15.sdi_dat3p */
> >=20
> > 			0x0d8 (PIN_OUTPUT | MUX_MODE1)   /* dss_data22.sdi_clkp */
> > 			0x0da (PIN_OUTPUT | MUX_MODE1)   /* dss_data23.sdi_clkn */
> > 		>;
> > 	};
>=20
> Thanks, I'll do the modifications. The dat3 lines are not needed, but if
> they're connected to the panel, I don't see any harm in muxing them.
>=20
> Although, makes me wonder. If the panel supports only 2 datalanes, why
> does it have connectors for 3? And if it supports 3, why would N900 use
> only 2?

I wondered about the same and I also assumed, that the muxing should be
safe.

> Are you able to check if the bootloader muxes dat3 to SDI mode?

The bootloader's source code is not available as far as i know.

I tried to cat /sys/kernel/debug/pinctrl/48002030.pinmux/pins, but I
get an external abort on non-linefetch.

So I can't check it :(

-- Sebastian

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSssWoAAoJENju1/PIO/qaRlYP/1r8O2gF5dLCKccRxTHnnnOK
q3324xmNpKkCF90BzVvsdc+xFyXKPVSSHkKgRZOLhHJm7woxU4PAfgwTimTiEg6L
VbOAcmp/nt5paxzbvrgvhUCF+sJ1yRXTUG4+bpw9G/+F7h5DBQ4T6aSYSxk5hStN
G3etXLTPPvtDTRMu1OKmlQLYJqlcriG1irYRkLYFDqT243YyCPWscxqfzvJdX9Mg
AYq+GHz2eCJMFXhyczbrmqUejnxISxwI+mRp2wxgXPS6HjRk7p1F41BV5pp/C9cK
enikgRxZ/zwaDqjwLY7jqD20nGuguEM0eH5yn5tJJP3YIsBX3MCALB49JXhPOCGj
KTmNCSvRPW9x6tSDuT3xogibgR+BhWDG4+JZnOnK3qFgN1gKCffLL/Gcp9dA1by3
+8plEAbSFyTlzwjkdKfmIktBFa9D9pzOAyMmS56+IslBUGEx9w4nxdI7mLCqImZ9
FotUx6MoidjvJoFQIFBhk+6pYkGqFpL8bIiXxybgHyHMgNIdTyF34uBvZ1nfh1RG
erX+b2XDQnNVaqbKWCApIb+ECjpHdvPKlpUiplUBkHsrVM+9bWLeNI7pnvs1vNwl
su0CZursj6uqNiGPbejod6uxJ5yR2pBLTdfDjVl5nKQ0KDs1AMouyfkjJvVPEoho
xx5EbiwDu5jBipCkdkck
=DRO3
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--

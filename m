From: Sebastian Reichel <sre@debian.org>
Subject: Re: [PATCH 0/4] OMAPDSS: DT support for N900 panel
Date: Wed, 18 Dec 2013 22:55:37 +0100
Message-ID: <20131218215536.GA23674@earth.universe>
References: <1386958650-2404-1-git-send-email-sre@debian.org>
 <52AFFF3F.7020807@ti.com>
 <20131217171412.GA10442@earth.universe>
 <52B089FE.8060704@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:56953 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753907Ab3LRVzm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Dec 2013 16:55:42 -0500
Content-Disposition: inline
In-Reply-To: <52B089FE.8060704@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2013 at 07:29:34PM +0200, Tomi Valkeinen wrote:
> >> I added N900 display DT support on top of my v2 series, including
> >> pinmuxing. Can you check if it looks right and works?
> >>
> >> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss=
-dt
> >=20
> > I just tried it and it does not work. On a first look the pinmuxing
> > looks fishy: 0x0d4 is muxed two times.
>=20
> Hmm, so it is.
>=20
> I'm not really familiar with SDI, I just muxed all the SDI pins, except
> datapair3. I previously thought that there's only the data and clock
> pairs for SDI, but the TRM revealed more sdi pins, so I included them.
> It is well possible that these can be removed:
>=20
> 0x0d0 (PIN_OUTPUT | MUX_MODE1)   /* dss_data18.sdi_vsync */
> 0x0d2 (PIN_OUTPUT | MUX_MODE1)   /* dss_data19.sdi_hsync */
> 0x0d4 (PIN_OUTPUT | MUX_MODE1)   /* dss_data20.sdi_den */
> 0x0d6 (PIN_OUTPUT | MUX_MODE1)   /* dss_data21.sdi_stp */

Just removing the dss_data20.sdi_den pin was enough to get a working displa=
y. I
don't know if the other pins are needed, because the display pins are alrea=
dy
muxed correctly by the bootloader.

-- Sebastian

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n90=
0.dts
index 39e5e50..33f29ac 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -163,7 +163,7 @@
=20
                        0x0d0 (PIN_OUTPUT | MUX_MODE1)   /* dss_data18.sdi_=
vsync */
                        0x0d2 (PIN_OUTPUT | MUX_MODE1)   /* dss_data19.sdi_=
hsync */
-                       0x0d4 (PIN_OUTPUT | MUX_MODE1)   /* dss_data20.sdi_=
den */
+                       //0x0d4 (PIN_OUTPUT | MUX_MODE1)   /* dss_data20.sd=
i_den */
                        0x0d6 (PIN_OUTPUT | MUX_MODE1)   /* dss_data21.sdi_=
stp */
                        0x0d8 (PIN_OUTPUT | MUX_MODE1)   /* dss_data22.sdi_=
clkp */
                        0x0da (PIN_OUTPUT | MUX_MODE1)   /* dss_data23.sdi_=
clkn */

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSshnXAAoJENju1/PIO/qaGLcQAJSHbXZGr154ETfkOy7NXugx
GrZrxqVMqlvPuYI+N4tOry2n0LkJpZFqi0Yyjdle+2rPheP7Tkfm8RWO/aioQMjY
1PDvgHCEfRuuV9o91ZsN6IuPwW0sO3aBjjHmiMO1u6xGFyxwgi/774Yp67j72UjW
cY7/P0w/jAis1XLV5y34Fas6YZIqeOtiRKpF5++iosozh3xWpWLMj/1N+oR9TrA8
hcGgpnhCPWsWCWl9U6GzRqNUS+FNDE8+WVJFsKR6Q5BOvRBmbo9SFWQjZA2Lnj2F
s71m7cdaSCq/Ers3BxV1TjiRHYHYTAGHz7u2egWDCXAFqkER9wUeA6k4TdfbZv1g
d+DH+i7j32H+jraRPq3ILwAk0KY6OuPjrwPC5HRACiAOevJXJbq1ItT2t5qOed9Q
0wIPeWoTaQiH8fId6HIsI0fd++wir9as51L6QiFzFddMqcif3KANLlFYdFo6H8MP
GQZP6LW5XpErNQ4IGHO/gO1FnQhEdwEEn6qz4BwG8cEhUwes2JHKtZCT9KbRw1hu
zHaO/mLPuhQ1vkIV3mJKb4CIA+JMG3F9p31jewZYqrR02Fhc3thWoCgNtyqO/yd0
77Py4n9QVdYvHulOP1Mtxewe2no37PTF3DAqPGp68nMHaITCOCBhHdcbUM7olNyH
p/rnWVxCge68nlJMumBC
=W9Qm
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--

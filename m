From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 2/3] ARM: omap: hwmod: get rid of all
 omap_clk_get_by_name usage
Date: Thu, 30 Aug 2012 19:42:13 +0300
Message-ID: <1346344933.2327.43.camel@deskari>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com>
	 <1346230576-20004-3-git-send-email-rnayak@ti.com>
	 <CAJOA=zM2sFsrdohooKp1+zsV_AK6dKnoN37+Gs2oskBUK4J00w@mail.gmail.com>
	 <503F26A4.3050902@ti.com> <503F5517.4010100@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-SKF4aaXgHUDF5+fdoWwR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:36953 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753850Ab2H3QmX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 12:42:23 -0400
Received: by lagy9 with SMTP id y9so1690449lag.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Aug 2012 09:42:16 -0700 (PDT)
In-Reply-To: <503F5517.4010100@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, "Turquette, Mike" <mturquette@ti.com>, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


--=-SKF4aaXgHUDF5+fdoWwR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-08-30 at 13:57 +0200, Benoit Cousson wrote:
> On 08/30/2012 10:39 AM, Rajendra Nayak wrote:
> > On Thursday 30 August 2012 05:45 AM, Turquette, Mike wrote:
> >> On Wed, Aug 29, 2012 at 1:56 AM, Rajendra Nayak<rnayak@ti.com>  wrote:
> >>> diff --git a/arch/arm/mach-omap2/clock44xx_data.c
> >>> b/arch/arm/mach-omap2/clock44xx_data.c
> >>> index d7f55e4..a3831a2 100644
> >>> --- a/arch/arm/mach-omap2/clock44xx_data.c
> >>> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> >>> @@ -3156,6 +3156,7 @@ static struct omap_clk omap44xx_clks[] =3D {
> >>>          CLK(NULL,       "dss_tv_clk",&dss_tv_clk,    CK_443X),
> >>>          CLK(NULL,       "dss_48mhz_clk",&dss_48mhz_clk, CK_443X),
> >>>          CLK(NULL,       "dss_dss_clk",&dss_dss_clk,   CK_443X),
> >>> +       CLK(NULL,       "dss_fck",&dss_fck,       CK_443X),
> >>>          CLK("omapdss_dss",      "ick",&dss_fck,       CK_443X),
> >>
> >> Is it right to re-use dss_fck for the "ick" here?  I think it is due
> >> to omap4 modulemode stuff but I don't have DM in front of me and
> >> wanted a double-check...
> >=20
> > yes, its because of the wierdness of DSS clocks where a so-called
> > optional clock is actually a function clock.
>=20
> Not only, it is a hack to allow the DSS to be enabled whenever a DSS
> submodule has to be enabled. Since they are sharing the ick, it will
> enable the modulemode when the DISPC will be enabled.
>=20
> That hack should disappear as soon as the DSS will be able to handle the
> PM dependency between DSS submodules and the DSS itself using pm_runtime
> parent/child link.
> And then we will have to remove this fake ick modulemode clock node and
> let hwmod handle that properly.
>=20
> Tomi already cleaned the DSS part, I guess it should be upstreamed soon,
> if this is not already the case.

This is in 3.5. omapdss_dss is now the parent for the rest of the dss
submodules, and runtime PM is being used.

I think we should now revisit this dss clock handling to see if there
are any other changes required in the omapdss side, but I hope they are
already according to our discussions and correct.

 Tomi


--=-SKF4aaXgHUDF5+fdoWwR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQP5flAAoJEPo9qoy8lh71iooP/10Kf7CoCe4/eXULZ6f9d4kM
R8x+z9DcDqpcqxywKtNYuiFvTQyNzDmb84AGBO1UaveKym3MmXwmYEBPHgTHzjdw
Q52r3+uRgTqkIF7O3R8A3jvlSoIo7FSNTCpiCpVF5FgdxccneubDgFNyJcx0R2Nv
AIfCdL0abCEFKCdppGXzUQcT3mUOd7zv9fTVDEAf2YklHDTEOrZVjpgm0zJEG/nY
p/5t/UL2NvS+3JeJjEAo4vmC4Ui1PGl0kleq8lF4FgyOn9cel3FPH77fUK7RDONj
2MDC0fepbu6c8/o8HLelSEBSXpsTTHmHUNnkfLD607O5uKg30xL8jfLYvvCPMMrL
ny/rcVPjBx4lUN4d837omUzB61Kp6iSxvh7pfFAAAcMfIip2C4/+1YsLIs+VBGbH
jUKxe9vo/XSDzv88Y5pQaoET9qPtaOz7brU3EEYLWnWTEihwtxjq7pC2NZboe/Ds
pc3j8MiSw0gqDKY86ebxKmjAp6gyvJwwjuZJ93n4QyDa0Zw4tRsiWXZpOvInn/lI
9S8NiA7YNOvfeuWLi/CWwtJJWmCzXRQmcoLUQHsESCB3deb3LK+QWQBG/L2skdQy
IEMrqpsNCZw901E6acQ888tiODS4fNgD8HXjLPa9cIcfazeN6e9HD9WOePHvA/cg
u72MOOFouk5caJ5yXKnQ
=RHTg
-----END PGP SIGNATURE-----

--=-SKF4aaXgHUDF5+fdoWwR--


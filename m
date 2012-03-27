From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V2 3/3] OMAPDSS: DISPC: Correct DISPC functional clock
 usage
Date: Tue, 27 Mar 2012 14:26:30 +0300
Message-ID: <1332847590.1867.149.camel@deskari>
References: <1332323530-9088-1-git-send-email-cmahapatra@ti.com>
	 <1332846215.1867.130.camel@deskari>
	 <CAF0AtAuxR6pa0y_kTgh454=joFoy_kG4XCnHAS94qkPk0+kLFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-ZZJrm/LNVgdAI5Dd2c/D"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:34822 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754235Ab2C0L0f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 07:26:35 -0400
Received: by lahi5 with SMTP id i5so7999428lah.39
        for <linux-omap@vger.kernel.org>; Tue, 27 Mar 2012 04:26:33 -0700 (PDT)
In-Reply-To: <CAF0AtAuxR6pa0y_kTgh454=joFoy_kG4XCnHAS94qkPk0+kLFw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>, Archit Taneja <archit@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org


--=-ZZJrm/LNVgdAI5Dd2c/D
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-03-27 at 16:44 +0530, Mahapatra, Chandrabhanu wrote:
> On Tue, Mar 27, 2012 at 4:33 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > On Wed, 2012-03-21 at 15:22 +0530, Chandrabhanu Mahapatra wrote:
> >> DISPC_FCLK is incorrectly used as functional clock of DISPC in scaling
> >> calculations. So, DISPC_CORE_CLK replaces as functional clock of DISPC=
.
> >> DISPC_CORE_CLK is derived from DISPC_FCLK divided by an independent DI=
SPC
> >> divisor LCD.
> >>
> >> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> >> ---
> >>  drivers/video/omap2/dss/dispc.c |   13 +++++++------
> >>  1 files changed, 7 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss=
/dispc.c
> >> index d8a1672..1fdac73 100644
> >> --- a/drivers/video/omap2/dss/dispc.c
> >> +++ b/drivers/video/omap2/dss/dispc.c
> >> @@ -1761,6 +1761,7 @@ static int dispc_ovl_calc_scaling(enum omap_plan=
e plane,
> >>                               dss_feat_get_param_max(FEAT_PARAM_LINEWI=
DTH);
> >>       const int max_decim_limit =3D 16;
> >>       unsigned long fclk =3D 0;
> >> +     unsigned long dispc_core_clk =3D dispc_mgr_lclk_rate(channel);
> >
> > Hmm, I don't think this is correct. dispc_mgr_lclk_rate() returns the
> > logic clock for the LCD output path. It's not DISPC core clock.
> >
> >  Tomi
> >
>=20
> As per the OMAP4 TRM DISPC_CORE_CLK is DISPC_FCLK / LCD factor and

Hmm? No it isn't. DISPC_CORE_CLK is DISPC_FCLK / LCD, where LCD is
defined in DISPC_DIVISOR register.

dispc_mgr_lclk_rate() returns the logic clock of an output, which is
LCD1_CLK / LCD1 or LCD2_CLK / LCD2. And LCD1 and LCD2 are defined in
DISPC_DIVISORo(n) register.

(Very confusing to have LCD mean a liquid-crystal-display and also
logic-clock-divisor =3D) I think we should rename them. Perhaps LCKD and
PCKD).

So the clocks for DISPC and for LCD outputs are totally separate ones,
on OMAP4. For OMAP2/3 they are the same.

That said, I have no idea which of the clock is used for what regarding
scaling calculations, and even less do I know how it's managed for
TV-out...

> dispc_mgr_lclk_rate() exactly does the same. Should we rename the
> function or have a separate fucntion for dispc_core_clk to avoid
> confusion?

I think we definitely should have a separate function, as it's a
separate clock. And I guess the places where FCKs and LCKs are used
should be verified so that they use the correct one. If somebody knows
what is the correct one (the TRM is a bit vague at times =3D).

 Tomi


--=-ZZJrm/LNVgdAI5Dd2c/D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPcaPmAAoJEPo9qoy8lh71eoYP/3LUt6uVj3yeWNoGEx8fgLsR
VRdKtuAFUzxmr+8v1jHbC47jVHu+BwH/bxAyGUj7e2j9ChUSlwvpT8BWz7d2RCLK
70JbL+2H/trosyVsT3rViwMxwMcWFgR6UCilm0ifdnXk/dikysoqoIwyG/CkiIIK
GAeyCvrJ1r+zneQwm6G63pszJQ+v+UivhTrhDTirys1mIwF800Wem9CVqYEknWSn
xbnYPq2nlsWqzRB787welpMDadznS5a65obGV40uHw3GOul2NQgcujiGKs4GFHjn
4jsSXU5sRvwIomqXq0Dr2lkMXHIW30X0tS6bCGdTudd1WHclLnq2412WV3lE/vv+
8z/smUbEHsQTfTBZT62TDf42lEMXaBSBeDYi0Ra6LtQoAFE5wZlZ4ymQAnrI5daK
DFLEvYGxz6AGukMt75FCcWG+huSgU2s8X9hnIMdUM6+Uxr7BOubJi5R9bCntPNJ7
LD0DpS0I+mYczvXtm1PS0GQrLC+5hL3va5K5qcLfLGRgki1qpedOxLo9mWPU0FTu
WFV79ivGtyn/mysIx/Td01L8WIyGPDzdtsAIO7Z7hgMqQtu4zBxkLtVk/HPG3/Os
AiORrd6ag1+HnTcnko9TWEtnW6XpesrdLcv33G2LPgaKDdUlxOvS1kpvdFTRtVG1
TYvvl3jXZEzUTenJIYbZ
=77Je
-----END PGP SIGNATURE-----

--=-ZZJrm/LNVgdAI5Dd2c/D--


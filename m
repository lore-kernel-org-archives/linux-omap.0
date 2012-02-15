From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: HDMI: Add M2 divider while calculating
 clkout
Date: Wed, 15 Feb 2012 16:52:21 +0200
Message-ID: <1329317541.1892.95.camel@deskari>
References: <1329285034-16121-1-git-send-email-mythripk@ti.com>
	 <1329291660.1892.9.camel@deskari>
	 <CAP5A+B9cuUsAnVSgt4G3Hue2Kns2+es8bW-8zHo2tLB9Kg-O=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-MzAtgx1fpyycEnU505Uu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:38682 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758524Ab2BOOw1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 09:52:27 -0500
Received: by mail-bk0-f51.google.com with SMTP id jc3so1308077bkc.24
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 06:52:26 -0800 (PST)
In-Reply-To: <CAP5A+B9cuUsAnVSgt4G3Hue2Kns2+es8bW-8zHo2tLB9Kg-O=g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org


--=-MzAtgx1fpyycEnU505Uu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-02-15 at 14:55 +0530, K, Mythri P wrote:
> Hi,
>=20
> On Wed, Feb 15, 2012 at 1:11 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > On Wed, 2012-02-15 at 11:20 +0530, mythripk@ti.com wrote:
> >> From: Mythri P K <mythripk@ti.com>
> >>
> >> Add M2 divider in the equation to calculate regm and regmf.
> >> Formula for calculating:
> >> Output clock on digital core domain:
> >>       CLKOUT =3D (M / (N+1))*CLKINP*(1/M2)
> >> Internal oscillator output clock on internal LDO domain:
> >>       CLKDCOLDO =3D (M / (N+1))*CLKINP
> >> The current code when allows variable M2 values as input
> >> ignores using M2 divider values in calculation of regm and regmf.
> >> so fix it by using M2 in calculation although the default value for
> >> M2 is 1.
> >>
> >> Signed-off-by: Mythri P K <mythripk@ti.com>
> >> ---
> >>  drivers/video/omap2/dss/hdmi.c |   16 ++++++++--------
> >>  1 files changed, 8 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/=
hdmi.c
> >> index 92a6679..9185630 100644
> >> --- a/drivers/video/omap2/dss/hdmi.c
> >> +++ b/drivers/video/omap2/dss/hdmi.c
> >> @@ -256,24 +256,24 @@ static void hdmi_compute_pll(struct omap_dss_dev=
ice *dssdev, int phy,
> >>
> >>       refclk =3D clkin / pi->regn;
> >>
> >> -     /*
> >> -      * multiplier is pixel_clk/ref_clk
> >> -      * Multiplying by 100 to avoid fractional part removal
> >> -      */
> >> -     pi->regm =3D (phy * 100 / (refclk)) / 100;
> >> -
> >>       if (dssdev->clocks.hdmi.regm2 =3D=3D 0)
> >>               pi->regm2 =3D HDMI_DEFAULT_REGM2;
> >>       else
> >>               pi->regm2 =3D dssdev->clocks.hdmi.regm2;
> >>
> >>       /*
> >> +      * multiplier is pixel_clk/ref_clk
> >> +      * Multiplying by 100 to avoid fractional part removal
> >> +      */
> >> +     pi->regm =3D (phy * 100 * pi->regm2 / (refclk)) / 100;
> >
> > No need for parenthesis around refclk.
> Well this is just a copy of old code will change.

The multiplication and division with 100 is actually extra also, they
don't bring any precision here.

> >
> >> +
> >> +     /*
> >>        * fractional multiplier is remainder of the difference between
> >>        * multiplier and actual phy(required pixel clock thus should be
> >>        * multiplied by 2^18(262144) divided by the reference clock
> >>        */
> >> -     mf =3D (phy - pi->regm * refclk) * 262144;
> >> -     pi->regmf =3D mf / (refclk);
> >> +     mf =3D (phy - pi->regm / pi->regm2 * refclk) * 262144;
> >
> > What kind of values does regm have? If the regm2 is something else than
> > 1, and regm is relatively small value, it's quite easy to lose precisio=
n
> > there. Would it be better to have:
> Normally regm values are much higher compared to regm2 , regm2 is
> normally 1 or 2.
> also given that regm2 is a multiplier factor in calculating regm there
> should not be any precision factor what do you think ?

Ok, I think it's fine.

 Tomi


--=-MzAtgx1fpyycEnU505Uu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPO8alAAoJEPo9qoy8lh71PCUP/jftX5rRLPabrnvhFL7tTDqa
GDJNFdXK8t3XHSy1bRfzL0ka0Ueddg+rSlX1AVgSNY4SF+If3Ig8uKQZUv4AUMQQ
zmfIAVFIMf4W+aC4p/hf7pAtvbvLW4ZWvdw1FopLRjOQXc3u0+P/n9WhBO7DmDzs
xIgS3EhtjnY9mcFOFzjoPfQlO0g1P22RLAYPUqoYHhAfOuFD6Js3LC9M6CDW4f+L
vUqcBGB8eKl8A9TFHFExq/23f6a39zlqyiOEsmPsMv+47qAAHQaMhPD+FyrciYPf
Dmdkh1TauvyMwqnWVtoXPqUN2KjZMZu5XVUK80sR4pq+P9JNKF014yvodqG8tOIp
28fr3O1mBXRLZVQTOmoGSdUkpJqHSAoTfOTK2Q9jTdUILnufTowiN/3znqYIXtFR
bIqx4Hw/F2XgqRUrC/rGiMh3DfRg5Mw30TXxv85Dyt5U1e5C9PxlflFm0qNpbQvi
KlTi3epb+FzsRAF+aSrJvdKNc97LWh1isS2O18GRA4KAD4Kjpsp1yqJNtL7stu7L
oxa/0FWmIQC6BP5d3wOgI6eotN7ekeIDK25RZLgu3qDwnMag13WfdnngwVX87K4F
kBeWtFVs3pjlcRH934LrXZMaB1wUAXVz1DZOuKKAI3DnyVqa8vtzhALTZQQrJiFp
b2LHmj5ojcbqDKGNRcky
=Xgd8
-----END PGP SIGNATURE-----

--=-MzAtgx1fpyycEnU505Uu--


From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [RFC] omap3: Enable SmartReflex calculations for 720MHz
Date: Fri, 7 Jan 2011 23:12:51 +0100
Message-ID: <ACB876EC-7696-4253-AC8D-C56663F4F79B@dominion.thruhere.net>
References: <1294421217-18730-1-git-send-email-premi@ti.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59436 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243Ab1AGWMz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 17:12:55 -0500
Received: by wyb28 with SMTP id 28so17829983wyb.19
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 14:12:53 -0800 (PST)
In-Reply-To: <1294421217-18730-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org


Op 7 jan 2011, om 18:26 heeft Sanjeev Premi het volgende geschreven:

> The eFuse registers do not contain the nValue to be used
> with 720MHz (OPP6). This patch implements procedure to
> calculate the nValue(OPP6) based on the nValue(OPP5).
>=20
>  [1] SPRUFF1D-June 2009 section 1.5.2.1.1
>=20
> This is first attempt to fit this mechanism into new
> smartreflex framework. Do note a FIXME which is added
> to illustrate the calculations; and express need for
> a mechanism to get nValues for each OPP.
>=20
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
> arch/arm/mach-omap2/sr_device.c           |   54 ++++++++++++++++++++=
+++++++++
> arch/arm/mach-omap2/voltage.c             |    1 +
> arch/arm/plat-omap/include/plat/voltage.h |    1 +
> 3 files changed, 56 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr=
_device.c
> index 786d685..43640a3 100644
> --- a/arch/arm/mach-omap2/sr_device.c
> +++ b/arch/arm/mach-omap2/sr_device.c
> @@ -38,6 +38,51 @@ static struct omap_device_pm_latency omap_sr_laten=
cy[] =3D {
> 	},
> };
>=20
> +static void swcalc_opp6_RG(u32 rFuse, u32 gainFuse, u32 deltaNT,
> +                               u32* rAdj, u32* gainAdj)
> +{
> +       u32 nAdj;
> +       u32 g, r;
> +
> +       nAdj =3D ((1 << (gainFuse + 8))/rFuse) + deltaNT;
> +
> +       for (g =3D 0; g < GAIN_MAXLIMIT; g++) {

GAIN_MAXLIMIT is undeclared at this point:

arch/arm/mach-omap2/sr_device.c: In function =91swcalc_opp6_RG=92:
arch/arm/mach-omap2/sr_device.c:49: error: =91GAIN_MAXLIMIT=92 undeclar=
ed (first use in this function)


> +               r =3D (1 << (g + 8)) / nAdj;
> +               if (r < 256) {
> +                       *rAdj =3D r;
> +                       *gainAdj =3D g;
> +               }
> +       }
> +}
> +
> +#define SWCALC_OPP6_DELTA_NNT	379
> +#define SWCALC_OPP6_DELTA_PNT	227
> +#define GAIN_MAXLIMIT		16

So these have to move up at bit.

regards,

Koen--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

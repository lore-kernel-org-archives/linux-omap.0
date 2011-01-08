From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC] omap3: Enable SmartReflex calculations for 720MHz
Date: Sat, 8 Jan 2011 16:12:05 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930247466DC7@dbde02.ent.ti.com>
References: <1294421217-18730-1-git-send-email-premi@ti.com>,<ACB876EC-7696-4253-AC8D-C56663F4F79B@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39194 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949Ab1AHKou convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Jan 2011 05:44:50 -0500
In-Reply-To: <ACB876EC-7696-4253-AC8D-C56663F4F79B@dominion.thruhere.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

_______________________________________
=46rom: Koen Kooi [koen@dominion.thruhere.net]
Sent: Saturday, January 08, 2011 3:42 AM
To: Premi, Sanjeev
Cc: linux-omap@vger.kernel.org
Subject: Re: [RFC] omap3: Enable SmartReflex calculations for 720MHz

Op 7 jan 2011, om 18:26 heeft Sanjeev Premi het volgende geschreven:

> The eFuse registers do not contain the nValue to be used
> with 720MHz (OPP6). This patch implements procedure to
> calculate the nValue(OPP6) based on the nValue(OPP5).
>
>  [1] SPRUFF1D-June 2009 section 1.5.2.1.1
>
> This is first attempt to fit this mechanism into new
> smartreflex framework. Do note a FIXME which is added
> to illustrate the calculations; and express need for
> a mechanism to get nValues for each OPP.
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
> arch/arm/mach-omap2/sr_device.c           |   54 ++++++++++++++++++++=
+++++++++
> arch/arm/mach-omap2/voltage.c             |    1 +
> arch/arm/plat-omap/include/plat/voltage.h |    1 +
> 3 files changed, 56 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr=
_device.c
> index 786d685..43640a3 100644
> --- a/arch/arm/mach-omap2/sr_device.c
> +++ b/arch/arm/mach-omap2/sr_device.c
> @@ -38,6 +38,51 @@ static struct omap_device_pm_latency omap_sr_laten=
cy[] =3D {
>       },
> };
>
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
> +#define SWCALC_OPP6_DELTA_NNT        379
> +#define SWCALC_OPP6_DELTA_PNT        227
> +#define GAIN_MAXLIMIT                16

So these have to move up at bit.

[sp] Thanks for catching this. For purpose of minimal changes I moved t=
his decl
manually from top of file leading to the error.

regards,

Koen
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

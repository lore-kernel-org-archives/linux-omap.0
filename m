From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 02/19] omap3630: hwmod: sr: enable for higher ES
Date: Sat, 19 Feb 2011 18:52:13 +0530
Message-ID: <cfec809cd80216111287ec9509b30250@mail.gmail.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com> <1298116918-30744-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:35942 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752318Ab1BSNWQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Feb 2011 08:22:16 -0500
Received: by mail-fx0-f48.google.com with SMTP id 2so4892879fxm.7
        for <linux-omap@vger.kernel.org>; Sat, 19 Feb 2011 05:22:15 -0800 (PST)
In-Reply-To: <1298116918-30744-3-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Nishanth Menon
> Sent: Saturday, February 19, 2011 5:32 PM
> To: linux-omap
> Cc: Tony Lindgren; Kevin Hilman; Nishanth Menon
> Subject: [PATCH 02/19] omap3630: hwmod: sr: enable for higher ES
>
> Enable hwmod entries for OMAP3630 for higher ES revisions as
> well. This is to ensure that SR can be used in all revisions of
> OMAP3630 as of this posting.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index ea1f49a..bbcbea6 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -1318,7 +1318,9 @@ static struct omap_hwmod
> omap36xx_sr1_hwmod = {
>  	},
>  	.slaves		= omap3_sr1_slaves,
>  	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
> -	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1	|
> +					CHIP_IS_OMAP3630ES1_1	|
> +					CHIP_IS_OMAP3630ES1_2),
What's the need of this?
Here is the code snippet from id.c
-----snip-----
	case 0xb891:
		/* Handle 36xx devices */
		omap_chip.oc |= CHIP_IS_OMAP3630ES1;

		switch(rev) {
		case 0: /* Take care of early samples */
			omap_revision = OMAP3630_REV_ES1_0;
			break;
		case 1:
			omap_revision = OMAP3630_REV_ES1_1;
			omap_chip.oc |= CHIP_IS_OMAP3630ES1_1;
			break;
		case 2:
		default:
			omap_revision =  OMAP3630_REV_ES1_2;
			omap_chip.oc |= CHIP_IS_OMAP3630ES1_2;
		}
So it's clear that omap_chip.oc will have CHIP_IS_OMAP3630ES1 anyway on
all ES versions.

Vishwa

>  	.mpu_irqs	= omap3_smartreflex_mpu_irqs,
>  	.mpu_irqs_cnt	=
> ARRAY_SIZE(omap3_smartreflex_mpu_irqs),
>  };
> @@ -1368,7 +1370,9 @@ static struct omap_hwmod
> omap36xx_sr2_hwmod = {
>  	},
>  	.slaves		= omap3_sr2_slaves,
>  	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
> -	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1	|
> +					CHIP_IS_OMAP3630ES1_1	|
> +					CHIP_IS_OMAP3630ES1_2),
>  	.mpu_irqs	= omap3_smartreflex_core_irqs,
>  	.mpu_irqs_cnt	=
> ARRAY_SIZE(omap3_smartreflex_core_irqs),
>  };
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

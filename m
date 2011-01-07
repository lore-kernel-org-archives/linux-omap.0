From: Nishanth Menon <nm@ti.com>
Subject: Re: omap: Beagle: detect new xM revision B
Date: Fri, 07 Jan 2011 07:03:30 -0600
Message-ID: <4D270F22.7050703@ti.com>
References: <1294391413-3612-1-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:47901 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752781Ab1AGNDp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 08:03:45 -0500
Received: by mail-gy0-f179.google.com with SMTP id 8so6395495gyg.10
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 05:03:44 -0800 (PST)
In-Reply-To: <1294391413-3612-1-git-send-email-koen@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, Koen Kooi <koen@beagleboard.org>

Koen Kooi wrote, on 01/07/2011 03:10 AM:
> From: Robert Nelson<robertcnelson@gmail.com>
>
> The xM B uses a DM3730 ES1.1 over the ES1.0 on xM A's, no other board changes.

unrelated to patch: funny why the GPIO version changed then!

related to patch: please add [PATCH] in $subject.. minor comment follows:

>
> Signed-off-by: Robert Nelson<robertcnelson@gmail.com>
> Signed-off-by: Koen Kooi<koen@beagleboard.org>
> ---
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 7c82730..4fd73e7 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -58,7 +58,8 @@
>    *	AXBX	= GPIO173, GPIO172, GPIO171: 1 1 1
>    *	C1_3	= GPIO173, GPIO172, GPIO171: 1 1 0
>    *	C4	= GPIO173, GPIO172, GPIO171: 1 0 1
> - *	XM	= GPIO173, GPIO172, GPIO171: 0 0 0
> + *	XMA	= GPIO173, GPIO172, GPIO171: 0 0 0
> + *	XMB	= GPIO173, GPIO172, GPIO171: 0 0 1
>    */
>   enum {
>   	OMAP3BEAGLE_BOARD_UNKN = 0,
> @@ -117,7 +118,11 @@ static void __init omap3_beagle_init_rev(void)
>   		omap3_beagle_version = OMAP3BEAGLE_BOARD_C4;
>   		break;
>   	case 0:
> -		printk(KERN_INFO "OMAP3 Beagle Rev: xM\n");
> +		printk(KERN_INFO "OMAP3 Beagle Rev: xM A\n");
> +		omap3_beagle_version = OMAP3BEAGLE_BOARD_XM;
> +		break;
> +	case 1:
> +		printk(KERN_INFO "OMAP3 Beagle Rev: xM B\n");

could you replace printk(KERN_INFO with pr_info?
>   		omap3_beagle_version = OMAP3BEAGLE_BOARD_XM;
>   		break;
>   	default:
> --
> cgit v0.8.3.1-30-gff3a
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Regards,
Nishanth Menon

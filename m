From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 03/04] OMAP3: PM: Fix I2C voltage levels send to T2 for different Power modes
Date: Mon, 29 Jun 2009 14:48:32 -0700
Message-ID: <87ab3q7lu7.fsf@deeprootsystems.com>
References: <1245153154-1876-1-git-send-email-rnayak@ti.com>
	<1245153154-1876-2-git-send-email-rnayak@ti.com>
	<1245153154-1876-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:45620 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746AbZF2Vsb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 17:48:31 -0400
Received: by wa-out-1112.google.com with SMTP id j5so867235wah.21
        for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2009 14:48:34 -0700 (PDT)
In-Reply-To: <1245153154-1876-3-git-send-email-rnayak@ti.com> (Rajendra Nayak's message of "Tue\, 16 Jun 2009 17\:22\:33 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, dderrick@ti.com, r-woodruff2@ti.com

Rajendra Nayak <rnayak@ti.com> writes:

> The ONLP and ONOFF values programed for both VDD1
> and VDD2 were not optimal.
>
> New values used are
> VDD1
> ON - 1.2v
> ONLP - 1.0v
> ONRET - .975v
> ONOFF - .6v
>
> VDD2
> ON - 1.15v
> ONLP - 1.0v
> ONRET - .975v
> ONOFF - .6v
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, pushing to PM branch (and pm-2.6.29)

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index d4225b4..c2d8b09 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -87,14 +87,14 @@ static struct prm_setup_vc prm_setup = {
>  	.voltsetup_time2 = 0xfff,
>  	.voltoffset = 0xff,
>  	.voltsetup2 = 0xff,
> -	.vdd0_on = 0x30,
> -	.vdd0_onlp = 0x1e,
> -	.vdd0_ret = 0x1e,
> -	.vdd0_off = 0x30,
> -	.vdd1_on = 0x2c,
> -	.vdd1_onlp = 0x1e,
> -	.vdd1_ret = 0x1e,
> -	.vdd1_off = 0x2c,
> +	.vdd0_on = 0x30,	/* 1.2v */
> +	.vdd0_onlp = 0x20,	/* 1.0v */
> +	.vdd0_ret = 0x1e,	/* 0.975v */
> +	.vdd0_off = 0x00,	/* 0.6v */
> +	.vdd1_on = 0x2c,	/* 1.15v */
> +	.vdd1_onlp = 0x20,	/* 1.0v */
> +	.vdd1_ret = 0x1e,	/* .975v */
> +	.vdd1_off = 0x00,	/* 0.6v */
>  };
>  
>  static inline void omap3_per_save_context(void)
> -- 
> 1.5.4.7
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

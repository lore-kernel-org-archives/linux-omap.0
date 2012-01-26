From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: fix erroneous mmc2 clock change on mmc3
 setup
Date: Thu, 26 Jan 2012 15:19:22 -0800
Message-ID: <20120126231921.GA29812@atomide.com>
References: <1324168547-26569-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:24346 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244Ab2AZXTY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jan 2012 18:19:24 -0500
Content-Disposition: inline
In-Reply-To: <1324168547-26569-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Grazvydas Ignotas <notasas@gmail.com> [111217 16:03]:
> hsmmc23_before_set_reg() can set MMCSDIO2ADPCLKISEL bit, which
> enables internal clock for MMC2. Currently this function is also called
> by code handling MMC3, and if .internal_clock is set in platform data
> (by default it currently is), it will set MMCSDIO2ADPCLKISEL for MMC2
> instead of MMC3 (MMC3 doesn't have such bit so nothing actually needs to
> be done). This breaks 2nd SD slot on pandora.
> 
> Fix this by changing hsmmc23_before_set_reg() to only handle MMC2.
> Note that this removes .remux() call for MMC3, but no board currently
> needs it and it's also not called for MMC4 and MMC5.
> 
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
> applies both on mainline and hsmmc branch.
> 
>  arch/arm/mach-omap2/hsmmc.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index f4a1020..d90ac08 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -171,7 +171,7 @@ static void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
>  	}
>  }
>  
> -static void hsmmc23_before_set_reg(struct device *dev, int slot,
> +static void hsmmc2_before_set_reg(struct device *dev, int slot,
>  				   int power_on, int vdd)
>  {
>  	struct omap_mmc_platform_data *mmc = dev->platform_data;

This hunk above changing the function name seems to be a typo?

Regards,

Tony


> @@ -378,14 +378,13 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
>  			c->caps &= ~MMC_CAP_8_BIT_DATA;
>  			c->caps |= MMC_CAP_4_BIT_DATA;
>  		}
> -		/* FALLTHROUGH */
> -	case 3:
>  		if (mmc->slots[0].features & HSMMC_HAS_PBIAS) {
>  			/* off-chip level shifting, or none */
> -			mmc->slots[0].before_set_reg = hsmmc23_before_set_reg;
> +			mmc->slots[0].before_set_reg = hsmmc2_before_set_reg;
>  			mmc->slots[0].after_set_reg = NULL;
>  		}
>  		break;
> +	case 3:
>  	case 4:
>  	case 5:
>  		mmc->slots[0].before_set_reg = NULL;
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

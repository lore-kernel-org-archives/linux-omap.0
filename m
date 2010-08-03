From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3630: Add ES1.1 and ES1.2 detection
Date: Tue, 3 Aug 2010 10:39:40 +0300
Message-ID: <20100803073940.GS12293@atomide.com>
References: <20100709072941.GG24913@atomide.com>
 <1278717461-5329-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58774 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076Ab0HCHjS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Aug 2010 03:39:18 -0400
Content-Disposition: inline
In-Reply-To: <1278717461-5329-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Manjunatha GK <manjugk@ti.com>

* Anand Gadiyar <gadiyar@ti.com> [100710 02:11]:
> Add revision detection for ES1.1 and ES1.2. Set default
> revision as ES1.2.
> 
> Add CHIP_GE_OMAP3630ES1_1 to detect revisions 1.1 and later.
> This is needed for at least one feature that is broken in
> 3630ES1.0 but exists on older (3430 ES3.1) and newer revisions.
> 
> Additionally, update some of the CHIP_GE_* macros to use other
> macros for ease of maintenance.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Manjunatha GK <manjugk@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
> This is based on Manju's original patch at [1] and my update [2].
> The original patch failed to properly update the CHIP_GE_OMAP3630ES1 macro.
> 
> Would be nice to get this queued for the next merge window
> 
> [1] https://patchwork.kernel.org/patch/95684/
> [2] https://patchwork.kernel.org/patch/99590/
> 
>  arch/arm/mach-omap2/id.c              |   27 +++++++++++++++++++++++----
>  arch/arm/plat-omap/include/plat/cpu.h |   15 +++++++++++----
>  2 files changed, 34 insertions(+), 8 deletions(-)
> 
> Index: linux-omap-2.6/arch/arm/mach-omap2/id.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/id.c
> +++ linux-omap-2.6/arch/arm/mach-omap2/id.c
> @@ -269,11 +269,24 @@ void __init omap3_check_revision(void)
>  		omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
>  		break;
>  	case 0xb891:
> -	/* FALLTHROUGH */
> -	default:
> -		/* Unknown default to latest silicon rev as default*/
> -		omap_revision = OMAP3630_REV_ES1_0;
> +		/* Handle 36xx devices */
>  		omap_chip.oc |= CHIP_IS_OMAP3630ES1;
> +
> +		switch(rev) {
> +		case 0: /* Take care of early samples */
> +			omap_revision = OMAP3630_REV_ES1_0;
> +			break;
> +		case 1:
> +			omap_revision = OMAP3630_REV_ES1_1;
> +			omap_chip.oc |= CHIP_IS_OMAP3630ES1_1;
> +			break;
> +		case 2:
> +		/* Fall through */
> +		default:
> +			/* Use the latest known revision as default */
> +			omap_revision =  OMAP3630_REV_ES1_2;
> +			omap_chip.oc |= CHIP_IS_OMAP3630ES1_2;
> +		}
>  	}
>  }

Please don't remove the default handling for unknown hawkeye
registers for omap3. Now you're only handling hawkeye 0xb891.

IMHO, setting unknown hawkeye chips to OMAP3630_REV_ES1_2
should be still best option for future chips.

Regards,

Tony

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] omap3: Add CHIP_GE_OMAP3430ES3 for HSUSB
Date: Tue, 22 Sep 2009 10:11:14 -0700
Message-ID: <20090922171114.GE14890@atomide.com>
References: <1253625132-15050-1-git-send-email-ajay.gupta@ti.com> <1253625132-15050-2-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54598 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbZIVRLO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 13:11:14 -0400
Content-Disposition: inline
In-Reply-To: <1253625132-15050-2-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, david-b@pacbell.net

* Ajay Kumar Gupta <ajay.gupta@ti.com> [090922 06:12]:
> OMAP3 HSUSB ports can be individually programmed in PHY or TLL
> mode in ES3.0 onwards whereas this is not supported in ES2.1
> and earlier versions.
> 
> CHIP_GE_OMAP3430ES3 is added to program this behavior at runtime.
> 
> Also updated the existing macros to use the priviously defined
> *_GE_* logic instead of repeating the same logic again.

Please use the omap_rev() test instead.

Tony 
 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> ---
> This is required to compile EHCI driver. EHCI driver patch
> "support for ES3.x" used CHIP_GE_OMAP3430ES2 and so this patch
> is also required.
> 
>  arch/arm/plat-omap/include/mach/cpu.h |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
> index 7a5f9e8..be6be3b 100644
> --- a/arch/arm/plat-omap/include/mach/cpu.h
> +++ b/arch/arm/plat-omap/include/mach/cpu.h
> @@ -414,10 +414,9 @@ IS_OMAP_TYPE(3430, 0x3430)
>   * chips at ES2 and beyond, but not, for example, any OMAP lines after
>   * OMAP3.
>   */
> -#define CHIP_GE_OMAP3430ES2		(CHIP_IS_OMAP3430ES2 | \
> -					 CHIP_IS_OMAP3430ES3_0 | \
> -					 CHIP_IS_OMAP3430ES3_1)
> -#define CHIP_GE_OMAP3430ES3_1		(CHIP_IS_OMAP3430ES3_1)
> +#define CHIP_GE_OMAP3430ES3_1	(CHIP_IS_OMAP3430ES3_1)
> +#define CHIP_GE_OMAP3430ES3	(CHIP_IS_OMAP3430ES3_0 | CHIP_GE_OMAP3430ES3_1)
> +#define CHIP_GE_OMAP3430ES2	(CHIP_IS_OMAP3430ES2 | CHIP_GE_OMAP3430ES3)
>  
>  
>  int omap_chip_is(struct omap_chip_id oci);
> -- 
> 1.6.2.4
> 

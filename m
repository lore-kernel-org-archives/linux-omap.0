From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH 05/15] ARM: OMAP2+: AM33XX: Update WKUP_M3 hwmod entry
 for reset status
Date: Mon, 5 Nov 2012 12:29:06 +0530
Message-ID: <509763BA.1070402@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-6-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52224 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682Ab2KEG7M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 01:59:12 -0500
In-Reply-To: <1351859566-24818-6-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com



On 11/2/2012 6:02 PM, Vaibhav Bedia wrote:
> Add the reset status offset for WKUP_M3 in the hwmod data
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 

Thanks for the patch, Probably you can resubmit this patch separately
which can be merged independently from this patch-series.

Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>

Thanks,
Vaibhav

> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> index 3c235d8..2e470ce 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> @@ -269,6 +269,7 @@ static struct omap_hwmod am33xx_wkup_m3_hwmod = {
>  		.omap4	= {
>  			.clkctrl_offs	= AM33XX_CM_WKUP_WKUP_M3_CLKCTRL_OFFSET,
>  			.rstctrl_offs	= AM33XX_RM_WKUP_RSTCTRL_OFFSET,
> +			.rstst_offs	= AM33XX_RM_WKUP_RSTST_OFFSET,
>  			.modulemode	= MODULEMODE_SWCTRL,
>  		},
>  	},
> 

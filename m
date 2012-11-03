From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 05/15] ARM: OMAP2+: AM33XX: Update WKUP_M3 hwmod entry
 for reset status
Date: Sat, 3 Nov 2012 21:45:29 +0530
Message-ID: <50954321.8010908@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-6-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40657 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564Ab2KCQPi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Nov 2012 12:15:38 -0400
In-Reply-To: <1351859566-24818-6-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com

On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
> Add the reset status offset for WKUP_M3 in the hwmod data
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> index 3c235d8..2e470ce 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> @@ -269,6 +269,7 @@ static struct omap_hwmod am33xx_wkup_m3_hwmod = {
>   		.omap4	= {
>   			.clkctrl_offs	= AM33XX_CM_WKUP_WKUP_M3_CLKCTRL_OFFSET,
>   			.rstctrl_offs	= AM33XX_RM_WKUP_RSTCTRL_OFFSET,
> +			.rstst_offs	= AM33XX_RM_WKUP_RSTST_OFFSET,
>   			.modulemode	= MODULEMODE_SWCTRL,
>   		},
>   	},
>
You are adding reset bit in this patch but using it in 4/15. Probably
you can re-order it to keep git bisect happy.

Regards
Santosh


From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: [PATCH PM-0] ARM: OMAP3: HSMMC: Ensure HSMMC is fully reset on boot
Date: Thu, 18 Sep 2008 18:16:23 +0530
Message-ID: <002501c9198c$8ff08430$LocalHost@wipultra1303>
References: <1221740552-27110-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59609 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752822AbYIRMqf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 08:46:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>


----- Original Message ----- 
From: "Kevin Hilman" <khilman@deeprootsystems.com>
To: <linux-omap@vger.kernel.org>
Cc: "Kevin Hilman" <khilman@deeprootsystems.com>
Sent: Thursday, September 18, 2008 5:52 PM
Subject: [PATCH PM-0] ARM: OMAP3: HSMMC: Ensure HSMMC is fully reset on boot


> This ensures that an unused HSMMC block will not interfere with sleep.
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> arch/arm/mach-omap2/hsmmc.c |    8 ++++++++
> 1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index 7334d86..03fe820 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -280,8 +280,16 @@ static struct omap_mmc_platform_data hsmmc_data = {
>  },
> };
> 
> +static void __init hsmmc_reset(void)
> +{
> +       omap_writel(MMCHS_SYSCONFIG_SWRESET, MMCHS1_SYSCONFIG);
> +       omap_writel(MMCHS_SYSCONFIG_SWRESET, MMCHS2_SYSCONFIG);
> +       omap_writel(MMCHS_SYSCONFIG_SWRESET, MMCHS3_SYSCONFIG);
> +}
> +
Where is MMCHS1_SYSCONFIG defined?
After seting the softreset bit in SYSCONFIG, you might want to poll on the RESETDONE bit in SYSSTATUS to wait for the reset to complete.
The interface and functional clocks should be provided before the reset is issued for reset to complete. At this point, I guess the clocks are not enabled yet.

Regards,
Madhu
> void __init hsmmc_init(void)
> {
> + hsmmc_reset();
>  omap2_init_mmc(&hsmmc_data);
> }
> 
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
>

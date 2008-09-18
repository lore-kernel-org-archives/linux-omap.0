From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH PM-0] ARM: OMAP3: HSMMC: Ensure HSMMC is fully reset on
	boot
Date: Thu, 18 Sep 2008 15:45:01 +0300
Message-ID: <20080918124501.GF28615@gandalf.research.nokia.com>
References: <1221740552-27110-1-git-send-email-khilman@deeprootsystems.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:50229 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbYIRMpi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 08:45:38 -0400
Content-Disposition: inline
In-Reply-To: <1221740552-27110-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Thu, Sep 18, 2008 at 03:22:32PM +0300, ext Kevin Hilman wrote:
> This ensures that an unused HSMMC block will not interfere with sleep.
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

It was observed that bootrom code initializes mmc in such a way that
prevents system from idling.

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/mach-omap2/hsmmc.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index 7334d86..03fe820 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -280,8 +280,16 @@ static struct omap_mmc_platform_data hsmmc_data = {
>  	},
>  };
>  
> +static void __init hsmmc_reset(void)
> +{
> +       omap_writel(MMCHS_SYSCONFIG_SWRESET, MMCHS1_SYSCONFIG);
> +       omap_writel(MMCHS_SYSCONFIG_SWRESET, MMCHS2_SYSCONFIG);
> +       omap_writel(MMCHS_SYSCONFIG_SWRESET, MMCHS3_SYSCONFIG);
> +}
> +
>  void __init hsmmc_init(void)
>  {
> +	hsmmc_reset();
>  	omap2_init_mmc(&hsmmc_data);
>  }
>  
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi

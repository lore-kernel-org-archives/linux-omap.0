From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] OMAP3: SRAM size fix for HS/EMU devices
Date: Thu, 18 Jun 2009 08:16:27 +0300
Message-ID: <20090618051624.GA8482@atomide.com>
References: <1245283206-6568-1-git-send-email-khilman@deeprootsystems.com> <1245283206-6568-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57472 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbZFRHQb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 03:16:31 -0400
Content-Disposition: inline
In-Reply-To: <1245283206-6568-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [090618 03:00]:
> From: Tero Kristo <tero.kristo@nokia.com>
> 
> SRAM size fix for HS/EMU devices
> 
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/plat-omap/sram.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>  mode change 100644 => 100755 arch/arm/plat-omap/sram.c

This one also has some mode change going on, please check your repos.
Will fix before applying.

Tony
 
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> old mode 100644
> new mode 100755
> index 65006df..80bf3b1
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -133,7 +133,11 @@ void __init omap_detect_sram(void)
>  			if (cpu_is_omap34xx()) {
>  				omap_sram_base = OMAP3_SRAM_PUB_VA;
>  				omap_sram_start = OMAP3_SRAM_PUB_PA;
> -				omap_sram_size = 0x8000; /* 32K */
> +				if ((omap_type() == OMAP2_DEVICE_TYPE_EMU) ||
> +				    (omap_type() == OMAP2_DEVICE_TYPE_SEC)) {
> +					omap_sram_size = 0x7000; /* 28K */
> +				else
> +					omap_sram_size = 0x8000; /* 32K */
>  			} else {
>  				omap_sram_base = OMAP2_SRAM_PUB_VA;
>  				omap_sram_start = OMAP2_SRAM_PUB_PA;
> -- 
> 1.6.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: drop SmartReflex base addresses mistakenly
	added by EHCI patch
Date: Wed, 17 Jun 2009 06:43:06 -0700
Message-ID: <20090617134306.GR6605@atomide.com>
References: <1245085932-9996-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50209 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765257AbZFQNnH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 09:43:07 -0400
Content-Disposition: inline
In-Reply-To: <1245085932-9996-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [090615 10:12]:
> From: Kevin Hilman <khilman@ti.deeprootsystems.com>
> 
> Drop them for now.  They will be re-added with the SmartReflex
> patches coming from the PM branch, and will use the
> L4_34XX_BASE + <offset> approach.

Felipe, can you please update your ehci-omap branch accordingly?

Also, please remove the addition of omap3evm_flash_init() call
for board-omap3evm.c in your branch.

Thanks,

Tony
 
> Signed-off-by: Kevin Hilman <khilman@ti.deeprootsystems.com>
> ---
>  arch/arm/plat-omap/include/mach/omap34xx.h |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/mach/omap34xx.h b/arch/arm/plat-omap/include/mach/omap34xx.h
> index 4655707..6a58f3d 100644
> --- a/arch/arm/plat-omap/include/mach/omap34xx.h
> +++ b/arch/arm/plat-omap/include/mach/omap34xx.h
> @@ -78,8 +78,6 @@
>  #define OMAP34XX_UHH_CONFIG_BASE	(L4_34XX_BASE + 0x64000)
>  #define OMAP34XX_OHCI_BASE	(L4_34XX_BASE + 0x64400)
>  #define OMAP34XX_EHCI_BASE	(L4_34XX_BASE + 0x64800)
> -#define OMAP34XX_SR1_BASE	0x480C9000
> -#define OMAP34XX_SR2_BASE	0x480CB000
>  
>  #define OMAP34XX_MAILBOX_BASE		(L4_34XX_BASE + 0x94000)
>  
> -- 
> 1.6.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

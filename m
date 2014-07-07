From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: DRA7/AM43XX: fix header definition for
 omap44xx_restart
Date: Mon, 7 Jul 2014 04:44:21 -0700
Message-ID: <20140707114421.GS28884@atomide.com>
References: <1400279769-28704-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:39666 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbaGGLoV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2014 07:44:21 -0400
Content-Disposition: inline
In-Reply-To: <1400279769-28704-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [140516 15:37]:
> omap44xx_restart is defined as a static void inline when DRA7/AM437X is
> defined alone, which implies that the restart function is no longer
> functional even though it is built in. So, fix the definition of the
> same.
> 
> Unfortunately, the number of SoCs starting to use omap44xx_restart is
> starting to grow and the definition looks a little ugly.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> based on v3.15-rc5
> 
> NOTE: this generates over 80 characters checkpatch warning.. I am not
> sure other than introducing a definition for restart it could be simplified.

Sorry found this still pending so applying into omap-for-v3.16/fixes.

Regards,

Tony
 
>  arch/arm/mach-omap2/common.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index d88aff7..46150f4 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -154,7 +154,7 @@ static inline void omap3xxx_restart(enum reboot_mode mode, const char *cmd)
>  }
>  #endif
>  
> -#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
> +#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
>  void omap44xx_restart(enum reboot_mode mode, const char *cmd);
>  #else
>  static inline void omap44xx_restart(enum reboot_mode mode, const char *cmd)
> -- 
> 1.7.9.5
> 

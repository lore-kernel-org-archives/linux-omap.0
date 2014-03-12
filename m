From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: Fix definition of IS_PM44XX_ERRATUM
Date: Thu, 13 Mar 2014 05:59:09 +0800
Message-ID: <5320D8AD.5000308@ti.com>
References: <1394660600-3771-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58135 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751833AbaCLV7e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Mar 2014 17:59:34 -0400
In-Reply-To: <1394660600-3771-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>

On Thursday 13 March 2014 05:43 AM, Nishanth Menon wrote:
> Just like IS_PM34XX_ERRATUM, IS_PM44XX_ERRATUM is valid only if
> CONFIG_PM is enabled, else, disabling CONFIG_PM results in build
> failure complaining about the following:
> arch/arm/mach-omap2/built-in.o: In function `omap4_boot_secondary':
> :(.text+0x8a70): undefined reference to `pm44xx_errata'
> 
Not entirely accurate since CPU hotplug doesn't depend on CONFIG_PM

> Fixes: c962184 (ARM: OMAP4: PM: add errata support)
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Patch based on: v3.14-rc6
> Reported originally with a randconfig defconfig: http://slexy.org/view/s21U7eF4k1
> 
But without the PM sleep code, hotplug won't work either.
SO I think its ok assumption in this particular case

>  arch/arm/mach-omap2/pm.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 7bdd22a..d4d0fce 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -103,7 +103,7 @@ static inline void enable_omap3630_toggle_l2_on_restore(void) { }
>  
>  #define PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD	(1 << 0)
>  
> -#if defined(CONFIG_ARCH_OMAP4)
> +#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP4)
>  extern u16 pm44xx_errata;
>  #define IS_PM44XX_ERRATUM(id)		(pm44xx_errata & (id))
>  #else
> 


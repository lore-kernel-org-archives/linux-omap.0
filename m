From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP2+: Get rid of custom OMAP_32K_TIMER_HZ
Date: Sun, 03 Feb 2013 14:50:23 +0200
Message-ID: <510E5D0F.3050708@compulab.co.il>
References: <1359646320-9086-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:40367 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752369Ab3BCMub (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 3 Feb 2013 07:50:31 -0500
In-Reply-To: <1359646320-9086-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, John Stultz <john.stultz@linaro.org>, Tony Lindgren <tony@atomide.com>

On 01/31/13 17:32, Santosh Shilimkar wrote:
> The timekeeping doesn't depend on HZ value in presence of fine grained
> clocksource and hence there should not be any time drift because of HZ
> value which was chosen to be divisor of 32768.
> 
> OMAP has been using HZ = 128 value to avoid any time drift issues
> because of 32768 HZ clock. But with various measurements performed
> with HZ = 100, no time drift is observed and it also proves the
> point about HZ not having impact on time keeping on OMAP.

Great! I had the same patch in my tree already for several months,
but I was afraid to send it as I had no time to test it thoroughly.
These kind of things are always scary to send without proper testing...

Thank you very much for testing and sending this out!

> 
> Very informative thread on this topic is here:
> 	https://lkml.org/lkml/2013/1/29/435
> 
> Special thanks to John Stulz, Arnd Bergmann and Russell King for their
> valuable suggestions.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Tony Lindgren <tony@atomide.com>

If it still not too late:
Acked-by: Igor Grinberg <grinberg@compulab.co.il>

> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  arch/arm/Kconfig                        |    1 -
>  arch/arm/plat-omap/Kconfig              |    9 ---------
>  arch/arm/plat-omap/include/plat/timex.h |    8 --------
>  3 files changed, 18 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index b35b27f..5493164 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1648,7 +1648,6 @@ config HZ
>  	int
>  	default 200 if ARCH_EBSA110 || ARCH_S3C24XX || ARCH_S5P64X0 || \
>  		ARCH_S5PV210 || ARCH_EXYNOS4
> -	default OMAP_32K_TIMER_HZ if ARCH_OMAP && OMAP_32K_TIMER
>  	default AT91_TIMER_HZ if ARCH_AT91
>  	default SHMOBILE_TIMER_HZ if ARCH_SHMOBILE
>  	default 100
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index 67c859c..ce66eb9 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -147,15 +147,6 @@ config OMAP3_L2_AUX_SECURE_SERVICE_SET_ID
>  	help
>  	  PPA routine service ID for setting L2 auxiliary control register.
>  
> -config OMAP_32K_TIMER_HZ
> -	int "Kernel internal timer frequency for 32KHz timer"
> -	range 32 1024
> -	depends on OMAP_32K_TIMER
> -	default "128"
> -	help
> -	  Kernel internal timer frequency should be a divisor of 32768,
> -	  such as 64 or 128.
> -
>  config OMAP_DM_TIMER
>  	bool "Use dual-mode timer"
>  	depends on ARCH_OMAP16XX || ARCH_OMAP2PLUS
> diff --git a/arch/arm/plat-omap/include/plat/timex.h b/arch/arm/plat-omap/include/plat/timex.h
> index 6d35767..e27d2da 100644
> --- a/arch/arm/plat-omap/include/plat/timex.h
> +++ b/arch/arm/plat-omap/include/plat/timex.h
> @@ -28,14 +28,6 @@
>  #if !defined(__ASM_ARCH_OMAP_TIMEX_H)
>  #define __ASM_ARCH_OMAP_TIMEX_H
>  
> -/*
> - * OMAP 32KHz timer updates time one jiffie at a time from a secondary timer,
> - * and that's why the CLOCK_TICK_RATE is not 32768.
> - */
> -#ifdef CONFIG_OMAP_32K_TIMER
> -#define CLOCK_TICK_RATE		(CONFIG_OMAP_32K_TIMER_HZ)
> -#else
>  #define CLOCK_TICK_RATE		(HZ * 100000UL)
> -#endif
>  
>  #endif /* __ASM_ARCH_OMAP_TIMEX_H */
> 

-- 
Regards,
Igor.

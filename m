From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V6 1/3] ARM: OMAP1: FIX: check possible error condition in timer_init
Date: Wed, 02 May 2012 13:08:09 -0700
Message-ID: <87y5pafis6.fsf@ti.com>
References: <1335967014-11937-1-git-send-email-hvaibhav@ti.com>
	<1335967014-11937-2-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:39150 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756288Ab2EBUIP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 16:08:15 -0400
Received: by pbbrq2 with SMTP id rq2so1343283pbb.6
        for <linux-omap@vger.kernel.org>; Wed, 02 May 2012 13:08:14 -0700 (PDT)
In-Reply-To: <1335967014-11937-2-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Wed, 2 May 2012 19:26:52 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> OMAP1, omap_32k_timer_init() function always returns "true",
> irrespective of whether error occurred while initializing 32k sync
> counter as a kernel clocksource or not and execution will never
> fallback to mpu_timer clocksource init code.
>
> This patch adds check for return value from function
> omap_init_clocksource_32k(), and fallback to omap_mpu_timer_init()
> in case of failure/error from omap_init_clocksource_32k().
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> ---
> This is new patch addition compared to original series (<=V5).
>
> Also, note that, this patch is only compile tested, since
> I do not have omap1 board with me to validate it.
> Kevin, can you help me to validate it.

I boot tested on OMAP1 (5912/OSK) with 32k timer and MPU timer
Kconfigs.  Works fine, but needs small change below for compile warnings.

Otherwise, looks good.

Acked-by: Kevin Hilman <khilman@ti.com>

>  arch/arm/mach-omap1/common.h   |   10 +++++++++-
>  arch/arm/mach-omap1/time.c     |   16 +---------------
>  arch/arm/mach-omap1/timer32k.c |   13 +++++++++----
>  3 files changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
> index 8cc616e..e8c9ad3 100644
> --- a/arch/arm/mach-omap1/common.h
> +++ b/arch/arm/mach-omap1/common.h
> @@ -63,7 +63,15 @@ extern void omap1_nand_cmd_ctl(struct mtd_info *mtd, int cmd,
>  			       unsigned int ctrl);
>
>  extern struct sys_timer omap1_timer;
> -extern bool omap_32k_timer_init(void);
> +
> +#ifdef CONFIG_OMAP_32K_TIMER
> +extern int omap_32k_timer_init(void);
> +#else
> +static int __init omap_32k_timer_init(void)

This needs to be inline.   Compile test on OMAP1 with
CONFIG_OMAP_32K_TIMER=n to see why.

> +{
> +	return -ENODEV;
> +}
> +#endif
>
>  extern u32 omap_irq_flags;
>
> diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
> index 4d8dd9a..4062480 100644
> --- a/arch/arm/mach-omap1/time.c
> +++ b/arch/arm/mach-omap1/time.c
> @@ -232,20 +232,6 @@ static inline void omap_mpu_timer_init(void)
>  }
>  #endif	/* CONFIG_OMAP_MPU_TIMER */
>
> -static inline int omap_32k_timer_usable(void)
> -{
> -	int res = false;
> -
> -	if (cpu_is_omap730() || cpu_is_omap15xx())
> -		return res;
> -
> -#ifdef CONFIG_OMAP_32K_TIMER
> -	res = omap_32k_timer_init();
> -#endif
> -
> -	return res;
> -}
> -
>  /*
>   * ---------------------------------------------------------------------------
>   * Timer initialization
> @@ -253,7 +239,7 @@ static inline int omap_32k_timer_usable(void)
>   */
>  static void __init omap1_timer_init(void)
>  {
> -	if (!omap_32k_timer_usable())
> +	if (omap_32k_timer_init() != 0)
>  		omap_mpu_timer_init();
>  }
>
> diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
> index 325b9a0..e3613a8 100644
> --- a/arch/arm/mach-omap1/timer32k.c
> +++ b/arch/arm/mach-omap1/timer32k.c
> @@ -182,10 +182,15 @@ static __init void omap_init_32k_timer(void)
>   * Timer initialization
>   * ---------------------------------------------------------------------------
>   */
> -bool __init omap_32k_timer_init(void)
> +int __init omap_32k_timer_init(void)
>  {
> -	omap_init_clocksource_32k();
> -	omap_init_32k_timer();
> +	int ret = -ENODEV;
>
> -	return true;
> +	if (cpu_is_omap16xx())
> +		ret = omap_init_clocksource_32k();
> +
> +	if (!ret)
> +		omap_init_32k_timer();
> +
> +	return ret;
>  }
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v11 04/10] clocksource: timer-ti-dm: Replace architecture
Date: Thu, 22 Feb 2018 11:57:13 +0100
Message-ID: <20180222105713.GA30885@lenoch>
References: <1518674511-26421-1-git-send-email-j-keerthy@ti.com>
 <1518674511-26421-5-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1518674511-26421-5-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, narmstrong@baylibre.com, tony@atomide.com, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, t-kristo@ti.com, thierry.reding@gmail.com, sebastian.reichel@collabora.co.uk, aaro.koskinen@iki.fi, grygorii.strashko@ti.com, Claudiu.Beznea@microchip.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 15, 2018 at 11:31:45AM +0530, Keerthy wrote:
> Replace architecture specific guard with clocksource guard.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Replace architecture specific defines with clocksource

This looks like a bit unussual commit log. Also, what about merging
it with previous patch?

Btw, I tested whole serie again on the top of today's -next and it is
still working fine. What is preventing these patches from being merged?

Thank you,
	ladis

> ---
>  include/clocksource/timer-ti-dm.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti-dm.h
> index 831174f..4f31095 100644
> --- a/include/clocksource/timer-ti-dm.h
> +++ b/include/clocksource/timer-ti-dm.h
> @@ -1,6 +1,4 @@
>  /*
> - * arch/arm/plat-omap/include/plat/dmtimer.h
> - *
>   * OMAP Dual-Mode Timers
>   *
>   * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
> @@ -36,8 +34,8 @@
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
>  
> -#ifndef __ASM_ARCH_DMTIMER_H
> -#define __ASM_ARCH_DMTIMER_H
> +#ifndef __CLOCKSOURCE_DMTIMER_H
> +#define __CLOCKSOURCE_DMTIMER_H
>  
>  /* clock sources */
>  #define OMAP_TIMER_SRC_SYS_CLK			0x00
> @@ -426,4 +424,4 @@ static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
>  	writel_relaxed(value, timer->irq_stat);
>  }
>  #endif /* CONFIG_ARCH_OMAP1 || CONFIG_ARCH_OMAP2PLUS */
> -#endif /* __ASM_ARCH_DMTIMER_H */
> +#endif /* __CLOCKSOURCE_DMTIMER_H */
> -- 
> 1.9.1

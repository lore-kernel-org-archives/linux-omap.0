From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] ARM: OMAP4: Add minimal support for omap4
Date: Wed, 20 May 2009 08:40:01 -0700
Message-ID: <20090520154000.GE8308@atomide.com>
References: <1242824343-5956-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61624 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbZETPkO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 11:40:14 -0400
Content-Disposition: inline
In-Reply-To: <1242824343-5956-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Hi,

Few more (mostly cosmetic) comments below.

* Santosh Shilimkar <santosh.shilimkar@ti.com> [090520 05:59]:
> This patch adds the support for OMAP4. The platform and machine specific
> headers and sources updated for OMAP4430 SDP platform.
> 
> OMAP4430 is Texas Instrument's SOC based on ARM Cortex-A9 SMP architecture.
> It's a dual core SOC with GIC used for interrupt handling and SCU for cache
> coherency.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/gpmc.c                    |    6 +
>  arch/arm/mach-omap2/id.c                      |    8 ++-
>  arch/arm/mach-omap2/io.c                      |   52 +++++++++-
>  arch/arm/mach-omap2/serial.c                  |    7 ++
>  arch/arm/mach-omap2/timer-gp.c                |    9 ++-
>  arch/arm/plat-omap/common.c                   |   31 ++++++
>  arch/arm/plat-omap/devices.c                  |    2 +
>  arch/arm/plat-omap/dma.c                      |   23 ++++-
>  arch/arm/plat-omap/dmtimer.c                  |   59 ++++++++++-
>  arch/arm/plat-omap/gpio.c                     |  134 ++++++++++++++++++------
>  arch/arm/plat-omap/include/mach/clock.h       |    8 +-
>  arch/arm/plat-omap/include/mach/common.h      |    1 +
>  arch/arm/plat-omap/include/mach/control.h     |    7 +-
>  arch/arm/plat-omap/include/mach/cpu.h         |   21 ++++-
>  arch/arm/plat-omap/include/mach/debug-macro.S |    2 +-
>  arch/arm/plat-omap/include/mach/dma.h         |    1 +
>  arch/arm/plat-omap/include/mach/entry-macro.S |   46 ++++++++-
>  arch/arm/plat-omap/include/mach/hardware.h    |    1 +
>  arch/arm/plat-omap/include/mach/io.h          |   37 +++++++
>  arch/arm/plat-omap/include/mach/irqs.h        |   89 ++++++++++++++++
>  arch/arm/plat-omap/include/mach/memory.h      |    3 +-
>  arch/arm/plat-omap/include/mach/omap44xx.h    |   46 +++++++++
>  arch/arm/plat-omap/include/mach/serial.h      |   16 +++-
>  arch/arm/plat-omap/io.c                       |   29 +++++-
>  arch/arm/plat-omap/mux.c                      |    3 +
>  arch/arm/plat-omap/sram.c                     |   21 ++++
>  26 files changed, 600 insertions(+), 62 deletions(-)

<snip snip>

> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -30,6 +32,7 @@
>  #include <mach/sdrc.h>
>  #include <mach/gpmc.h>
>  
> +#ifndef CONFIG_ARCH_OMAP4	/* FIXME: Remove this once clkdev is ready */
>  #include "clock.h"
>  
>  #include <mach/powerdomain.h>

Maybe move this part to your clk stub patch?


> @@ -198,9 +244,11 @@ void __init omap2_map_common_io(void)
>  void __init omap2_init_common_hw(struct omap_sdrc_params *sp)
>  {
>  	omap2_mux_init();
> +#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is ready */
>  	pwrdm_init(powerdomains_omap);
>  	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
>  	omap2_clk_init();
>  	omap2_sdrc_init(sp);
> +#endif
>  	gpmc_init();
>  }

And this too?


> --- a/arch/arm/mach-omap2/timer-gp.c
> +++ b/arch/arm/mach-omap2/timer-gp.c
> @@ -82,7 +83,8 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
>  	case CLOCK_EVT_MODE_PERIODIC:
>  		period = clk_get_rate(omap_dm_timer_get_fclk(gptimer)) / HZ;
>  		period -= 1;
> -
> +		if (cpu_is_omap44xx())
> +			period = 0xFF;	/* FIXME: */
>  		omap_dm_timer_set_load_start(gptimer, 1, 0xffffffff - period);
>  		break;
>  	case CLOCK_EVT_MODE_ONESHOT:

One more hex 0xFF to lower case here. Maybe grep your patches for 0x
and lower case them for consistent hex addresses?

Regards,

Tony



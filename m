From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] omap4: Enable ARM local timers with OMAP4430 es1.0
 exception
Date: Mon, 14 Feb 2011 13:08:39 -0800
Message-ID: <20110214210838.GI20795@atomide.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
 <1297510187-31547-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54584 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015Ab1BNVIp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 16:08:45 -0500
Content-Disposition: inline
In-Reply-To: <1297510187-31547-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110212 03:28]:
> On OMAP4430 ES1.0 the local timers are gated by security. Enable the
> CONFIG_LOCAL_TIMERS for omap2plus build and handle the OMAP4430 es1.0
> exception case.
> 
> This patch has dependency on the first patch in this series.
> 	ARM: smp: Select local timers vs dummy timer support runtime
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/mach-omap2/Kconfig     |    1 +
>  arch/arm/mach-omap2/timer-mpu.c |    4 ++++
>  2 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 1a2cf62..f285dd7 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -44,6 +44,7 @@ config ARCH_OMAP4
>  	depends on ARCH_OMAP2PLUS
>  	select CPU_V7
>  	select ARM_GIC
> +	select LOCAL_TIMERS
>  	select PL310_ERRATA_588369
>  	select ARM_ERRATA_720789
>  	select ARCH_HAS_OPP
> diff --git a/arch/arm/mach-omap2/timer-mpu.c b/arch/arm/mach-omap2/timer-mpu.c
> index 09c73dc..31c0ac4 100644
> --- a/arch/arm/mach-omap2/timer-mpu.c
> +++ b/arch/arm/mach-omap2/timer-mpu.c
> @@ -28,6 +28,10 @@
>   */
>  int __cpuinit local_timer_setup(struct clock_event_device *evt)
>  {
> +	/* Local timers are not supprted on OMAP4430 ES1.0 */
> +	if (omap_rev() == OMAP4430_REV_ES1_0)
> +		return -ENXIO;
> +
>  	evt->irq = OMAP44XX_IRQ_LOCALTIMER;
>  	twd_timer_setup(evt);
>  	return 0;
> -- 
> 1.6.0.4
> 

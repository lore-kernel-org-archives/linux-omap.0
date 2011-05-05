From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 12/12] OMAP2: Serial: Add no async wake flag.
Date: Thu, 05 May 2011 10:32:49 -0700
Message-ID: <87k4e5hx32.fsf@ti.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
	<1304080796-625-13-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:48968 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754435Ab1EERcx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 13:32:53 -0400
In-Reply-To: <1304080796-625-13-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Fri, 29 Apr 2011 18:09:56 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

"Govindraj.R" <govindraj.raja@ti.com> writes:

> For omap2 cpu_idle thread will not be available

Why not?

> and uart_clock cutting happens only in suspend path.

Aren't clocks also cut after runtime PM autosuspend?

> Prior to this patch the uart_clock was cut using prepare/resume
> calls since these funcs are no more available with runtime
> changes use no_async_wake flag to keep clock active during bootup
> otherwise uart port will disabled during boot-up and cannot be
> enabled back.

This doesn't just keep clock active during bootup, but it keeps clock
active always, except during suspend.

> Also based on this flag we can disable uart port during suspend
> and enable back during resume.

I think disabling UART port during suspend should already be part of an
earlier patch.  This patch should then only make it conditional.

> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c                  |    7 +++++++
>  arch/arm/plat-omap/include/plat/omap-serial.h |    3 +++
>  drivers/tty/serial/omap-serial.c              |   14 ++++++++++++++
>  3 files changed, 24 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index d4ef370..1af9fd5 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -245,6 +245,12 @@ static void omap_uart_wakeup_enable(struct platform_device *pdev, bool enable)
>  static void omap_uart_idle_init(struct omap_uart_port_info *uart,
>  				unsigned short num)
>  {
> +	/* On omap2 no cpu_idle and async wakeup from prcm_module.

Please remove comments about CPU idle, as the need for this has nothing
to do with CPU idle.

> +	 * This flag can be used to cut clocks only in suspend path.
> +	 * to avoid boot break due to aggressive clock cutting from
> +	 * omap-serial driver.
> +	 */

fix multi-line comment style throughout

> +	uart->no_async_wake = true;

If needed (which I still don't think I understand), for readability sake
this flag should be called 'has_async_wake', and default to false.  It
should then be set to true on available SoCs.

Kevin

>  	if (cpu_is_omap34xx()) {
>  		u32 mod = num > 1 ? OMAP3430_PER_MOD : CORE_MOD;
>  		u32 wk_mask = 0;
> @@ -266,6 +272,7 @@ static void omap_uart_idle_init(struct omap_uart_port_info *uart,
>  			break;
>  		}
>  		uart->wk_mask = wk_mask;
> +		uart->no_async_wake = false;
>  	} else if (cpu_is_omap24xx()) {
>  		u32 wk_mask = 0;
>  		u32 wk_en = PM_WKEN1, wk_st = PM_WKST1;
> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
> index b5117bd..1de5bc4 100644
> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
> @@ -79,6 +79,7 @@ struct omap_uart_port_info {
>  	void __iomem *wk_st;
>  	void __iomem *wk_en;
>  	u32 wk_mask;
> +	bool			no_async_wake;
>  };
>  
>  struct uart_omap_dma {
> @@ -134,6 +135,8 @@ struct uart_omap_port {
>  	unsigned int		errata;
>  	void (*enable_wakeup)(struct platform_device *, bool);
>  	bool (*chk_wakeup)(struct platform_device *);
> +
> +	bool			no_async_wake;
>  };
>  
>  #endif /* __OMAP_SERIAL_H__ */
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index eea478c..59f548f 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -1168,6 +1168,13 @@ static int serial_omap_suspend(struct device *dev)
>  		uart_suspend_port(&serial_omap_reg, &up->port);
>  		console_trylock();
>  		serial_omap_pm(&up->port, 3, 0);
> +
> +		/* OMAP2 dont have cpu_idle thread and async wakeup from prcm.
> +		 * For such socs clocks will be kept active from probe and
> +		 * cut only in suspend path.
> +		 */
> +		if (up->no_async_wake)
> +			serial_omap_port_disable(up);
>  	}
>  	return 0;
>  }
> @@ -1179,6 +1186,9 @@ static int serial_omap_resume(struct device *dev)
>  	if (up) {
>  		uart_resume_port(&serial_omap_reg, &up->port);
>  		console_unlock();
> +
> +		if (up->no_async_wake)
> +			serial_omap_port_enable(up);
>  	}
>  
>  	return 0;
> @@ -1402,6 +1412,7 @@ static int serial_omap_probe(struct platform_device *pdev)
>  	up->errata = omap_up_info->errata;
>  	up->enable_wakeup = omap_up_info->enable_wakeup;
>  	up->chk_wakeup = omap_up_info->chk_wakeup;
> +	up->no_async_wake = omap_up_info->no_async_wake;
>  
>  	if (omap_up_info->dma_enabled) {
>  		up->uart_dma.uart_dma_tx = dma_tx->start;
> @@ -1430,6 +1441,9 @@ static int serial_omap_probe(struct platform_device *pdev)
>  		serial_omap_port_disable(up);
>  	}
>  
> +	if (up->no_async_wake)
> +		serial_omap_port_enable(up);
> +
>  	ui[pdev->id] = up;
>  	serial_omap_add_console_port(up);

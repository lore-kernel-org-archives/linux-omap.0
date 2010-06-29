From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/3] OMAP3: PM: Conditional UART context save restore
Date: Tue, 29 Jun 2010 08:32:48 -0700
Message-ID: <87k4phua5b.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0323763482@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50370 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756572Ab0F2PkN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 11:40:13 -0400
Received: by pwj8 with SMTP id 8so3894414pwj.19
        for <linux-omap@vger.kernel.org>; Tue, 29 Jun 2010 08:40:10 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0323763482@dbde02.ent.ti.com>
	(Teerth Reddy's message of "Tue, 29 Jun 2010 12:29:02 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Reddy, Teerth" <teerth@ti.com> writes:

> From: Teerth Reddy <teerth@ti.com>
>
> Currently UART context save is done in idle thread thru a call
> to omap_uart_prepare_idle irrespective of what power state is 
> attained by the power domain to which the UART belongs to. This
> patch allows omap_uart_prepare_idle to take power state as a 
> parameter and this function in turn does a uart context save 
> only if the passed power state is PWRDM_POWER_OFF. In the restore
> path a restore will happen only if a valid save has happened.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Signed-off-by: Teerth Reddy <teerth@ti.com>

The idea is fine, but the implementation is not quite right.  Some
comments on that below.

I like this as it also removes the dependency on enable_off_mode.

That being said, I'd rather not spend much more time hacking on this
layer.  Soon, we will have the new omap-serial driver, and we will be
moving most of this PM smarts into the the omap-serial driver itself
using runtime PM.

> ---
>  arch/arm/mach-omap2/pm34xx.c             |    6 +++---
>  arch/arm/mach-omap2/serial.c             |   26 ++++++++++++++++----------
>  arch/arm/plat-omap/include/plat/serial.h |    2 +-
>  3 files changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 207905d..85a21e7 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -418,7 +418,7 @@ void omap_sram_idle(void)
>  			} else
>  				omap3_per_save_context();
>  		}
> -		omap_uart_prepare_idle(2);
> +		omap_uart_prepare_idle(2, per_next_state);
>  	}
>  
>  	if (pwrdm_read_pwrst(cam_pwrdm) == PWRDM_POWER_ON)
> @@ -426,8 +426,8 @@ void omap_sram_idle(void)
>  
>  	/* CORE */
>  	if (core_next_state < PWRDM_POWER_ON) {
> -		omap_uart_prepare_idle(0);
> -		omap_uart_prepare_idle(1);
> +		omap_uart_prepare_idle(0, core_next_state);
> +		omap_uart_prepare_idle(1, core_next_state);
>  		if (core_next_state == PWRDM_POWER_OFF) {
>  			omap3_core_save_context();
>  			omap3_prcm_save_context();
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index d545eed..85e09ef 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -185,9 +185,6 @@ static void omap_uart_save_context(struct omap_uart_state *uart)
>  	u16 lcr = 0;
>  	struct plat_serial8250_port *p = uart->p;
>  
> -	if (!enable_off_mode)
> -		return;
> -
>  	lcr = serial_read_reg(p, UART_LCR);
>  	serial_write_reg(p, UART_LCR, 0xBF);
>  	uart->dll = serial_read_reg(p, UART_DLL);
> @@ -206,9 +203,6 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)
>  	u16 efr = 0;
>  	struct plat_serial8250_port *p = uart->p;
>  
> -	if (!enable_off_mode)
> -		return;
> -
>  	if (!uart->context_valid)
>  		return;
>  
> @@ -252,12 +246,24 @@ static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
>  
>  #ifdef CONFIG_PM
>  
> -static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
> +static inline void omap_uart_disable_clocks(struct omap_uart_state *uart,
> +						int power_state)
>  {
>  	if (!uart->clocked)
>  		return;
>  
> -	omap_uart_save_context(uart);
> +	if (power_state == PWRDM_POWER_OFF) {
> +		if (uart->context_valid)
> +			return;

This check is done inside save_context

> +		if (!uart->clocked) {
> +			clk_enable(uart->ick);
> +			clk_enable(uart->fck);
> +		}

What is this for?  The first statement above checks for !uart->clocked
and returns, so this should never happen.

> +		omap_uart_save_context(uart);
> +	} else if (!uart->clocked) {
> +		return;

This else clause isn't needed.  It's already checked above.

> +	}
> +
>  	uart->clocked = 0;
>  	clk_disable(uart->ick);
>  	clk_disable(uart->fck);
> @@ -347,13 +353,13 @@ static void omap_uart_idle_timer(unsigned long data)
>  	omap_uart_allow_sleep(uart);
>  }
>  
> -void omap_uart_prepare_idle(int num)
> +void omap_uart_prepare_idle(int num, int power_state)
>  {
>  	struct omap_uart_state *uart;
>  
>  	list_for_each_entry(uart, &uart_list, node) {
>  		if (num == uart->num && uart->can_sleep) {
> -			omap_uart_disable_clocks(uart);
> +			omap_uart_disable_clocks(uart, power_state);
>  			return;
>  		}
>  	}
> diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
> index 19145f5..71ca2da 100644
> --- a/arch/arm/plat-omap/include/plat/serial.h
> +++ b/arch/arm/plat-omap/include/plat/serial.h
> @@ -99,7 +99,7 @@ extern void omap_serial_init_port(int port);
>  extern int omap_uart_can_sleep(void);
>  extern void omap_uart_check_wakeup(void);
>  extern void omap_uart_prepare_suspend(void);
> -extern void omap_uart_prepare_idle(int num);
> +extern void omap_uart_prepare_idle(int num, int power_state);
>  extern void omap_uart_resume_idle(int num);
>  extern void omap_uart_enable_irqs(int enable);
>  #endif

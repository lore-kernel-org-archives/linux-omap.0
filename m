From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/8] OMAP3 PM: Conditional UART context save restore.
Date: Fri, 22 Jan 2010 15:44:23 -0800
Message-ID: <878wbp3dt4.fsf@deeprootsystems.com>
References: <1264001442-20078-1-git-send-email-thara@ti.com>
	<1264001442-20078-2-git-send-email-thara@ti.com>
	<1264001442-20078-3-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:55075 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954Ab0AVXoZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jan 2010 18:44:25 -0500
Received: by pwi21 with SMTP id 21so1123410pwi.21
        for <linux-omap@vger.kernel.org>; Fri, 22 Jan 2010 15:44:25 -0800 (PST)
In-Reply-To: <1264001442-20078-3-git-send-email-thara@ti.com> (Thara Gopinath's message of "Wed\, 20 Jan 2010 21\:00\:36 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org

Thara Gopinath <thara@ti.com> writes:

> Currently UART context save is done in idle
> thread thru a call to omap_uart_prepare_idle irrespective of
> what power state is attained by the power domain to which
> the UART belongs to. This patch allows omap_uart_prepare_idle
> to take power state as a parameter and this function in
> turn does a uart context save only if the passed power state
> is PWRDM_POWER_OFF. In the restore path a restore will
> happen only if a valid save has happened.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

Nice.  Pulling this one into PM branch and queuing for 2.6.34.

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c             |    6 +++---
>  arch/arm/mach-omap2/serial.c             |   17 +++++++----------
>  arch/arm/plat-omap/include/plat/serial.h |    2 +-
>  3 files changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 8f5e819..895e9ef 100644
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
> @@ -435,8 +435,8 @@ void omap_sram_idle(void)
>  
>  	/* CORE */
>  	if (core_next_state < PWRDM_POWER_ON) {
> -		omap_uart_prepare_idle(0);
> -		omap_uart_prepare_idle(1);
> +		omap_uart_prepare_idle(0, core_next_state);
> +		omap_uart_prepare_idle(1, core_next_state);
>  		if (core_next_state == PWRDM_POWER_OFF) {
>  			u32 voltctrl = OMAP3430_AUTO_OFF;
>  
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 837b347..fb59d5f 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -168,9 +168,6 @@ static void omap_uart_save_context(struct omap_uart_state *uart)
>  	u16 lcr = 0;
>  	struct plat_serial8250_port *p = uart->p;
>  
> -	if (!enable_off_mode)
> -		return;
> -
>  	lcr = serial_read_reg(p, UART_LCR);
>  	serial_write_reg(p, UART_LCR, 0xBF);
>  	uart->dll = serial_read_reg(p, UART_DLL);
> @@ -189,9 +186,6 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)
>  	u16 efr = 0;
>  	struct plat_serial8250_port *p = uart->p;
>  
> -	if (!enable_off_mode)
> -		return;
> -
>  	if (!uart->context_valid)
>  		return;
>  
> @@ -235,12 +229,15 @@ static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
>  
>  #ifdef CONFIG_PM
>  
> -static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
> +static inline void omap_uart_disable_clocks(struct omap_uart_state *uart,
> +							int power_state)
>  {
>  	if (!uart->clocked)
>  		return;
>  
> -	omap_uart_save_context(uart);
> +	if (power_state == PWRDM_POWER_OFF)
> +		omap_uart_save_context(uart);
> +
>  	uart->clocked = 0;
>  	clk_disable(uart->ick);
>  	clk_disable(uart->fck);
> @@ -329,13 +326,13 @@ static void omap_uart_idle_timer(unsigned long data)
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
> index f5a4a92..ca76742 100644
> --- a/arch/arm/plat-omap/include/plat/serial.h
> +++ b/arch/arm/plat-omap/include/plat/serial.h
> @@ -57,7 +57,7 @@ extern void omap_serial_init_port(int port);
>  extern int omap_uart_can_sleep(void);
>  extern void omap_uart_check_wakeup(void);
>  extern void omap_uart_prepare_suspend(void);
> -extern void omap_uart_prepare_idle(int num);
> +extern void omap_uart_prepare_idle(int num, int power_state);
>  extern void omap_uart_resume_idle(int num);
>  extern void omap_uart_enable_irqs(int enable);
>  #endif
> -- 
> 1.5.6.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

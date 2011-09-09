From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 09/11] OMAP2+: Serial: Use prepare and resume calls to gate uart clocks
Date: Fri, 09 Sep 2011 11:59:49 -0700
Message-ID: <87ehzpv8wq.fsf@ti.com>
References: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
	<1315400013-4849-10-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:39205 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758646Ab1IIS75 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 14:59:57 -0400
In-Reply-To: <1315400013-4849-10-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Wed, 7 Sep 2011 18:23:31 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Currently we are using uart prepare and resume calls to gate uart clocks
> retaining the same method.
>
> More details on reason to retain this design is provided here:
> http://www.spinics.net/lists/linux-serial/msg04128.html

This type of thing can go after the '---' since it doesn't belong in the
permanent git history.

> Since prepare and resume hooks are moved to driver itself we can just use
> a single prepare and resume call. As in driver we traverse on number of uart
> instance and handle it accordingly.

Some important functionality has been removed (and not documented.)
Namely, the current code checks the next power when deciding whether or
not to call prepare_idle, and vice versa for resume_idle.

It's quite possible that it is no longer needed with the runtime PM 

> In 34xx uart can wakeup using module level PM_WKEN or IO PAD wakeup use
> resume_call from prcm irq handler to wakeup uart, based on chk_wakeup_status
> from io_pad or PM_WKST.

IMO, this patch should just replace the mulitple calls with a single
call, but still in the idle path.

Using the PRCM IRQ handler should be a separate patch with it's own
changelog.

> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

Also, moving these calls to the driver means that the driver cannot be
built as a module:

arch/arm/mach-omap2/built-in.o: In function `omap2_enter_full_retention':
/work/kernel/omap/pm/arch/arm/mach-omap2/pm24xx.c:141: undefined reference to `omap_uart_prepare_idle'
/work/kernel/omap/pm/arch/arm/mach-omap2/pm24xx.c:148: undefined reference to `omap_uart_resume_idle'
arch/arm/mach-omap2/built-in.o: In function `prcm_clear_mod_irqs':
/work/kernel/omap/pm/arch/arm/mach-omap2/pm34xx.c:213: undefined reference to `omap_uart_resume_idle'
arch/arm/mach-omap2/built-in.o: In function `omap_sram_idle':
/work/kernel/omap/pm/arch/arm/mach-omap2/pm34xx.c:390: undefined reference to `omap_uart_prepare_idle'

> ---
>  arch/arm/mach-omap2/pm24xx.c             |    8 +----
>  arch/arm/mach-omap2/pm34xx.c             |   17 +++++-------
>  arch/arm/plat-omap/include/plat/serial.h |    4 +-
>  drivers/tty/serial/omap-serial.c         |   40 ++++++++++++++++++++++++++++++
>  4 files changed, 51 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
> index 39f26af..91eacef 100644
> --- a/arch/arm/mach-omap2/pm24xx.c
> +++ b/arch/arm/mach-omap2/pm24xx.c
> @@ -138,18 +138,14 @@ static void omap2_enter_full_retention(void)
>  		if (!console_trylock())
>  			goto no_sleep;
>  
> -	omap_uart_prepare_idle(0);
> -	omap_uart_prepare_idle(1);
> -	omap_uart_prepare_idle(2);
> +	omap_uart_prepare_idle();
>  
>  	/* Jump to SRAM suspend code */
>  	omap2_sram_suspend(sdrc_read_reg(SDRC_DLLA_CTRL),
>  			   OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL),
>  			   OMAP_SDRC_REGADDR(SDRC_POWER));
>  
> -	omap_uart_resume_idle(2);
> -	omap_uart_resume_idle(1);
> -	omap_uart_resume_idle(0);
> +	omap_uart_resume_idle();
>  
>  	if (!is_suspending())
>  		console_unlock();
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 9f3bf2c..26ddd56 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -210,6 +210,7 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs)
>  
>  	wkst = omap2_prm_read_mod_reg(module, wkst_off);
>  	wkst &= omap2_prm_read_mod_reg(module, grpsel_off);
> +	c += omap_uart_resume_idle();
>  	if (wkst) {
>  		iclk = omap2_cm_read_mod_reg(module, iclk_off);
>  		fclk = omap2_cm_read_mod_reg(module, fclk_off);
> @@ -380,17 +381,19 @@ void omap_sram_idle(void)
>  	}
>  
>  	/* Block console output in case it is on one of the OMAP UARTs */
> -	if (!is_suspending())
> +	if (!is_suspending()) {
>  		if (per_next_state < PWRDM_POWER_ON ||
> -		    core_next_state < PWRDM_POWER_ON)
> +		    core_next_state < PWRDM_POWER_ON) {
>  			if (!console_trylock())
>  				goto console_still_active;
> +			else
> +				omap_uart_prepare_idle();
> +		}
> +	}
>  
>  	/* PER */
>  	if (per_next_state < PWRDM_POWER_ON) {
>  		per_going_off = (per_next_state == PWRDM_POWER_OFF) ? 1 : 0;
> -		omap_uart_prepare_idle(2);
> -		omap_uart_prepare_idle(3);
>  		omap2_gpio_prepare_for_idle(per_going_off);
>  		if (per_next_state == PWRDM_POWER_OFF)
>  				omap3_per_save_context();
> @@ -398,8 +401,6 @@ void omap_sram_idle(void)
>  
>  	/* CORE */
>  	if (core_next_state < PWRDM_POWER_ON) {
> -		omap_uart_prepare_idle(0);
> -		omap_uart_prepare_idle(1);
>  		if (core_next_state == PWRDM_POWER_OFF) {
>  			omap3_core_save_context();
>  			omap3_cm_save_context();
> @@ -446,8 +447,6 @@ void omap_sram_idle(void)
>  			omap3_sram_restore_context();
>  			omap2_sms_restore_context();
>  		}
> -		omap_uart_resume_idle(0);
> -		omap_uart_resume_idle(1);
>  		if (core_next_state == PWRDM_POWER_OFF)
>  			omap2_prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
>  					       OMAP3430_GR_MOD,
> @@ -461,8 +460,6 @@ void omap_sram_idle(void)
>  		omap2_gpio_resume_after_idle();
>  		if (per_prev_state == PWRDM_POWER_OFF)
>  			omap3_per_restore_context();
> -		omap_uart_resume_idle(2);
> -		omap_uart_resume_idle(3);
>  	}
>  
>  	if (!is_suspending())
> diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
> index bfd73b7..5b8c8f2 100644
> --- a/arch/arm/plat-omap/include/plat/serial.h
> +++ b/arch/arm/plat-omap/include/plat/serial.h
> @@ -109,8 +109,8 @@ struct omap_board_data;
>  
>  extern void omap_serial_init(void);
>  extern void omap_serial_init_port(struct omap_board_data *bdata);
> -extern void omap_uart_prepare_idle(int num);
> -extern void omap_uart_resume_idle(int num);
> +extern void omap_uart_prepare_idle(void);
> +extern int omap_uart_resume_idle(void);
>  #endif
>  
>  #endif
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 96fc860..05c2f52 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -54,6 +54,46 @@ static void serial_omap_rx_timeout(unsigned long uart_no);
>  static int serial_omap_start_rxdma(struct uart_omap_port *up);
>  static void omap_uart_mdr1_errataset(struct uart_omap_port *up, u8 mdr1);
>  
> +int omap_uart_resume_idle()
> +{
> +	struct uart_omap_port *up;
> +	int i, ret = 0;
> +
> +	for (i = 0; i < OMAP_MAX_HSUART_PORTS; i++) {
> +		up = ui[i];
> +		if (!up)
> +			continue;
> +
> +		if (!up->clocked && up->chk_wakeup(up->pdev)) {
> +			pm_runtime_get_sync(&up->pdev->dev);
> +			up->clocked = 1;
> +			ret++;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +void omap_uart_prepare_idle()
> +{
> +	struct uart_omap_port *up;
> +	int i;
> +
> +	for (i = 0; i < OMAP_MAX_HSUART_PORTS; i++) {
> +		up = ui[i];
> +		if (!up)
> +			continue;
> +
> +		if (up->clocked &&
> +				jiffies_to_msecs(jiffies - up->port_activity)
> +					> 3000) {

What is this check for?

> +			pm_runtime_mark_last_busy(&up->pdev->dev);
> +			pm_runtime_put_autosuspend(&up->pdev->dev);
> +			up->clocked = 0;
> +		}
> +	}
> +}
> +
>  static inline unsigned int serial_in(struct uart_omap_port *up, int offset)
>  {
>  	offset <<= up->port.regshift;

Kevin

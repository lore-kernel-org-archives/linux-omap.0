From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 07/15] OMAP: GPIO: handle save/restore ctx in GPIO driver
Date: Wed, 25 May 2011 15:33:51 -0700
Message-ID: <87ipsypfzk.fsf@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-8-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:47064 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932090Ab1EYWdz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 18:33:55 -0400
Received: by mail-px0-f175.google.com with SMTP id 17so80633pxi.34
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 15:33:54 -0700 (PDT)
In-Reply-To: <1306247094-25372-8-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 24 May 2011 19:54:46 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> Modify omap_gpio_prepare_for_idle() & omap_gpio_resume_after_idle()
> functions to handle save context & restore context respectively in the
> OMAP GPIO driver itself instead of calling these functions from pm specific
> files. For this, in gpio_prepare_for_idle(), use
> omap_device_get_context_loss_count() and in gpio_resume_after_idle()
> call it again. If the count is different, do restore context.
>
> context lost count is modified in omap_sram_idle() path when
> pwrdm_post_transition() is called. But pwrdm_post_transition() is called
> only after omap_gpio_resume_after_idle() is called. Hence correct this
> so that context lost count is modified before calling
> omap_gpio_resume_after_idle().

This change to modify where pwrdm_post_transition() is called should be
separated out into a dedicated patch. 

> omap_gpio_prepare_for_idle() & omap_gpio_resume_after_idle()
> do nothing if none of the GPIOs in a bank is being used.
>
> Also remove usage of cpu_is_* checks from the above mentioned
> functions and fix the multi-line comment style
>
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c           |   22 +----
>  arch/arm/plat-omap/include/plat/gpio.h |    2 -
>  drivers/gpio/gpio_omap.c               |  138 +++++++++++++++++---------------
>  3 files changed, 78 insertions(+), 84 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 0c5e3a4..682d147 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -91,16 +91,6 @@ static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
>  static struct powerdomain *core_pwrdm, *per_pwrdm;
>  static struct powerdomain *cam_pwrdm;
>  
> -static inline void omap3_per_save_context(void)
> -{
> -	omap_gpio_save_context();
> -}
> -
> -static inline void omap3_per_restore_context(void)
> -{
> -	omap_gpio_restore_context();
> -}
> -
>  static void omap3_enable_io_chain(void)
>  {
>  	int timeout = 0;
> @@ -395,8 +385,10 @@ void omap_sram_idle(void)
>  	if (!is_suspending())
>  		if (per_next_state < PWRDM_POWER_ON ||
>  		    core_next_state < PWRDM_POWER_ON)
> -			if (!console_trylock())
> +			if (!console_trylock()) {
> +				pwrdm_post_transition();
>  				goto console_still_active;
> +			}

Rather than having to add an extra post_transition call, I think i best
to move the pre_transition call down to just before the following 
/* PER */ block.

>  
>  	/* PER */
>  	if (per_next_state < PWRDM_POWER_ON) {
> @@ -404,8 +396,6 @@ void omap_sram_idle(void)
>  		omap_uart_prepare_idle(2);
>  		omap_uart_prepare_idle(3);
>  		omap2_gpio_prepare_for_idle(per_going_off);
> -		if (per_next_state == PWRDM_POWER_OFF)
> -				omap3_per_save_context();
>  	}
>  
>  	/* CORE */
> @@ -467,12 +457,12 @@ void omap_sram_idle(void)
>  	}
>  	omap3_intc_resume_idle();
>  
> +	pwrdm_post_transition();
> +
>  	/* PER */
>  	if (per_next_state < PWRDM_POWER_ON) {
>  		per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
>  		omap2_gpio_resume_after_idle();
> -		if (per_prev_state == PWRDM_POWER_OFF)
> -			omap3_per_restore_context();
>  		omap_uart_resume_idle(2);
>  		omap_uart_resume_idle(3);
>  	}
> @@ -490,8 +480,6 @@ console_still_active:
>  		omap3_disable_io_chain();
>  	}
>  
> -	pwrdm_post_transition();
> -
>  	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
>  }
>  
> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
> index 64b1ee7..5718a45 100644
> --- a/arch/arm/plat-omap/include/plat/gpio.h
> +++ b/arch/arm/plat-omap/include/plat/gpio.h
> @@ -209,8 +209,6 @@ extern void omap2_gpio_prepare_for_idle(int off_mode);
>  extern void omap2_gpio_resume_after_idle(void);
>  extern void omap_set_gpio_debounce(int gpio, int enable);
>  extern void omap_set_gpio_debounce_time(int gpio, int enable);
> -extern void omap_gpio_save_context(void);
> -extern void omap_gpio_restore_context(void);
>  /*-------------------------------------------------------------------------*/
>  
>  /* Wrappers for "new style" GPIO calls, using the new infrastructure
> diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
> index 9d55b7d..bc02ec5 100644
> --- a/drivers/gpio/gpio_omap.c
> +++ b/drivers/gpio/gpio_omap.c
> @@ -22,6 +22,8 @@
>  #include <linux/slab.h>
>  #include <linux/pm_runtime.h>
>  
> +#include <plat/omap_device.h>
> +

Should not be needed.  More on this below.

>  #include <mach/hardware.h>
>  #include <asm/irq.h>
>  #include <mach/irqs.h>
> @@ -72,6 +74,7 @@ struct gpio_bank {
>  	bool loses_context;
>  	int stride;
>  	u32 width;
> +	u32 ctx_lost_cnt_before;

Please call this ctx_loss_count.

>  	u16 id;
>  
>  	void (*set_dataout)(struct gpio_bank *bank, int gpio, int enable);
> @@ -1310,6 +1313,9 @@ static struct sys_device omap_gpio_device = {
>  
>  #ifdef CONFIG_ARCH_OMAP2PLUS
>  
> +static void omap_gpio_save_context(struct gpio_bank *bank);
> +static void omap_gpio_restore_context(struct gpio_bank *bank);
> +
>  static int workaround_enabled;
>  
>  void omap2_gpio_prepare_for_idle(int off_mode)
> @@ -1318,6 +1324,7 @@ void omap2_gpio_prepare_for_idle(int off_mode)
>  	struct gpio_bank *bank;
>  
>  	list_for_each_entry(bank, &omap_gpio_list, node) {
> +		struct platform_device *pdev;
>  		u32 l1 = 0, l2 = 0;
>  		int j;
>  
> @@ -1334,7 +1341,7 @@ void omap2_gpio_prepare_for_idle(int off_mode)
>  		 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
>  		 * generated.  See OMAP2420 Errata item 1.101. */
>  		if (!(bank->enabled_non_wakeup_gpios))
> -			continue;
> +			goto save_gpio_ctx;
>  
>  		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
>  			bank->saved_datain = __raw_readl(bank->base +
> @@ -1372,6 +1379,12 @@ void omap2_gpio_prepare_for_idle(int off_mode)
>  		}
>  
>  		c++;
> +
> +save_gpio_ctx:
> +		pdev = to_platform_device(bank->dev);
> +		bank->ctx_lost_cnt_before =
> +				omap_device_get_context_loss_count(pdev);

Drivers should not be directly calling omap_device APIs.  Instead,
drivers should use a pdata function pointer to call device specific
code for getting context loss.  See OMAP HSMMC driver for an example on
how this is done.

> +		omap_gpio_save_context(bank);
>  	}
>  	if (!c) {
>  		workaround_enabled = 0;
> @@ -1385,6 +1398,8 @@ void omap2_gpio_resume_after_idle(void)
>  	struct gpio_bank *bank;
>  
>  	list_for_each_entry(bank, &omap_gpio_list, node) {
> +		u32 ctx_lost_cnt_after;
> +		struct platform_device *pdev;
>  		u32 l = 0, gen, gen0, gen1;
>  		int j;
>  
> @@ -1394,11 +1409,17 @@ void omap2_gpio_resume_after_idle(void)
>  		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
>  			clk_enable(bank->dbck);
>  
> -		if (!workaround_enabled)
> +		pdev = to_platform_device(bank->dev);
> +		ctx_lost_cnt_after = omap_device_get_context_loss_count(pdev);
> +
> +		if (ctx_lost_cnt_after == bank->ctx_lost_cnt_before)
>  			continue;
>  
> +		if (!workaround_enabled)
> +			goto restore_gpio_ctx;

Now that these functions are all bank-specific, this
'workaround_enabled' flag should be made per-bank.

That being said, do we even need this flag?  I think that the
combination of enabled_non_wakeup_gpios and whether or not context has
been lost reflects the same condition.

>  		if (!(bank->enabled_non_wakeup_gpios))
> -			continue;
> +			goto restore_gpio_ctx;
>  
>  		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
>  			__raw_writel(bank->saved_fallingdetect,
> @@ -1472,117 +1493,104 @@ void omap2_gpio_resume_after_idle(void)
>  						OMAP4_GPIO_LEVELDETECT1);
>  			}
>  		}
> +
> +restore_gpio_ctx:
> +		omap_gpio_restore_context(bank);

After considering the placement of the restore context here, I don't
think it's quite right.  It is equivalent to current behavior, but I'm
having a hard time understanding how current behavior is actually
working.

Consider the sequence

- prepare for idle
- remove triggering
  - save edge-detect registers, then modify them to "workaround" values
- save context (w/ "workaround" edge-detect register values
- WFI, off-mode hit
- wakeup, resume from idle
- write "saved" values to edge-detect registers
- restore context
  - here the "workaround" values from the saved context are restored !!!
    so the "saved" values are now lost.

For this to be symmetric with the save, I think the restore context
should come before handling the workaround/hack.

Kevin

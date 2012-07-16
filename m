From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC 1/6] ARM: OMAP3: PRM: move prcm interrupt handlers to PRM
 driver code
Date: Mon, 16 Jul 2012 16:56:25 +0530
Message-ID: <5003FA61.2050003@ti.com>
References: <1342197459-7920-1-git-send-email-t-kristo@ti.com> <1342197459-7920-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:58303 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752245Ab2GPL0r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jul 2012 07:26:47 -0400
Received: by obbwd20 with SMTP id wd20so11479418obb.23
        for <linux-omap@vger.kernel.org>; Mon, 16 Jul 2012 04:26:31 -0700 (PDT)
In-Reply-To: <1342197459-7920-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Friday 13 July 2012 10:07 PM, Tero Kristo wrote:
> PM code doesn't really care about the PRCM wakeup + io interrupts on
> OMAP3, as these are used only for acking PRCM internal events, and the
> IO chain handler is taken care of by hwmod code. Thus move the interrupt
> handling logic from pm34xx.c to prm2xxx_3xxx.c file. This patch also
> includes a minor cleanup for removing the priority handling and replacing
> it with a mechanism for acking pending events. This gets rid of the need
> for registering the shared interrupt handlers in specific order.

It would be easier to review if you were to split this into 2 patches,
one which moves functions around as-is and another which does the
cleanup/optimization. Having both in one is kinda hard to review.

>
> Signed-off-by: Tero Kristo<t-kristo@ti.com>
> ---
>   arch/arm/mach-omap2/pm34xx.c       |  109 +------------------------------
>   arch/arm/mach-omap2/prcm-common.h  |   10 ++--
>   arch/arm/mach-omap2/prm2xxx_3xxx.c |  124 ++++++++++++++++++++++++++++++++++--
>   arch/arm/mach-omap2/prm2xxx_3xxx.h |    1 +
>   arch/arm/mach-omap2/prm44xx.c      |    4 +-
>   arch/arm/mach-omap2/prm_common.c   |   42 ++----------
>   6 files changed, 138 insertions(+), 152 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index d25a9d8..474ed9d 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -133,85 +133,6 @@ static void omap3_save_secure_ram_context(void)
>   	}
>   }
>
> -/*
> - * PRCM Interrupt Handler Helper Function
> - *
> - * The purpose of this function is to clear any wake-up events latched
> - * in the PRCM PM_WKST_x registers. It is possible that a wake-up event
> - * may occur whilst attempting to clear a PM_WKST_x register and thus
> - * set another bit in this register. A while loop is used to ensure
> - * that any peripheral wake-up events occurring while attempting to
> - * clear the PM_WKST_x are detected and cleared.
> - */
> -static int prcm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits)
> -{
> -	u32 wkst, fclk, iclk, clken;
> -	u16 wkst_off = (regs == 3) ? OMAP3430ES2_PM_WKST3 : PM_WKST1;
> -	u16 fclk_off = (regs == 3) ? OMAP3430ES2_CM_FCLKEN3 : CM_FCLKEN1;
> -	u16 iclk_off = (regs == 3) ? CM_ICLKEN3 : CM_ICLKEN1;
> -	u16 grpsel_off = (regs == 3) ?
> -		OMAP3430ES2_PM_MPUGRPSEL3 : OMAP3430_PM_MPUGRPSEL;
> -	int c = 0;
> -
> -	wkst = omap2_prm_read_mod_reg(module, wkst_off);
> -	wkst&= omap2_prm_read_mod_reg(module, grpsel_off);
> -	wkst&= ~ignore_bits;
> -	if (wkst) {
> -		iclk = omap2_cm_read_mod_reg(module, iclk_off);
> -		fclk = omap2_cm_read_mod_reg(module, fclk_off);
> -		while (wkst) {
> -			clken = wkst;
> -			omap2_cm_set_mod_reg_bits(clken, module, iclk_off);
> -			/*
> -			 * For USBHOST, we don't know whether HOST1 or
> -			 * HOST2 woke us up, so enable both f-clocks
> -			 */
> -			if (module == OMAP3430ES2_USBHOST_MOD)
> -				clken |= 1<<  OMAP3430ES2_EN_USBHOST2_SHIFT;
> -			omap2_cm_set_mod_reg_bits(clken, module, fclk_off);
> -			omap2_prm_write_mod_reg(wkst, module, wkst_off);
> -			wkst = omap2_prm_read_mod_reg(module, wkst_off);
> -			wkst&= ~ignore_bits;
> -			c++;
> -		}
> -		omap2_cm_write_mod_reg(iclk, module, iclk_off);
> -		omap2_cm_write_mod_reg(fclk, module, fclk_off);
> -	}
> -
> -	return c;
> -}
> -
> -static irqreturn_t _prcm_int_handle_io(int irq, void *unused)
> -{
> -	int c;
> -
> -	c = prcm_clear_mod_irqs(WKUP_MOD, 1,
> -		~(OMAP3430_ST_IO_MASK | OMAP3430_ST_IO_CHAIN_MASK));
> -
> -	return c ? IRQ_HANDLED : IRQ_NONE;
> -}
> -
> -static irqreturn_t _prcm_int_handle_wakeup(int irq, void *unused)
> -{
> -	int c;
> -
> -	/*
> -	 * Clear all except ST_IO and ST_IO_CHAIN for wkup module,
> -	 * these are handled in a separate handler to avoid acking
> -	 * IO events before parsing in mux code
> -	 */
> -	c = prcm_clear_mod_irqs(WKUP_MOD, 1,
> -		OMAP3430_ST_IO_MASK | OMAP3430_ST_IO_CHAIN_MASK);
> -	c += prcm_clear_mod_irqs(CORE_MOD, 1, 0);
> -	c += prcm_clear_mod_irqs(OMAP3430_PER_MOD, 1, 0);
> -	if (omap_rev()>  OMAP3430_REV_ES1_0) {
> -		c += prcm_clear_mod_irqs(CORE_MOD, 3, 0);
> -		c += prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1, 0);
> -	}
> -
> -	return c ? IRQ_HANDLED : IRQ_NONE;
> -}
> -
>   static void omap34xx_save_context(u32 *save)
>   {
>   	u32 val;
> @@ -671,29 +592,10 @@ int __init omap3_pm_init(void)
>   	 * supervised mode for powerdomains */
>   	prcm_setup_regs();
>
> -	ret = request_irq(omap_prcm_event_to_irq("wkup"),
> -		_prcm_int_handle_wakeup, IRQF_NO_SUSPEND, "pm_wkup", NULL);
> -
> -	if (ret) {
> -		pr_err("pm: Failed to request pm_wkup irq\n");
> -		goto err1;
> -	}
> -
> -	/* IO interrupt is shared with mux code */
> -	ret = request_irq(omap_prcm_event_to_irq("io"),
> -		_prcm_int_handle_io, IRQF_SHARED | IRQF_NO_SUSPEND, "pm_io",
> -		omap3_pm_init);
> -	enable_irq(omap_prcm_event_to_irq("io"));
> -
> -	if (ret) {
> -		pr_err("pm: Failed to request pm_io irq\n");
> -		goto err2;
> -	}
> -
>   	ret = pwrdm_for_each(pwrdms_setup, NULL);
>   	if (ret) {
>   		pr_err("Failed to setup powerdomains\n");
> -		goto err3;
> +		goto err;
>   	}
>
>   	(void) clkdm_for_each(omap_pm_clkdms_setup, NULL);
> @@ -702,7 +604,7 @@ int __init omap3_pm_init(void)
>   	if (mpu_pwrdm == NULL) {
>   		pr_err("Failed to get mpu_pwrdm\n");
>   		ret = -EINVAL;
> -		goto err3;
> +		goto err;
>   	}
>
>   	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
> @@ -750,14 +652,11 @@ int __init omap3_pm_init(void)
>   	omap3_save_scratchpad_contents();
>   	return ret;
>
> -err3:
> +err:
>   	list_for_each_entry_safe(pwrst, tmp,&pwrst_list, node) {
>   		list_del(&pwrst->node);
>   		kfree(pwrst);
>   	}
> -	free_irq(omap_prcm_event_to_irq("io"), omap3_pm_init);
> -err2:
> -	free_irq(omap_prcm_event_to_irq("wkup"), NULL);
> -err1:
> +
>   	return ret;
>   }
> diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
> index fca23cb..ad23bb4 100644
> --- a/arch/arm/mach-omap2/prcm-common.h
> +++ b/arch/arm/mach-omap2/prcm-common.h
> @@ -466,6 +466,7 @@ struct omap_prcm_irq {
>    * @ocp_barrier: fn ptr to force buffered PRM writes to complete
>    * @save_and_clear_irqen: fn ptr to save and clear IRQENABLE regs
>    * @restore_irqen: fn ptr to save and clear IRQENABLE regs
> + * @ack_pending_events: fn ptr to ack pending events after handling
>    * @saved_mask: IRQENABLE regs are saved here during suspend
>    * @priority_mask: 1 bit per IRQ, set to 1 if omap_prcm_irq.priority = true
>    * @base_irq: base dynamic IRQ number, returned from irq_alloc_descs() in init
> @@ -487,18 +488,17 @@ struct omap_prcm_irq_setup {
>   	void (*ocp_barrier)(void);
>   	void (*save_and_clear_irqen)(u32 *saved_mask);
>   	void (*restore_irqen)(u32 *saved_mask);
> +	void (*ack_pending_events)(unsigned long *events);
>   	u32 *saved_mask;
> -	u32 *priority_mask;
>   	int base_irq;
>   	bool suspended;
>   	bool suspend_save_flag;
>   };
>
>   /* OMAP_PRCM_IRQ: convenience macro for creating struct omap_prcm_irq records */
> -#define OMAP_PRCM_IRQ(_name, _offset, _priority) {	\
> -	.name = _name,					\
> -	.offset = _offset,				\
> -	.priority = _priority				\
> +#define OMAP_PRCM_IRQ(_name, _offset) {	\
> +	.name = _name,			\
> +	.offset = _offset,		\
>   	}
>
>   extern void omap_prcm_irq_cleanup(void);
> diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
> index a0309de..3761019 100644
> --- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
> +++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
> @@ -16,6 +16,7 @@
>   #include<linux/err.h>
>   #include<linux/io.h>
>   #include<linux/irq.h>
> +#include<linux/interrupt.h>
>
>   #include "common.h"
>   #include<plat/cpu.h>
> @@ -28,10 +29,11 @@
>   #include "cm2xxx_3xxx.h"
>   #include "prm-regbits-24xx.h"
>   #include "prm-regbits-34xx.h"
> +#include "cm-regbits-34xx.h"
>
>   static const struct omap_prcm_irq omap3_prcm_irqs[] = {
> -	OMAP_PRCM_IRQ("wkup",	0,	0),
> -	OMAP_PRCM_IRQ("io",	9,	1),
> +	OMAP_PRCM_IRQ("wkup",	0),
> +	OMAP_PRCM_IRQ("io",	9),
>   };
>
>   static struct omap_prcm_irq_setup omap3_prcm_irq_setup = {
> @@ -45,6 +47,7 @@ static struct omap_prcm_irq_setup omap3_prcm_irq_setup = {
>   	.ocp_barrier		=&omap3xxx_prm_ocp_barrier,
>   	.save_and_clear_irqen	=&omap3xxx_prm_save_and_clear_irqen,
>   	.restore_irqen		=&omap3xxx_prm_restore_irqen,
> +	.ack_pending_events	=&omap3xxx_prm_clear_wakeups,
>   };
>
>   u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
> @@ -349,18 +352,127 @@ static void __init omap3xxx_prm_enable_io_wakeup(void)
>   					   PM_WKEN);
>   }
>
> +/**
> + * prcm_clear_mod_irqs - clear module level wakeup irqs for omap3
> + * @module: prm module to clear
> + * @regs: register set to use, either 1 or 3
> + *
> + * The purpose of this function is to clear any wake-up events latched
> + * in the PRCM PM_WKST_x registers. It is possible that a wake-up event
> + * may occur whilst attempting to clear a PM_WKST_x register and thus
> + * set another bit in this register. A while loop is used to ensure
> + * that any peripheral wake-up events occurring while attempting to
> + * clear the PM_WKST_x are detected and cleared. Returns the number
> + * of active wakeup events detected, or 0 if none.
> + */
> +static int _prcm_clear_mod_irqs(s16 module, u8 regs)
> +{
> +	u32 wkst, fclk, iclk, clken;
> +	u16 wkst_off = (regs == 3) ? OMAP3430ES2_PM_WKST3 : PM_WKST1;
> +	u16 fclk_off = (regs == 3) ? OMAP3430ES2_CM_FCLKEN3 : CM_FCLKEN1;
> +	u16 iclk_off = (regs == 3) ? CM_ICLKEN3 : CM_ICLKEN1;
> +	u16 grpsel_off = (regs == 3) ?
> +		OMAP3430ES2_PM_MPUGRPSEL3 : OMAP3430_PM_MPUGRPSEL;
> +	int c = 0;
> +
> +	wkst = omap2_prm_read_mod_reg(module, wkst_off);
> +	wkst&= omap2_prm_read_mod_reg(module, grpsel_off);
> +	if (wkst) {
> +		iclk = omap2_cm_read_mod_reg(module, iclk_off);
> +		fclk = omap2_cm_read_mod_reg(module, fclk_off);
> +		while (wkst) {
> +			clken = wkst;
> +			omap2_cm_set_mod_reg_bits(clken, module, iclk_off);
> +			/*
> +			 * For USBHOST, we don't know whether HOST1 or
> +			 * HOST2 woke us up, so enable both f-clocks
> +			 */
> +			if (module == OMAP3430ES2_USBHOST_MOD)
> +				clken |= 1<<  OMAP3430ES2_EN_USBHOST2_SHIFT;
> +			omap2_cm_set_mod_reg_bits(clken, module, fclk_off);
> +			omap2_prm_write_mod_reg(wkst, module, wkst_off);
> +			wkst = omap2_prm_read_mod_reg(module, wkst_off);
> +			c++;
> +		}
> +		omap2_cm_write_mod_reg(iclk, module, iclk_off);
> +		omap2_cm_write_mod_reg(fclk, module, fclk_off);
> +	}
> +
> +	return c;
> +}
> +
> +/**
> + * omap3xxx_prm_clear_wakeups - clears wakeup event sources
> + * @events: active PRCM interrupt event mask
> + *
> + * This function will first check if PRCM chain handler detected
> + * a wakeup event or not. If yes, it will continue to clear any
> + * pending wakeup events from PRCM module. Typically the module
> + * will generate an actual interrupt together with the wakeup event,
> + * which will then be handled separately by the driver code.
> + */
> +void omap3xxx_prm_clear_wakeups(unsigned long *events)
> +{
> +	int c;
> +
> +	/*
> +	 * If we didn't come here because of a wakeup event, do nothing
> +	 */
> +	if (!(events[0]&  OMAP3430_WKUP_ST_MASK))
> +		return;
> +
> +	c = _prcm_clear_mod_irqs(WKUP_MOD, 1);
> +	c += _prcm_clear_mod_irqs(CORE_MOD, 1);
> +	c += _prcm_clear_mod_irqs(OMAP3430_PER_MOD, 1);
> +	if (omap_rev()>  OMAP3430_REV_ES1_0) {
> +		c += _prcm_clear_mod_irqs(CORE_MOD, 3);
> +		c += _prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1);
> +	}
> +}
> +
> +/**
> + * _prcm_int_handle_wakeup - dummy irq handler for prcm wakeup event
> + * @irq: not used, irq common API
> + * @unused: not used, irq common API
> + *
> + * Dummy handler for PRCM wakeup event interrupt. On software level,
> + * this handler doesn't do anything, but it is needed for hardware
> + * to function properly. Adding this handler will enable the wakeup
> + * event generation from PRCM, which is needed to get CPU out of
> + * WFI. Otherwise the CPU will get stuck on the WFI instruction
> + * indefinitely, as the MPU powerdomain remains idle.
> + */
> +static irqreturn_t _prcm_int_handle_wakeup(int irq, void *unused)
> +{
> +	return IRQ_HANDLED;
> +}
> +
>   static int __init omap3xxx_prcm_init(void)
>   {
> -	int ret = 0;
> +	int ret;
>
>   	if (cpu_is_omap34xx()) {
>   		omap3xxx_prm_enable_io_wakeup();
>   		ret = omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
> -		if (!ret)
> -			irq_set_status_flags(omap_prcm_event_to_irq("io"),
> -					     IRQ_NOAUTOEN);
> +		if (ret) {
> +			pr_err("%s: failed to register chain handler: %d\n",
> +				__func__, ret);
> +			return ret;
> +		}
> +
> +		ret = request_irq(omap_prcm_event_to_irq("wkup"),
> +			_prcm_int_handle_wakeup, IRQF_NO_SUSPEND, "prcm_wkup",
> +			NULL);
> +		if (ret) {
> +			pr_err("%s: failed to request prcm_wkup irq: %d\n",
> +				__func__, ret);
> +			goto err;
> +		}
>   	}
>
> +	return 0;
> +err:
> +	omap_prcm_irq_cleanup();
>   	return ret;
>   }
>   subsys_initcall(omap3xxx_prcm_init);
> diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
> index 1ba3d65..078df35 100644
> --- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
> +++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
> @@ -322,6 +322,7 @@ extern void omap3xxx_prm_read_pending_irqs(unsigned long *events);
>   extern void omap3xxx_prm_ocp_barrier(void);
>   extern void omap3xxx_prm_save_and_clear_irqen(u32 *saved_mask);
>   extern void omap3xxx_prm_restore_irqen(u32 *saved_mask);
> +extern void omap3xxx_prm_clear_wakeups(unsigned long *events);
>
>   #endif	/* CONFIG_ARCH_OMAP4 */
>
> diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
> index bb727c2..fd26279 100644
> --- a/arch/arm/mach-omap2/prm44xx.c
> +++ b/arch/arm/mach-omap2/prm44xx.c
> @@ -30,8 +30,8 @@
>   #include "prminst44xx.h"
>
>   static const struct omap_prcm_irq omap4_prcm_irqs[] = {
> -	OMAP_PRCM_IRQ("wkup",   0,      0),
> -	OMAP_PRCM_IRQ("io",     9,      1),
> +	OMAP_PRCM_IRQ("wkup",	0),
> +	OMAP_PRCM_IRQ("io",	9),
>   };
>
>   static struct omap_prcm_irq_setup omap4_prcm_irq_setup = {
> diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
> index dfe00dd..4643651 100644
> --- a/arch/arm/mach-omap2/prm_common.c
> +++ b/arch/arm/mach-omap2/prm_common.c
> @@ -57,21 +57,6 @@ static struct omap_prcm_irq_setup *prcm_irq_setup;
>   /* Private functions */
>
>   /*
> - * Move priority events from events to priority_events array
> - */
> -static void omap_prcm_events_filter_priority(unsigned long *events,
> -	unsigned long *priority_events)
> -{
> -	int i;
> -
> -	for (i = 0; i<  prcm_irq_setup->nr_regs; i++) {
> -		priority_events[i] =
> -			events[i]&  prcm_irq_setup->priority_mask[i];
> -		events[i] ^= priority_events[i];
> -	}
> -}
> -
> -/*
>    * PRCM Interrupt Handler
>    *
>    * This is a common handler for the OMAP PRCM interrupts. Pending
> @@ -82,7 +67,6 @@ static void omap_prcm_events_filter_priority(unsigned long *events,
>   static void omap_prcm_irq_handler(unsigned int irq, struct irq_desc *desc)
>   {
>   	unsigned long pending[OMAP_PRCM_MAX_NR_PENDING_REG];
> -	unsigned long priority_pending[OMAP_PRCM_MAX_NR_PENDING_REG];
>   	struct irq_chip *chip = irq_desc_get_chip(desc);
>   	unsigned int virtirq;
>   	int nr_irqs = prcm_irq_setup->nr_regs * 32;
> @@ -113,20 +97,19 @@ static void omap_prcm_irq_handler(unsigned int irq, struct irq_desc *desc)
>   		if (find_first_bit(pending, nr_irqs)>= nr_irqs)
>   			break;
>
> -		omap_prcm_events_filter_priority(pending, priority_pending);
> -
>   		/*
>   		 * Loop on all currently pending irqs so that new irqs
>   		 * cannot starve previously pending irqs
>   		 */
> -
> -		/* Serve priority events first */
> -		for_each_set_bit(virtirq, priority_pending, nr_irqs)
> -			generic_handle_irq(prcm_irq_setup->base_irq + virtirq);
> -
> -		/* Serve normal events next */
>   		for_each_set_bit(virtirq, pending, nr_irqs)
>   			generic_handle_irq(prcm_irq_setup->base_irq + virtirq);
> +
> +		/*
> +		 * Ack pending events if needed, this will clean the
> +		 * wakeup events on omap3
> +		 */
> +		if (prcm_irq_setup->ack_pending_events)
> +			prcm_irq_setup->ack_pending_events(pending);
>   	}
>   	if (chip->irq_ack)
>   		chip->irq_ack(&desc->irq_data);
> @@ -191,9 +174,6 @@ void omap_prcm_irq_cleanup(void)
>   	kfree(prcm_irq_setup->saved_mask);
>   	prcm_irq_setup->saved_mask = NULL;
>
> -	kfree(prcm_irq_setup->priority_mask);
> -	prcm_irq_setup->priority_mask = NULL;
> -
>   	irq_set_chained_handler(prcm_irq_setup->irq, NULL);
>
>   	if (prcm_irq_setup->base_irq>  0)
> @@ -262,11 +242,8 @@ int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup)
>
>   	prcm_irq_chips = kzalloc(sizeof(void *) * nr_regs, GFP_KERNEL);
>   	prcm_irq_setup->saved_mask = kzalloc(sizeof(u32) * nr_regs, GFP_KERNEL);
> -	prcm_irq_setup->priority_mask = kzalloc(sizeof(u32) * nr_regs,
> -		GFP_KERNEL);
>
> -	if (!prcm_irq_chips || !prcm_irq_setup->saved_mask ||
> -	    !prcm_irq_setup->priority_mask) {
> +	if (!prcm_irq_chips || !prcm_irq_setup->saved_mask) {
>   		pr_err("PRCM: kzalloc failed\n");
>   		goto err;
>   	}
> @@ -276,9 +253,6 @@ int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup)
>   	for (i = 0; i<  irq_setup->nr_irqs; i++) {
>   		offset = irq_setup->irqs[i].offset;
>   		mask[offset>>  5] |= 1<<  (offset&  0x1f);
> -		if (irq_setup->irqs[i].priority)
> -			irq_setup->priority_mask[offset>>  5] |=
> -				1<<  (offset&  0x1f);
>   	}
>
>   	irq_set_chained_handler(irq_setup->irq, omap_prcm_irq_handler);


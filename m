From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH][RFC] OMAP3: PM: Prevent hang in prcm_interrupt_handler
Date: Wed, 22 Jul 2009 10:09:54 -0700
Message-ID: <87k520lk4d.fsf@deeprootsystems.com>
References: <1245452921-24142-1-git-send-email-jon-hunter@ti.com>
	<87prcv25ro.fsf@deeprootsystems.com>
	<1246079245.3336.47.camel@a0741266-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f176.google.com ([209.85.216.176]:43599 "EHLO
	mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbZGVRKN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jul 2009 13:10:13 -0400
Received: by pxi6 with SMTP id 6so116126pxi.33
        for <linux-omap@vger.kernel.org>; Wed, 22 Jul 2009 10:10:12 -0700 (PDT)
In-Reply-To: <1246079245.3336.47.camel@a0741266-laptop> (Jon Hunter's message of "Sat\, 27 Jun 2009 00\:07\:25 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Jon Hunter <jon-hunter@ti.com> writes:

> On Mon, 2009-06-22 at 18:44 -0500, Kevin Hilman wrote:
>> Jon Hunter <jon-hunter@ti.com> writes:
>> 
>> > From: Jon Hunter <jon-hunter@ti.com>
>> >
>> > There are two scenarios where a race condition could result in a hang in the
>> > prcm_interrupt handler. These are:
>> 
>> IIRC, the RX51 tree has a workaround for some hangs seen in this
>> interrupt handler as well, so this has definitely been seen.  The fix
>> there though was just to no loop, I think your fix is more thorough 
>> and fixes the root cause.  Thanks.
>> 
>> No comments on the funtional changes, but a couple
>> cosmetic/documentation changes.
>> 
>> 1) Would it be possible to summarize the requirements in the function
>> itself as part of this patch.
>> 
>> 2) With the extra indentation, this function is getting too indented.
>> Looking closer, an abstraction of the 'enable clocks, poll PM_WKST,
>> disable clocks loop' could be done an called with the various modules
>> and offsets.  I've attached a hack/patch below to show what I mean.
>> You could just fold this into your patch.
>
> Hi Kevin,
>
> Please find the update patch below.
>

Thanks, incorporating this into a set of PRCM interrupt fixes to
be posted shortly.

Kevin

>
>
>
> There are two scenarios where a race condition could result in a hang
> in the prcm_interrupt handler. These are:
>
> 1). Waiting for PRM_IRQSTATUS_MPU register to clear.
> Bit 0 of the PRM_IRQSTATUS_MPU register indicates that a wake-up event
> is pending for the MPU. This bit can only be cleared if the all the
> wake-up events latched in the various PM_WKST_x registers have been
> cleared. If a wake-up event occurred during the processing of the prcm
> interrupt handler, after the corresponding PM_WKST_x register was
> checked but before the PRM_IRQSTATUS_MPU was cleared, then the CPU
> would be stuck forever waiting for bit 0 in PRM_IRQSTATUS_MPU to be
> cleared.
>
> 2). Waiting for the PM_WKST_x register to clear.
> Some power domains have more than one wake-up source. The PM_WKST_x
> registers indicate the source of a wake-up event and need to be cleared
> after a wake-up event occurs. When the PM_WKST_x registers are read and
> before they are cleared, it is possible that another wake-up event
> could occur causing another bit to be set in one of the PM_WKST_x
> registers. If this did occur after reading a PM_WKST_x register then
> the CPU would miss this event and get stuck forever in a loop waiting
> for that PM_WKST_x register to clear.
>
> This patch address the above race conditions that would result in a
> hang.
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |  148
> ++++++++++++++++++------------------------
>  1 files changed, 62 insertions(+), 86 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 7a4a525..9ba6b53 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -194,97 +194,73 @@ static void omap3_save_secure_ram_context(u32
> target_mpu_state)
>  	}
>  }
>  
> -/* PRCM Interrupt Handler for wakeups */
> -static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
> -{
> -	u32 wkst, irqstatus_mpu;
> -	u32 fclk, iclk;
> -
> -	/* WKUP */
> -	wkst = prm_read_mod_reg(WKUP_MOD, PM_WKST);
> -	if (wkst) {
> -		iclk = cm_read_mod_reg(WKUP_MOD, CM_ICLKEN);
> -		fclk = cm_read_mod_reg(WKUP_MOD, CM_FCLKEN);
> -		cm_set_mod_reg_bits(wkst, WKUP_MOD, CM_ICLKEN);
> -		cm_set_mod_reg_bits(wkst, WKUP_MOD, CM_FCLKEN);
> -		prm_write_mod_reg(wkst, WKUP_MOD, PM_WKST);
> -		while (prm_read_mod_reg(WKUP_MOD, PM_WKST))
> -			cpu_relax();
> -		cm_write_mod_reg(iclk, WKUP_MOD, CM_ICLKEN);
> -		cm_write_mod_reg(fclk, WKUP_MOD, CM_FCLKEN);
> -	}
> -
> -	/* CORE */
> -	wkst = prm_read_mod_reg(CORE_MOD, PM_WKST1);
> -	if (wkst) {
> -		iclk = cm_read_mod_reg(CORE_MOD, CM_ICLKEN1);
> -		fclk = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
> -		cm_set_mod_reg_bits(wkst, CORE_MOD, CM_ICLKEN1);
> -		cm_set_mod_reg_bits(wkst, CORE_MOD, CM_FCLKEN1);
> -		prm_write_mod_reg(wkst, CORE_MOD, PM_WKST1);
> -		while (prm_read_mod_reg(CORE_MOD, PM_WKST1))
> -			cpu_relax();
> -		cm_write_mod_reg(iclk, CORE_MOD, CM_ICLKEN1);
> -		cm_write_mod_reg(fclk, CORE_MOD, CM_FCLKEN1);
> -	}
> -	wkst = prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_WKST3);
> -	if (wkst) {
> -		iclk = cm_read_mod_reg(CORE_MOD, CM_ICLKEN3);
> -		fclk = cm_read_mod_reg(CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
> -		cm_set_mod_reg_bits(wkst, CORE_MOD, CM_ICLKEN3);
> -		cm_set_mod_reg_bits(wkst, CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
> -		prm_write_mod_reg(wkst, CORE_MOD, OMAP3430ES2_PM_WKST3);
> -		while (prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_WKST3))
> -			cpu_relax();
> -		cm_write_mod_reg(iclk, CORE_MOD, CM_ICLKEN3);
> -		cm_write_mod_reg(fclk, CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
> -	}
> +/*
> + * PRCM Interrupt Handler Helper Function
> + *
> + * The purpose of this function is to clear any wake-up events latched
> + * in the PRCM PM_WKST_x registers. It is possible that a wake-up event
> + * may occur whilst attempting to clear a PM_WKST_x register and thus
> + * set another bit in this register. A while loop is used to ensure
> + * that any peripheral wake-up events occurring while attempting to
> + * clear the PM_WKST_x are detected and cleared.
> + */
> +static void prcm_clear_mod_irqs(s16 module, u16 wkst_off,
> +			u16 iclk_off, u16 fclk_off) {
> +	u32 wkst, fclk, iclk;
>  
> -	/* PER */
> -	wkst = prm_read_mod_reg(OMAP3430_PER_MOD, PM_WKST);
> +	wkst = prm_read_mod_reg(module, wkst_off);
>  	if (wkst) {
> -		iclk = cm_read_mod_reg(OMAP3430_PER_MOD, CM_ICLKEN);
> -		fclk = cm_read_mod_reg(OMAP3430_PER_MOD, CM_FCLKEN);
> -		cm_set_mod_reg_bits(wkst, OMAP3430_PER_MOD, CM_ICLKEN);
> -		cm_set_mod_reg_bits(wkst, OMAP3430_PER_MOD, CM_FCLKEN);
> -		prm_write_mod_reg(wkst, OMAP3430_PER_MOD, PM_WKST);
> -		while (prm_read_mod_reg(OMAP3430_PER_MOD, PM_WKST))
> -			cpu_relax();
> -		cm_write_mod_reg(iclk, OMAP3430_PER_MOD, CM_ICLKEN);
> -		cm_write_mod_reg(fclk, OMAP3430_PER_MOD, CM_FCLKEN);
> -	}
> -
> -	if (omap_rev() > OMAP3430_REV_ES1_0) {
> -		/* USBHOST */
> -		wkst = prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, PM_WKST);
> -		if (wkst) {
> -			iclk = cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
> -					       CM_ICLKEN);
> -			fclk = cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
> -					       CM_FCLKEN);
> -			cm_set_mod_reg_bits(wkst, OMAP3430ES2_USBHOST_MOD,
> -					    CM_ICLKEN);
> -			cm_set_mod_reg_bits(wkst, OMAP3430ES2_USBHOST_MOD,
> -					    CM_FCLKEN);
> -			prm_write_mod_reg(wkst, OMAP3430ES2_USBHOST_MOD,
> -					  PM_WKST);
> -			while (prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
> -						PM_WKST))
> -				cpu_relax();
> -			cm_write_mod_reg(iclk, OMAP3430ES2_USBHOST_MOD,
> -					 CM_ICLKEN);
> -			cm_write_mod_reg(fclk, OMAP3430ES2_USBHOST_MOD,
> -					 CM_FCLKEN);
> +		iclk = cm_read_mod_reg(module, iclk_off);
> +		fclk = cm_read_mod_reg(module, fclk_off);
> +		while (wkst) {
> +			cm_set_mod_reg_bits(wkst, module, iclk_off);
> +			cm_set_mod_reg_bits(wkst, module, fclk_off);
> +			prm_write_mod_reg(wkst, module, wkst_off);
> +			wkst = prm_read_mod_reg(module, wkst_off);
>  		}
> +		cm_write_mod_reg(iclk, module, iclk_off);
> +		cm_write_mod_reg(fclk, module, fclk_off);
>  	}
> +}
>  
> -	irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
> -					 OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> -	prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
> -			  OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> -
> -	while (prm_read_mod_reg(OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET))
> -		cpu_relax();
> +/*
> + * PRCM Interrupt Handler
> + *
> + * The PRM_IRQSTATUS_MPU register indicates if there are any pending
> + * interrupts from the PRCM for the MPU. These bits must be cleared in
> + * order to clear the PRCM interrupt. The PRCM interrupt handler is
> + * implemented to simply clear the PRM_IRQSTATUS_MPU in order to clear
> + * the PRCM interrupt. Please note that bit 0 of the PRM_IRQSTATUS_MPU
> + * register indicates that a wake-up event is pending for the MPU and
> + * this bit can only be cleared if the all the wake-up events latched
> + * in the various PM_WKST_x registers have been cleared. The interrupt
> + * handler is implemented using a do-while loop so that if a wake-up
> + * event occurred during the processing of the prcm interrupt handler
> + * (setting a bit in the corresponding PM_WKST_x register and thus
> + * preventing us from clearing bit 0 of the PRM_IRQSTATUS_MPU register)
> + * this would be handled.
> + */
> +static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
> +{
> +	u32 irqstatus_mpu;
> +
> +	do {
> +		prcm_clear_mod_irqs(WKUP_MOD, PM_WKST, CM_ICLKEN, CM_FCLKEN);
> +		prcm_clear_mod_irqs(CORE_MOD, PM_WKST1, CM_ICLKEN1, CM_ICLKEN1);
> +		prcm_clear_mod_irqs(CORE_MOD, OMAP3430ES2_PM_WKST3,
> +					CM_ICLKEN3, OMAP3430ES2_CM_FCLKEN3);
> +		prcm_clear_mod_irqs(OMAP3430_PER_MOD, PM_WKST,
> +					CM_ICLKEN, CM_FCLKEN);
> +		if (omap_rev() > OMAP3430_REV_ES1_0)
> +			prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, PM_WKST,
> +					CM_ICLKEN, CM_FCLKEN);
> +
> +		irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
> +					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> +		prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
> +					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> +
> +	} while (prm_read_mod_reg(OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET));
>  
>  	return IRQ_HANDLED;
>  }
> -- 
> 1.6.0.4

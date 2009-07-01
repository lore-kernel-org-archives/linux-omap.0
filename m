From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [ARM][OMAP] TWL4030 IRQ
Date: Wed, 01 Jul 2009 06:51:42 -0700
Message-ID: <87r5x0wlxt.fsf@deeprootsystems.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B530E9C6@dbde02.ent.ti.com>
	<20090624075756.GA13052@n2100.arm.linux.org.uk>
	<20090629093004.GA2111@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02B546698E@dbde02.ent.ti.com>
	<871vp1491d.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02B5467016@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:41027 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbZGANvm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jul 2009 09:51:42 -0400
Received: by pzk26 with SMTP id 26so835889pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 01 Jul 2009 06:51:44 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B5467016@dbde02.ent.ti.com> (Santosh Shilimkar's message of "Wed\, 1 Jul 2009 10\:33\:13 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

> From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
> Subject: RE: [ARM][OMAP] TWL4030 IRQ
> To: Kevin Hilman <khilman@deeprootsystems.com>
> CC: Russell King - ARM Linux <linux@arm.linux.org.uk>,
>         "linux-arm-kernel@lists.arm.linux.org.uk"
> 	<linux-arm-kernel@lists.arm.linux.org.uk>,
>         "linux-omap@vger.kernel.org"
> 	<linux-omap@vger.kernel.org>
> Date: Wed, 1 Jul 2009 10:33:13 +0530
>
>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>> Sent: Wednesday, July 01, 2009 4:36 AM
>> To: Shilimkar, Santosh
>> Cc: Russell King - ARM Linux; 
>> linux-arm-kernel@lists.arm.linux.org.uk; linux-omap@vger.kernel.org
>> Subject: Re: [ARM][OMAP] TWL4030 IRQ
>> 
>> "Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:
>> 
>> > Kevin/Vikram,
>> > Can this patch be included on omap_pm branch to check for 
>> any regression?
>> 
>> Sure, I have it applied to the PM branch locally, but before I push,
>> can you (or Russell) send me a descriptive changelog for this patch.
>
> (Here is the patch with some description.)

Thanks, will merge into next PM branch.

Kevin

>
> From 67d399fd88629f37b8debea1aa51bf20ff8957f6 Mon Sep 17 00:00:00 2001
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> Date: Wed, 1 Jul 2009 10:31:17 +0530
> Subject: [PATCH] ARM: OMAP: TWL4030 IRQ
>
> The TWL4030 IRQ handler has a bug which leads to spinlock lock-up. It is
> calling the 'unmask' function in a process context. The mask/unmask/ack
> functions are only designed to be called from the IRQ handler code,
> or the proper API interfaces found in linux/interrupt.h.
>
> Also there is no need to have IRQ chaining mechanism. The right way to
> handle this is to claim the parent interrupt as a standard interrupt
> and arrange for handle_twl4030_pih to take care of the rest of the devices.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  drivers/mfd/twl4030-irq.c |   54 ++++++++++++++++++++-------------------------
>  1 files changed, 24 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
> index aca2670..e30e7bc 100644
> --- a/drivers/mfd/twl4030-irq.c
> +++ b/drivers/mfd/twl4030-irq.c
> @@ -180,14 +180,9 @@ static struct completion irq_event;
>  static int twl4030_irq_thread(void *data)
>  {
>  	long irq = (long)data;
> -	struct irq_desc *desc = irq_to_desc(irq);
>  	static unsigned i2c_errors;
>  	static const unsigned max_i2c_errors = 100;
>  
> -	if (!desc) {
> -		pr_err("twl4030: Invalid IRQ: %ld\n", irq);
> -		return -EINVAL;
> -	}
>  
>  	current->flags |= PF_NOFREEZE;
>  
> @@ -240,7 +235,7 @@ static int twl4030_irq_thread(void *data)
>  		}
>  		local_irq_enable();
>  
> -		desc->chip->unmask(irq);
> +		enable_irq(irq);
>  	}
>  
>  	return 0;
> @@ -255,23 +250,12 @@ static int twl4030_irq_thread(void *data)
>   * thread.  All we do here is acknowledge and mask the interrupt and wakeup
>   * the kernel thread.
>   */
> -static void handle_twl4030_pih(unsigned int irq, irq_desc_t *desc)
> +static irqreturn_t handle_twl4030_pih(int irq, void *devid)
>  {
>  	/* Acknowledge, clear *AND* mask the interrupt... */
> -	desc->chip->ack(irq);
> -	complete(&irq_event);
> -}
> -
> -static struct task_struct *start_twl4030_irq_thread(long irq)
> -{
> -	struct task_struct *thread;
> -
> -	init_completion(&irq_event);
> -	thread = kthread_run(twl4030_irq_thread, (void *)irq, "twl4030-irq");
> -	if (!thread)
> -		pr_err("twl4030: could not create irq %ld thread!\n", irq);
> -
> -	return thread;
> +	disable_irq_nosync(irq);
> +	complete(devid);
> +	return IRQ_HANDLED;
>  }
>  
>  /*----------------------------------------------------------------------*/
> @@ -734,18 +718,28 @@ int twl_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
>  	}
>  
>  	/* install an irq handler to demultiplex the TWL4030 interrupt */
> -	task = start_twl4030_irq_thread(irq_num);
> -	if (!task) {
> -		pr_err("twl4030: irq thread FAIL\n");
> -		status = -ESRCH;
> -		goto fail;
> -	}
>  
> -	set_irq_data(irq_num, task);
> -	set_irq_chained_handler(irq_num, handle_twl4030_pih);
>  
> -	return status;
> +	init_completion(&irq_event);
>  
> +	status = request_irq(irq_num, handle_twl4030_pih, IRQF_DISABLED,
> +				"TWL4030-PIH", &irq_event);
> +	if (status < 0) {
> +		pr_err("twl4030: could not claim irq%d: %d\n", irq_num, status);
> +		goto fail_rqirq;
> +	}
> +
> +	task = kthread_run(twl4030_irq_thread, (void *)irq_num, "twl4030-irq");
> +	if (IS_ERR(task)) {
> +		pr_err("twl4030: could not create irq %d thread!\n", irq_num);
> +		status = PTR_ERR(task);
> +		goto fail_kthread;
> +	}
> +	return status;
> +fail_kthread:
> +	free_irq(irq_num, &irq_event);
> +fail_rqirq:
> +	/* clean up twl4030_sih_setup */
>  fail:
>  	for (i = irq_base; i < irq_end; i++)
>  		set_irq_chip_and_handler(i, NULL, NULL);
> -- 
> 1.5.4.7
>
>
> Regards,

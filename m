From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] ARM: OMAP: TWL4030 IRQ
Date: Sat, 1 Aug 2009 18:20:15 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B5BF236B@dbde02.ent.ti.com>
References: <1248674448-17495-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34453 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbZHAMug convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Aug 2009 08:50:36 -0400
In-Reply-To: <1248674448-17495-1-git-send-email-santosh.shilimkar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, Russell King <rmk+kernel@arm.linux.org.uk>

Samuel,
Any comments?
In case the patch is ok, can you please merge it.
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Shilimkar, Santosh
> Sent: Monday, July 27, 2009 11:31 AM
> To: sameo@linux.intel.com
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.arm.linux.org.uk;
> Russell King
> Subject: [PATCH] ARM: OMAP: TWL4030 IRQ
> 
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> (Rebased on 2.6.31-rc4)
> 
> The TWL4030 IRQ handler has a bug which leads to spinlock lock-up. It is
> calling the 'unmask' function in a process context. :The mask/unmask/ack
> functions are only designed to be called from the IRQ handler code,
> or the proper API interfaces found in linux/interrupt.h.
> 
> Also there is no need to have IRQ chaining mechanism. The right way to
> handle this is to claim the parent interrupt as a standard interrupt
> and arrange for handle_twl4030_pih to take care of the rest of the devices.
> 
> Mail thread on this issue can be found at:
> http://marc.info/?l=linux-arm-kernel&m=124629940123396&w=2
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  drivers/mfd/twl4030-irq.c |   55 +++++++++++++++++++---------------------
> ----
>  1 files changed, 24 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
> index bae61b2..7d43083 100644
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
> @@ -255,25 +250,13 @@ static int twl4030_irq_thread(void *data)
>   * thread.  All we do here is acknowledge and mask the interrupt and
> wakeup
>   * the kernel thread.
>   */
> -static void handle_twl4030_pih(unsigned int irq, struct irq_desc *desc)
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
> -	thread = kthread_run(twl4030_irq_thread, (void *)irq, "twl4030-
> irq");
> -	if (!thread)
> -		pr_err("twl4030: could not create irq %ld thread!\n", irq);
> -
> -	return thread;
> +	disable_irq_nosync(irq);
> +	complete(devid);
> +	return IRQ_HANDLED;
>  }
> -
>  /*----------------------------------------------------------------------
> */
> 
>  /*
> @@ -734,18 +717,28 @@ int twl_init_irq(int irq_num, unsigned irq_base,
> unsigned irq_end)
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
> +		pr_err("twl4030: could not claim irq%d: %d\n", irq_num,
> status);
> +		goto fail_rqirq;
> +	}
> +
> +	task = kthread_run(twl4030_irq_thread, (void *)irq_num, "twl4030-
> irq");
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


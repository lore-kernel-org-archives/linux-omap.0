From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] omap: prcm: switch to a chained IRQ handler mechanism
Date: Wed, 17 Nov 2010 14:32:26 +0100
Message-ID: <4CE3D96A.5010004@ti.com>
References: <1289996179-17698-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53883 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933867Ab0KQNcc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Nov 2010 08:32:32 -0500
In-Reply-To: <1289996179-17698-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Petazzoni-XID, Thomas" <t-petazzoni@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi Thomas,

On 11/17/2010 1:16 PM, Thomas Petazzoni wrote:
> From: Thomas Petazzoni<t-petazzoni@ti.com>

[...]

>   static int __init omap3_pm_init(void)

That code is purely OMAP3 specific, do you think it might scale well on 
OMAP4?
BTW, you should maybe change the subject with "OMAP3: prcm: ..." to 
reflect that.

>   {
>   	struct power_state *pwrst, *tmp;
>   	struct clockdomain *neon_clkdm, *per_clkdm, *mpu_clkdm, *core_clkdm;
> -	int ret;
> +	int ret, i;
>
>   	if (!cpu_is_omap34xx())
>   		return -ENODEV;
> @@ -1013,19 +1053,34 @@ static int __init omap3_pm_init(void)
>   	 * supervised mode for powerdomains */
>   	prcm_setup_regs();
>
> -	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,
> -			  (irq_handler_t)prcm_interrupt_handler,
> -			  IRQF_DISABLED, "prcm", NULL);
> +	for (i = OMAP_PRCM_IRQ_BASE; i<  OMAP_PRCM_IRQ_END; i++) {
> +		set_irq_chip(i,&prcm_irq_chip);
> +		set_irq_handler(i, handle_level_irq);
> +		set_irq_flags(i, IRQF_VALID);
> +	}
> +
> +	set_irq_chained_handler(INT_34XX_PRCM_MPU_IRQ, prcm_irq_handler);
> +
> +	ret = request_irq(INT_34XX_PRCM_WKUP_EN, _prcm_int_handle_wakeup,
> +			  IRQF_NO_SUSPEND, "prcm_wkup", NULL);
>   	if (ret) {
>   		printk(KERN_ERR "request_irq failed to register for 0x%x\n",

OK, I know, this is not your code, but it might be good to get rid of 
the "printk(KERN_ERR..." and use pr_err instead.

> -		       INT_34XX_PRCM_MPU_IRQ);
> +		       INT_34XX_PRCM_WKUP_EN);
>   		goto err1;
>   	}
>
> +	ret = request_irq(INT_34XX_PRCM_IO_EN, _prcm_int_handle_wakeup,
> +			  IRQF_NO_SUSPEND, "prcm_io", NULL);
> +	if (ret) {
> +		printk(KERN_ERR "request_irq failed to register for 0x%x\n",
> +		       INT_34XX_PRCM_IO_EN);
> +		goto err2;
> +	}
> +
>   	ret = pwrdm_for_each(pwrdms_setup, NULL);
>   	if (ret) {
>   		printk(KERN_ERR "Failed to setup powerdomains\n");
> -		goto err2;
> +		goto err3;
>   	}
>
>   	(void) clkdm_for_each(clkdms_setup, NULL);
> @@ -1033,7 +1088,7 @@ static int __init omap3_pm_init(void)
>   	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
>   	if (mpu_pwrdm == NULL) {
>   		printk(KERN_ERR "Failed to get mpu_pwrdm\n");
> -		goto err2;
> +		goto err3;
>   	}
>
>   	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
> @@ -1080,7 +1135,9 @@ static int __init omap3_pm_init(void)
>   err1:
>   	return ret;
>   err2:
> -	free_irq(INT_34XX_PRCM_MPU_IRQ, NULL);
> +	free_irq(INT_34XX_PRCM_WKUP_EN, NULL);
> +err3:
> +	free_irq(INT_34XX_PRCM_IO_EN, NULL);
>   	list_for_each_entry_safe(pwrst, tmp,&pwrst_list, node) {
>   		list_del(&pwrst->node);
>   		kfree(pwrst);
> diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
> index 65e20a6..6c5eb1c 100644
> --- a/arch/arm/plat-omap/include/plat/irqs.h
> +++ b/arch/arm/plat-omap/include/plat/irqs.h
> @@ -363,7 +363,43 @@
>   #define OMAP_MAX_GPIO_LINES	192
>   #define IH_GPIO_BASE		(128 + IH2_BASE)
>   #define IH_MPUIO_BASE		(OMAP_MAX_GPIO_LINES + IH_GPIO_BASE)
> -#define OMAP_IRQ_END		(IH_MPUIO_BASE + 16)
> +#define OMAP_MPUIO_IRQ_END	(IH_MPUIO_BASE + 16)
> +
> +/* 32 IRQs for the PRCM */
> +#define OMAP_PRCM_IRQ_BASE                 (OMAP_MPUIO_IRQ_END)
> +#define INT_34XX_PRCM_WKUP_EN              (OMAP_PRCM_IRQ_BASE +  0)
> +#define INT_34XX_PRCM_EVGENON_EN           (OMAP_PRCM_IRQ_BASE +  2)
> +#define INT_34XX_PRCM_EVGENOFF_EN          (OMAP_PRCM_IRQ_BASE +  3)
> +#define INT_34XX_PRCM_TRANSITION_EN        (OMAP_PRCM_IRQ_BASE +  4)
> +#define INT_34XX_PRCM_CORE_DPLL_RECAL_EN   (OMAP_PRCM_IRQ_BASE +  5)
> +#define INT_34XX_PRCM_PERIPH_DPLL_RECAL_EN (OMAP_PRCM_IRQ_BASE +  6)
> +#define INT_34XX_PRCM_MPU_DPLL_RECAL_EN_EN (OMAP_PRCM_IRQ_BASE +  7)
> +#define INT_34XX_PRCM_IVA2_DPLL_RECAL_EN   (OMAP_PRCM_IRQ_BASE +  8)
> +#define INT_34XX_PRCM_IO_EN                (OMAP_PRCM_IRQ_BASE +  9)
> +#define INT_34XX_PRCM_VP1_OPPCHANGEDONE_EN (OMAP_PRCM_IRQ_BASE + 10)
> +#define INT_34XX_PRCM_VP1_MINVDD_EN        (OMAP_PRCM_IRQ_BASE + 11)
> +#define INT_34XX_PRCM_VP1_MAXVDD_EN        (OMAP_PRCM_IRQ_BASE + 12)
> +#define INT_34XX_PRCM_VP1_NOSMPSACK_EN     (OMAP_PRCM_IRQ_BASE + 13)
> +#define INT_34XX_PRCM_VP1_EQVALUE_EN       (OMAP_PRCM_IRQ_BASE + 14)
> +#define INT_34XX_PRCM_VP1_TRANXDONE_EN     (OMAP_PRCM_IRQ_BASE + 15)
> +#define INT_34XX_PRCM_VP2_OPPCHANGEDONE_EN (OMAP_PRCM_IRQ_BASE + 16)
> +#define INT_34XX_PRCM_VP2_MINVDD_EN        (OMAP_PRCM_IRQ_BASE + 17)
> +#define INT_34XX_PRCM_VP2_MAXVDD_EN        (OMAP_PRCM_IRQ_BASE + 18)
> +#define INT_34XX_PRCM_VP2_NOSMPSACK_EN     (OMAP_PRCM_IRQ_BASE + 19)
> +#define INT_34XX_PRCM_VP2_EQVALUE_EN       (OMAP_PRCM_IRQ_BASE + 20)
> +#define INT_34XX_PRCM_VP2_TRANXDONE_EN     (OMAP_PRCM_IRQ_BASE + 21)
> +#define INT_34XX_PRCM_VC_SAERR_EN          (OMAP_PRCM_IRQ_BASE + 22)
> +#define INT_34XX_PRCM_VC_RAERR_EN          (OMAP_PRCM_IRQ_BASE + 23)
> +#define INT_34XX_PRCM_VC_TIMEOUT_ERR_EN    (OMAP_PRCM_IRQ_BASE + 24)
> +#define INT_34XX_PRCM_SND_PERIPH_RECAL_EN  (OMAP_PRCM_IRQ_BASE + 25)
> +#define INT_36XX_PRCM_ABB_LDO_TRANXDONE_EN (OMAP_PRCM_IRQ_BASE + 26)
> +#define INT_36XX_PRCM_VC_VP1_ACK_EN        (OMAP_PRCM_IRQ_BASE + 27)
> +#define INT_36XX_PRCM_VC_BYPASS_ACK_EN     (OMAP_PRCM_IRQ_BASE + 28)
> +#define OMAP_PRCM_NR_IRQS                  32
> +#define OMAP_PRCM_IRQ_END                  (OMAP_PRCM_IRQ_BASE + \
> +					    OMAP_PRCM_NR_IRQS)

We are in the process of getting rid of all the IRQ defines thanks to 
hwmod. Maybe we should consider moving that to hwmod data? I'm not sure 
exactly how we will handle that case but it might worth considering it.

If we do want to make that code OMAP generic, we will probably have to.


That being said, that patch is already a good improvement compared to 
the previous solution. So maybe we should do that in several phases.

Kevin,
Any thoughts on that?

Thanks,
Benoit

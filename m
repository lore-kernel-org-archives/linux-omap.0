From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/4] mfd: twl6030-irq: convert to use linear irq_domain
Date: Wed, 24 Jul 2013 12:35:08 +0100
Message-ID: <20130724113508.GI26801@laptop>
References: <1374595624-15054-1-git-send-email-grygorii.strashko@ti.com>
 <1374595624-15054-4-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:58828 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab3GXLfP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jul 2013 07:35:15 -0400
Received: by mail-ee0-f48.google.com with SMTP id b47so173821eek.35
        for <linux-omap@vger.kernel.org>; Wed, 24 Jul 2013 04:35:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1374595624-15054-4-git-send-email-grygorii.strashko@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@linaro.org>, Graeme Gregory <gg@slimlogic.co.uk>, linux-omap@vger.kernel.org, Ruslan Bilovol <ruslan.bilovol@ti.com>, linux-kernel@vger.kernel.org

On Tue, 23 Jul 2013, Grygorii Strashko wrote:

> Since the TWL6030 PMIC is used with OMAP4 SoCs only and OMAP4 legacy
> boot is dropped there are no needs to allocate the range of IRQ
> descriptors during system boot to support TWL6030 IRQs.
>=20
> Hence, convert it to use linear irq_domain and move IRQ configuration=
 in
> .map()/.unmap() callbacks of irq_domain. So, IRQ mapping and descript=
ors
> allocation will be performed dynamically basing on DT configuration.
>=20
> The error message will be reported in case if unmapped IRQ is receive=
d by
> TWL6030 (virq=3D=3D0).
>=20
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/mfd/twl6030-irq.c |  114 ++++++++++++++++++++++++-----------=
----------
>  1 file changed, 61 insertions(+), 53 deletions(-)
>=20
> diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
> index 790cc28..89f130b 100644
> --- a/drivers/mfd/twl6030-irq.c
> +++ b/drivers/mfd/twl6030-irq.c
> @@ -138,6 +138,7 @@ static struct notifier_block twl6030_irq_pm_notif=
ier_block =3D {
>  static irqreturn_t twl6030_irq_thread(int irq, void *data)
>  {
>  	int i, ret;
> +	struct irq_domain *irq_domain =3D (struct irq_domain *)data;
>  	union {
>  		u8 bytes[4];
>  		u32 int_sts;
> @@ -161,9 +162,14 @@ static irqreturn_t twl6030_irq_thread(int irq, v=
oid *data)
> =20
>  	for (i =3D 0; sts.int_sts; sts.int_sts >>=3D 1, i++)
>  		if (sts.int_sts & 0x1) {
> -			int module_irq =3D twl6030_irq_base +
> -					twl6030_interrupt_mapping[i];
> -			handle_nested_irq(module_irq);
> +			int module_irq =3D
> +				irq_find_mapping(irq_domain,
> +						 twl6030_interrupt_mapping[i]);
> +			if (module_irq)
> +				handle_nested_irq(module_irq);
> +			else
> +				pr_err("%s: Unmapped PIH ISR %u detected\n",
> +				       __func__, i);

Same here. Does the user really care which function failed?

Please consider replacing with the device name.

>  			pr_debug("%s: PIH ISR %u, virq%u\n",
>  				 __func__, i, module_irq);
>  		}
> @@ -186,19 +192,6 @@ static irqreturn_t twl6030_irq_thread(int irq, v=
oid *data)
> =20
>  /*------------------------------------------------------------------=
----*/
> =20
> -static inline void activate_irq(int irq)
> -{
> -#ifdef CONFIG_ARM
> -	/* ARM requires an extra step to clear IRQ_NOREQUEST, which it
> -	 * sets on behalf of every irq_chip.  Also sets IRQ_NOPROBE.
> -	 */
> -	set_irq_flags(irq, IRQF_VALID);
> -#else
> -	/* same effect on other architectures */
> -	irq_set_noprobe(irq);
> -#endif
> -}
> -
>  static int twl6030_irq_set_wake(struct irq_data *d, unsigned int on)
>  {
>  	if (on)
> @@ -308,28 +301,54 @@ int twl6030_mmc_card_detect(struct device *dev,=
 int slot)
>  }
>  EXPORT_SYMBOL(twl6030_mmc_card_detect);
> =20
> +static struct irq_chip twl6030_irq_chip;
> +
> +static int twl6030_irq_map(struct irq_domain *d, unsigned int virq,
> +			      irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_data(virq, &twl6030_irq_chip);
> +	irq_set_chip_and_handler(virq,  &twl6030_irq_chip, handle_simple_ir=
q);
> +	irq_set_nested_thread(virq, true);
> +
> +#ifdef CONFIG_ARM
> +	/*
> +	 * ARM requires an extra step to clear IRQ_NOREQUEST, which it
> +	 * sets on behalf of every irq_chip.  Also sets IRQ_NOPROBE.
> +	 */
> +	set_irq_flags(virq, IRQF_VALID);
> +#else
> +	/* same effect on other architectures */
> +	irq_set_noprobe(virq);
> +#endif
> +
> +	return 0;
> +}
> +
> +static void twl6030_irq_unmap(struct irq_domain *d, unsigned int vir=
q)
> +{
> +#ifdef CONFIG_ARM
> +	set_irq_flags(virq, 0);
> +#endif
> +	irq_set_chip_and_handler(virq, NULL, NULL);
> +	irq_set_chip_data(virq, NULL);
> +}
> +
> +static struct irq_domain_ops twl6030_irq_domain_ops =3D {
> +	.map	=3D twl6030_irq_map,
> +	.unmap	=3D twl6030_irq_unmap,
> +	.xlate	=3D irq_domain_xlate_onetwocell,
> +};
> +
>  int twl6030_init_irq(struct device *dev, int irq_num)
>  {
>  	struct			device_node *node =3D dev->of_node;
> -	int			nr_irqs, irq_base, irq_end;
> -	static struct irq_chip  twl6030_irq_chip;
> +	int			nr_irqs;
>  	int			status;
> -	int			i;
>  	u8			mask[3];
> +	struct irq_domain	*irq_domain;
> =20
>  	nr_irqs =3D TWL6030_NR_IRQS;
> =20
> -	irq_base =3D irq_alloc_descs(-1, 0, nr_irqs, 0);
> -	if (IS_ERR_VALUE(irq_base)) {
> -		dev_err(dev, "Fail to allocate IRQ descs\n");
> -		return irq_base;
> -	}
> -
> -	irq_domain_add_legacy(node, nr_irqs, irq_base, 0,
> -			      &irq_domain_simple_ops, NULL);
> -
> -	irq_end =3D irq_base + nr_irqs;
> -
>  	mask[0] =3D 0xFF;
>  	mask[1] =3D 0xFF;
>  	mask[2] =3D 0xFF;
> @@ -346,8 +365,6 @@ int twl6030_init_irq(struct device *dev, int irq_=
num)
>  		return status;
>  	}
> =20
> -	twl6030_irq_base =3D irq_base;
> -
>  	/*
>  	 * install an irq handler for each of the modules;
>  	 * clone dummy irq_chip since PIH can't *do* anything
> @@ -357,20 +374,18 @@ int twl6030_init_irq(struct device *dev, int ir=
q_num)
>  	twl6030_irq_chip.irq_set_type =3D NULL;
>  	twl6030_irq_chip.irq_set_wake =3D twl6030_irq_set_wake;
> =20
> -	for (i =3D irq_base; i < irq_end; i++) {
> -		irq_set_chip_and_handler(i, &twl6030_irq_chip,
> -					 handle_simple_irq);
> -		irq_set_chip_data(i, (void *)irq_num);
> -		irq_set_nested_thread(i, true);
> -		activate_irq(i);
> +	irq_domain =3D irq_domain_add_linear(node, nr_irqs,
> +					   &twl6030_irq_domain_ops, NULL);
> +	if (!irq_domain) {
> +		dev_err(dev, "Can't add irq_domain\n");
> +		return -ENOMEM;
>  	}
> =20
> -	dev_info(dev, "PIH (irq %d) nested IRQs %d..%d\n",
> -		 irq_num, irq_base, irq_end);
> +	dev_info(dev, "PIH (irq %d) nested IRQs\n", irq_num);
> =20
>  	/* install an irq handler to demultiplex the TWL6030 interrupt */
>  	status =3D request_threaded_irq(irq_num, NULL, twl6030_irq_thread,
> -				      IRQF_ONESHOT, "TWL6030-PIH", NULL);
> +				      IRQF_ONESHOT, "TWL6030-PIH", irq_domain);
>  	if (status < 0) {
>  		dev_err(dev, "could not claim irq %d: %d\n", irq_num, status);
>  		goto fail_irq;
> @@ -378,26 +393,19 @@ int twl6030_init_irq(struct device *dev, int ir=
q_num)
> =20
>  	twl_irq =3D irq_num;
>  	register_pm_notifier(&twl6030_irq_pm_notifier_block);
> -	return irq_base;
> +	return irq_num;

I think you need to change twl-core to now expect the total number of
IRQs rather than the base one now.

>  fail_irq:
> -	for (i =3D irq_base; i < irq_end; i++)
> -		irq_set_chip_and_handler(i, NULL, NULL);
> -
> +	irq_domain_remove(irq_domain);

Why do you kill the irqdomain here, but not in exit()?

>  	return status;
>  }
> =20
>  int twl6030_exit_irq(void)
>  {
> -	unregister_pm_notifier(&twl6030_irq_pm_notifier_block);
> -
> -	if (!twl6030_irq_base) {
> -		pr_err("twl6030: can't yet clean up IRQs?\n");
> -		return -ENOSYS;
> +	if (twl_irq) {
> +		unregister_pm_notifier(&twl6030_irq_pm_notifier_block);
> +		free_irq(twl_irq, NULL);
>  	}

Ah yes, that's better.

> -
> -	free_irq(twl_irq, NULL);
> -
>  	return 0;
>  }
> =20

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

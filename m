From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V3 15/19] OMAP3+: SR: introduce notifier_control
Date: Thu, 17 Mar 2011 10:35:13 -0700
Message-ID: <878vwd7ir2.fsf@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-16-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:53223 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751576Ab1CQRft (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 13:35:49 -0400
Received: by mail-yx0-f179.google.com with SMTP id 4so1464276yxp.24
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 10:35:16 -0700 (PDT)
In-Reply-To: <1299338962-5602-16-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 5 Mar 2011 20:59:18 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>

Nishanth Menon <nm@ti.com> writes:

> We need some mechanism from class drivers to control when notifiers
> should be triggered and when not, currently we have none, which makes
> Class driver usage of the interrupt events almost impossible.
>
> Introduce an SmartReflex driver API for doing the same. This is useful
> for SmartReflex AVS class 1.5 or 2 drivers.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/smartreflex.c |   57 +++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/smartreflex.h |    8 +++++
>  2 files changed, 65 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 21944e2..f6e44a1 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -712,6 +712,63 @@ void sr_disable(struct voltagedomain *voltdm)
>  }
>  
>  /**
> + * sr_notifier_control() - control the notifier mechanism
> + * @voltdm:	VDD pointer to which the SR module to be configured belongs to.
> + * @enable:	true to enable notifiers and false to disable the same
> + *
> + * SR modules allow an MCU interrupt mechanism that vary based on the IP
> + * revision, we allow the system to generate interrupt if the class driver
> + * has capability to handle the same. it is upto the class driver to ensure
> + * the proper sequencing and handling for a clean implementation. returns
> + * 0 if all goes fine, else returns failure results
> + */
> +int sr_notifier_control(struct voltagedomain *voltdm, bool enable)
> +{
> +	struct omap_sr *sr = _sr_lookup(voltdm);
> +	u32 value = 0;

insert blank line

> +	if (IS_ERR_OR_NULL(sr)) {

checking for NULL should suffice

> +		pr_warning("%s: sr corresponding to domain not found\n",
> +				__func__);
> +		return -EINVAL;
> +	}
> +	if (!sr->autocomp_active)
> +		return -EINVAL;
> +
> +	/* if I could never register an isr, why bother?? */

s/isr/ISR/

> +	if (!(sr_class && sr_class->notify && sr_class->notify_flags &&
> +			sr->irq)) {
> +		dev_warn(&sr->pdev->dev,
> +			"%s: unable to setup irq without handling mechanism\n",
> +			__func__);

s/irq/IRQ/

> +		return -EINVAL;
> +	}
> +
> +	switch (sr->ip_type) {
> +	case SR_TYPE_V1:
> +		value = notifier_to_irqen_v1(sr_class->notify_flags);
> +		sr_modify_reg(sr, ERRCONFIG_V1, value,
> +				(enable) ? value : 0);
> +		break;
> +	case SR_TYPE_V2:
> +		value = notifier_to_irqen_v2(sr_class->notify_flags);
> +		sr_write_reg(sr, (enable) ? IRQENABLE_SET : IRQENABLE_CLR,
> +				value);
> +		break;
> +	default:
> +		 dev_warn(&sr->pdev->dev, "%s: unknown type of sr??\n",
> +				 __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (enable)
> +		enable_irq(sr->irq);
> +	else
> +		disable_irq_nosync(sr->irq);
> +
> +	return 0;
> +}

I'm not all that familiar with the SR IRQs, but why do you need to
disable them at the IP an at the INTC?  It seems like one of the two
should suffice, and it seems like the INTC would be the most efficient.

Kevin

> +/**
>   * sr_register_class() - API to register a smartreflex class parameters.
>   * @class_data:	The structure containing various sr class specific data.
>   *
> diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
> index 2976bf6..4a1ada4 100644
> --- a/arch/arm/mach-omap2/smartreflex.h
> +++ b/arch/arm/mach-omap2/smartreflex.h
> @@ -242,6 +242,7 @@ void omap_sr_register_pmic(struct omap_sr_pmic_data *pmic_data);
>  /* Smartreflex driver hooks to be called from Smartreflex class driver */
>  int sr_enable(struct voltagedomain *voltdm, unsigned long volt);
>  void sr_disable(struct voltagedomain *voltdm);
> +int sr_notifier_control(struct voltagedomain *voltdm, bool enable);
>  int sr_configure_errgen(struct voltagedomain *voltdm);
>  int sr_configure_minmax(struct voltagedomain *voltdm);
>  
> @@ -250,6 +251,13 @@ int sr_register_class(struct omap_sr_class_data *class_data);
>  #else
>  static inline void omap_sr_enable(struct voltagedomain *voltdm) {}
>  static inline void omap_sr_disable(struct voltagedomain *voltdm) {}
> +
> +static inline int sr_notifier_control(struct voltagedomain *voltdm,
> +		bool enable)
> +{
> +	return -EINVAL;
> +}
> +
>  static inline void omap_sr_disable_reset_volt(
>  		struct voltagedomain *voltdm) {}
>  static inline void omap_sr_register_pmic(

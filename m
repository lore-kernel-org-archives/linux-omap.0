From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 04/14] irqchip: pruss: Add a PRUSS irqchip driver for
 PRUSS interrupts
Date: Mon, 4 Feb 2019 09:11:57 -0600
Message-ID: <57e5b54e-430e-daa1-4b5d-f61827095606@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-5-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549290167-876-5-git-send-email-rogerq@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com, ohad@wizery.com, bjorn.andersson@linaro.org
Cc: s-anna@ti.com, david@lechnology.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
List-Id: linux-omap@vger.kernel.org

On 2/4/19 8:22 AM, Roger Quadros wrote:
> From: "Andrew F. Davis" <afd@ti.com>
> 

[...]

> +static const struct pruss_intc_match_data am437x_pruss_intc_data = {
> +	.no_host7_intr = true,

Like done for the PRUSS driver with 'has_no_sharedram' becoming a DT
flag the same could be done here, then all this match data stuff could
be dropped.

> +};
> +
> +static const struct of_device_id pruss_intc_of_match[] = {
> +	{
> +		.compatible = "ti,am3356-pruss-intc",
> +		.data = NULL,
> +	},
> +	{
> +		.compatible = "ti,am4376-pruss-intc",
> +		.data = &am437x_pruss_intc_data,
> +	},
> +	{
> +		.compatible = "ti,am5728-pruss-intc",
> +		.data = NULL,
> +	},
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, pruss_intc_of_match);
> +
> +static struct platform_driver pruss_intc_driver = {
> +	.driver = {
> +		.name = "pruss-intc",
> +		.of_match_table = pruss_intc_of_match,
> +	},
> +	.probe  = pruss_intc_probe,
> +	.remove = pruss_intc_remove,
> +};
> +module_platform_driver(pruss_intc_driver);
> +
> +MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
> +MODULE_AUTHOR("Suman Anna <s-anna@ti.com>");
> +MODULE_DESCRIPTION("PRU-ICSS INTC Driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/irqchip/irq-pruss-intc.h b/include/linux/irqchip/irq-pruss-intc.h
> new file mode 100644
> index 0000000..4538a0b
> --- /dev/null
> +++ b/include/linux/irqchip/irq-pruss-intc.h
> @@ -0,0 +1,94 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/**
> + * irq-pruss-intc.h - PRU-ICSS INTC management

Filename not needed.

Andrew

> + *
> + * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
> + */
> +
> +#ifndef __INCLUDE_LINUX_IRQCHIP_IRQ_PRUSS_INTC_H
> +#define __INCLUDE_LINUX_IRQCHIP_IRQ_PRUSS_INTC_H
> +
> +/* maximum number of system events */
> +#define MAX_PRU_SYS_EVENTS	64
> +
> +/* maximum number of interrupt channels */
> +#define MAX_PRU_CHANNELS	10
> +
> +/**
> + * struct pruss_intc_config - INTC configuration info
> + * @sysev_to_ch: system events to channel mapping information
> + * @ch_to_host: interrupt channel to host interrupt information
> + */
> +struct pruss_intc_config {
> +	s8 sysev_to_ch[MAX_PRU_SYS_EVENTS];
> +	s8 ch_to_host[MAX_PRU_CHANNELS];
> +};
> +
> +#if IS_ENABLED(CONFIG_TI_PRUSS)
> +
> +/**
> + * pruss_intc_configure() - configure the PRUSS INTC
> + * @dev: device
> + * @intc_config: PRU core-specific INTC configuration
> + *
> + * Configures the PRUSS INTC with the provided configuration from
> + * a PRU core. Any existing event to channel mappings or channel to
> + * host interrupt mappings are checked to make sure there are no
> + * conflicting configuration between both the PRU cores. The function
> + * is intended to be used only by the PRU remoteproc driver.
> + *
> + * Returns 0 on success, or a suitable error code otherwise
> + */
> +int pruss_intc_configure(struct device *dev,
> +			 struct pruss_intc_config *intc_config);
> +
> +/**
> + * pruss_intc_unconfigure() - unconfigure the PRUSS INTC
> + * @dev: device
> + * @intc_config: PRU core specific INTC configuration
> + *
> + * Undo whatever was done in pruss_intc_configure() for a PRU core.
> + * It should be sufficient to just mark the resources free in the
> + * global map and disable the host interrupts and sysevents.
> + */
> +int pruss_intc_unconfigure(struct device *dev,
> +			   struct pruss_intc_config *intc_config);
> +/**
> + * pruss_intc_trigger() - trigger a PRU system event
> + * @irq: linux IRQ number associated with a PRU system event
> + *
> + * Trigger an interrupt by signalling a specific PRU system event.
> + * This can be used by PRUSS client users to raise/send an event to
> + * a PRU or any other core that is listening on the host interrupt
> + * mapped to that specific PRU system event. The @irq variable is the
> + * Linux IRQ number associated with a specific PRU system event that
> + * a client user/application uses. The interrupt mappings for this is
> + * provided by the PRUSS INTC irqchip instance.
> + *
> + * Returns 0 on success, or an error value upon failure.
> + */
> +int pruss_intc_trigger(unsigned int irq);
> +
> +#else
> +
> +static inline int pruss_intc_configure(struct device *dev,
> +				       struct pruss_intc_config *intc_config)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline int pruss_intc_unconfigure(struct device *dev,
> +					 struct pruss_intc_config *intc_config)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline int pruss_intc_trigger(unsigned int irq)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +#endif	/* CONFIG_TI_PRUSS */
> +
> +#endif /* __INCLUDE_LINUX_IRQCHIP_IRQ_OMAP_INTC_H */
> +
> 

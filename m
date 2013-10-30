From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2 2/7] DRIVERS: IRQCHIP: CROSSBAR: Add support for
 Crossbar IP
Date: Wed, 30 Oct 2013 16:30:31 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1310301615430.24686@ionos.tec.linutronix.de>
References: <1383145040-15852-1-git-send-email-r.sricharan@ti.com> <1383145040-15852-3-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1383145040-15852-3-git-send-email-r.sricharan@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, linux@arm.linux.org.uk, tony@atomide.com, rnayak@ti.com, marc.zyngier@arm.com, grant.likely@linaro.org, mark.rutland@arm.com, robherring2@gmail.com, santosh.shilimkar@ti.com, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-omap@vger.kernel.org

On Wed, 30 Oct 2013, Sricharan R wrote:
> +static inline const u32 allocate_free_irq(int cb_no)

I understand the "static inline" part, but "const u32" is more than
fishy. What's wrong with "static inline int" ?

> +{
> +	int i;
> +
> +	for (i = 0; i < cb->int_max; i++) {
> +		if (cb->irq_map[i] == IRQ_FREE) {
> +			cb->irq_map[i] = cb_no;
> +			return i;
> +		}
> +	}
> +
> +	return -ENODEV;
> +}

> +static int crossbar_domain_xlate(struct irq_domain *d,
> +				 struct device_node *controller,
> +				 const u32 *intspec, unsigned int intsize,
> +				 unsigned long *out_hwirq,
> +				 unsigned int *out_type)
> +{
> +	unsigned long ret = 0;

Why do you need to initialize ret when you assign a value to it in the
next line?

Thanks,

	tglx

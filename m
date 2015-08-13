From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 3/6] genirq: introduce irq_chip_set_type_parent() helper
Date: Thu, 13 Aug 2015 09:58:20 +0100
Message-ID: <55CC5C2C.4080301@arm.com>
References: <1439401562-28874-1-git-send-email-grygorii.strashko@ti.com> <1439401562-28874-4-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439401562-28874-4-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Marc Zyngier <Marc.Zyngier@arm.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "tony@atomide.com" <tony@atomide.com>, Sudeep Holla <sudeep.holla@arm.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "nsekhar@ti.com" <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "balbi@ti.com" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org



On 12/08/15 18:45, Grygorii Strashko wrote:
> It's expected to use this helper when the current
> domain doesn't implement .irq_set_type(),  but expect
> the parent to do so.
>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>   include/linux/irq.h |  1 +
>   kernel/irq/chip.c   | 20 ++++++++++++++++++++
>   2 files changed, 21 insertions(+)
>
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index 92188b0..51744bc 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -484,6 +484,7 @@ extern int irq_chip_set_affinity_parent(struct irq_data *data,
>   extern int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on);
>   extern int irq_chip_set_vcpu_affinity_parent(struct irq_data *data,
>   					     void *vcpu_info);
> +extern int irq_chip_set_type_parent(struct irq_data *data, unsigned int type);
>   #endif
>
>   /* Handling of unhandled and spurious interrupts: */
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index bdb1b9d..b48938b 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -985,6 +985,26 @@ int irq_chip_set_affinity_parent(struct irq_data *data,
>   }
>
>   /**
> + * irq_chip_set_type_parent - Set IRQ type on the parent interrupt
> + * @data:	Pointer to interrupt specific data
> + * @type:	IRQ_TYPE_{LEVEL,EDGE}_* value - see include/linux/irq.h
> + *
> + * Conditional, as the underlying parent chip might not implement it.
> + */
> +int irq_chip_set_type_parent(struct irq_data *data, unsigned int type)
> +{
> +	data = data->parent_data;
> +
> +	if (irq_data_get_irq_chip(data)->flags & IRQCHIP_SKIP_SET_WAKE)
> +		return 0;
> +

I think this is unrelated here(perhaps copy-paste error ?). I fail to
see how wakeup and trigger type are related.

Regards,
Sudeep

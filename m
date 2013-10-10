From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/6] pinctrl: single: Add support for wake-up interrupts
Date: Thu, 10 Oct 2013 16:24:15 +0300
Message-ID: <5256AA7F.8030005@ti.com>
References: <20131003054104.8941.88857.stgit@localhost> <20131003054221.8941.87801.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131003054221.8941.87801.stgit@localhost>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Prakash Manjunathappa <prakash.pm-l0cyMroinI0@public.gmane.org>, Haojian Zhuang <haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 10/03/2013 08:42 AM, Tony Lindgren wrote:
> The pin control registers can have interrupts for example
> for device wake-up. These interrupts can be treated as a
> chained interrupt controller as suggested earlier by
> Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>.
>=20
> This patch adds support for interrupts in a way that
> should be pretty generic, and works for the omaps that
> support wake-up interrupts. On omaps, there's an
> interrupt enable and interrupt status bit for each pin.
> The two pinctrl domains on omaps share a single interrupt
> from the PRM chained interrupt handler. Support for
> other similar hardware should be easy to add.
>=20
> Note that this patch does not attempt to handle the
> wake-up interrupts automatically unlike the earlier
> patches. This patch allows the device drivers to do
> a request_irq() on the wake-up pins as needed. I'll
> try to do also a separate generic patch for handling
> the wake-up events automatically.
>=20
> Also note that as this patch makes the pinctrl-single
> an irq controller, the current bindings need some
> extra trickery to use interrupts from two different
> interrupt controllers for the same driver. So it
> might be worth waiting a little on the patches
> enabling the wake-up interrupts from drivers as there
> should be a generic way to handle it coming. And also
> there's been discussion of interrupts-extended binding
> for using interrupts from multiple interrupt controllers.
>=20
> In any case, this patch should be ready to go allowing
> handling the wake-up interrupts in a generic way, or
> separately from the device drivers.
>=20
> Cc: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
> Cc: Prakash Manjunathappa <prakash.pm-l0cyMroinI0@public.gmane.org>
> Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> Cc: Haojian Zhuang <haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Beno=C3=AEt Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  .../devicetree/bindings/pinctrl/pinctrl-single.txt |   11 +
>  drivers/pinctrl/pinctrl-single.c                   |  325 ++++++++++=
++++++++++
>  2 files changed, 336 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single=
=2Etxt b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
> index 5a02e30..7069a0b 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
> @@ -72,6 +72,13 @@ Optional properties:
>  		/* pin base, nr pins & gpio function */
>  		pinctrl-single,gpio-range =3D <&range 0 3 0 &range 3 9 1>;
> =20
> +- interrupt-controller : standard interrupt controller binding if us=
ing
> +  interrupts for wake-up events for example. In this case pinctrl-si=
ngle
> +  is set up as a chained interrupt controller and the wake-up interr=
upts
> +  can be requested by the drivers using request_irq().
> +
> +- #interrupt-cells : standard interrupt binding if using interrupts
> +
>  This driver assumes that there is only one register for each pin (un=
less the
>  pinctrl-single,bit-per-mux is set), and uses the common pinctrl bind=
ings as
>  specified in the pinctrl-bindings.txt document in this directory.
> @@ -121,6 +128,8 @@ pmx_core: pinmux@4a100040 {
>  	reg =3D <0x4a100040 0x0196>;
>  	#address-cells =3D <1>;
>  	#size-cells =3D <0>;
> +	#interrupt-cells =3D <1>;
> +	interrupt-controller;
>  	pinctrl-single,register-width =3D <16>;
>  	pinctrl-single,function-mask =3D <0xffff>;
>  };
> @@ -131,6 +140,8 @@ pmx_wkup: pinmux@4a31e040 {
>  	reg =3D <0x4a31e040 0x0038>;
>  	#address-cells =3D <1>;
>  	#size-cells =3D <0>;
> +	#interrupt-cells =3D <1>;
> +	interrupt-controller;
>  	pinctrl-single,register-width =3D <16>;
>  	pinctrl-single,function-mask =3D <0xffff>;
>  };
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinct=
rl-single.c
> index f88d3d1..b4ff055 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -15,10 +15,14 @@
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/list.h>
> +#include <linux/interrupt.h>
> +
> +#include <linux/irqchip/chained_irq.h>
> =20
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/of_address.h>
> +#include <linux/of_irq.h>
> =20
>  #include <linux/pinctrl/pinctrl.h>
>  #include <linux/pinctrl/pinmux.h>
> @@ -152,9 +156,15 @@ struct pcs_name {
>  /**
>   * struct pcs_soc_data - SoC specific settings
>   * @flags:	initial SoC specific PCS_FEAT_xxx values
> + * @irq:	optional interrupt for the controller
> + * @irq_enable_mask:	optional SoC specific interrupt enable mask
> + * @irq_status_mask:	optional SoC specific interrupt status mask
>   */
>  struct pcs_soc_data {
>  	unsigned flags;
> +	int irq;
> +	unsigned irq_enable_mask;
> +	unsigned irq_status_mask;
>  };
> =20
>  /**
> @@ -165,6 +175,7 @@ struct pcs_soc_data {
>   * @dev:	device entry
>   * @pctl:	pin controller device
>   * @flags:	mask of PCS_FEAT_xxx values
> + * @lock:	spinlock for register access
>   * @mutex:	mutex protecting the lists
>   * @width:	bits per mux register
>   * @fmask:	function register mask
> @@ -179,6 +190,9 @@ struct pcs_soc_data {
>   * @pingroups:	list of pingroups
>   * @functions:	list of functions
>   * @gpiofuncs:	list of gpio functions
> + * @irqs:	list of interrupt registers
> + * @chip:	chip container for this instance
> + * @domain:	IRQ domain for this instance
>   * @ngroups:	number of pingroups
>   * @nfuncs:	number of functions
>   * @desc:	pin controller descriptor
> @@ -192,7 +206,11 @@ struct pcs_device {
>  	struct device *dev;
>  	struct pinctrl_dev *pctl;
>  	unsigned flags;
> +#define PCS_QUIRK_SHARED_IRQ	(1 << 2)
> +#define PCS_FEAT_IRQ		(1 << 1)
>  #define PCS_FEAT_PINCONF	(1 << 0)
> +	struct pcs_soc_data socdata;
> +	raw_spinlock_t lock;
>  	struct mutex mutex;
>  	unsigned width;
>  	unsigned fmask;
> @@ -208,6 +226,9 @@ struct pcs_device {
>  	struct list_head pingroups;
>  	struct list_head functions;
>  	struct list_head gpiofuncs;
> +	struct list_head irqs;
> +	struct irq_chip chip;
> +	struct irq_domain *domain;
>  	unsigned ngroups;
>  	unsigned nfuncs;
>  	struct pinctrl_desc desc;
> @@ -215,6 +236,8 @@ struct pcs_device {
>  	void (*write)(unsigned val, void __iomem *reg);
>  };
> =20
> +#define PCS_QUIRK_HAS_SHARED_IRQ	(pcs->flags & PCS_QUIRK_SHARED_IRQ)
> +#define PCS_HAS_IRQ		(pcs->flags & PCS_FEAT_IRQ)
>  #define PCS_HAS_PINCONF		(pcs->flags & PCS_FEAT_PINCONF)
> =20
>  static int pcs_pinconf_get(struct pinctrl_dev *pctldev, unsigned pin=
,
> @@ -440,9 +463,11 @@ static int pcs_enable(struct pinctrl_dev *pctlde=
v, unsigned fselector,
> =20
>  	for (i =3D 0; i < func->nvals; i++) {
>  		struct pcs_func_vals *vals;
> +		unsigned long flags;
>  		unsigned val, mask;
> =20
>  		vals =3D &func->vals[i];
> +		raw_spin_lock_irqsave(&pcs->lock, flags);
>  		val =3D pcs->read(vals->reg);
> =20
>  		if (pcs->bits_per_mux)
> @@ -453,6 +478,7 @@ static int pcs_enable(struct pinctrl_dev *pctldev=
, unsigned fselector,
>  		val &=3D ~mask;
>  		val |=3D (vals->val & mask);
>  		pcs->write(val, vals->reg);
> +		raw_spin_unlock_irqrestore(&pcs->lock, flags);
>  	}
> =20
>  	return 0;
> @@ -494,13 +520,16 @@ static void pcs_disable(struct pinctrl_dev *pct=
ldev, unsigned fselector,
> =20
>  	for (i =3D 0; i < func->nvals; i++) {
>  		struct pcs_func_vals *vals;
> +		unsigned long flags;
>  		unsigned val;
> =20
>  		vals =3D &func->vals[i];
> +		raw_spin_lock_irqsave(&pcs->lock, flags);
>  		val =3D pcs->read(vals->reg);
>  		val &=3D ~pcs->fmask;
>  		val |=3D pcs->foff << pcs->fshift;
>  		pcs->write(val, vals->reg);
> +		raw_spin_unlock_irqrestore(&pcs->lock, flags);
>  	}
>  }
> =20
> @@ -1451,11 +1480,33 @@ static void pcs_free_pingroups(struct pcs_dev=
ice *pcs)
>  }
> =20
>  /**
> + * pcs_irq_free() - free interrupt
> + * @pcs: pcs driver instance
> + */
> +static void pcs_irq_free(struct pcs_device *pcs)
> +{
> +	struct pcs_soc_data *pcs_soc =3D &pcs->socdata;
> +
> +	if (pcs_soc->irq < 0)
> +		return;
> +
> +	if (pcs->domain)
> +		irq_domain_remove(pcs->domain);
> +
> +	if (PCS_QUIRK_HAS_SHARED_IRQ)
> +		free_irq(pcs_soc->irq, pcs_soc);
> +	else
> +		irq_set_chained_handler(pcs_soc->irq, NULL);
> +}
> +
> +/**
>   * pcs_free_resources() - free memory used by this driver
>   * @pcs: pcs driver instance
>   */
>  static void pcs_free_resources(struct pcs_device *pcs)
>  {
> +	pcs_irq_free(pcs);
> +
>  	if (pcs->pctl)
>  		pinctrl_unregister(pcs->pctl);
> =20
> @@ -1504,6 +1555,259 @@ static int pcs_add_gpio_func(struct device_no=
de *node, struct pcs_device *pcs)
>  	}
>  	return ret;
>  }
> +/**
> + * @reg:	virtual address of interrupt register
> + * @hwirq:	hardware irq number
> + * @irq:	virtual irq number
> + * @node:	list node
> + */
> +struct pcs_interrupt {
> +	void __iomem *reg;
> +	irq_hw_number_t hwirq;
> +	unsigned int irq;
> +	struct list_head node;
> +};
> +
> +/**
> + * pcs_irq_set() - enables or disables an interrupt
> + *
> + * Note that this currently assumes one interrupt per pinctrl
> + * register that is typically used for wake-up events.
> + */
> +static inline void pcs_irq_set(struct pcs_soc_data *pcs_soc,
> +			       int irq, const bool enable)
> +{
> +	struct pcs_device *pcs;
> +	struct list_head *pos;
> +	unsigned mask;
> +
> +	pcs =3D container_of(pcs_soc, struct pcs_device, socdata);
> +	list_for_each(pos, &pcs->irqs) {
> +		struct pcs_interrupt *pcswi;
> +		unsigned soc_mask;
> +
> +		pcswi =3D list_entry(pos, struct pcs_interrupt, node);
> +		if (irq !=3D pcswi->hwirq)
> +			continue;
> +
> +		soc_mask =3D pcs_soc->irq_enable_mask;
> +		raw_spin_lock(&pcs->lock);
> +		mask =3D pcs->read(pcswi->reg);
> +		if (enable)
> +			mask &=3D ~soc_mask;
> +		else
> +			mask |=3D soc_mask;
> +		pcs->write(mask, pcswi->reg);
> +		raw_spin_unlock(&pcs->lock);
> +	}
> +}
> +
> +/**
> + * pcs_irq_mask() - mask pinctrl interrupt
> + * @d: interrupt data
> + */
> +static void pcs_irq_mask(struct irq_data *d)
> +{
> +	struct pcs_soc_data *pcs_soc =3D irq_data_get_irq_chip_data(d);
> +
> +	pcs_irq_set(pcs_soc, d->irq, false);
> +}
> +
> +/**
> + * pcs_irq_unmask() - unmask pinctrl interrupt
> + * @d: interrupt data
> + */
> +static void pcs_irq_unmask(struct irq_data *d)
> +{
> +	struct pcs_soc_data *pcs_soc =3D irq_data_get_irq_chip_data(d);
> +
> +	pcs_irq_set(pcs_soc, d->irq, true);
> +}
> +
> +/**
> + * pcs_irq_set_wake() - toggle the suspend and resume wake up
> + * @d: interrupt data
> + * @state: wake-up state
> + *
> + * Note that this should be called only for suspend and resume.
> + * For runtime PM, the wake-up events should be enabled by default.
> + */
> +static int pcs_irq_set_wake(struct irq_data *d, unsigned int state)
> +{
> +	if (state)
> +		pcs_irq_unmask(d);
> +	else
> +		pcs_irq_mask(d);
> +
> +	return 0;
> +}
> +


I tried testing this with the USB EHCI driver, but I'm not getting wake=
 up interrupts
while the system is still running and only the EHCI controller is runti=
me suspended.

It seems we need to somehow call _reconfigure_io_chain() to update the =
daisy chain
whenever the pad wakeup_enable bit is changed.

I think pcs_irq_set_wake() is where need to control system wakeup behav=
iour for the irq.
This is where we should be able to change WAKEUP_EN bit of the pad
to enable/disable system wakeup for that pad and also call _reconfigure=
_io_chain().

This would mean that we don't really need to set WAKEUP_EN for the pads=
 in the DTS file.

cheers,
-roger

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

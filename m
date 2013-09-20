From: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 1/4] DRIVERS: IRQCHIP: Add crossbar irqchip driver
Date: Fri, 20 Sep 2013 15:29:25 +0530
Message-ID: <523C1C7D.1060407@ti.com>
References: <1379000351-15672-1-git-send-email-r.sricharan@ti.com> <1379000351-15672-2-git-send-email-r.sricharan@ti.com> <20130920085830.GF17453@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130920085830.GF17453-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "rnayak-l0cyMroinI0@public.gmane.org" <rnayak-l0cyMroinI0@public.gmane.org>, "santosh.shilimkar-l0cyMroinI0@public.gmane.org" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Mark,

On Friday 20 September 2013 02:28 PM, Mark Rutland wrote:
> Hi,
>
> I have a few comments, mostly on the DT binding and parsing.
>
 Thanks for the review. The idea of seeing the crossbar as a new IRQCHIP
 itself did not go and the latest direction on this was to handle it inside the GIC.

  http://www.spinics.net/lists/linux-omap/msg97085.html
  I am working on that now.

  I would have agreed with most of the comments below, otherwise.

>> diff --git a/Documentation/devicetree/bindings/arm/omap/irq-crossbar.txt b/Documentation/devicetree/bindings/arm/omap/irq-crossbar.txt
>> new file mode 100644
>> index 0000000..5d465cf
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/omap/irq-crossbar.txt
>> @@ -0,0 +1,39 @@
>> +* IRQ CROSSBAR
>> +
>> +Some socs have a large number of interrupts requests to service
>> +the needs of its many peripherals and subsystems. All of the
>> +interrupt lines from the subsystems are not needed at the same
>> +time, so they have to be muxed to the irq-controller appropriately.
>> +In such places a interrupt controllers are preceded by an CROSSBAR
>> +that provides flexibility in muxing the device requests to the controller
>> +inputs.
>> +
>> +Required properties:
>> +- compatible : Should be "irq-crossbar"
> Missing vendor prefix, this should be something like "ti,irq-crossbar".
> Does this have a more specific name than CROSSBAR that can be used to
> qualify it?
 yes, ti,irq-crossbar. Not sure if it can be called as anything
 generically apart from crossbar .
>> +- interrupt-parent: phandle to crossbar's interrupt parent.
>> +- interrupt-controller: Identifies the node as an interrupt controller.
>> +- interrupt-cells: Should be the same value as the interrupt parent.
> That doesn't make sense. The crossbar driver is necessarily interpreting
> these cells in a way the parent won't (as it supports more interrupts).
> What are the meaning of these cells?
 These properties were added so that the DT code identifies this as a
 interrupt controller and map the children's irq in to this domain and
 to map the free irqs allocated in this driver to its parent.
>> +- reg: Base address and the size of the crossbar registers.
>> +- max-crossbar-lines: Total number of input lines of the crossbar.
>> +- max-irqs: Total number of irqs available at the interrupt controller.
> Is this the maximum number of interrupts targeting the parent interrupt
> controller? Starting at what number, ending at what number? Can this
> have gaps?
>
> Is this a shortcut so in the GIC case you don't have to describe up to
> 160 interrupts? I can see why you don't want to, but there's a big loss
> of generality here...
>
 Yes, this was the maximum irqs available at the parent.
 The gaps was not considered here because it was mentioned
 used the below property irqs-reserved.
>> +- reg-size: size of the crossbar registers.
> As in the size of all the registers (the size component of reg)?
>
> Or is this the size of each individual register? Does that apply to all
> registers or only a subset of them?
>
> What units are these in, bytes?
>
> What are valid sizes?
>
> Is this really that configurable?
 This was meant to describe the size a individual register and applied to
 all. This was used to choose the API's to write. But yes some more
 description could be made here.
>> +- irqs-reserved: List of the reserved irq lines that are not muxed using
>> +                crossbar. These interrupt lines are reserved in the soc,
>> +                so crossbar bar driver should not consider them as free
>> +                lines.
> Are these reserved inputs lines, or outputs to the parent interrupt
> controller?
>
> What is the format of each entry in this list?
>
> The example seems to be a different format to the parent interrupt
> controller (which per your binding also defined the crossbar's interrupt
> format). While <0 1 2> is a valid interrupt per the GIC binding (SPI 0
> edge-triggered both ways), <3 5 6>, <131 132 139>, and <140 . .> are
> not.
 These were parent's input lines that were not muxed from crossbar
 but directly connected from peripherals, so the driver should not
consider it as a free line while allocating a irq. This property was meant to
 interpreted only in this driver.
>> +
>> +Examples:
>> +               crossbar_mpu: @4a020000 {
>> +                       compatible = "irq-crossbar";
>> +                       interrupt-parent = <&gic>;
>> +                       interrupt-controller;
>> +                       #interrupt-cells = <3>;
>> +                       reg = <0x4a002a48 0x130>;
>> +                       max-crossbar-lines = <512>;
>> +                       max-irqs = <160>;
>> +                       reg-size = <2>;
>> +                       irqs-reserved = <0 1 2 3 5 6 131 132 139 140>;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
> Why are there #address-cells and #size cells? This has no children, and
> this affects any interrupt-map property (as the parent unit address now
> must be a single cell, that isn't going to be used).
>
> [...]
 yes, they could have been dropped and simply inherit from parent.
>> +static int crossbar_set_affinity(struct irq_data *d,
>> +                                const struct cpumask *mask_val,
>> +                                bool force)
>> +{
>> +       struct irq_chip *chip;
>> +       struct irq_data *data;
>> +       int ret = 0;
>> +
>> +       crossbar_to_irq_chip_data(d->hwirq, &chip, &data);
>> +
>> +       if (chip->irq_set_affinity)
>> +               ret = chip->irq_set_affinity(data, mask_val, force);
>> +
>> +       return ret;
> So if our parent chip can't set affinity, we pretend it can?
>
> irq_set_affinity in kernel/irq/manage.c returns -EINVAL if an irqchip
> doesn't have irq_set_affinity.
>
 Yes the return value should be corrected for the other case.
>> +/*
>> + * Request and free are already called in atomic contexts
>> + */
>> +unsigned int crossbar_request_irq(struct irq_data *d)
>> +{
>> +       int cb_no = d->hwirq;
>> +       int virq = allocate_free_irq(cb_no);
>> +       void *irq = &cb->crossbar_map[cb_no].hwirq;
>> +       int err;
>> +
>> +       err = request_threaded_irq(virq, crossbar_irq, NULL,
>> +                                  0, "CROSSBAR", irq);
>> +       if (err)
>> +               pr_err("\n request_irq failed for crossbar %d", cb_no);
> Why does the print begin with a newline rather than ending with one?
>
 yes, should be in the end.
>> +
>> +       return 0;
>> +}
> [...]
>
>> +static int crossbar_domain_xlate(struct irq_domain *d,
>> +                                struct device_node *controller,
>> +                                const u32 *intspec, unsigned int intsize,
>> +                                unsigned long *out_hwirq,
>> +                                unsigned int *out_type)
>> +{
>> +       int i, cb_no;
>> +       u32 *cb_intspec = kzalloc(intsize * sizeof(int), GFP_KERNEL);
>> +
>> +       if (!cb_intspec)
>> +               return -ENOMEM;
>> +
>> +       cb_no = intspec[1];
> So #interrupt-cells must be at least <2>. You should sanity check
> intsize >= 2 before this line or you'll perform an illegal array access.
>
 yes, that was missing.
>> +
>> +       if (WARN_ON(intsize < 1))
>> +               return -EINVAL;
> This sanity check is both wrong and too late, as mentioned above.
>
>> +
>> +       cb->crossbar_map[cb_no].intspec = cb_intspec;
>> +
>> +       /*
>> +        * Free irq is allocated and mapped during request_irq
>> +        * So just save the interrupt properties here
>> +        */
>> +       for (i = 0; i < intsize; i++)
>> +               cb->crossbar_map[cb_no].intspec[i] = intspec[i];
>> +
>> +       cb->crossbar_map[cb_no].intspec_size = intsize;
>> +       *out_hwirq = intspec[1];
>> +       *out_type = IRQ_TYPE_NONE;
>> +
>> +       return 0;
>> +}
>> +
>> +const struct irq_domain_ops crossbar_domain_ops = {
>> +       .map = crossbar_domain_map,
>> +       .xlate = crossbar_domain_xlate
>> +};
>> +
>> +static int __init crossbar_of_init(struct device_node *node,
>> +                                  struct device_node *parent)
>> +{
>> +       int i, size, max, reserved = 0;
>> +       const __be32 *irqsr;
>> +
>> +       if (!parent) {
>> +               pr_err("\n interrupt-parent is missing");
> Another odd newline.
 correct.
>> +               return -ENODEV;
>> +       }
>> +
>> +       cb = kzalloc(sizeof(struct cb_device *), GFP_KERNEL);
>> +
>> +       if (!cb)
>> +               return -ENOMEM;
>> +
>> +       cb->irqp = parent;
>> +
>> +       cb->crossbar_base = of_iomap(node, 0);
>> +       if (!cb->crossbar_base)
>> +               return -ENOMEM;
> Leaking allocated cb here.
 Agree here and other leaks mentioned below, free is missing.
>> +
>> +       of_property_read_u32(node, "max-crossbar-lines", &max);
>> +       cb->crossbar_map = kzalloc(max * sizeof(struct pirqs *), GFP_KERNEL);
>> +
>> +       if (!cb->crossbar_map)
>> +               return -ENOMEM;
> Leaking cb and cb->crossbar_base mapping.
>
>> +
>> +       cb->domain = irq_domain_add_linear(node, max,
>> +                                      &crossbar_domain_ops, NULL);
>> +
>> +       if (!cb->domain) {
>> +               pr_err("Couldn't register an IRQ domain\n");
>> +               return -ENODEV;
>> +       }
> Leaking cb, cb->crossbar_base, and cb->crossbar_map here.
>
>> +
>> +       of_property_read_u32(node, "max-irqs", &max);
>> +       cb->irq_map = kzalloc(max * sizeof(int), GFP_KERNEL);
>> +       if (!cb->irq_map)
>> +               return -ENOMEM;
> Leaking cb, cb->crossbar_base, cb->crossbar_map, and cb->domain.
>
>> +
>> +       cb->int_max = max;
>> +
>> +       for (i = 0; i < max; i++)
>> +               cb->irq_map[i] = IRQ_FREE;
>> +
>> +       /* Get and mark reserved irqs */
>> +       irqsr = of_get_property(node, "irqs-reserved", &size);
>> +       size /= sizeof(int);
> The entries will be __be32, not int.
>
>> +
>> +       for (i = 0; i < size; i++)
>> +               cb->irq_map[be32_to_cpup(irqsr + i)] = 0;
> No sanity check on array bounds?
>
> What about a dt that has something like:
>
> 	irqs-reserved = <0x0 0xcccccccc 0xffffffff>;
>
> It's clearly wrong, and we can detect that rather than bringing down the
> kernel...
 yes, sanity check was required here.
>> +
>> +       cb->register_offsets = kzalloc(max * sizeof(int), GFP_KERNEL);
>> +       if (!cb->register_offsets)
>> +               return -ENOMEM;
> Leaking cb, cb->crossbar_base, cb->crossbar_map, cb->domain, and
> cb->irq_map here.
>
>> +
>> +       of_property_read_u32(node, "reg-size", &size);
> Sanity check?
>
>> +
>> +       /*
>> +        * Register offsets are not linear because of the
>> +        * reserved irqs. so find and store the offsets once.
>> +        */
>> +       for (i = 0; i < max; i++) {
>> +               if (!cb->irq_map[i])
>> +                       continue;
>> +
>> +               cb->register_offsets[i] = reserved;
>> +               reserved += size;
>> +       }
>> +
>> +       switch (size) {
>> +       case 1:
>> +               cb->write = crossbar_writeb;
>> +               break;
>> +       case 2:
>> +               cb->write = crossbar_writew;
>> +               break;
>> +       case 4:
>> +               cb->write = crossbar_writel;
>> +               break;
>> +       default:
>> +               break;
> Perform cleanup and return -EINVAL here?
 correct.
>> +       }
>> +
>> +       return 0;
>> +}
>> +IRQCHIP_DECLARE(crossbar, "crossbar-irqchip", crossbar_of_init);
>> --
>> 1.7.9.5
 Regards,
 Sricharan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

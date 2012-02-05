From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Sun, 5 Feb 2012 11:10:02 +0000
Message-ID: <20120205111002.GM1275@n2100.arm.linux.org.uk>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205015530.GI1426@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38289 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754436Ab2BELKN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Feb 2012 06:10:13 -0500
Content-Disposition: inline
In-Reply-To: <20120205015530.GI1426@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Sat, Feb 04, 2012 at 05:55:30PM -0800, Tony Lindgren wrote:
> Hi,
> 
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120204 12:03]:
> > 
> > Another problem oopses the kernel at boot in the voltage domain code,
> > which I suspect this has never been boot tested on OMAP34xx CPUs:
> > 
> > omap_vc_init_channel: PMIC info requried to configure vc forvdd_core not populated.Hence cannot initialize vc
> > Unable to handle kernel NULL pointer dereference at virtual address 00000000
> ...
> > Backtrace: 
> > [<c03db824>] (omap_vp_init+0x0/0x15c) from [<c03db448>] (omap_voltage_late_init+
> > 0xc4/0xfc)
> > [<c03db384>] (omap_voltage_late_init+0x0/0xfc) from [<c03d9df8>] (omap2_common_p
> > m_late_init+0x14/0x54)
> >  r8:00000000 r7:00000013 r6:c0039988 r5:c03fe004 r4:c03fdfb8
> > [<c03d9de4>] (omap2_common_pm_late_init+0x0/0x54) from [<c0008798>] (do_one_init
> > call+0x9c/0x164)
> > [<c00086fc>] (do_one_initcall+0x0/0x164) from [<c03d1284>] (kernel_init+0x7c/0x1
> > 20)
> > [<c03d1208>] (kernel_init+0x0/0x120) from [<c0039988>] (do_exit+0x0/0x2cc)
> >  r5:c03d1208 r4:00000000
> ...
> 
> > And OMAP4 doesn't build.  Fixing the build error in prm44xx.c (which is
> > virtually the same as the OMAP3 build error in its prm file) gets us to
> > a buildable state, but... it silently fails to boot.
> > 
> > arch/arm/mach-omap2/prm44xx.c:41: error: 'OMAP44XX_IRQ_PRCM' undeclared here (not in a function)
> > 
> > At least enabling DEBUG_LL gets this reason:
> > 
> > <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000 
> ...
> > Backtrace:                                                                      
> > [<c007bab4>] (irq_domain_add+0x0/0x134) from [<c029baac>] (twl_probe+0xd0/0x370)
> >  r6:c03bef90 r5:00000014 r4:00000170                                            
> > [<c029b9dc>] (twl_probe+0x0/0x370) from [<c01eee70>] (i2c_device_probe+0xb0/0xe4
> > )                                                                               
> > [<c01eedc0>] (i2c_device_probe+0x0/0xe4) from [<c01d1f34>] (really_probe+0xa0/0x
> > 178)                                                                            
> ...
> 
> Just to verify, it seems that both of these happen because of
> IRQ_DOMAIN not being set?

No.  The OMAP3 boot oops is partly because of that rubbish dependency
preventing the PMIC support code being build, but that is only part of
the problem and therefore that patch is only _part_ of the solution.

It's clearly a legal configuration for the TWL support to be disabled,
and the kernel should NOT oops on boot because of that.  So even though
removing the IRQ_DOMAIN dependency _and_ enabling the driver makes the
oops go away, that's _really_ not a fix by any shape or form.

Code should _never_ oops because something isn't built-in that's required.
The vc layer of the voltage domain cope with the missing pmic, and so
should the vp layer.

As for OMAP4, in no way does that patch fix the problem there, because
OMAP4 has the GIC, and the GIC selects CONFIG_IRQ_DOMAIN.  The problem is
much more fundamental, and of course the code reveals why:

drivers/mfd/twl-core.c:
        domain.irq_base = pdata->irq_base;
        domain.nr_irq = nr_irqs;
#ifdef CONFIG_OF_IRQ
        domain.of_node = of_node_get(node);
        domain.ops = &irq_domain_simple_ops;
#endif
        irq_domain_add(&domain);

kernel/irq/irqdomain.c:
void irq_domain_add(struct irq_domain *domain)
{
        irq_domain_for_each_irq(domain, hwirq, irq) {

include/linux/irqdomain.h:
#define irq_domain_for_each_irq(d, hw, irq) \
        for (hw = d->hwirq_base, irq = irq_domain_to_irq(d, hw); \
             hw < d->hwirq_base + d->nr_irq; \
             hw++, irq = irq_domain_to_irq(d, hw))

static inline unsigned int irq_domain_to_irq(struct irq_domain *d,
                                             unsigned long hwirq)
{
        if (d->ops->to_irq)
                return d->ops->to_irq(d, hwirq);

Basically, the irq domain ops pointer _must_ _always_ be a valid pointer
before an irq domain is added.

At a guess, twl-core.c should be:

drivers/mfd/twl-core.c:
#ifdef CONFIG_IRQ_DOMAIN
        domain.irq_base = pdata->irq_base;
        domain.nr_irq = nr_irqs;
#ifdef CONFIG_OF_IRQ
        domain.of_node = of_node_get(node);
#endif
        domain.ops = &irq_domain_simple_ops;
        irq_domain_add(&domain);
#endif

From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 1/4] DRIVERS: IRQCHIP: Add crossbar irqchip driver
Date: Fri, 13 Sep 2013 10:55:46 -0400
Message-ID: <52332772.5040203@ti.com>
References: <1379000351-15672-1-git-send-email-r.sricharan@ti.com> <1379000351-15672-2-git-send-email-r.sricharan@ti.com> <alpine.DEB.2.02.1309122201530.4089@ionos.tec.linutronix.de> <523228B5.5070507@ti.com> <alpine.DEB.2.02.1309122335440.4089@ionos.tec.linutronix.de> <5232457A.8080709@ti.com> <alpine.DEB.2.02.1309130138550.4089@ionos.tec.linutronix.de> <52326D6B.2010003@ti.com> <alpine.DEB.2.02.1309131142540.4089@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.02.1309131142540.4089-3cz04HxQygjZikZi3RtOZ1XZhhPuCNm+@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LAK <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, rnayak-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Friday 13 September 2013 10:24 AM, Thomas Gleixner wrote:
> On Thu, 12 Sep 2013, Santosh Shilimkar wrote:
>> On Thursday 12 September 2013 08:26 PM, Thomas Gleixner wrote:
>>> Let me summarize:
>>>
>>>    - GIC supports up to 160 interrupts
>>>
>>>    - CROSSBAR supports up to 250 interrupts 
>>>
>>>    - CROSSBAR routes up to 160 out of 250 interrupts to the GIC ones
>>>
>>>    - Drivers request a CROSSBAR interrupt number which must be mapped
>>>      to some arbitrary available GIC irq number
>>>
>> Correct.
>>
>>> So basically the CROSSBAR mechanism is pretty much the same as MSI[X]
>>> just in a different flavour and with a different set of semantics and
>>> limitations, i.e. poor mans MSI[X] with a new level of bogosity.
>>>
>>> So if CROSSBAR is going to be the new fangled SoC MSI[X] long term
>>> equivalent then you better provide some infrastructure for that and
>>> make the drivers ready to use it. Maybe check with the PCI/MSI folks
>>> to share some of the interfaces.
>>>
>>> If that whole thing is another onetime HW designers wet dream, then
>>> please go back to the limited but completely functional (Who is going
>>> to use more than 160 peripheral interrupts????) device tree model. I
>>> really have no interest to support hardware designer brain farts.
>>>
>> Thanks for clear NAK for irqchip approach. I should have looped you
>> in the discussion where I was also suggesting against the irqchip
>> approach. We will try to look at MSI stuff but if its get too
>> complicated am going to fall-back to the initial probe based
>> approach to achieve the functionality.
> 
> Before you dig into MSI, lets talk about irq domains first.
> 
> GIC implements a legacy irq domain, i.e. a linear domain of all
> possible GIC interrupts with a 1:1 mapping.
> 
> So why can't you make use of irq domains and have the whole routing
> business implemented sanely?
> 
> What's needed is in gic_init_bases():
> 
>        if (of_property_read(node, "routable_irqs", &nr_routable_irqs) {
>        	  irq_domain_add_legacy(nr_gic_irqs);
>        } else {
>        	  irq_domain_add_legacy(nr_per_cpu_irqs);
> 	  irq_domain_add_linear(nr_routable_irqs);
>        }
> 
> Now that separate domain has an xlate function which grabs a free GIC
> irq from a bitmap and returns the hardware irq number in the gic
> space. The map/unmap callbacks take care of setting up / tearing down
> the route in the crossbar.
> 
> Thoughts?
> 
This sounds pretty good idea. We will explore above option.
Thanks Thomas.

Regards,
Santosh

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [RFC PATCH 1/4] DRIVERS: IRQCHIP: Add crossbar irqchip driver
Date: Thu, 19 Sep 2013 00:31:57 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1309190014160.4089@ionos.tec.linutronix.de>
References: <1379000351-15672-1-git-send-email-r.sricharan@ti.com> <1379000351-15672-2-git-send-email-r.sricharan@ti.com> <alpine.DEB.2.02.1309122201530.4089@ionos.tec.linutronix.de> <523228B5.5070507@ti.com> <alpine.DEB.2.02.1309122335440.4089@ionos.tec.linutronix.de>
 <5232457A.8080709@ti.com> <alpine.DEB.2.02.1309130138550.4089@ionos.tec.linutronix.de> <52326D6B.2010003@ti.com> <alpine.DEB.2.02.1309131142540.4089@ionos.tec.linutronix.de> <52332772.5040203@ti.com> <5239C19E.1090609@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5239C19E.1090609-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LAK <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, rnayak-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, 18 Sep 2013, Santosh Shilimkar wrote:
> On Friday 13 September 2013 10:55 AM, Santosh Shilimkar wrote:
> > On Friday 13 September 2013 10:24 AM, Thomas Gleixner wrote:
> 
> [...]
> 
> >> Before you dig into MSI, lets talk about irq domains first.
> >>
> >> GIC implements a legacy irq domain, i.e. a linear domain of all
> >> possible GIC interrupts with a 1:1 mapping.
> >>
> >> So why can't you make use of irq domains and have the whole routing
> >> business implemented sanely?
> >>
> >> What's needed is in gic_init_bases():
> >>
> >>        if (of_property_read(node, "routable_irqs", &nr_routable_irqs) {
> >>        	  irq_domain_add_legacy(nr_gic_irqs);
> >>        } else {
> >>        	  irq_domain_add_legacy(nr_per_cpu_irqs);
> >> 	  irq_domain_add_linear(nr_routable_irqs);
> >>        }
> >>
> >> Now that separate domain has an xlate function which grabs a free GIC
> >> irq from a bitmap and returns the hardware irq number in the gic
> >> space. The map/unmap callbacks take care of setting up / tearing down
> >> the route in the crossbar.
> >>
> >> Thoughts?
> >>
> > This sounds pretty good idea. We will explore above option.
> > Thanks Thomas.
> > 
> After further looking into this, the irqdomain approach lets us
> setup the map only once during the init. This is similar to
> the earlier approach of cross-bar driver where at probe time
> the router was setup.  The whole debate started with the fact
> that we shouldn't fix the irq mapping at probe and should
> dynamically change the mapping based on [request/free]_irq()
> to be able to maximize the use of the IP.

Well, that's what irq_of_parse_and_map() resp. irq_create_mapping and
irq_dispose_mapping() are for.

It requires changes to drivers, but you can't get that thing for free.

Thanks,

	tglx
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

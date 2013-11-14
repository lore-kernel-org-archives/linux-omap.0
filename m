From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V4 1/4] DRIVERS: IRQCHIP: IRQ-GIC: Add support for
 routable irqs
Date: Thu, 14 Nov 2013 14:01:03 +0000
Message-ID: <20131114140103.GA28328@e106331-lin.cambridge.arm.com>
References: <1384431530-2166-1-git-send-email-r.sricharan@ti.com>
 <1384431530-2166-2-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1384431530-2166-2-git-send-email-r.sricharan-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "rnayak-l0cyMroinI0@public.gmane.org" <rnayak-l0cyMroinI0@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "nm-l0cyMroinI0@public.gmane.org" <nm-l0cyMroinI0@public.gmane.org>, "bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org" <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 14, 2013 at 12:18:47PM +0000, Sricharan R wrote:
> In some socs the gic can be preceded by a crossbar IP which
> routes the peripheral interrupts to the gic inputs. The peripheral
> interrupts are associated with a fixed crossbar input line and the
> crossbar routes that to one of the free gic input line.
> 
> The DT entries for peripherals provides the fixed crossbar input line
> as its interrupt number and the mapping code should associate this with
> a free gic input line. This patch adds the support inside the gic irqchip
> to handle such routable irqs. The routable irqs are registered in a linear
> domain. The registered routable domain's callback should be implemented
> to get a free irq and to configure the IP to route it.
> 
> Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
> Cc: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
> Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
> Acked-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> ---
>  [V2] Added default routable-irqs functions to avoid
>       unnecessary if checks as per Thomas Gleixner comments
>       and renamed routable-irq binding as per
>       Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> comments.
> 
>  [V3] Addressed unnecessary warn-on and updated default
>       xlate function as per Thomas Gleixner comments
> 
>  Documentation/devicetree/bindings/arm/gic.txt |    6 ++
>  drivers/irqchip/irq-gic.c                     |   81 ++++++++++++++++++++++---
>  include/linux/irqchip/arm-gic.h               |    7 ++-
>  3 files changed, 83 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
> index 3dfb0c0..5357745 100644
> --- a/Documentation/devicetree/bindings/arm/gic.txt
> +++ b/Documentation/devicetree/bindings/arm/gic.txt
> @@ -49,6 +49,11 @@ Optional
>    regions, used when the GIC doesn't have banked registers. The offset is
>    cpu-offset * cpu-nr.
>  
> +- arm,routable-irqs : Total number of gic irq inputs which are not directly
> +		  connected from the peripherals, but are routed dynamically
> +		  by a crossbar/multiplexer preceding the GIC. The GIC irq
> +		  input line is assigned dynamically when the corresponding
> +		  peripheral's crossbar line is mapped.

I'm not keen on the design of the arm,routable-irqs property. The set of
IRQs which the crossbar IP can use is a property of which IRQ lines it
has routed to the GIC. I don't see why that should be considered a
property of the GIC; it's a property of the crossbar IP's attachment to
the GIC.

Given we already have a mechanism for describing the attachment (i.e.
the interrupts property) where the property appears on the node for the
device generating/propagating the interrupt, I don't see why we should
do differently here.

Listing 160 interrupts in the crossbar node is clearly something we
don't want to have to do.  If we had a property that we could use to
define a range (or multiple ranges) of interrupts, then the crossbar
driver could go and request those ranges from its interrupt-parent (the
GIC) and the GIC driver could reserve/allocate the irqdomain at that
time.

This feels like a point-hack, counter in style to the vast majority of
provider/consumer bindings. It only allows for one multiplexer before
the GIC. What if we had multiple multiplexers feeding into the GIC?
Describing the attachment on the multiplexer allows that to be handled,
describing that on the GIC does not.

Describing the attachement on the multiplexer would also prevent the
duplication of information (i.e. the max-irqs property in the crossbar
binding).

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

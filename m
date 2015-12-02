From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 00/27] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Tue, 1 Dec 2015 19:26:43 -0800
Message-ID: <20151202032643.GF64635@google.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
 <20151026212346.GJ13239@google.com>
 <562F45BF.8020205@ti.com>
 <20151130195449.GI64635@google.com>
 <565DB18C.7040505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <565DB18C.7040505-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On Tue, Dec 01, 2015 at 04:41:16PM +0200, Roger Quadros wrote:
> On 30/11/15 21:54, Brian Norris wrote:
> > On Tue, Oct 27, 2015 at 11:37:03AM +0200, Roger Quadros wrote:
> >> On 26/10/15 23:23, Brian Norris wrote:
> >>> On Fri, Sep 18, 2015 at 05:53:22PM +0300, Roger Quadros wrote:
> >>>> - Remove NAND IRQ handling from omap-gpmc driver, share the GPMC IRQ
> >>>> with the omap2-nand driver and handle NAND IRQ events in the NAND driver.
> >>>> This causes performance increase when using prefetch-irq mode.
> >>>> 30% increase in read, 17% increase in write in prefetch-irq mode.
> >>>
> >>> Have you pinpointed the exact causes for the performance increase, or
> >>> can you give an educated guess? AIUI, you're reducing the number of
> >>> interrupts needed for NAND prefetch mode, but you're also removing a bit
> >>> of abstraction and implementing hooks that look awfully like the
> >>> existing abstractions:
> >>>
> >>> +       int (*nand_irq_enable)(enum gpmc_nand_irq irq);
> >>> +       int (*nand_irq_disable)(enum gpmc_nand_irq irq);
> >>> +       void (*nand_irq_clear)(enum gpmc_nand_irq irq);
> >>> +       u32 (*nand_irq_status)(void);
> >>>
> >>> That's not really a problem if there's a good reason for them (brcmnand
> >>> implements similar hooks because of quirks in the implementation of
> >>> interrupts across various BRCM SoCs, and it's not worth writing irqchip
> >>> drivers for those cases). I'm mainly curious for an explanation.
> >>
> >> I have both implementations with me. My guess is that the 20% performance
> >> gain is due to absence of irqchip/irqdomain translation code.
> >> I haven't investigated further though.
> > 
> > I don't have much context for whether this makes sense or not. According
> > to your tests, you're getting ~800K interrupts over ~15 seconds. So
> > should you start noticing performance hits due to abstraction at 53K
> > interrupts per second?
> 
> Yes, this was my understanding.

Am I computing wrong, or is that a pretty insane rate of interrupts?

> > But anyway, I'm not sure that completely answered my question. My
> > question was whether you were removing the irqchip code solely for
> > performance reasons, or are there others?
> 
> Yes. Only for performance reasons.

Hmm, that's not my favorite answer. I'd prefer that more analysis was
done here before scrapping irqchip...

But maybe that's not too bad. It seems like your patch set overall is a
net positive for disentangling some of arch/ and drivers/.

I'll take another pass over your patch set, but if things are looking
better, how do you expect to merge this? There are significant portions
that touch at least 2 or 3 different subsystem trees, AFAICT.

Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

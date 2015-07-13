From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 03/12] mtd: nand: omap: Move IRQ handling from GPMC to
 NAND driver
Date: Mon, 13 Jul 2015 06:01:10 -0700
Message-ID: <20150713130109.GG26485@atomide.com>
References: <1436531019-18088-1-git-send-email-rogerq@ti.com>
 <1436531019-18088-4-git-send-email-rogerq@ti.com>
 <20150713071008.GC26485@atomide.com>
 <55A38D2E.9010500@ti.com>
 <20150713124059.GF26485@atomide.com>
 <55A3B467.8030409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55A3B467.8030409-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nick <xerofoify-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* nick <xerofoify-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [150713 05:54]:
> On 2015-07-13 08:40 AM, Tony Lindgren wrote:
> > * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [150713 03:07]:
> >  
> >> What is the best map we should use for irqchip?
> >> Some Socs have 4 WAIT pins, some have 3 and some have 2.
> >>
> >> Should we start with 0,1,2, for the wait pins and use the next
> >> available free one for the NAND?
> > 
> > Maybe we can just use the bits defined for each SoC in the
> > GPMC_IRQSTATUS register for the mapping?  
> > Regards,
>
> Is that a good idea as to my knowledge of OMAP platforms that register is hardware
> dependent and therefore that may be an issue unless your idea is to create device
> tables like the way they do in the nand subsystems to support various vendor's 
> nand flash expect here for the pins on OMAP SOCs.

Do you mean mapping irqs based on the GPMC_IRQSTATUS register
bits? If so, that's pretty much how all the GPIO drivers
handle them. We can have a SoC specific irqmask of the valid
bits passed from the dts files, and if necessary we can also
add custom SoC specific IRQ handlers to the GPMC driver if
needed.

The idea is that the NAND driver can just request the irq
from the GPMC driver and do whatever it wants with the
interrupt.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

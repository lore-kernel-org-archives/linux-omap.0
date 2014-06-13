From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 05/36] mtd: nand: omap: Move IRQ handling from GPMC to
 NAND driver
Date: Fri, 13 Jun 2014 00:58:57 -0700
Message-ID: <20140613075856.GQ17845@atomide.com>
References: <1402477001-31132-1-git-send-email-rogerq@ti.com>
 <1402477001-31132-6-git-send-email-rogerq@ti.com>
 <20140613071820.GI17845@atomide.com>
 <539AAA8C.2070709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <539AAA8C.2070709-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, pekon-l0cyMroinI0@public.gmane.org, ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [140613 00:40]:
> On 06/13/2014 10:18 AM, Tony Lindgren wrote:
> > * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [140611 01:58]:
> >> Since the Interrupt Events are used only by the NAND driver,
> >> there is no point in managing the Interrupt registers
> >> in the GPMC driver and complicating it with irqchip modeling.
> >>
> >> Let's manage the interrupt registers directly in the NAND driver
> >> and get rid of irqchip model from GPMC driver.
> >>
> >> Get rid of IRQ commands and unused commands from gpmc_configure() in
> >> the GPMC driver.
> > 
> > This seems like a step backward to me. The GPMC interrupt enable
> > register can do edge detection on the wait pins, how is that
> > limited to NAND?
> 
> OK. But wait pin edge detection was not yet being used and I couldn't
> think of how it would ever be used. Any ideas?

Maybe to wake-up the system on bus activity or something? 

> > Further, let's not start mixing GPMC hardware module register
> > access with the NAND driver register access. They can be clocked
> > separately. And bugs in the NAND driver can cause issues in other
> > GPMC using drivers.
> 
> I understood that NAND controller is integrated into the GPMC module and they are clocked
> the same. Not sure why the hardware designers would keep the registers so closely knit.

Yeah. Maybe regmap could provide some abstraction to the the
NAND registers.
 
> FYI. memory/ti-amif.c and mtd/nand/davinci_nand.c share the AMIF register space in the
> same way. I thought it'd be nice to be consistent across TI drivers.

Probably they did not yet learn the problems caused by it :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

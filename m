From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 03/12] mtd: nand: omap: Move IRQ handling from GPMC to
 NAND driver
Date: Mon, 13 Jul 2015 13:04:30 +0300
Message-ID: <55A38D2E.9010500@ti.com>
References: <1436531019-18088-1-git-send-email-rogerq@ti.com> <1436531019-18088-4-git-send-email-rogerq@ti.com> <20150713071008.GC26485@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150713071008.GC26485-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Tony,

On 13/07/15 10:10, Tony Lindgren wrote:
> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [150710 05:26]:
>> Since the Interrupt Events are used only by the NAND driver,
>> there is no point in managing the Interrupt registers
>> in the GPMC driver and complicating it with irqchip modeling.
> 
> I don't think it's a good idea to allow external drivers to
> tinker directly with GPMC registers. How about just set up GPMC
> as an irqchip for the edge detection interrupts?
> 
> I think we already have devices with multiple NAND chips. And
> there's nothing stopping other drivers from using the edge
> detection interrupts.

OK. The GPMC_IRQ registers manage 2 NAND specific interrupts
(terminalcount and fifo) and 'n' WAIT pin edge interrupts.

So we can model this as a irqchip with 'n + 2' interrupts.

We need to take care that if a GPMC chip select needs a
wait pin then it can't be used as a generic interrupt.

We need to get rid of omap_dev_ready() in nand/omap2.c as
it accesses the GPMC_STATUS register directly. Plus it is
hard coded to only monitor wait0 pin.

What is the best map we should use for irqchip?
Some Socs have 4 WAIT pins, some have 3 and some have 2.

Should we start with 0,1,2, for the wait pins and use the next
available free one for the NAND?

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

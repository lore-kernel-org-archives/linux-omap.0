From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 00/27] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Wed, 2 Dec 2015 21:09:05 -0800
Message-ID: <20151203050905.GE120110@google.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1442588029-13769-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Sep 18, 2015 at 05:53:22PM +0300, Roger Quadros wrote:
> Hi,
> 
> We do a couple of things in this series which result in
> cleaner device tree implementation, faster perfomance and
> multi-platform support. As an added bonus we get new GPI/Interrupt pins
> for use in the system.
> 
> - Establish a custom interface between NAND and GPMC driver. This is
> needed because all of the NAND registers sit in the GPMC register space.
> Some bits like NAND IRQ are even shared with GPMC.
> 
> - Remove NAND IRQ handling from omap-gpmc driver, share the GPMC IRQ
> with the omap2-nand driver and handle NAND IRQ events in the NAND driver.
> This causes performance increase when using prefetch-irq mode.
> 30% increase in read, 17% increase in write in prefetch-irq mode.
> 
> - Clean up device tree support so that omap-gpmc IP and the omap2 NAND
> driver can be used on non-OMAP platforms. e.g. Keystone.
> 
> - Implement GPIOCHIP + IRQCHIP for the GPMC WAITPINS. SoCs can contain
> 2 to 4 of these and most of them would be unused otherwise. It also
> allows a cleaner implementation of NAND Ready pin status for the NAND driver.
> 
> - Implement GPIOlib based NAND ready pin checking for OMAP NAND driver.
> 
> This series is available at
> git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:rogerq/linux.git
> in branch
> for-v4.4/gpmc-v3
> 
> cheers,
> -roger
> 
> Changelog:
> v3:
> -Fixed and tested NAND using legacy boot on omap3-beagle.
> -Support rising and falling edge interrupts on WAITpins.
> -Update DT node of all gpmc users.

The MTD stuff looks mostly good to me know. I've made all my comments
for now, but I'm not sure how you're going to end up rebasing/splitting
and what you're going to do with the irqchip removal, so I'll refrain
from ack's for now. Hopefully I can either ack or merge v4.

I brought it up on one other patch, but it's not really clear to me what
the split is on board file vs. device tree handling, since you seem to
have a combination of both (i.e., platform data that passes along device
nodes). What's the plan on that?

And of course, there's the question of how exactly to merge this, given
the:
(1) conflicts already existing in the MTD dev tree
(2) this touches several trees, often in the same patch and
(3) even if the patches were split out a little better into MTD and
    non-MTD stuff, I think there would still be dependencies such that
    we'd need at least 1 (probably 2) cross merges to get it all
    straight

I'd be happy to hear your thoughts.

Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

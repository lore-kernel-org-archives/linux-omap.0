From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 00/27] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Mon, 26 Oct 2015 14:23:46 -0700
Message-ID: <20151026212346.GJ13239@google.com>
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

Hi Roger,

I'm not too familiar with OMAP platforms, and I might have missed out on
prior discussions/context, so please forgive if I'm asking silly or old
questions here.

On Fri, Sep 18, 2015 at 05:53:22PM +0300, Roger Quadros wrote:
> - Remove NAND IRQ handling from omap-gpmc driver, share the GPMC IRQ
> with the omap2-nand driver and handle NAND IRQ events in the NAND driver.
> This causes performance increase when using prefetch-irq mode.
> 30% increase in read, 17% increase in write in prefetch-irq mode.

Have you pinpointed the exact causes for the performance increase, or
can you give an educated guess? AIUI, you're reducing the number of
interrupts needed for NAND prefetch mode, but you're also removing a bit
of abstraction and implementing hooks that look awfully like the
existing abstractions:

+       int (*nand_irq_enable)(enum gpmc_nand_irq irq);
+       int (*nand_irq_disable)(enum gpmc_nand_irq irq);
+       void (*nand_irq_clear)(enum gpmc_nand_irq irq);
+       u32 (*nand_irq_status)(void);

That's not really a problem if there's a good reason for them (brcmnand
implements similar hooks because of quirks in the implementation of
interrupts across various BRCM SoCs, and it's not worth writing irqchip
drivers for those cases). I'm mainly curious for an explanation.

Regards,
Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

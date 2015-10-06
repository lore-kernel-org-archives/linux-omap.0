From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 00/27] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Tue, 6 Oct 2015 03:00:01 -0700
Message-ID: <20151006100000.GN23801@atomide.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
 <560BC0DB.5020205@ti.com>
 <20151006083346.GL23801@atomide.com>
 <56139A72.6040600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56139A72.6040600-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [151006 02:59]:
> On 06/10/15 11:33, Tony Lindgren wrote:
> > Does build and boot and use NAND work throughtout the series?
> > Otherwise we'll have hard time bisecting anything..
> 
> Yes it does with the following exceptions.
> 
> - Patch 7 "memory: omap-gpmc: Remove NAND IRQ code" breaks prefetch-irq mode
> but none of the boards seem to be using it so it shouldn't break NAND on existing boards.
> At patch 9 "mtd: nand: omap2: manage NAND interrupts" prefetch-irq mode is working again.
> Do you want me to squash patches 7,8,9 so that pre-fetch irq is not broken at any point?

OK, no that's fine, no need to squash them together then.

> - Then at patch 11 "mtd: nand: omap: Clean up device tree support" we break NAND on all DT
> boards as we expect NAND to be a real child node with compatible id. Simply applying the
> DT patch at this point makes it work again.

Hmm can we at least warn about incompatible DT entry when somebody boots
with an older dtb?

> >> Test procedure was to read an existing ubifs partition,
> >> create a new one and read it back.
> >>
> >> Need you to Ack if it looks good.
> >> Do you mind taking it via omap-soc once MTD maintainers ack their relevant parts?
> > 
> > Sure. I'll try to do some testing on the series first too.
> > 
> Thanks.
> 
> > Can the dts changes be merged separtely? Otherwise we'll have
> > a dependency between dts branch and the GPMC/NAND changes.
> 
> I'm afraid no. Patch 11 makes us incompatible with the old DT.

OK. If we can warn about that, then the out of tree users will
have easier time to update their dts file.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

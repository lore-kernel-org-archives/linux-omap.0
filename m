From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 0/6] DRIVERS: IRQCHIP: Add support for crossbar IP
Date: Thu, 24 Oct 2013 10:57:04 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1310241045120.4983@ionos.tec.linutronix.de>
References: <1380549564-31045-1-git-send-email-r.sricharan@ti.com> <52499441.1030403@gmail.com> <524AAE69.8060703@ti.com> <524AD290.207@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <524AD290.207@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Sricharan R <r.sricharan@ti.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, santosh.shilimkar@ti.com, linux@arm.linux.org.uk, tony@atomide.com, rnayak@ti.com, marc.zyngier@arm.com, grant.likely@linaro.org, mark.rutland@arm.com
List-Id: linux-omap@vger.kernel.org

On Tue, 1 Oct 2013, Rob Herring wrote:
> On 10/01/2013 06:13 AM, Sricharan R wrote:
> 
> Is there an actual usecase on a single h/w design that you run out of
> interrupts and it is a user decision which interrupts to use?

I don't think that matters. What matters is that you have a single DT
entry which tells the driver which crossbar irq to use for that
particular device. And that is the only information which is relevant
because the IP block is connected to a crossbar input and not to a GIC
line. The crossbar provides the mapping and this is really best done
at runtime w/o having hardcoded information in the DT or at some other
place.
 
> You could fill in the interrupt-map at run-time. It would have to be
> early (bootloader or early kernel init) and can't be at request_irq time.

How is that supposed to work when you have no idea at early boot time
which particular IP blocks are going to be used later on?

> >   http://www.spinics.net/lists/linux-omap/msg97085.html
> 
> This has nothing to do with the GIC, so it does not belong there.

Errm. crossbar is a mapping device which happens to sit between the
GIC and the IP blocks. So how is this NOT related to GIC ?

Thanks,

	tglx

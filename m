From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] irqchip: omap-intc: fix spurious irq handling
Date: Tue, 20 Oct 2015 07:52:56 -0700
Message-ID: <20151020145255.GB3078@atomide.com>
References: <3d433cfeeb93366cadbb1668ebeac2e8006b0fd5.1445247844.git.nsekhar@ti.com>
 <20151019145039.GA21839@atomide.com>
 <5625DD9F.6010106@ti.com>
 <876122c7vd.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <876122c7vd.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: Sekhar Nori <nsekhar@ti.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* John Ogness <john.ogness@linutronix.de> [151020 00:33]:
> On 2015-10-20, Sekhar Nori <nsekhar@ti.com> wrote:
> >> Do you know what really is causing the spurious interrupts in your
> >> case?
> >
> > No, not yet.
> 
> According to the TRM this is normal behavior if conditions that might
> affect priority are changed during priority sorting.
> 
>     6.2.5 ARM A8 INTC Spurious Interrupt Handling
> 
>     The spurious flag indicates whether the result of the sorting (a
>     window of 10 INTC functional clock cycles after the interrupt
>     assertion) is invalid. The sorting is invalid if:
> 
>     - The interrupt that triggered the sorting is no longer active
>       during the sorting.
> 
>     - A change in the mask has affected the result during the sorting
>       time.
> 
> >> In all the cases I've seen, the spurious interrupts were caused by a
> >> missing flush of posted write acking the IRQ at the device driver.
> >> for the _previously triggered_ INTC interrupt.
> >> 
> >> If you have a reproducable case, I suggest you test that by printing
> >> out the previous interrupt to check if that makes sense. And then see
> >> if adding the missing read back to that interrupt handler fixes the
> >> issue.
> >
> > Okay, thats good to know. Thanks for the hints and history of your debug
> > on OMAP3. The issue is not easily reproducible in my case. But if I try
> > hard enough, I can get hit it though. So I can surely try your hints.
> 
> I can reproduce the situation very easily. After running a test for a
> few minutes and printing out the previous interrupt, I have the
> following list. These are the irq numbers seen by the handler before the
> spurious interrupt triggered.
> 
>     INT12 - EDMACOMPINT - TPCC (EDMA)
>     INT41 - 3PGSWRXINT0 - CPSW (Ethernet)
>     INT42 - 3PGSWTXINT0 - CPSW (Ethernet)
>     INT68 - TINT2       - DMTIMER2
>     INT72 - UART0INT    - UART0
> 
> From this I do not think we can put the blame on any single driver. I
> trigger this situation very easily by putting a load of 7,000+
> interrupts per second on the system. This means we have 70,000 INTC
> clock cycles per second where a change in the interrupt priority
> conditions would cause the priority sorting to become invalid and thus
> cause the spurious interrupt.
> 
> I'm not sure if we can/should do anything more than Sekhar's patch of
> acknowledging the spurious interrupt so the priority sorting algorithm
> can run again.

OK thanks for testing. My guess from the above list would be EDMA
or CPSW missing a flush of posted write. Maybe try adding a readback
of the related device revision register after acking the interrupt into
TPCC interrupt handler and CPSW interrupt handler(s)?

The timer2 and uart0 seem to be false positives here naturally.

I would not yet rule out the "previous interrupt" theory until you have
tried that. We really want to know the root cause of the issue, just
printing out spurious interrupt does not fix the problem :)

Regards,

Tony

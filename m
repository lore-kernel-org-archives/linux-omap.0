From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] irqchip: omap-intc: fix spurious irq handling
Date: Tue, 20 Oct 2015 09:32:54 +0200
Message-ID: <876122c7vd.fsf@linutronix.de>
References: <3d433cfeeb93366cadbb1668ebeac2e8006b0fd5.1445247844.git.nsekhar@ti.com>
	<20151019145039.GA21839@atomide.com> <5625DD9F.6010106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5625DD9F.6010106@ti.com> (Sekhar Nori's message of "Tue, 20 Oct
	2015 11:52:23 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 2015-10-20, Sekhar Nori <nsekhar@ti.com> wrote:
>> Do you know what really is causing the spurious interrupts in your
>> case?
>
> No, not yet.

According to the TRM this is normal behavior if conditions that might
affect priority are changed during priority sorting.

    6.2.5 ARM A8 INTC Spurious Interrupt Handling

    The spurious flag indicates whether the result of the sorting (a
    window of 10 INTC functional clock cycles after the interrupt
    assertion) is invalid. The sorting is invalid if:

    - The interrupt that triggered the sorting is no longer active
      during the sorting.

    - A change in the mask has affected the result during the sorting
      time.

>> In all the cases I've seen, the spurious interrupts were caused by a
>> missing flush of posted write acking the IRQ at the device driver.
>> for the _previously triggered_ INTC interrupt.
>> 
>> If you have a reproducable case, I suggest you test that by printing
>> out the previous interrupt to check if that makes sense. And then see
>> if adding the missing read back to that interrupt handler fixes the
>> issue.
>
> Okay, thats good to know. Thanks for the hints and history of your debug
> on OMAP3. The issue is not easily reproducible in my case. But if I try
> hard enough, I can get hit it though. So I can surely try your hints.

I can reproduce the situation very easily. After running a test for a
few minutes and printing out the previous interrupt, I have the
following list. These are the irq numbers seen by the handler before the
spurious interrupt triggered.

    INT12 - EDMACOMPINT - TPCC (EDMA)
    INT41 - 3PGSWRXINT0 - CPSW (Ethernet)
    INT42 - 3PGSWTXINT0 - CPSW (Ethernet)
    INT68 - TINT2       - DMTIMER2
    INT72 - UART0INT    - UART0

>From this I do not think we can put the blame on any single driver. I
trigger this situation very easily by putting a load of 7,000+
interrupts per second on the system. This means we have 70,000 INTC
clock cycles per second where a change in the interrupt priority
conditions would cause the priority sorting to become invalid and thus
cause the spurious interrupt.

I'm not sure if we can/should do anything more than Sekhar's patch of
acknowledging the spurious interrupt so the priority sorting algorithm
can run again.

John Ogness

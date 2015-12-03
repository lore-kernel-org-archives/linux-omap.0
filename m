From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] irqchip: omap-intc: fix spurious irq handling
Date: Thu, 3 Dec 2015 16:58:41 +0530
Message-ID: <56602769.9050708@ti.com>
References: <3d433cfeeb93366cadbb1668ebeac2e8006b0fd5.1445247844.git.nsekhar@ti.com>
 <20151019145039.GA21839@atomide.com> <5625DD9F.6010106@ti.com>
 <876122c7vd.fsf@linutronix.de> <20151020145255.GB3078@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151020145255.GB3078@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, John Ogness <john.ogness@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Tuesday 20 October 2015 08:22 PM, Tony Lindgren wrote:
> * John Ogness <john.ogness@linutronix.de> [151020 00:33]:
>> On 2015-10-20, Sekhar Nori <nsekhar@ti.com> wrote:
>>>> Do you know what really is causing the spurious interrupts in your
>>>> case?
>>>
>>> No, not yet.
>>
>> According to the TRM this is normal behavior if conditions that might
>> affect priority are changed during priority sorting.
>>
>>     6.2.5 ARM A8 INTC Spurious Interrupt Handling
>>
>>     The spurious flag indicates whether the result of the sorting (a
>>     window of 10 INTC functional clock cycles after the interrupt
>>     assertion) is invalid. The sorting is invalid if:
>>
>>     - The interrupt that triggered the sorting is no longer active
>>       during the sorting.
>>
>>     - A change in the mask has affected the result during the sorting
>>       time.
>>
>>>> In all the cases I've seen, the spurious interrupts were caused by a
>>>> missing flush of posted write acking the IRQ at the device driver.
>>>> for the _previously triggered_ INTC interrupt.
>>>>
>>>> If you have a reproducable case, I suggest you test that by printing
>>>> out the previous interrupt to check if that makes sense. And then see
>>>> if adding the missing read back to that interrupt handler fixes the
>>>> issue.
>>>
>>> Okay, thats good to know. Thanks for the hints and history of your debug
>>> on OMAP3. The issue is not easily reproducible in my case. But if I try
>>> hard enough, I can get hit it though. So I can surely try your hints.
>>
>> I can reproduce the situation very easily. After running a test for a
>> few minutes and printing out the previous interrupt, I have the
>> following list. These are the irq numbers seen by the handler before the
>> spurious interrupt triggered.
>>
>>     INT12 - EDMACOMPINT - TPCC (EDMA)
>>     INT41 - 3PGSWRXINT0 - CPSW (Ethernet)
>>     INT42 - 3PGSWTXINT0 - CPSW (Ethernet)
>>     INT68 - TINT2       - DMTIMER2
>>     INT72 - UART0INT    - UART0
>>
>> From this I do not think we can put the blame on any single driver. I
>> trigger this situation very easily by putting a load of 7,000+
>> interrupts per second on the system. This means we have 70,000 INTC
>> clock cycles per second where a change in the interrupt priority
>> conditions would cause the priority sorting to become invalid and thus
>> cause the spurious interrupt.
>>
>> I'm not sure if we can/should do anything more than Sekhar's patch of
>> acknowledging the spurious interrupt so the priority sorting algorithm
>> can run again.
> 
> OK thanks for testing. My guess from the above list would be EDMA
> or CPSW missing a flush of posted write. Maybe try adding a readback
> of the related device revision register after acking the interrupt into
> TPCC interrupt handler and CPSW interrupt handler(s)?

I could get back to debugging this only now. I have converted
__raw_writel to writel() and also added readback from the same register
in both EDMA and CPSW drivers. But I am still able to reproduce the
spurious irq reports.

> The timer2 and uart0 seem to be false positives here naturally.

I also added readback in 8250 driver. I haven't touched the timer
driver, but I guess if that driver had an issue, it should have come out
much earlier.

I also saw that sometimes previous irq was the TI LCDC interrupt. Added
readback there too. Did not help.

> I would not yet rule out the "previous interrupt" theory until you have
> tried that. We really want to know the root cause of the issue, just
> printing out spurious interrupt does not fix the problem :)

While we cannot rule out a software issue completely, the description in
TRM around spurious interrupts suggests it can happen even with no role
of software.

May I suggest we go ahead and add this patch to the kernel after
addressing Thomas's comment? At least it will prevent kernel from
locking up with flood of prints when a spurious irq happens and allows
easier debug by others too.

Thanks,
Sekhar

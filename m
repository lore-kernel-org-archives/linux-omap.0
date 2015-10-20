From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] irqchip: omap-intc: fix spurious irq handling
Date: Tue, 20 Oct 2015 11:52:23 +0530
Message-ID: <5625DD9F.6010106@ti.com>
References: <3d433cfeeb93366cadbb1668ebeac2e8006b0fd5.1445247844.git.nsekhar@ti.com>
 <20151019145039.GA21839@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151019145039.GA21839@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, John Ogness <john.ogness@linutronix.de>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Monday 19 October 2015 08:20 PM, Tony Lindgren wrote:
> Hi,
> 
> * Sekhar Nori <nsekhar@ti.com> [151019 02:51]:
>> Under some conditions, irq sorting procedure used by INTC can go wrong
>> resulting in a spurious irq getting reported.
>>
>> This condition is flagged by INTC by setting "Spurious IRQ Flag" in SIR
>> register to 0x1ffffff. Section 6.2.5 of AM335x TRM revised Jun 2014
>> describes this.
> 
> OK so we have this finally documented, that's great. It's been bugging
> me for years now :) What we used to have for omap3 was 6ccc4c0dedf8
> ("ARM: OMAP3: Warn about spurious interrupts"). I alsways thought it's
> some undocumented omap3 weirdness but obviously not if you're seeing it
> on am335x too.

BTW, I noticed the AM335x documentation itself is copied from OMAP35x
public TRM: http://www.ti.com/lit/ug/spruf98y/spruf98y.pdf. Surprising
that OMAP34x never had this documented though.

> 
>> Using IRQ number 0 for checking this condition is wrong. 0 is a valid
>> INTC IRQ. For example, on AM335x, it is the emulation interrupt.
>>
>> Fix handing of spurious interrupt condition in omap-intc driver by
>> correct detection of spurious interrupt condition.
>>
>> Since spurious IRQ condition can happen under genuine conditions (see
>> the section of AM335x TRM for details) and is recoverable, we do not
>> need a warning splat for users to report. It can however result in
>> reduced performance so we add a ratelimited debug print to aid
>> developers.
> 
> Do you know what really is causing the spurious interrupts in your
> case?

No, not yet.

> 
> In all the cases I've seen, the spurious interrupts were caused by
> a missing flush of posted write acking the IRQ at the device driver.
> for the _previously triggered_ INTC interrupt.
> 
> If you have a reproducable case, I suggest you test that by printing
> out the previous interrupt to check if that makes sense. And then see
> if adding the missing read back to that interrupt handler fixes the
> issue.

Okay, thats good to know. Thanks for the hints and history of your debug
on OMAP3. The issue is not easily reproducible in my case. But if I try
hard enough, I can get hit it though. So I can surely try your hints.

> 
> And if my assumption is correct, you can then update your patch and
> actually warn about the real culprit irq number :)

I am not sure about introducing the prediction of bad IRQ in the same
patch as this. While its certainly useful to have hints about the
culprit, its not guaranteed to be true all the time. And if we later
discover the prediction scheme is throwing people off course more often
than not, it will be easy to revert just that prediction part without
affecting basic detection of spurious IRQ itself as documented by TRM.

So I propose this patch goes in with Thomas's comments fixed and I work
on adding some prediction based on your work in 6ccc4c0dedf8 ("ARM:
OMAP3: Warn about spurious interrupts").

Thanks,
Sekhar

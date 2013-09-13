From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH 1/4] DRIVERS: IRQCHIP: Add crossbar irqchip driver
Date: Thu, 12 Sep 2013 21:42:03 -0400
Message-ID: <52326D6B.2010003@ti.com>
References: <1379000351-15672-1-git-send-email-r.sricharan@ti.com> <1379000351-15672-2-git-send-email-r.sricharan@ti.com> <alpine.DEB.2.02.1309122201530.4089@ionos.tec.linutronix.de> <523228B5.5070507@ti.com> <alpine.DEB.2.02.1309122335440.4089@ionos.tec.linutronix.de> <5232457A.8080709@ti.com> <alpine.DEB.2.02.1309130138550.4089@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1309130138550.4089@ionos.tec.linutronix.de>
Sender: linux-doc-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sricharan R <r.sricharan@ti.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, linux@arm.linux.org.uk, tony@atomide.com, rnayak@ti.com
List-Id: linux-omap@vger.kernel.org

On Thursday 12 September 2013 08:26 PM, Thomas Gleixner wrote:
> On Thu, 12 Sep 2013, Santosh Shilimkar wrote:
>> On Thursday 12 September 2013 06:22 PM, Thomas Gleixner wrote:
>>> Now the real question is, how that expansion mechanism is supposed to
>>> work. There are two possible scenarios:
>>>
>>> 1) Expand the number of handled interrupts beyond the GIC capacity:
>>>
>>>    That requires a mechanism in CROSSBAR to map several CROSSBAR
>>>    interrupts to a particular GIC interrupt and provide a demux
>>>    mechanism to invoke the shared handlers.
>>>
>> This is not possible in hardware and not supported. Hardware has
>> no notion of muxing multiple IRQ's to generate 1 IRQ or ack etc
>> functionality. Its a simple MUX to tie knots between input and output
>> wires.
> 
> It's not a MUX. It's a ROUTING mechanism. That's similar to the
> mechanisms which are used by MSI[X]. We assign arbitrary interrupt
> numbers to a device and route them to some underlying limited hardware
> interrupt controller.
> 
>>> 2) Provide a mapping mechanism between possibly 250 interrupt numbers
>>>    and a limitation of a total 160 active interrupts by the underlying
>>>    GIC.
>>>
>> This is the need and problem we are trying to solve.
> 
> Let me summarize:
> 
>    - GIC supports up to 160 interrupts
> 
>    - CROSSBAR supports up to 250 interrupts 
> 
>    - CROSSBAR routes up to 160 out of 250 interrupts to the GIC ones
> 
>    - Drivers request a CROSSBAR interrupt number which must be mapped
>      to some arbitrary available GIC irq number
> 
Correct.

> So basically the CROSSBAR mechanism is pretty much the same as MSI[X]
> just in a different flavour and with a different set of semantics and
> limitations, i.e. poor mans MSI[X] with a new level of bogosity.
> 
> So if CROSSBAR is going to be the new fangled SoC MSI[X] long term
> equivalent then you better provide some infrastructure for that and
> make the drivers ready to use it. Maybe check with the PCI/MSI folks
> to share some of the interfaces.
>
> If that whole thing is another onetime HW designers wet dream, then
> please go back to the limited but completely functional (Who is going
> to use more than 160 peripheral interrupts????) device tree model. I
> really have no interest to support hardware designer brain farts.
> 
Thanks for clear NAK for irqchip approach. I should have looped you
in the discussion where I was also suggesting against the irqchip
approach. We will try to look at MSI stuff but if its get too
complicated am going to fall-back to the initial probe based
approach to achieve the functionality.

Thanks again for clear direction and useful discussion.

Regards,
Santosh

From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH 1/4] DRIVERS: IRQCHIP: Add crossbar irqchip driver
Date: Thu, 12 Sep 2013 18:51:38 -0400
Message-ID: <5232457A.8080709@ti.com>
References: <1379000351-15672-1-git-send-email-r.sricharan@ti.com> <1379000351-15672-2-git-send-email-r.sricharan@ti.com> <alpine.DEB.2.02.1309122201530.4089@ionos.tec.linutronix.de> <523228B5.5070507@ti.com> <alpine.DEB.2.02.1309122335440.4089@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1309122335440.4089@ionos.tec.linutronix.de>
Sender: linux-doc-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sricharan R <r.sricharan@ti.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, linux@arm.linux.org.uk, tony@atomide.com, rnayak@ti.com
List-Id: linux-omap@vger.kernel.org

On Thursday 12 September 2013 06:22 PM, Thomas Gleixner wrote:
> On Thu, 12 Sep 2013, Santosh Shilimkar wrote:
>> Specifically for the IRQ case addressed here, the cross-bar IP
>> sits between the interrupt controller and peripheral interrupts.
>>
>> CPU <-- GIC  <----- CROSSBAR <----- PERIPHERAL IRQs
>>
>> Just to expand it better, cross-bar input IRQ lines are more than
>> what a GIC IRQ controller can support.
>> e.q Total 250 peripheral IRQ lines out of which GIC support
>> only 160 IRQ lines.
>>
>> So the idea here is to dynamically map the IRQ lines at
>> cross-bar level to pick based on request_irq() so that one
>> can optimize the use of limited IRQ lines at the GIC level.
>> Strictly speaking the need is just establish the IRQ
>> connection from peripheral to GIC and thats achieved
>> at the request_irq() level.
>>
>> Earlier approach was to statically build this connections
>> using the DT information in a separate driver probe but
>> it had limitations of fixing the IRQ map and taking away
>> flexibility what this IP provide. 
>>  
>> Hope this gives better picture to you behind the patch
>> series.
> 
> Yes. I halfways understand what you are trying to achieve.
> 
> So CROSSBAR is a routing block between the peripheral and the GIC in
> order to expand the number of possible interrupts.
> 
> Now the real question is, how that expansion mechanism is supposed to
> work. There are two possible scenarios:
> 
> 1) Expand the number of handled interrupts beyond the GIC capacity:
> 
>    That requires a mechanism in CROSSBAR to map several CROSSBAR
>    interrupts to a particular GIC interrupt and provide a demux
>    mechanism to invoke the shared handlers.
> 
This is not possible in hardware and not supported. Hardware has
no notion of muxing multiple IRQ's to generate 1 IRQ or ack etc
functionality. Its a simple MUX to tie knots between input and output
wires.

> 2) Provide a mapping mechanism between possibly 250 interrupt numbers
>    and a limitation of a total 160 active interrupts by the underlying
>    GIC.
> 
This is the need and problem we are trying to solve.

Regards,
Santosh


From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v2 4/6] irqchip/irq-pruss-intc: Add helper functions to
 configure internal mapping
Date: Thu, 1 Aug 2019 12:10:50 -0500
Message-ID: <89abc27f-5d02-a8ce-df0e-b185c2a647cd@ti.com>
References: <20190731224149.11153-1-s-anna@ti.com>
 <20190731224149.11153-5-s-anna@ti.com>
 <1a63eb50-7c5c-eb3d-3cbe-bd1cc59ce3fe@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1a63eb50-7c5c-eb3d-3cbe-bd1cc59ce3fe@kernel.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
Cc: devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, David Lechner <david@lechnology.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Rob Herring <robh+dt@kernel.org>, Murali Karicheri <m-karicheri2@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Marc,

On 8/1/19 3:45 AM, Marc Zyngier wrote:
> On 31/07/2019 23:41, Suman Anna wrote:
>> The PRUSS INTC receives a number of system input interrupt source events
>> and supports individual control configuration and hardware prioritization.
>> These input events can be mapped to some output interrupt lines through 2
>> levels of many-to-one mapping i.e. events to channel mapping and channels
>> to output interrupts.
>>
>> This mapping information is provided through the PRU firmware that is
>> loaded onto a PRU core/s or through the device tree node of the PRU
>> application. The mapping is configured by the PRU remoteproc driver, and
>> is setup before the PRU core is started and cleaned up after the PRU core
>> is stopped. This event mapping configuration logic programs the Channel
>> Map Registers (CMRx) and Host-Interrupt Map Registers (HMRx) only when a
>> new program is being loaded/started and the same events and interrupt
>> channels are reset to zero when stopping a PRU.
>>
>> Add two helper functions: pruss_intc_configure() & pruss_intc_unconfigure()
>> that the PRU remoteproc driver can use to configure the PRUSS INTC.
> 
> So let me see if I correctly understand this: this adds yet another
> firmware description parser, with a private interface to another
> (undisclosed?) driver, bypassing the standard irqchip configuration
> mechanism. It sounds great, doesn't it?
> 
> What I cannot really infer from this message (-ETOOMUCHJARGON) is what
> interrupts this affects:
> 
> - Interrupts from random devices to the PRUSS?
> - Interrupts from the PRUSS to the host?
> - Something else?

The interrupt sources (called system events) can be from internal PRUSS
peripherals, SoC-level peripherals or just software triggering (limited
to some events).

So, the PRUSS INTC behaves as a funnel and is both an interrupt router
and multiplexer. The INTC itself is part of the PRUSS, and all PRU
application related interrupts/events that need to trigger an interrupt
to either the PRU cores or other host processors (like DSP, ARM) have to
go through this INTC, and routed out to a limited number of output
interrupts that are then connected to different processors.

The split of interrupt handling between a PRU and its peer host
processor will be a application design choice (We can implement soft IPs
like UARTs, ADCs, I2Cs etc using PRUs). Some of the input events
themselves are multiplexed and controlled by a single MMR (outside of
INTC) that feeds different sets of events into the INTC. The MMR
configuration is outside of scope of this driver and will depend on the
application/client driver being run.

> 
> When does this happen? Under control of what? It isn't even clear why
> this is part of this irqchip driver.

The mapping configuration is per PRU application and firmware, and is
done in line with acquiring and release a PRU which is treated as an
exclusive resource. We establish the mapping for all events through this
driver including the events that are to be routed to PRUs. This is done
to save the tiny/limited Instruction RAM space that PRUs have.

We have designed this as an irqchip driver (instead of some custom SoC
driver exporting custom functions) to use standard Linux semantics/irq
API and better integrate with Linux DT, but we need some semantics for
establishing the routing at runtime depending on the PRU client driver
we are running. The exported functions will be called only by the PRU
remoteproc driver during a pru_rproc_get()/pru_rproc_put(), and are
transparent to PRU client drivers.

Please also see the discussion from v1 [1] on why we can't use an
extended number of interrupt-cells infrastructure for achieving this.

[1] https://patchwork.kernel.org/patch/11034563/


> Depending what this does, there may be ways to fit it into the standard
> interrupt configuration framework. After all, we already have standard
> interfaces to route interrupts to virtual CPUs, effectively passing full
> control of an interrupt to another entity. If you squint hard enough,
> your PRUSS can fit that description.

Yeah, I am open to suggestions if there is a better way of doing this.

regards
Suman

> 
> If that doesn't work, then we need to make the IRQ framework grok that
> kind of requirement (hence my request for clarification). But I'm
> strongly opposed to inventing a SoC-private way of configuring
> interrupts behind the kernel's back.
> 
> Thanks,
> 
> 	M.
> 

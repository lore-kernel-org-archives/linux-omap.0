From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH V4 1/4] DRIVERS: IRQCHIP: IRQ-GIC: Add support for routable
 irqs
Date: Mon, 2 Dec 2013 15:56:47 +0530
Message-ID: <529C6067.7010907@ti.com>
References: <1384431530-2166-1-git-send-email-r.sricharan@ti.com> <1384431530-2166-2-git-send-email-r.sricharan@ti.com> <20131114140103.GA28328@e106331-lin.cambridge.arm.com> <5284FE6C.9040901@ti.com> <20131115112329.GE1709@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20131115112329.GE1709@e106331-lin.cambridge.arm.com>
Sender: linux-doc-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "tony@atomide.com" <tony@atomide.com>, "rnayak@ti.com" <rnayak@ti.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "robherring2@gmail.com" <robherring2@gmail.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "galak@codeaurora.org" <galak@codeaurora.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "nm@ti.com" <nm@ti.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

Hi Mark,

Sorry for delayed response. I was away for some time.

On Friday 15 November 2013 04:53 PM, Mark Rutland wrote:
> On Thu, Nov 14, 2013 at 04:46:36PM +0000, Sricharan R wrote:
>> Hi Mark,
>>
>> On Thursday 14 November 2013 07:31 PM, Mark Rutland wrote:
>>> On Thu, Nov 14, 2013 at 12:18:47PM +0000, Sricharan R wrote:
>>>> In some socs the gic can be preceded by a crossbar IP which
>>>> routes the peripheral interrupts to the gic inputs. The peripheral
>>>> interrupts are associated with a fixed crossbar input line and the
>>>> crossbar routes that to one of the free gic input line.
>>>>
>>>> The DT entries for peripherals provides the fixed crossbar input line
>>>> as its interrupt number and the mapping code should associate this with
>>>> a free gic input line. This patch adds the support inside the gic irqchip
>>>> to handle such routable irqs. The routable irqs are registered in a linear
>>>> domain. The registered routable domain's callback should be implemented
>>>> to get a free irq and to configure the IP to route it.
>>>>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>> Cc: Russell King <linux@arm.linux.org.uk>
>>>> Cc: Tony Lindgren <tony@atomide.com>
>>>> Cc: Rajendra Nayak <rnayak@ti.com>
>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>> Cc: Grant Likely <grant.likely@linaro.org>
>>>> Cc: Rob Herring <rob.herring@calxeda.com>
>>>> Signed-off-by: Sricharan R <r.sricharan@ti.com>
>>>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>> ---
>>>>  [V2] Added default routable-irqs functions to avoid
>>>>       unnecessary if checks as per Thomas Gleixner comments
>>>>       and renamed routable-irq binding as per
>>>>       Kumar Gala <galak@codeaurora.org> comments.
>>>>
>>>>  [V3] Addressed unnecessary warn-on and updated default
>>>>       xlate function as per Thomas Gleixner comments
>>>>
>>>>  Documentation/devicetree/bindings/arm/gic.txt |    6 ++
>>>>  drivers/irqchip/irq-gic.c                     |   81 ++++++++++++++++++++++---
>>>>  include/linux/irqchip/arm-gic.h               |    7 ++-
>>>>  3 files changed, 83 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
>>>> index 3dfb0c0..5357745 100644
>>>> --- a/Documentation/devicetree/bindings/arm/gic.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/gic.txt
>>>> @@ -49,6 +49,11 @@ Optional
>>>>    regions, used when the GIC doesn't have banked registers. The offset is
>>>>    cpu-offset * cpu-nr.
>>>>  
>>>> +- arm,routable-irqs : Total number of gic irq inputs which are not directly
>>>> +		  connected from the peripherals, but are routed dynamically
>>>> +		  by a crossbar/multiplexer preceding the GIC. The GIC irq
>>>> +		  input line is assigned dynamically when the corresponding
>>>> +		  peripheral's crossbar line is mapped.
>>> I'm not keen on the design of the arm,routable-irqs property. The set of
>>> IRQs which the crossbar IP can use is a property of which IRQ lines it
>>> has routed to the GIC. I don't see why that should be considered a
>>> property of the GIC; it's a property of the crossbar IP's attachment to
>>> the GIC.
>>>
>>> Given we already have a mechanism for describing the attachment (i.e.
>>> the interrupts property) where the property appears on the node for the
>>> device generating/propagating the interrupt, I don't see why we should
>>> do differently here.
>>  We did try using interrupts=<> property for all peripherals and
>>  mapping them as crossbar's parent. But that approach of representing
>>  crossbar as a interrupt parent was not accepted, since the crossbar
>>  was just routing the interrupts from peripherals to GIC and nothing more.
>>  Also  mapping all the interrupts using interrupt-map like property by a fixed way
>>  in DTS itself was considered hacky
> I'm not suggesting you should interrupt-map. I agree that that
> interrupt-map is not suitable for a dynamically configurable device like
> the crossbar.
>
> When you say that the crossbar is just routing the interrupts, at what
> level is it doing so? Does it accept a logical interrupt and output
> another logical interrupt, or does it just connect the two lines
> electrically?
As Santosh, already mentioned this just makes a physical connection
 and thats it
>
> We don't necessarily have to use the interrupts property, but I still
> think that the set of GIC input IRQ lines that the crossbar is wired to
> should be described on the crossbar node.
>
>>> Listing 160 interrupts in the crossbar node is clearly something we
>>> don't want to have to do.  If we had a property that we could use to
>>> define a range (or multiple ranges) of interrupts, then the crossbar
>>> driver could go and request those ranges from its interrupt-parent (the
>>> GIC) and the GIC driver could reserve/allocate the irqdomain at that
>>> time.
>> Again, this kind of approach of crossbar requesting irqs from GIC
>> was tried earlier and it did not go anywhere. Subsequently after lot of
>> discussions this design was considered the best one.
>>
>> http://www.spinics.net/lists/linux-omap/msg97085.html
> As far as I can see, the comment there was to use irqdomains, which I am
> not arguing against. I am arguing that the linkage of the GIC and the
> crossbar is being described the wrong way around. The GIC input lines
> that the crossbar is wired to should be described on the crossbar node,
> and the crossbar driver should request the appropriate domain from the
> GIC.
  The comment was and there was also a code snippet suggested which
 was to use GIC's irq domain and to use GIC xlate, map, unmap functions.
 This patch simply does that.
>>> This feels like a point-hack, counter in style to the vast majority of
>>> provider/consumer bindings. It only allows for one multiplexer before
>>> the GIC. What if we had multiple multiplexers feeding into the GIC?
>>> Describing the attachment on the multiplexer allows that to be handled,
>>> describing that on the GIC does not.
>>  This is case where the interrupts to GIC is not coming from full irqchip,
>>  but just a router and support added in the GIC helps to handle
>>  such cases. In the case of more than one multiplexer, the crossbar
>>  driver should really take care of handling the downward muxes and
>>  crossbar like driver can be expanded to handle if such a scenario happens.
> That still feels like a hack. If there are multiple instances, I see no
> reason why they should have to know about each other. It's fundamentally
> at odds to the generic composable model we have now.
>
Infact it looks like this because crossbar is not full irqchip and the
whole aim here was to use the existing infrastructure best to support this.
After all discussions, this was considered the ideal way. Atleast now,
we do not have any Socs with multiple *routers* feeding in to each other.

Regards,
 Sricharan


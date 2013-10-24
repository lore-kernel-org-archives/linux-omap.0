From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [RFC PATCH 1/6] DRIVERS: IRQCHIP: IRQ-GIC: Add support for routable
 irqs
Date: Thu, 24 Oct 2013 16:14:16 +0530
Message-ID: <5268FA00.1010902@ti.com>
References: <1380549564-31045-1-git-send-email-r.sricharan@ti.com> <1380549564-31045-2-git-send-email-r.sricharan@ti.com> <D170CC15-C746-412F-A683-E8A73EFB8133@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <D170CC15-C746-412F-A683-E8A73EFB8133@codeaurora.org>
Sender: linux-doc-owner@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tglx@linutronix.de, linus.walleij@linaro.org, santosh.shilimkar@ti.com, linux@arm.linux.org.uk, tony@atomide.com, rnayak@ti.com, marc.zyngier@arm.com, grant.likely@linaro.org, rob.herring@calxeda.com, mark.rutland@arm.com
List-Id: linux-omap@vger.kernel.org

On Thursday 24 October 2013 03:08 PM, Kumar Gala wrote:
> On Sep 30, 2013, at 8:59 AM, Sricharan R wrote:
>
>> In some socs the gic can be preceded by a crossbar IP which
>> routes the peripheral interrupts to the gic inputs. The peripheral
>> interrupts are associated with a fixed crossbar input line and the
>> crossbar routes that to one of the free gic input line.
>>
>> The DT entries for peripherals provides the fixed crossbar input line
>> as its interrupt number and the mapping code should associate this with
>> a free gic input line. This patch adds the support inside the gic irqchip
>> to handle such routable irqs. The routable irqs are registered in a linear
>> domain. The registered routable domain's callback should be implemented
>> to get a free irq and to configure the IP to route it.
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Rajendra Nayak <rnayak@ti.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Grant Likely <grant.likely@linaro.org>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Signed-off-by: Sricharan R <r.sricharan@ti.com>
>> ---
>> Documentation/devicetree/bindings/arm/gic.txt |    5 +++
>> arch/arm/boot/dts/dra7.dtsi                   |    1 +
>> drivers/irqchip/irq-gic.c                     |   57 +++++++++++++++++++++----
>> include/linux/irqchip/arm-gic.h               |    8 +++-
>> 4 files changed, 61 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
>> index 3dfb0c0..2d8c680 100644
>> --- a/Documentation/devicetree/bindings/arm/gic.txt
>> +++ b/Documentation/devicetree/bindings/arm/gic.txt
>> @@ -49,6 +49,11 @@ Optional
>>   regions, used when the GIC doesn't have banked registers. The offset is
>>   cpu-offset * cpu-nr.
>>
>> +- routable-irqs	: Total number of gic irq inputs which are not directly
>> +		  connected from the peripherals, but are routed dynamically
>> +		  by a crossbar/multiplexer preceding the GIC. The GIC irq
>> +		  input line is assigned dynamically when the corresponding
>> +		  peripheral's crossbar line is mapped.
> arm,routable-irqs
 ok will change here as well.

 Thanks for reviewing.

Regards,
 Sricharan

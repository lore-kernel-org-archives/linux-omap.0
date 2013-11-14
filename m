From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH V4 2/4] DRIVERS: IRQCHIP: CROSSBAR: Add support for
 Crossbar IP
Date: Thu, 14 Nov 2013 22:11:41 +0530
Message-ID: <5284FD45.6090109@ti.com>
References: <1384431530-2166-1-git-send-email-r.sricharan@ti.com>
 <1384431530-2166-3-git-send-email-r.sricharan@ti.com>
 <20131114141225.GB28328@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131114141225.GB28328@e106331-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "nm@ti.com" <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "rnayak@ti.com" <rnayak@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "galak@codeaurora.org" <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Mark,

On Thursday 14 November 2013 07:42 PM, Mark Rutland wrote:
> On Thu, Nov 14, 2013 at 12:18:48PM +0000, Sricharan R wrote:
>> Some socs have a large number of interrupts requests to service
>> the needs of its many peripherals and subsystems. All of the
>> interrupt lines from the subsystems are not needed at the same
>> time, so they have to be muxed to the irq-controller appropriately.
>> In such places a interrupt controllers are preceded by an CROSSBAR
>> that provides flexibility in muxing the device requests to the controller
>> inputs.
>>
>> This driver takes care a allocating a free irq and then configuring the
>> crossbar IP as a part of the mpu's irqchip callbacks. crossbar_init should
>> be called right before the irqchip_init, so that it is setup to handle the
>> irqchip callbacks.
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
>> Acked-by: Kumar Gala <galak@codeaurora.org> (for DT binding portion)
>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  [V2] Addressed Thomas Gleixner <tglx@linutronix.de> comments
>>       and renamed the bindings as per Kumar Gala <galak@codeaurora.org>
>>       comments.
>>  [V3] Changed static inline const to static inline int and removed
>>       unnecessary variable initialization as per
>>       Thomas Gleixner <tglx@linutronix.de>. Updated commit tags
>>  [V4] Renamed crossbar_init as irqcrossbar_init as per
>>       Rajendra Nayak <rnayak@ti.com> suggestion.
>>
>>  .../devicetree/bindings/arm/omap/crossbar.txt      |   27 +++
>>  drivers/irqchip/Kconfig                            |    8 +
>>  drivers/irqchip/Makefile                           |    1 +
>>  drivers/irqchip/irq-crossbar.c                     |  206 ++++++++++++++++++++
>>  include/linux/irqchip/irq-crossbar.h               |   11 ++
>>  5 files changed, 253 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/omap/crossbar.txt
>>  create mode 100644 drivers/irqchip/irq-crossbar.c
>>  create mode 100644 include/linux/irqchip/irq-crossbar.h
>>
>> diff --git a/Documentation/devicetree/bindings/arm/omap/crossbar.txt b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
>> new file mode 100644
>> index 0000000..fb88585
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
>> @@ -0,0 +1,27 @@
>> +Some socs have a large number of interrupts requests to service
>> +the needs of its many peripherals and subsystems. All of the
>> +interrupt lines from the subsystems are not needed at the same
>> +time, so they have to be muxed to the irq-controller appropriately.
>> +In such places a interrupt controllers are preceded by an CROSSBAR
>> +that provides flexibility in muxing the device requests to the controller
>> +inputs.
>> +
>> +Required properties:
>> +- compatible : Should be "ti,irq-crossbar"
>> +- reg: Base address and the size of the crossbar registers.
>> +- ti,max-irqs: Total number of irqs available at the interrupt controller.
>> +- ti,reg-size: Size of a individual register in bytes. Every individual
>> +	    register is assumed to be of same size. Valid sizes are 1, 2, 4.
>> +- ti,irqs-reserved: List of the reserved irq lines that are not muxed using
>> +		 crossbar. These interrupt lines are reserved in the soc,
>> +		 so crossbar bar driver should not consider them as free
>> +		 lines.
> The combination of the ti,max-irqs and ti,irqs-reserved properties seems
> backwards to me. Why can we not describe the set of IRQs that _can_ be
> used?
 Total set of irqs that are usable is max - reserved. Since reserved irqs
 are not continuous, we have to give the list. During the init we count
 the total number of reserved and get the usable one.
>> +
>> +Examples:
>> +		crossbar_mpu: @4a020000 {
>> +			compatible = "ti,irq-crossbar";
>> +			reg = <0x4a002a48 0x130>;
>> +			ti,max-irqs = <160>;
>> +			ti,reg-size = <2>;
>> +			ti,irqs-reserved = <0 1 2 3 5 6 131 132 139 140>;
>> +		};
> [...]
>
>> +	/* Get and mark reserved irqs */
>> +	irqsr = of_get_property(node, "ti,irqs-reserved", &size);
>> +	if (irqsr) {
>> +		size /= sizeof(__be32);
>> +
>> +		for (i = 0; i < size; i++) {
>> +			entry = be32_to_cpup(irqsr + i);
>> +			if (entry > max) {
>> +				pr_err("Invalid reserved entry\n");
>> +				goto err3;
>> +			}
>> +			cb->irq_map[entry] = 0;
>> +		}
>> +	}
> Don't deal with the raw DTB. Use of_property_read_u32_index.
 Ok, i will correct this.
>> +
>> +	cb->register_offsets = kzalloc(max * sizeof(int), GFP_KERNEL);
>> +	if (!cb->register_offsets)
>> +		goto err3;
>> +
>> +	of_property_read_u32(node, "ti,reg-size", &size);
> If "ti,reg-size" isn't present, size is uninitialized. Please check the
> return value of of_property_read_u32.
Ok, will correct this.

Regards,
 Sricharan

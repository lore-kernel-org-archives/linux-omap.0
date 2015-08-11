From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] ARM: OMAP: irqdomain_hierarchy: fix arm gic irq type
 configuration
Date: Tue, 11 Aug 2015 15:16:13 +0300
Message-ID: <55C9E78D.7040404@ti.com>
References: <1439285147-20027-1-git-send-email-grygorii.strashko@ti.com>
 <20150811122456.1efe1656@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150811122456.1efe1656@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Tony Lindgren <tony@atomide.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "balbi@ti.com" <balbi@ti.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 08/11/2015 02:24 PM, Marc Zyngier wrote:
> On Tue, 11 Aug 2015 10:25:47 +0100
> Grygorii Strashko <grygorii.strashko@ti.com> wrote:
>
> Hi Grygorii,
>
>> It's observed that ARM GIC IRQ triggering type is not configured
>> properly when IRQ is routed through IRQ domains hierarchy and
>> system started using DT. As result, system will start using default
>> ARM GIC configuration, ignore DT IRQ type configuration,
>> and value of desc->irq_data.state_use_accessors = 0.
>>
>> In case of TI OMAP the following IRQ hierarchy is defined:
>> ARM GIC <- OMAP wakeupgen <- TI CBAR
>>
>> Failed call chain:
>>   irq_create_of_mapping
>>   irq_set_irq_type
>>   __irq_set_trigger
>>   if (!chip || !chip->irq_set_type) {
>>      return 0; <- return here
>>   }
>>   CBAR has no .irq_set_type() defined and, so, IRQ triggering
>>   configuration will not be propagated to parent IRQ domain.
>>
>> Hence, fix it by introducing irq_chip_set_type_parent(), in the
>> same manner as irq_chip_set_wake_parent(), and use it for IRQ
>> triggering type propagation to the parent IRQ domain in
>> irq-crossbar and omap-wakeupgen.
>>
>> / # cat /proc/interrupts -- before
>> 230:          0          0      CBAR  30 Edge    -00000000  48051000.gpio
>> 263:          0          0      CBAR 116 Edge    -00000000  48053000.gpio
>> 296:        246          0      CBAR  67 Edge    -00000000  OMAP UART0
>> 311:        341          0      CBAR  51 Edge    -00000000  48070000.i2c
>> 312:          3          0      CBAR  52 Edge    -00000000  48072000.i2c
>> 313:          0          0      CBAR  56 Edge    -00000000  48060000.i2c
>> 314:        255          0      CBAR  78 Edge    -00000000  mmc0
>> 315:         40          0      CBAR  81 Edge    -00000000  mmc1
>> 316:         13          0      CBAR  91 Edge    -00000000  mmc2
>> 320:          0          0      CBAR  49 Edge    -00000000  4a140000.sata
>> 324:          0          0      CBAR   1 Edge    -00000000  48078000.elm
>> 325:          0          0      CBAR  15 Edge    -00000000  gpmc
>> 333:          0          0      CBAR 335 Edge    -00000000  48484000.ethernet
>> 334:          0          0      CBAR 336 Edge    -00000000  48484000.ethernet
>> 415:          0          0   pcf857x   2 Edge    -00000000  btnUser1
>> 416:          0          0   pcf857x   3 Edge    -00000000  btnUser2
>> 445:          0          0   pinctrl 992 Edge    -00010000  4806a000.seria
>>
>> / # cat /proc/interrupts -- after
>> 230:          0          0      CBAR  30 Level   -00002004  48051000.gpio
>> 263:          0          0      CBAR 116 Level   -00002004  48053000.gpio
>> 296:        567          0      CBAR  67 Level   -00002004  OMAP UART0
>> 311:        363          0      CBAR  51 Level   -00002004  48070000.i2c
>> 312:          3          0      CBAR  52 Level   -00002004  48072000.i2c
>> 313:          0          0      CBAR  56 Level   -00002004  48060000.i2c
>> 314:        197          0      CBAR  78 Level   -00002004  mmc0
>> 315:         40          0      CBAR  81 Level   -00002004  mmc1
>> 316:         13          0      CBAR  91 Level   -00002004  mmc2
>> 320:          0          0      CBAR  49 Level   -00002004  4a140000.sata
>> 324:          0          0      CBAR   1 Level   -00002004  48078000.elm
>> 325:          0          0      CBAR  15 Level   -00002004  gpmc
>> 333:          0          0      CBAR 335 Level   -00002004  48484000.ethernet
>> 334:          0          0      CBAR 336 Level   -00002004  48484000.ethernet
>> 415:          0          0   pcf857x   2 Edge    -00000000  btnUser1
>> 416:          4          2   pcf857x   3 Edge    -00000000  btnUser2
>> 445:          0          0   pinctrl 992 Edge    -00010000  4806a000.serial
>>
>> Fixes: 783d31863fb8 ('irqchip: crossbar: Convert dra7 crossbar to stacked domains')
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>> Hi All,
>>
>> I can split patch if required and overall solution acceptable.
>
> This looks good to me. Please repost it after splitting it in two
> patches.

just to clarify - Do you want to see two or three patches?

2) or 3) arch/arm/mach-omap2/omap-wakeupgen.c |  1 +
2) drivers/irqchip/irq-crossbar.c       |  1 +
1) include/linux/irq.h                  |  1 +
1) kernel/irq/chip.c                    | 16 ++++++++++++++++



-- 
regards,
-grygorii

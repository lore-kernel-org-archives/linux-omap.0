From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] mfd: palmas: Add support for optional wakeup
Date: Fri, 29 Aug 2014 07:41:57 -0500
Message-ID: <54007515.5080506@ti.com>
References: <1408457197-30487-1-git-send-email-nm@ti.com> <20140829105619.GH24579@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140829105619.GH24579@lee--X1>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 08/29/2014 05:56 AM, Lee Jones wrote:
> On Tue, 19 Aug 2014, Nishanth Menon wrote:
> 
>> With the recent pinctrl-single changes, omaps can treat wake-up events
>> from deeper idle states as interrupts.
>>
>> Let's add support for the optional second interrupt for wake-up
>> events. And then SoC can wakeup and handle the event using it's
>> regular handler.
>>
>> Finally, to pass the wake-up interrupt in the dts file,
>> interrupts-extended property needs to be passed.
>>
>> This is similar in approach to commit 2a0b965cfb6e ("serial: omap: Add
>> support for optional wake-up")
>>
>> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/mfd/palmas.txt |   20 ++++++++
> 
> DT Ack please.
> 
>>  drivers/mfd/palmas.c                             |   59 ++++++++++++++++++++++
>>  include/linux/mfd/palmas.h                       |    2 +
>>  3 files changed, 81 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/palmas.txt b/Documentation/devicetree/bindings/mfd/palmas.txt
>> index eda8989..2627842 100644
>> --- a/Documentation/devicetree/bindings/mfd/palmas.txt
>> +++ b/Documentation/devicetree/bindings/mfd/palmas.txt
>> @@ -51,3 +51,23 @@ palmas {
>>  		....
>>  	};
>>  }
>> +
>> +Example: with interrupts extended
>> + See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>> + Use pinmux 0x418 as wakeup interrupt and gpio1_0 as interrupt source
>> +
>> +palmas {
> 
> Should this be 'palmas@40 {'?

I might have preferred that as well.. I kept the existing style in the
documentation. Would you like me to change existing doc style too?

> 
>> +	compatible = "ti,twl6035", "ti,palmas";
>> +	reg = <0x48>
>> +	interrupt-parent = <&intc>;
>> +	interrupt-controller;
>> +	#interrupt-cells = <2>;
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	interrupts-extended = <&gpio1 0 IRQ_TYPE_LEVEL_HIGH
>> +			       &pinmux 0x418>;
> 
> Can I get a DT Ack, that this is being used correctly?  It doesn't
> match the syntax given in:
> 
>   Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
Did you mean:
<&gpio1 0 IRQ_TYPE_LEVEL_HIGH>, <&pinmux 0x418>;

Yes, I can fix that - sorry, both usage seem to be functional.

> 
>> +	pmic {
>> +		compatible = "ti,twl6035-pmic", "ti,palmas-pmic";
>> +		....
>> +	};
>> +}
>> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
>> index 28cb048..11186ab 100644
>> --- a/drivers/mfd/palmas.c
>> +++ b/drivers/mfd/palmas.c
>> @@ -24,6 +24,7 @@
>>  #include <linux/mfd/core.h>
>>  #include <linux/mfd/palmas.h>
>>  #include <linux/of_device.h>
>> +#include <linux/of_irq.h>
>>  
>>  static const struct regmap_config palmas_regmap_config[PALMAS_NUM_CLIENTS] = {
>>  	{
>> @@ -326,6 +327,16 @@ static struct regmap_irq_chip tps65917_irq_chip = {
>>  			PALMAS_INT1_MASK),
>>  };
>>  
>> +static irqreturn_t palmas_wake_irq(int irq, void *_palmas)
>> +{
>> +	/*
>> +	 * Return Not handled so that interrupt is disabled.
>> +	 * Level event ensures that the event is eventually handled
>> +	 * by the appropriate chip handler already registered
>> +	 */
> 
> This looks okay to me, but could do with a second opinion from someone
> who is a little more familier with this kind of h/w.
> 
> How does this differ from threading IRQs?

I could try with an example:
consider a GPIO block 7 gpio 4 connected to a pinctrl pin 234 as the
interrupt source for palmas.

When the system is active, the GPIO block 7, gpio 4 happily functions
as the interrupt source. However, the SoC might not capable of
achieving SoC wide deepsleep when GPIO block 7 is active, So we have
to power off GPIO block 7. However on achieving low power, the system
needs to be capable of waking backup, for this, SoC uses the hardware
at the pin itself(TI calls it control module, others have other names,
lets for the discussion, call it pinctrl), on going to sleep the
action of enabling the pinctrl irq - enables the wakeup capability of
the pin, and disabling it disabled the wakeup capability. when the
wakeup event does take place, in some cases, it might be a edge event,
where by the time we have recofigured GPIO block, the interrupt event
is long gone - to support this, pinctrl invokes the driver interrupt
handler to ensure this functions. in our case(palmas), we are level
event and can depend on GPIO block to handle it when it is configured.

Basically two interrupt sources when SoC is in deep sleep(1 to exit
from deepsleep, and other from the module handling the actual event) -
Example: powerbutton press OR palmas RTC wakeup OR Palmas GPIO
generated wakeup.

However, this is not the same as threading IRQ as the wakeup event is
involved only during suspend path.

commit 2a0b965cfb6e ("serial: omap: Add support for optional wake-up")

is a good reference from serial port handling perspective.

-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

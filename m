From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 01/18] ARM: am57xx: cl-som-am57x: dts: add basic module
 support
Date: Sun, 29 Nov 2015 11:06:06 -0600
Message-ID: <565B307E.2000203@ti.com>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il> <1448433590-1399-2-git-send-email-lifshitz@compulab.co.il> <565629D2.2010401@ti.com> <565AEB19.4050107@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <565AEB19.4050107-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Toni Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 11/29/2015 06:10 AM, Dmitry Lifshitz wrote:
[...]
>>> +    };
>>> +
>>> +    leds {
>>> +        compatible = "gpio-leds";
>>> +        pinctrl-names = "default";
>>> +        pinctrl-0 = <&leds_pins_default>;
>>> +
>>> +        led@0 {
>>> +            label = "cl-som-am57x:green";
>>> +            gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
>>> +            linux,default-trigger = "heartbeat";
>>> +            default-state = "off";
>>> +        };
>>> +    };
>>> +};
>>> +
>>> +&dra7_pmx_core {
>>> +    leds_pins_default: leds_pins_default {
>>> +        pinctrl-single,pins = <
>>> +            DRA7XX_CORE_IOPAD(0x347c, PIN_OUTPUT | MUX_MODE14)    /*
>>> gpmc_a15.gpio2_5 */
>>> +        >;
>>> +    };
>>> +
>>> +    i2c1_pins_default: i2c1_pins_default {
>>> +        pinctrl-single,pins = <
>>> +            DRA7XX_CORE_IOPAD(0x3800, PIN_INPUT_PULLUP |
>>> MUX_MODE0)    /* i2c1_sda.sda */
>>> +            DRA7XX_CORE_IOPAD(0x3804, PIN_INPUT_PULLUP |
>>> MUX_MODE0)    /* i2c1_scl.scl */
>>> +        >;
>>> +    };
>>> +
>>> +    tps659038_pins_default: tps659038_pins_default {
>>> +        pinctrl-single,pins = <
>>> +            DRA7XX_CORE_IOPAD(0x3818, PIN_INPUT_PULLUP | MUX_MODE14)
>>> /* wakeup0.gpio1_0 */
>>> +        >;
>>> +    };
>>
>> Generic comment: As per requirements of the SoC -> all pinctrl must be
>> done in bootloader. this was a recommendation that came in too late
>> for TI platforms that got introduced in upstream, but that cleanup
>> should eventually take place as well.
>>
> 
> Please, could you provide a reference to those recommendations.
> Do you mean pinctrl for PMIC pins only?

You might want to ask your TI support contact for IODelay
recommendations. TRM mentions that pinmuxing must be performed under IO
isolation. There are silicon constraints in DRA7/AM57xx family, which
were not present previously.

>>> +    tps659038: tps659038@58 {
>>> +        compatible = "ti,tps659038";
>>> +        reg = <0x58>;
>>> +        interrupt-parent = <&gpio1>;
>>> +        interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>>
>> Also See: https://patchwork.kernel.org/patch/7596541/ ->
>> Documentation/devicetree/bindings/i2c/i2c.txt -> since you seem to
>> have a PMIC with power button, you might be able to get wakeup source
>> also there.
>>
> 
> Do you mean just adding "wakeup-source" property?
> 
> According to Documentation/devicetree/bindings/i2c/i2c.txt the primary
> interrupt will be used as wakeup interrupt.

I think you might have to describe a "wakeup" interrupt -> which will be
similar in description to the one you used to describe uart wakeup
capability.

[..]

>>> +        pinctrl-names = "default";
>>> +        pinctrl-0 = <&tps659038_pins_default>;
>>> +
>>> +        #interrupt-cells = <2>;
>>> +        interrupt-controller;
>>> +
>>> +        ti,system-power-controller;
>>
>> Assuming powerhold signal and BOOT0,1 is proper here, else poweroff
>> will never work.
>>
> 
> Please, could you provide more details regarding this issue.

well,  if poweroff command does not completely power off your board, you
may want to investigate further. overall, the better circuit
configuration is the X15 configuration:
https://github.com/beagleboard/beagleboard-x15/blob/master/BeagleBoard-X15_RevA2.pdf
Pay close attention to the PMIC GPIO_&/POWERHOLD signal. Also notice the
extra reset circuit involved.

Again, a topic that you should probably discuss with your TI support
contact person.

[...]

-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 5/5] usb: musb: dsps: use proper child nodes
Date: Fri, 02 Aug 2013 12:29:40 +0200
Message-ID: <51FB8A14.8040008@linutronix.de>
References: <1375215401-19729-1-git-send-email-bigeasy@linutronix.de> <1375215401-19729-6-git-send-email-bigeasy@linutronix.de> <51F9F10A.4000908@ti.com> <51FA3DD9.9080207@linutronix.de> <51FA46C3.9000101@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51FA46C3.9000101-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 08/01/2013 01:30 PM, Sebastian Andrzej Siewior wrote:
> On 08/01/2013 12:52 PM, Sebastian Andrzej Siewior wrote:
>> On 08/01/2013 07:24 AM, George Cherian wrote:
>>>> b/arch/arm/boot/dts/am33xx.dtsi
>>>> index 38b446b..0f756ca 100644
>>>> --- a/arch/arm/boot/dts/am33xx.dtsi
>>>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>>>> @@ -333,21 +337,85 @@
>>>>               status = "disabled";
>>>>           };
>>>>   -        usb@47400000 {
>>>> -            compatible = "ti,musb-am33xx";
>>>> -            reg = <0x47400000 0x1000    /* usbss */
>>>> -                   0x47401000 0x800        /* musb instance 0 */
>>>> -                   0x47401800 0x800>;    /* musb instance 1 */
>>>> -            interrupts = <17        /* usbss */
>>>> -                      18        /* musb instance 0 */
>>>> -                      19>;        /* musb instance 1 */
>>>> -            multipoint = <1>;
>>>> -            num-eps = <16>;
>>>> -            ram-bits = <12>;
>>>> -            port0-mode = <3>;
>>>> -            port1-mode = <3>;
>>>> -            power = <250>;
>>>> +        usb: usb@47400000 {
>>>> +            compatible = "ti,am33xx-usb";
>>>> +            reg = <0x47400000 0x1000>;
>>>> +            ranges;
>>>> +            #address-cells = <1>;
>>>> +            #size-cells = <1>;
>>>>               ti,hwmods = "usb_otg_hs";
>>>> +            status = "disabled";
>>>> +
>>>> +            ctrl_mod: control@44e10000 {
>>>> +                compatible = "ti,am335x-ctrl-module";
>>>> +                reg = <0x44e10000 0x650>;
>>>
>>> Do you really need to map Control Module base to 0x650? If some other
>>> driver does this mapping
>>
>> This is what I cam currently not sure about. Either we minimize the
>> register window and introduce two (the other wakeup) or we keep using
>> the same reset driver for other devices.
> 
> I mean drivers/reset or something like that.

If there are no further comments / preferences on this I'm going to
shrink to registers and make usb only.

> 
Sebastian

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

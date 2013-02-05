From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 10/13] ARM: dts: OMAP4: Add HS USB Host IP nodes
Date: Tue, 5 Feb 2013 14:27:03 +0530
Message-ID: <5110C95F.9070500@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com> <1359993540-20780-11-git-send-email-rogerq@ti.com> <5110A5B8.3030803@ti.com> <5110C8CE.2020606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5110C8CE.2020606-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 05 February 2013 02:24 PM, Roger Quadros wrote:
> On 02/05/2013 08:24 AM, kishon wrote:
>> On Monday 04 February 2013 09:28 PM, Roger Quadros wrote:
>>> Adds device nodes for HS USB Host module, TLL module,
>>> OHCI and EHCI controllers.
>>>
>>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>>> ---
>>>    arch/arm/boot/dts/omap4.dtsi |   30 ++++++++++++++++++++++++++++++
>>>    1 files changed, 30 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>>> index 739bb79..3429280 100644
>>> --- a/arch/arm/boot/dts/omap4.dtsi
>>> +++ b/arch/arm/boot/dts/omap4.dtsi
>>> @@ -529,5 +529,35 @@
>>>                ti,hwmods = "timer11";
>>>                ti,timer-pwm;
>>>            };
>>> +
>>> +        usbhstll: usbhstll@0x4a062000 {
>>> +            compatible = "ti,usbhs-tll";
>>> +            reg = <0x4a062000 0x1000>;
>>> +            interrupts = <0 78 0x4>;
>>> +            ti,hwmods = "usb_tll_hs";
>>> +        };
>>> +
>>> +        usbhshost: usbhshost@0x4a064000 {
>>> +            compatible = "ti,usbhs-host";
>>> +            reg = <0x4a064000 0x800>;
>>> +            ti,hwmods = "usb_host_hs";
>>> +            #address-cells = <1>;
>>> +            #size-cells = <1>;
>>> +            ranges;
>>> +
>>> +            usbhsohci: ohci@0x4a064800 {
>>> +                compatible = "ti,omap3-ohci", "usb-ohci";
>>> +                reg = <0x4a064800 0x400>;
>>> +                interrupt-parent = <&gic>;
>>
>> Just curious.. Were you facing issues if you are not having interrupt-parent here? It's also missing in your dt node usbhstll.
>
> Yes I was. Interrupt-parent is not there in any of the children which are at the same level as usbhstll.

Cool. Thought so :-)

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] extcon: extcon-dra7xx: Add extcon driver for USB
 ID detection
Date: Tue, 20 Aug 2013 12:25:08 +0530
Message-ID: <521312CC.8060003@ti.com>
References: <1376648029-30659-1-git-send-email-george.cherian@ti.com> <1376648029-30659-2-git-send-email-george.cherian@ti.com> <52127284.6030506@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52127284.6030506-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Stephen,

Thanks for your review.

On 8/20/2013 1:01 AM, Stephen Warren wrote:

> On 08/16/2013 04:13 AM, George Cherian wrote:
>> Adding extcon driver for USB ID detection to dynamically
>> configure USB Host/Peripheral mode.
>> diff --git a/Documentation/devicetree/bindings/extcon/extcon-dra7xx.txt b/Documentation/devicetree/bindings/extcon/extcon-dra7xx.txt
>> +EXTCON FOR DRA7xx
>> +
>> +Required Properties:
> Please at lest explain what a DRA7xxx is, and the purpose of the HW
> module this binding describes.

DRA7xx is the SoC name and the USB VID  detection is implemented via gpio's
Basically it does only ID detection via GPIO and there is no VBUS 
detection in h/w.
>
>> + - compatible : Should be "ti,dra7xx-usb"
> If this is a USB VID detector rather than a full USB host controller,
> then "usb" in the binding is a bit over-reaching. Perhaps "-usb-vid" or
> "-usb-vid-detector" would be more accurate.

This will be renamed to dra7xx-extcon.
>
>> + - gpios : phandle to ID pin and interrupt gpio.
> This isn't just a phandle; it's phandle+args, or a GPIO specifier. Some
> reference should be made to ../gpio/gpio.txt for the format.

okay
> Why does the interrupt line need to be included in a list of GPIOs?

ID pins are connected to pcf8575, and the pcf8575's interrupt line is 
inturn connected to
gpio bank6 pin 11, we use this gpio interrupt to detect the ID pin change.
> If the DRA7xxx is a VID detector, why does it even need/have any GPIOs
> associated with it; surely it has a dedicated VID input pin. Can you
> provide more details re: how the HW is structured.
>
>> +Optional Properties:
>> +  - interrupt-parent : interrupt controller phandle
>> +  - interrupts : interrupt number
>> +
>> +
> It's typical insert the following between those two blank lines:
>
> Example:
>
> ... or delete one of the blank lines.
>
>> +dra7x_extcon1 {
>> +		compatible = "ti,dra7xx-usb";
>> +		gpios = <&pcf_usb 1 0>,
>> +			<&gpio6 11 2>;
>> +		interrupt-parent = <&gpio6>;
>> +		interrupts = <11>;
>> +	};
>> +
> No need for that trailing blank line.

okay
>


-- 
-George

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

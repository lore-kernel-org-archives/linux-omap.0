From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 15/26] ARM: omap4-panda.dts: add display information
Date: Mon, 9 Dec 2013 16:09:09 +0100
Message-ID: <CABxcv==-aknRfzybA6ify5JSHeiquS9bqAEXumJwhnS6PT0MfA@mail.gmail.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
	<1386160133-24026-16-git-send-email-tomi.valkeinen@ti.com>
	<CABxcv=m+-9V2qwvuQgJavQ3qOb2+fBcAoW9G_Mi33BTHCWE85g@mail.gmail.com>
	<52A5BDF4.2070304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35112 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933810Ab3LIPJL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Dec 2013 10:09:11 -0500
Received: by mail-wi0-f174.google.com with SMTP id z2so3914828wiv.1
        for <linux-omap@vger.kernel.org>; Mon, 09 Dec 2013 07:09:09 -0800 (PST)
In-Reply-To: <52A5BDF4.2070304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Enric Balletbo Serra <eballetbo@gmail.com>

Hi Tomi,

On Mon, Dec 9, 2013 at 1:56 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 2013-12-06 10:57, Javier Martinez Canillas wrote:
>
>>> +       tfp410: encoder@0 {
>>> +               compatible = "ti,tfp410";
>>> +               gpios = <&gpio1 0 0>;   /* 0, power-down */
>>> +
>>
>> Please use the constants from include/dt-bindings/ instead of magic
>> numbers, i.e:
>>
>> gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;   /* 0, power-down */
>
> Thanks, fixed now (for all .dts files)
>
> However... The TFP410 gpio is "power-down". I think we should actually
> mark it as GPIO_ACTIVE_LOW, as setting it to 0 powers down the device.
>

yes, I looked at the TFP410 datasheet [0] and the Power Down pin is
indeed an active-low, I just replaced to GPIO_ACTIVE_HIGH since you
were using a constant 0 and include/dt-bindings/gpio/gpio.h defines
GPIO_ACTIVE_HIGH  as 0.

I just asked to Enric why we use GPIO_ACTIVE_HIGH for the PD pin on
the IGEPv2 DTS instad and is because the IGEP board uses a hardware
signal inverter but that is a special case. I don't know about the
Panda board since I haven't looked at its datasheet.

Thanks a lot and best regards,
Javier

[0]: http://www.ti.com/lit/ds/slds145b/slds145b.pdf

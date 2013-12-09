From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 15/26] ARM: omap4-panda.dts: add display information
Date: Mon, 9 Dec 2013 17:53:44 +0100
Message-ID: <CABxcv==2TS00WJduP0EUCmOgLT9x-qzTO+GzyE=R+yooGAmPEA@mail.gmail.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
	<1386160133-24026-16-git-send-email-tomi.valkeinen@ti.com>
	<CABxcv=m+-9V2qwvuQgJavQ3qOb2+fBcAoW9G_Mi33BTHCWE85g@mail.gmail.com>
	<52A5BDF4.2070304@ti.com>
	<CABxcv==-aknRfzybA6ify5JSHeiquS9bqAEXumJwhnS6PT0MfA@mail.gmail.com>
	<52A5E230.4010901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:38051 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933852Ab3LIQxq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Dec 2013 11:53:46 -0500
Received: by mail-we0-f171.google.com with SMTP id q58so3783705wes.16
        for <linux-omap@vger.kernel.org>; Mon, 09 Dec 2013 08:53:45 -0800 (PST)
In-Reply-To: <52A5E230.4010901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Enric Balletbo Serra <eballetbo@gmail.com>

Hi Tomi,

On Mon, Dec 9, 2013 at 4:30 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 2013-12-09 17:09, Javier Martinez Canillas wrote:
>> Hi Tomi,
>>
>> On Mon, Dec 9, 2013 at 1:56 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>> On 2013-12-06 10:57, Javier Martinez Canillas wrote:
>>>
>>>>> +       tfp410: encoder@0 {
>>>>> +               compatible = "ti,tfp410";
>>>>> +               gpios = <&gpio1 0 0>;   /* 0, power-down */
>>>>> +
>>>>
>>>> Please use the constants from include/dt-bindings/ instead of magic
>>>> numbers, i.e:
>>>>
>>>> gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;   /* 0, power-down */
>>>
>>> Thanks, fixed now (for all .dts files)
>>>
>>> However... The TFP410 gpio is "power-down". I think we should actually
>>> mark it as GPIO_ACTIVE_LOW, as setting it to 0 powers down the device.
>>>
>>
>> yes, I looked at the TFP410 datasheet [0] and the Power Down pin is
>> indeed an active-low, I just replaced to GPIO_ACTIVE_HIGH since you
>> were using a constant 0 and include/dt-bindings/gpio/gpio.h defines
>> GPIO_ACTIVE_HIGH  as 0.
>>
>> I just asked to Enric why we use GPIO_ACTIVE_HIGH for the PD pin on
>> the IGEPv2 DTS instad and is because the IGEP board uses a hardware
>> signal inverter but that is a special case. I don't know about the
>> Panda board since I haven't looked at its datasheet.
>
> Oh. Does it work on igep? The TFP410 driver always handles the PD GPIO
> as it were active-low. The flag is ignored.
>

How weird, it does work on the IGEPv2 but you are right I just looked
at  at drivers/video/omap2/displays-new/encoder-tfp410.c and I see
that it indeed just does:

r = devm_gpio_request_one(&pdev->dev, ddata->pd_gpio,
GPIOF_OUT_INIT_LOW, "tfp410 PD");

So I don't know how it is working... I'm on the road and won't have
access to my IGEPv2 to dig further on this. Maybe Enric can shed more
light on this.

>  Tomi
>
>

Thanks a lot and best regards,
Javier

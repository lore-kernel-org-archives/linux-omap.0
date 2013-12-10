From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH 15/26] ARM: omap4-panda.dts: add display information
Date: Tue, 10 Dec 2013 11:56:02 +0100
Message-ID: <CAFqH_517U6vUz7adwaF4h78wvvwPf3v0CYMw93_aFY7_=an1Xg@mail.gmail.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
	<1386160133-24026-16-git-send-email-tomi.valkeinen@ti.com>
	<CABxcv=m+-9V2qwvuQgJavQ3qOb2+fBcAoW9G_Mi33BTHCWE85g@mail.gmail.com>
	<52A5BDF4.2070304@ti.com>
	<CABxcv==-aknRfzybA6ify5JSHeiquS9bqAEXumJwhnS6PT0MfA@mail.gmail.com>
	<52A5E230.4010901@ti.com>
	<CABxcv==2TS00WJduP0EUCmOgLT9x-qzTO+GzyE=R+yooGAmPEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:33935 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159Ab3LJK4G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Dec 2013 05:56:06 -0500
In-Reply-To: <CABxcv==2TS00WJduP0EUCmOgLT9x-qzTO+GzyE=R+yooGAmPEA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>

Hi all,

2013/12/9 Javier Martinez Canillas <javier@dowhile0.org>:
> Hi Tomi,
>
> On Mon, Dec 9, 2013 at 4:30 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> On 2013-12-09 17:09, Javier Martinez Canillas wrote:
>>> Hi Tomi,
>>>
>>> On Mon, Dec 9, 2013 at 1:56 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>>> On 2013-12-06 10:57, Javier Martinez Canillas wrote:
>>>>
>>>>>> +       tfp410: encoder@0 {
>>>>>> +               compatible = "ti,tfp410";
>>>>>> +               gpios = <&gpio1 0 0>;   /* 0, power-down */
>>>>>> +
>>>>>
>>>>> Please use the constants from include/dt-bindings/ instead of magic
>>>>> numbers, i.e:
>>>>>
>>>>> gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;   /* 0, power-down */
>>>>
>>>> Thanks, fixed now (for all .dts files)
>>>>
>>>> However... The TFP410 gpio is "power-down". I think we should actually
>>>> mark it as GPIO_ACTIVE_LOW, as setting it to 0 powers down the device.
>>>>
>>>
>>> yes, I looked at the TFP410 datasheet [0] and the Power Down pin is
>>> indeed an active-low, I just replaced to GPIO_ACTIVE_HIGH since you
>>> were using a constant 0 and include/dt-bindings/gpio/gpio.h defines
>>> GPIO_ACTIVE_HIGH  as 0.
>>>
>>> I just asked to Enric why we use GPIO_ACTIVE_HIGH for the PD pin on
>>> the IGEPv2 DTS instad and is because the IGEP board uses a hardware
>>> signal inverter but that is a special case. I don't know about the
>>> Panda board since I haven't looked at its datasheet.
>>
>> Oh. Does it work on igep? The TFP410 driver always handles the PD GPIO
>> as it were active-low. The flag is ignored.
>>
>
> How weird, it does work on the IGEPv2 but you are right I just looked
> at  at drivers/video/omap2/displays-new/encoder-tfp410.c and I see
> that it indeed just does:
>
> r = devm_gpio_request_one(&pdev->dev, ddata->pd_gpio,
> GPIOF_OUT_INIT_LOW, "tfp410 PD");
>
> So I don't know how it is working... I'm on the road and won't have
> access to my IGEPv2 to dig further on this. Maybe Enric can shed more
> light on this.
>

On IGEPv2 the GPIO that controls the power-down pin is connected
through a dual/buffer driver [1]. This driver is only a buffer, not
inverts the signal (I had told you wrong, sorry Javier ), so the pin
continues being active low.

As both of you pointed the driver ignores the flag to handle the PD
GPIO, so doesn't matter if in the device tree we put GPIO_ACTIVE_HIGH
or GPIO_ACTIVE_LOW, so simply it works. About the patch to support
display for IGEP, to be coherent, the gpio should be defined as
GPIO_ACTIVE_LOW not GPIO_ACTIVE_HIGH. I have tested, and of course,
works.


diff --git a/arch/arm/boot/dts/omap3-igep0020.dts
b/arch/arm/boot/dts/omap3-igep0020.dts
index 2569d60..d185e06 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -233,7 +233,7 @@

        tfp410: encoder@0 {
                compatible = "ti,tfp410";
-               gpios = <&gpio6 10 GPIO_ACTIVE_HIGH>; /* 170, power-down */
+               gpios = <&gpio6 10 GPIO_ACTIVE_LOW>; /* 170, power-down */

                ports {
                        #address-cells = <1>;


[1] http://www.ti.com/product/sn74lvc2g07

Best regards,
  Enric

>>  Tomi
>>
>>
>
> Thanks a lot and best regards,
> Javier

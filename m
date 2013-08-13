From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap3-igep: add pinmux node for GPIO LED configuration
Date: Tue, 13 Aug 2013 13:35:49 +0200
Message-ID: <CAAwP0s3WWMXY-VNDSwU_H-P2X9mMf01yT20tnAgTFR4zzJ8dgA@mail.gmail.com>
References: <1371739352-19670-1-git-send-email-javier.martinez@collabora.co.uk>
 <CAAwP0s0BqsWqhi4vRxLHjDWdaVhPy2TL6syydV-=+vAYioi6ig@mail.gmail.com> <520A1685.10508@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172]:44079 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755564Ab3HMLgK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Aug 2013 07:36:10 -0400
Received: by mail-ve0-f172.google.com with SMTP id oz10so6641803veb.3
        for <linux-omap@vger.kernel.org>; Tue, 13 Aug 2013 04:36:09 -0700 (PDT)
In-Reply-To: <520A1685.10508@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, benoit.cousson@linaro.org, Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org

On Tue, Aug 13, 2013 at 1:20 PM, Benoit Cousson <bcousson@baylibre.com> wrote:
> Hi Javier,
>
>
> On 03/08/2013 21:11, Javier Martinez Canillas wrote:
>>
>> On Thu, Jun 20, 2013 at 4:42 PM, Javier Martinez Canillas
>> <javier.martinez@collabora.co.uk> wrote:
>>>
>>> IGEP boards have a number of LED connected to OMAP or TWL GPIO
>>> lines. The actual wiring is different on each board so each board
>>> DT has need to configure the mux correctly.
>>>
>>> Even though it works with the current DT, the kernel complains with:
>>>
>>> [2.305023] leds-gpio leds.18: pins are not configured from the driver
>>>
>>> Add an empty pinmux_leds_pins pinctrl child node so boards can
>>> override with the correct mux configuration and not depend on
>>> default values for the GPIO LEDs to work.
>>>
>>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>> ---
>>>   arch/arm/boot/dts/omap3-igep.dtsi |    2 ++
>>>   1 files changed, 2 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/omap3-igep.dtsi
>>> b/arch/arm/boot/dts/omap3-igep.dtsi
>>> index bc48b11..55f9f61 100644
>>> --- a/arch/arm/boot/dts/omap3-igep.dtsi
>>> +++ b/arch/arm/boot/dts/omap3-igep.dtsi
>>> @@ -68,6 +68,8 @@
>>>                          0x1a2 (PIN_INPUT | MUX_MODE4)           /*
>>> mcspi1_cs2.gpio_176 */
>>>                  >;
>>>          };
>>> +
>>> +       leds_pins: pinmux_leds_pins { };
>
>
> I'm just wondering what will happen if you do not override it with the board
> file?
>
> Will we still have the warning? Because the warning is there to notify you
> that the pin config is missing so we should not prevent that to work.
>

If you don't override on the board file you will just get the warning.

Once when I send this patches the gpio-leds driver was indeed failing
to probe because of this. I noticed this because the LED stop working
and didn't appear in /sys/class/leds/ and setting the pin mux
correctly solved the issue.

Now I just see a warning so it seems this got fixed in the meantime.

So since is not a regression probably this is v3.12 material and there
is no need to send it on the -rc series.

> Regards,
> Benoit
>

Thanks a lot and best regards,
Javier

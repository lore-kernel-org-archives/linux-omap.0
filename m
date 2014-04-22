From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: regressions in linux-next?
Date: Wed, 23 Apr 2014 00:32:37 +0200
Message-ID: <CABxcv=nqiCsBt2V3Dw+Q+PfBCAg3LSLEuon2+CcRn3o-AFCs_Q@mail.gmail.com>
References: <53566C20.6000208@ti.com>
	<53566EBA.808@ti.com>
	<CABxcv=mu=xvt7cM7Q8vBP2hQH124=CL9Yuox8WWcVGeKJ+NSjA@mail.gmail.com>
	<20140422193754.GA28885@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:41061 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbaDVWcj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2014 18:32:39 -0400
Received: by mail-wg0-f42.google.com with SMTP id y10so98732wgg.1
        for <linux-omap@vger.kernel.org>; Tue, 22 Apr 2014 15:32:37 -0700 (PDT)
In-Reply-To: <20140422193754.GA28885@arch.cereza>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Linus Walleij <linus.walleij@linaro.org>

Hello Ezequiel,

On Tue, Apr 22, 2014 at 9:37 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> On Apr 22, Javier Martinez Canillas wrote:
>> On Tue, Apr 22, 2014 at 3:29 PM, Peter Ujfalusi <peter.ujfalusi@ti.c=
om> wrote:
>> > On 04/22/2014 04:18 PM, Nishanth Menon wrote:
>> >> next-20140422-omap2plus_defconfig
>> >>  1:  am335x-sk:  Boot FAIL: http://slexy.org/raw/s2gh6XsLve
>> >>  2: am3517-evm:  Boot PASS: http://slexy.org/raw/s2MTkdzPnb
>> >>  3:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2SJwrVat8
>> >>  4: am43xx-epos:  Boot PASS: http://slexy.org/raw/s2184jfKlq
>> >>  5: am43xx-gpevm:  Boot FAIL: http://slexy.org/raw/s21qIYDHqa
>> >>> known
>> >>  6: BeagleBoard-XM:  Boot FAIL: http://slexy.org/raw/s21EyANlGX
>> >>  7: beagleboard-vanilla:  Boot FAIL: http://slexy.org/raw/s20lc3i=
cwS
>> >>  8: beaglebone-black:  Boot PASS: http://slexy.org/raw/s2ykosQg6C
>> >>  9: beaglebone:  Boot PASS: http://slexy.org/raw/s2DN9gqlmo
>> >> 10: craneboard:  Boot FAIL: http://slexy.org/raw/s21bP0auhl
>> >> 11: DRA7xx-EVM:  Boot FAIL: http://slexy.org/raw/s2rBG0C1x6
>> >> 12: OMAP3430-Labrador(LDP):  Boot PASS: http://slexy.org/raw/s2N3=
afw0TI
>> >> 13:       n900:  Boot PASS: http://slexy.org/raw/s21qmT6XCJ
>> >> 14: pandaboard-es:  Boot FAIL: http://slexy.org/raw/s28vlMGdeh
>> >> 15: pandaboard-vanilla:  Boot FAIL: http://slexy.org/raw/s20yHoGH=
dW
>> >> 16:    sdp2430:  Boot PASS: http://slexy.org/raw/s20i8Ir3yn
>> >> 17:    sdp3430:  Boot PASS: http://slexy.org/raw/s20t4VTeEB
>> >> 18:    sdp4430:  Boot FAIL: http://slexy.org/raw/s21SHcOP01
>> >> 19: OMAP5432uEVM:  Boot FAIL: http://slexy.org/raw/s2qmlRZped
>> >> TOTAL =3D 19 boards, Booted Boards =3D 9, No Boot boards =3D 10
>> >>
>> >> next-20140417-omap2plus_defconfig
>> >>  1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2Yvz8RRkn
>> >>  2:  am335x-sk:  Boot FAIL: http://slexy.org/raw/s2JFbaPPVA
>> >>> farm issues. - But peter reports fail as well.
>> >
>> > Yes, 20140417 boot fails for me on am335x-evmsk. What I can see wi=
th early
>> > printk is that the boot hangs around/after omap-gpio in all cases =
without any
>> > further information.
>> > I have checked the diff between 20140407, which was fine on evmsk =
regarding to
>> > omap-gpio and if I revert:
>> > d04b76626e94 gpio: omap: convert driver to use gpiolib irqchip
>> >
>> > am335x-evmsk boots up fine.
>> >
>> > With that commit in place PandaBoardES boots fine, but evmsk does =
not.
>> >
>>
>> I've revised the patch again and I couldn't find the reason why
>> certain boards are failing to boot.
>>
>> I can't reproduce this issue since I only have a DM3730 IGEPv2 board
>> which boots fine but I should have access to an AM3354 IGEP Aquila
>> board which is similar to the am335x-evmsk so I may be able to debug
>> it.
>>
>
> I've tested 20140422 -next on a Beaglebone black board with a custom
> gpio-keys cape and it seems to be working fine.
>

Thanks a lot for testing the patches, then is not a problem with all
am335x since BBB is booting correctly.

> All the gpio are registered, but there are some suspicious messages:
>
> # dmesg | grep gpio
> gpiochip_add: registered GPIOs 0 to 31 on device: gpio
> gpiochip_add: registered GPIOs 32 to 63 on device: gpio
> gpiochip_add: registered GPIOs 64 to 95 on device: gpio
> gpiochip_add: registered GPIOs 96 to 127 on device: gpio
> of_get_named_gpiod_flags: can't parse gpios property of node '/fixedr=
egulator@0[0]'
> of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/se=
rial@44e09000[0]'
> of_get_named_gpiod_flags exited with status 0
> of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/mm=
c@48060000[0]'
> of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/mm=
c@481d8000[0]'
> of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/mm=
c@481d8000[0]'
>

Yes those messages are suspicious indeed but I don't think that are
related with this patch-set since I've a similar log on my IGEPv2 when
booting 3.15-rc2 (which does not include the gpiolib irqchip
conversion):

dmesg | grep -i gpio
[    0.505554] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.506927] OMAP GPIO hardware version 2.5
[    0.508697] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.511352] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.514007] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.516571] gpiochip_add: registered GPIOs 128 to 159 on device: gpi=
o
[    0.519256] gpiochip_add: registered GPIOs 160 to 191 on device: gpi=
o
[    0.653167] of_get_named_gpiod_flags: can't parse gpios property of
node '/regulator-vdd33[0]'
[    0.654907] of_get_named_gpiod_flags: can't parse gpios property of
node '/regulator-vddvario[0]'
[    0.656066] of_get_named_gpiod_flags: can't parse gpios property of
node '/regulator-vdd33a[0]'
[    0.657257] of_get_named_gpiod_flags exited with status -517
[    0.665985] of_get_named_gpiod_flags exited with status 0
[    1.213073] of_get_named_gpiod_flags: can't parse gpios property of
node '/ocp/serial@4806a000[0]'
[    1.218109] of_get_named_gpiod_flags: can't parse gpios property of
node '/ocp/serial@4806c000[0]'
[    1.221160] of_get_named_gpiod_flags: can't parse gpios property of
node '/ocp/serial@49020000[0]'
[    2.094512] of_get_named_gpiod_flags: can't parse gpios property of
node '/ocp/serial@49042000[0]'
[    2.552764] of_get_named_gpiod_flags: can't parse gpios property of
node '/ocp/mmc@4809c000[0]'
[    2.552795] of_get_named_gpiod_flags: can't parse gpios property of
node '/ocp/mmc@4809c000[0]'
[    2.569305] of_get_named_gpiod_flags: can't parse gpios property of
node '/ocp/mmc@480b4000[0]'
[    2.569335] of_get_named_gpiod_flags: can't parse gpios property of
node '/ocp/mmc@480b4000[0]'
[    2.647216] of_get_named_gpiod_flags exited with status 0
[    2.659545] of_get_named_gpiod_flags exited with status -517
[    2.669006] of_get_named_gpiod_flags exited with status 0
[    2.908355] twl4030_gpio twl4030-gpio: gpio (irq 338) chaining IRQs =
354..371
[    2.917266] gpiochip_find_base: found new base at 492
[    2.918487] gpiochip_add: registered GPIOs 492 to 511 on device: twl=
4030
[    2.993957] of_get_named_gpiod_flags: can't parse gpios property of
node '/ocp/mmc@4809c000[0]'
[    2.993988] of_get_named_gpiod_flags: can't parse gpios property of
node '/ocp/mmc@4809c000[0]'
[    3.045196] of_get_named_gpiod_flags: can't parse gpios property of
node '/ocp/mmc@480b4000[0]'
[    3.045227] of_get_named_gpiod_flags: can't parse gpios property of
node '/ocp/mmc@480b4000[0]'
[    3.094604] of_get_named_gpiod_flags exited with status 0
[    3.101531] of_get_named_gpiod_flags exited with status 0
[    8.423065] of_get_named_gpiod_flags exited with status 0
[    9.788970] of_get_named_gpiod_flags: can't parse gpios property of
node '/sound[0]'
[    9.837951] of_get_named_gpiod_flags: can't parse gpios property of
node '/sound[0]'
[   10.200561] of_get_named_gpiod_flags: can't parse gpios property of
node '/sound[0]'
[   10.203399] of_get_named_gpiod_flags: can't parse gpios property of
node '/ocp/i2c@48070000/twl@48/audio/codec[0]'

Best regards,
Javier

> Regards,
> --
> Ezequiel Garc=C3=ADa, Free Electrons
> Embedded Linux, Kernel and Android Engineering
> http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

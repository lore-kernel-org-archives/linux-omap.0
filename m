From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: regressions in linux-next?
Date: Tue, 22 Apr 2014 16:37:54 -0300
Message-ID: <20140422193754.GA28885@arch.cereza>
References: <53566C20.6000208@ti.com>
 <53566EBA.808@ti.com>
 <CABxcv=mu=xvt7cM7Q8vBP2hQH124=CL9Yuox8WWcVGeKJ+NSjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:51326 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750888AbaDVTig (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2014 15:38:36 -0400
Content-Disposition: inline
In-Reply-To: <CABxcv=mu=xvt7cM7Q8vBP2hQH124=CL9Yuox8WWcVGeKJ+NSjA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Linus Walleij <linus.walleij@linaro.org>

On Apr 22, Javier Martinez Canillas wrote:
> On Tue, Apr 22, 2014 at 3:29 PM, Peter Ujfalusi <peter.ujfalusi@ti.co=
m> wrote:
> > On 04/22/2014 04:18 PM, Nishanth Menon wrote:
> >> next-20140422-omap2plus_defconfig
> >>  1:  am335x-sk:  Boot FAIL: http://slexy.org/raw/s2gh6XsLve
> >>  2: am3517-evm:  Boot PASS: http://slexy.org/raw/s2MTkdzPnb
> >>  3:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2SJwrVat8
> >>  4: am43xx-epos:  Boot PASS: http://slexy.org/raw/s2184jfKlq
> >>  5: am43xx-gpevm:  Boot FAIL: http://slexy.org/raw/s21qIYDHqa
> >>> known
> >>  6: BeagleBoard-XM:  Boot FAIL: http://slexy.org/raw/s21EyANlGX
> >>  7: beagleboard-vanilla:  Boot FAIL: http://slexy.org/raw/s20lc3ic=
wS
> >>  8: beaglebone-black:  Boot PASS: http://slexy.org/raw/s2ykosQg6C
> >>  9: beaglebone:  Boot PASS: http://slexy.org/raw/s2DN9gqlmo
> >> 10: craneboard:  Boot FAIL: http://slexy.org/raw/s21bP0auhl
> >> 11: DRA7xx-EVM:  Boot FAIL: http://slexy.org/raw/s2rBG0C1x6
> >> 12: OMAP3430-Labrador(LDP):  Boot PASS: http://slexy.org/raw/s2N3a=
fw0TI
> >> 13:       n900:  Boot PASS: http://slexy.org/raw/s21qmT6XCJ
> >> 14: pandaboard-es:  Boot FAIL: http://slexy.org/raw/s28vlMGdeh
> >> 15: pandaboard-vanilla:  Boot FAIL: http://slexy.org/raw/s20yHoGHd=
W
> >> 16:    sdp2430:  Boot PASS: http://slexy.org/raw/s20i8Ir3yn
> >> 17:    sdp3430:  Boot PASS: http://slexy.org/raw/s20t4VTeEB
> >> 18:    sdp4430:  Boot FAIL: http://slexy.org/raw/s21SHcOP01
> >> 19: OMAP5432uEVM:  Boot FAIL: http://slexy.org/raw/s2qmlRZped
> >> TOTAL =3D 19 boards, Booted Boards =3D 9, No Boot boards =3D 10
> >>
> >> next-20140417-omap2plus_defconfig
> >>  1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2Yvz8RRkn
> >>  2:  am335x-sk:  Boot FAIL: http://slexy.org/raw/s2JFbaPPVA
> >>> farm issues. - But peter reports fail as well.
> >
> > Yes, 20140417 boot fails for me on am335x-evmsk. What I can see wit=
h early
> > printk is that the boot hangs around/after omap-gpio in all cases w=
ithout any
> > further information.
> > I have checked the diff between 20140407, which was fine on evmsk r=
egarding to
> > omap-gpio and if I revert:
> > d04b76626e94 gpio: omap: convert driver to use gpiolib irqchip
> >
> > am335x-evmsk boots up fine.
> >
> > With that commit in place PandaBoardES boots fine, but evmsk does n=
ot.
> >
>=20
> I've revised the patch again and I couldn't find the reason why
> certain boards are failing to boot.
>=20
> I can't reproduce this issue since I only have a DM3730 IGEPv2 board
> which boots fine but I should have access to an AM3354 IGEP Aquila
> board which is similar to the am335x-evmsk so I may be able to debug
> it.
>=20

I've tested 20140422 -next on a Beaglebone black board with a custom
gpio-keys cape and it seems to be working fine.

All the gpio are registered, but there are some suspicious messages:

# dmesg | grep gpio
gpiochip_add: registered GPIOs 0 to 31 on device: gpio
gpiochip_add: registered GPIOs 32 to 63 on device: gpio
gpiochip_add: registered GPIOs 64 to 95 on device: gpio
gpiochip_add: registered GPIOs 96 to 127 on device: gpio
of_get_named_gpiod_flags: can't parse gpios property of node '/fixedreg=
ulator@0[0]'
of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/seri=
al@44e09000[0]'
of_get_named_gpiod_flags exited with status 0
of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/mmc@=
48060000[0]'
of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/mmc@=
481d8000[0]'
of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/mmc@=
481d8000[0]'

Regards,
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

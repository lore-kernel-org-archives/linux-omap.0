From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: regressions in linux-next?
Date: Tue, 22 Apr 2014 17:52:58 +0200
Message-ID: <CABxcv=mu=xvt7cM7Q8vBP2hQH124=CL9Yuox8WWcVGeKJ+NSjA@mail.gmail.com>
References: <53566C20.6000208@ti.com>
	<53566EBA.808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:34473 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756389AbaDVPxA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2014 11:53:00 -0400
Received: by mail-wg0-f47.google.com with SMTP id x12so4054552wgg.6
        for <linux-omap@vger.kernel.org>; Tue, 22 Apr 2014 08:52:58 -0700 (PDT)
In-Reply-To: <53566EBA.808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Linus Walleij <linus.walleij@linaro.org>

Hello Peter and Nishanth,

On Tue, Apr 22, 2014 at 3:29 PM, Peter Ujfalusi <peter.ujfalusi@ti.com>=
 wrote:
> On 04/22/2014 04:18 PM, Nishanth Menon wrote:
>> next-20140422-omap2plus_defconfig
>>  1:  am335x-sk:  Boot FAIL: http://slexy.org/raw/s2gh6XsLve
>>  2: am3517-evm:  Boot PASS: http://slexy.org/raw/s2MTkdzPnb
>>  3:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2SJwrVat8
>>  4: am43xx-epos:  Boot PASS: http://slexy.org/raw/s2184jfKlq
>>  5: am43xx-gpevm:  Boot FAIL: http://slexy.org/raw/s21qIYDHqa
>>> known
>>  6: BeagleBoard-XM:  Boot FAIL: http://slexy.org/raw/s21EyANlGX
>>  7: beagleboard-vanilla:  Boot FAIL: http://slexy.org/raw/s20lc3icwS
>>  8: beaglebone-black:  Boot PASS: http://slexy.org/raw/s2ykosQg6C
>>  9: beaglebone:  Boot PASS: http://slexy.org/raw/s2DN9gqlmo
>> 10: craneboard:  Boot FAIL: http://slexy.org/raw/s21bP0auhl
>> 11: DRA7xx-EVM:  Boot FAIL: http://slexy.org/raw/s2rBG0C1x6
>> 12: OMAP3430-Labrador(LDP):  Boot PASS: http://slexy.org/raw/s2N3afw=
0TI
>> 13:       n900:  Boot PASS: http://slexy.org/raw/s21qmT6XCJ
>> 14: pandaboard-es:  Boot FAIL: http://slexy.org/raw/s28vlMGdeh
>> 15: pandaboard-vanilla:  Boot FAIL: http://slexy.org/raw/s20yHoGHdW
>> 16:    sdp2430:  Boot PASS: http://slexy.org/raw/s20i8Ir3yn
>> 17:    sdp3430:  Boot PASS: http://slexy.org/raw/s20t4VTeEB
>> 18:    sdp4430:  Boot FAIL: http://slexy.org/raw/s21SHcOP01
>> 19: OMAP5432uEVM:  Boot FAIL: http://slexy.org/raw/s2qmlRZped
>> TOTAL =3D 19 boards, Booted Boards =3D 9, No Boot boards =3D 10
>>
>> next-20140417-omap2plus_defconfig
>>  1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2Yvz8RRkn
>>  2:  am335x-sk:  Boot FAIL: http://slexy.org/raw/s2JFbaPPVA
>>> farm issues. - But peter reports fail as well.
>
> Yes, 20140417 boot fails for me on am335x-evmsk. What I can see with =
early
> printk is that the boot hangs around/after omap-gpio in all cases wit=
hout any
> further information.
> I have checked the diff between 20140407, which was fine on evmsk reg=
arding to
> omap-gpio and if I revert:
> d04b76626e94 gpio: omap: convert driver to use gpiolib irqchip
>
> am335x-evmsk boots up fine.
>
> With that commit in place PandaBoardES boots fine, but evmsk does not=
=2E
>

I've revised the patch again and I couldn't find the reason why
certain boards are failing to boot.

I can't reproduce this issue since I only have a DM3730 IGEPv2 board
which boots fine but I should have access to an AM3354 IGEP Aquila
board which is similar to the am335x-evmsk so I may be able to debug
it.

Thanks a lot and best regards,
Javier

>
>>  3: am3517-evm:  Boot PASS: http://slexy.org/raw/s29h2lXGuw
>>  4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s20Whu6Qjr
>>  5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s21jBdk51T
>>  6: am43xx-gpevm:  Boot FAIL: http://slexy.org/raw/s2118uUlle
>>> known.
>>  7: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s29I92x0p3
>>  8: beagleboard-vanilla:  Boot FAIL: http://slexy.org/raw/s2GqJbMp7C
>>> farm issues
>>  9: beaglebone-black:  Boot PASS: http://slexy.org/raw/s2fb7JvizO
>> 10: beaglebone:  Boot PASS: http://slexy.org/raw/s2uQNDnOlV
>> 11: craneboard:  Boot PASS: http://slexy.org/raw/s2pTk8AgdX
>> 12: DRA7xx-EVM:  Boot PASS: http://slexy.org/raw/s2r2XdK8XF
>> 13: OMAP3430-Labrador(LDP):  Boot PASS: http://slexy.org/raw/s213f9w=
x5p
>> 14:       n900:  Boot PASS: http://slexy.org/raw/s2SaNcFG85
>> 15: pandaboard-es:  Boot PASS: http://slexy.org/raw/s2fR7PoakJ
>> 16: pandaboard-vanilla:  Boot PASS: http://slexy.org/raw/s2IMJ75sNc
>> 17:    sdp2430:  Boot PASS: http://slexy.org/raw/s207NAmPbO
>> 18:    sdp3430:  Boot PASS: http://slexy.org/raw/s20Yzlg3lU
>> 19:    sdp4430:  Boot PASS: http://slexy.org/raw/s21eYIZxtI
>> 20: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s2HIEtrDX9
>> TOTAL =3D 20 boards, Booted Boards =3D 17, No Boot boards =3D 3
>>
>> next-20140416-omap2plus_defconfig
>>  1: am335x-evm:  Boot PASS: http://slexy.org/raw/s20LxN1Qn4
>>  2:  am335x-sk:  Boot FAIL: http://slexy.org/raw/s202mfovsx
>>  3: am3517-evm:  Boot PASS: http://slexy.org/raw/s2IAJlhTFg
>>  4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s213AOULx7
>>  5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s22NCBg38K
>>  6: am43xx-gpevm:  Boot FAIL: http://slexy.org/raw/s2IhClBS3N
>>> known
>>  7: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s2octtFj30
>>  8: beagleboard-vanilla:  Boot PASS: http://slexy.org/raw/s20t9axfIr
>>  9: beaglebone-black:  Boot PASS: http://slexy.org/raw/s21FvZM0Gz
>> 10: beaglebone:  Boot PASS: http://slexy.org/raw/s2119uANhW
>> 11: craneboard:  Boot PASS: http://slexy.org/raw/s2FoVFiYaC
>> 12: DRA7xx-EVM:  Boot PASS: http://slexy.org/raw/s2FJjqu4MU
>> 13: OMAP3430-Labrador(LDP):  Boot PASS: http://slexy.org/raw/s29X2FB=
Mhu
>> 14:       n900:  Boot PASS: http://slexy.org/raw/s2AcjThjhw
>> 15: pandaboard-es:  Boot PASS: http://slexy.org/raw/s2LF8KsxJw
>> 16: pandaboard-vanilla:  Boot PASS: http://slexy.org/raw/s2E2KTBSFY
>> 17:    sdp2430:  Boot PASS: http://slexy.org/raw/s20HnXbU9M
>> 18:    sdp3430:  Boot PASS: http://slexy.org/raw/s20OuKg9mw
>> 19:    sdp4430:  Boot PASS: http://slexy.org/raw/s25V9CJgUB
>> 20: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s21WFeZmTd
>> TOTAL =3D 20 boards, Booted Boards =3D 18, No Boot boards =3D 2
>>
>
>
> --
> P=C3=A9ter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

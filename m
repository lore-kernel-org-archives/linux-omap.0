From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: OMAP3xxx hsmmc : MMC3 doesn't work, always times out?
Date: Thu, 11 Jun 2009 12:29:21 +0300
Message-ID: <6ed0b2680906110229u7ce2481sddb0168829bf7d38@mail.gmail.com>
References: <5a7b8b7b0906101913h2dbcbbc6l8f27873b8f81a3e0@mail.gmail.com>
	 <FCCFB4CDC6E5564B9182F639FC35608702F5345DB6@dbde02.ent.ti.com>
	 <5a7b8b7b0906102035s448e33cfpe4b321d36288e514@mail.gmail.com>
	 <1244700526.9815.31.camel@blitz>
	 <5910F919-941B-4964-99F5-C5772B1965C9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:55839 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755758AbZFKJ3U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2009 05:29:20 -0400
Received: by bwz9 with SMTP id 9so1313320bwz.37
        for <linux-omap@vger.kernel.org>; Thu, 11 Jun 2009 02:29:21 -0700 (PDT)
In-Reply-To: <5910F919-941B-4964-99F5-C5772B1965C9@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hugo Vincent <hugo.vincent@gmail.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "General mailing list for gumstix users." <gumstix-users@lists.sourceforge.net>

On Thu, Jun 11, 2009 at 10:43 AM, Hugo Vincent<hugo.vincent@gmail.com> =
wrote:
>
> On 11/06/2009, at 6:08 PM, Peter Barada wrote:
>
>> On Thu, 2009-06-11 at 15:35 +1200, Hugo Vincent wrote:
>>>
>>> On Thu, Jun 11, 2009 at 2:39 PM, Pandita, Vikram<vikram.pandita@ti.=
com>
>>> wrote:
>>>>
>>>> Hugo
>>>>
>>>>> -----Original Message-----
>>>>> From: linux-omap-owner@vger.kernel.org
>>>>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Hugo
>>>>> Vincent
>>>>> Sent: Wednesday, June 10, 2009 9:14 PM
>>>>> To: linux-omap; General mailing list for gumstix users.
>>>>> Subject: OMAP3xxx hsmmc : MMC3 doesn't work, always times out?
>>>>>
>>>>> Hi everyone,
>>>>>
>>>>> I'm trying to get the MMC3 slot working on my OMAP3503 Gumstix Ov=
ero
>>>>> based board working.
>>>>
>>>> Please check if your MMC3 Mux setting are as follows:
>>>> Note the input configuration for CLK and CMD. This is needed.
>>>>
>>>> /* MMC3 */
>>>> MUX_CFG_34XX("AF10_3430_MMC3_CLK", 0x1d0,
>>>> =A0 =A0 =A0 =A0 =A0 =A0OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PUL=
LUP)
>>>> MUX_CFG_34XX("AC3_3430_MMC3_CMD", 0x5d8,
>>>> =A0 =A0 =A0 =A0 =A0 =A0OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PUL=
LUP)
>>>> MUX_CFG_34XX("AE11_3430_MMC3_DAT0", 0x5e4,
>>>> =A0 =A0 =A0 =A0 =A0 =A0OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PUL=
LUP)
>>>> MUX_CFG_34XX("AH9_3430_MMC3_DAT1", 0x5e6,
>>>> =A0 =A0 =A0 =A0 =A0 =A0OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PUL=
LUP)
>>>> MUX_CFG_34XX("AF13_3430_MMC3_DAT2", 0x5e8,
>>>> =A0 =A0 =A0 =A0 =A0 =A0OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PUL=
LUP)
>>>> MUX_CFG_34XX("AF13_3430_MMC3_DAT3", 0x5e2,
>>>> =A0 =A0 =A0 =A0 =A0 =A0OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PUL=
LUP)
>>>>
>>>>
>>>> Also we will be soon (tomorrow) posting MUX patch for MMC1,2,3.
>>>
>>> Thanks for that Vikram. Unfortunately, these are the exact mux &
>>> pullup settings I was already using. (In my case, they were set by
>>> u-boot, but to be sure, I've copied and pasted the above exactly in=
to
>>> mach-omap2/mux.c - same result). Any other ideas?
>>
>> Are you using a 1.8V capable SD/MMC card? =A0MMC3 only works at 1.8V=
 on
>> the 3430 - MMC1 can work at 3V due to PBIAS register settings. =A0If
>> you're not, then the MMC can talk to the card, but the card can't
>> understand what its seeing due to the volatages of CLK/CMD being too
>> low...
>
> I am using a 3V SD card. But I'm also using TI TXS02612 for level
> translation (and to multiplex between two slots - but for now I only =
need to
> get one slot working and thus the select pin is wired high). I'm pret=
ty
> confident that the level translation is working correctly as (a) the =
clk and
> cmd signals come out to the correct pins on the socket at the correct=
 levels
> and (b) remultiplexing the datX signals as GPIOs and driving them is
> correctly reflected (and at the correct 3V levels) on the correct pin=
s on
> the card socket. Similarly in the card->OMAP direction of signaling (=
they
> are of course bidirectional level translators).
>
> Do I need to somehow tell the mmc host or core driver that I have ext=
ernal
> level translation and therefore not to worry that the host only suppo=
rts
> 1.8V cards?

The TRM says MMC3 "is used without external transceiver" [only?].
Doesn't the transceiver need additional control signals (dir_cmd and
dir_dat[2:0]), that are only provided by MMC2?

>
> Thanks for your help!
>
> Hugo
>
>>>>> Compiling 2.6.29-omap1 with
>>>>> =A0CONFIG_MMC=3Dy
>>>>> =A0CONFIG_MMC_DEBUG=3Dy
>>>>> =A0CONFIG_MMC_BLOCK=3Dy
>>>>> =A0CONFIG_MMC_BLOCK_BOUNCE=3Dy
>>>>> and MMC polling enabled (mmc->caps |=3D MMC_CAP_NEEDS_POLL; in
>>>>> omap_hsmmc.c)
>>>>>
>>>>> then doing: $ echo 8 > /proc/sys/kernel/printk
>>>>> gives the following:
>>>>>
>>>>> clock 0Hz busmode 1 powermode 1 cs 0 Vdd 20 width 0 timing 0
>>>>> mmc2: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 ti=
ming 0
>>>>> mmc2: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 20 width 0 ti=
ming 0
>>>>> mmc2: starting CMD0 arg 00000000 flags 000000c0
>>>>> mmci-omap-hs mmci-omap-hs.2: mmc2: CMD0, argument 0x00000000
>>>>> mmci-omap-hs mmci-omap-hs.2: IRQ Status is 1
>>>>> mmc2: req done (CMD0): 0: 00000000 00000000 00000000 00000000
>>>>> mmc2: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 ti=
ming 0
>>>>> mmc2: starting CMD8 arg 000001aa flags 000002f5
>>>>> mmci-omap-hs mmci-omap-hs.2: mmc2: CMD8, argument 0x000001aa
>>>>> mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>>>>> mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>>>>> mmc2: req done (CMD8): -110: 00000000 00000000 00000000 00000000
>>>>> mmc2: starting CMD5 arg 00000000 flags 000002e1
>>>>> mmci-omap-hs mmci-omap-hs.2: mmc2: CMD5, argument 0x00000000
>>>>> mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>>>>> mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>>>>> mmc2: req failed (CMD5): -110, retrying...
>>>>> mmci-omap-hs mmci-omap-hs.2: mmc2: CMD5, argument 0x00000000
>>>>> mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>>>>> mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>>>>> mmc2: req failed (CMD5): -110, retrying...
>>>>> mmci-omap-hs mmci-omap-hs.2: mmc2: CMD5, argument 0x00000000
>>>>> mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>>>>> mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>>>>> mmc2: req failed (CMD5): -110, retrying...
>>>>> mmci-omap-hs mmci-omap-hs.2: mmc2: CMD5, argument 0x00000000
>>>>> mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>>>>> mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>>>>> mmc2: req done (CMD5): -110: 00000000 00000000 00000000 00000000
>>>>> mmc2: starting CMD55 arg 00000000 flags 000000f5
>>>>> mmci-omap-hs mmci-omap-hs.2: mmc2: CMD55, argument 0x00000000
>>>>> mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>>>>> mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>>>>> mmc2: req done (CMD55): -110: 00000000 00000000 00000000 00000000
>>>>> mmc2: starting CMD55 arg 00000000 flags 000000f5
>>>>> mmci-omap-hs mmci-omap-hs.2: mmc2: CMD55, argument 0x00000000
>>>>> mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>>>>> mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>>>>> mmc2: req done (CMD55): -110: 00000000 00000000 00000000 00000000
>>>>> mmc2: starting CMD55 arg 00000000 flags 000000f5
>>>>> mmci-omap-hs mmci-omap-hs.2: mmc2: CMD55, argument 0x00000000
>>>>> mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>>>>> mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>>>>> mmc2: req done (CMD55): -110: 00000000 00000000 00000000 00000000
>>>>> mmc2: starting CMD55 arg 00000000 flags 000000f5
>>>>> mmci-omap-hs mmci-omap-hs.2: mmc2: CMD55, argument 0x00000000
>>>>> mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>>>>> mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>>>>> mmc2: req done (CMD55): -110: 00000000 00000000 00000000 00000000
>>>>> mmc2: starting CMD1 arg 00000000 flags 000000e1
>>>>> mmci-omap-hs mmci-omap-hs.2: mmc2: CMD1, argument 0x00000000
>>>>> mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>>>>> mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>>>>> mmc2: req done (CMD1): -110: 00000000 00000000 00000000 00000000
>>>>> mmc2: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
>>>>>
>>>>> It seems every request returns -110 which is -ETIMEDOUT.
>>>>>
>>>>> I've checked the hardware, and it appears to be correct (level
>>>>> translators etc seem to be doing their job).
>>>>>
>>>>> During polling, the CMD and CLK signals show activity, but the da=
ta
>>>>> lines never change; this is presumably why every request is timin=
g
>>>>> out.
>>>>>
>>>>> I've also tried it with 2.6.30-omap1 in git, which changes some
>>>>> MMC3-specific stuff (notably DMA), but has the exact same behavio=
ur.
>>>>>
>>>>> I've also checked pin multiplexing settings and confirmed that th=
e
>>>>> correct values are set for the MMC3 data pins. The card I'm using=
 is a
>>>>> microSD card that works when attached to MMC1 (the Gumstix Overo
>>>>> built-in microSD slot). The slot is powered by 3.3V that is alway=
s on,
>>>>> there is no provision for power switching with this particular bo=
ard.
>>>>>
>>>>> Any ideas?
>>>>>
>>>>> Many thanks,
>>>>> Hugo Vincent
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-o=
map"
>>>>> in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Laine Walker-Avina <lwalkera@ieee.org>
Subject: Re: AM3517 (Sitara) MMC2 help
Date: Tue, 24 Aug 2010 17:36:11 -0700
Message-ID: <AANLkTikYFtB1PW-bQnpxpG0A9FQiCxqk6+PMNH91JK7W@mail.gmail.com>
References: <4C73BE1C.7080503@compulab.co.il>
	<AANLkTinQWpYbFzDeAdsjpLsiW63q5q9XLkhef0NiujM1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64154 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755637Ab0HYAgO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Aug 2010 20:36:14 -0400
Received: by wwb34 with SMTP id 34so40466wwb.1
        for <linux-omap@vger.kernel.org>; Tue, 24 Aug 2010 17:36:12 -0700 (PDT)
In-Reply-To: <AANLkTinQWpYbFzDeAdsjpLsiW63q5q9XLkhef0NiujM1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org

On Tue, Aug 24, 2010 at 5:29 PM, Laine Walker-Avina <lwalkera@ieee.org>=
 wrote:
> On Tue, Aug 24, 2010 at 5:42 AM, Igor Grinberg <grinberg@compulab.co.=
il> wrote:
>> =C2=A0Hi,
>>
>> I have am3517 based board and Libertas sdio (4 wires)
>> wifi connected directly (no transceiver / level shifter) on mmc2
>> (which is named mmc1 in s/w).
>>
>> am3517 is configured (h/w) for 3.3V and so is Libertas wifi.
>>
>> dmesg | grep mmc1 shows:
>>
>> --------------cut------------------
>> mux: Setting signal sdmmc1_clk.sdmmc1_clk 0x0000 -> 0x0118
>> mux: Setting signal sdmmc1_cmd.sdmmc1_cmd 0x0000 -> 0x0118
>> mux: Setting signal sdmmc1_dat0.sdmmc1_dat0 0x0100 -> 0x0118
>> mux: Setting signal sdmmc1_dat1.sdmmc1_dat1 0x0100 -> 0x0118
>> mux: Setting signal sdmmc1_dat2.sdmmc1_dat2 0x0100 -> 0x0118
>> mux: Setting signal sdmmc1_dat3.sdmmc1_dat3 0x0100 -> 0x0118

Also, shouldn't you setting the mux values for sdmmc2_* not sdmmc1_*
if your chip is on MMC2?

>> mmc1: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
>> mmc1: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 20 width 0 timing 0
>> mmc1: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timin=
g 0
>> mmc1: starting CMD52 arg 00000c00 flags 00000195
>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD52, argument 0x00000c00
>> mmc1: req done (CMD52): -110: 00000000 00000000 00000000 00000000
>> mmc1: starting CMD52 arg 80000c08 flags 00000195
>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD52, argument 0x80000c08
>> mmc1: req done (CMD52): -110: 00000000 00000000 00000000 00000000
>> mmc1: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 20 width 0 timin=
g 0
>> mmc1: starting CMD0 arg 00000000 flags 000000c0
>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD0, argument 0x00000000
>> mmc1: req done (CMD0): 0: 00000000 00000000 00000000 00000000
>> mmc1: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timin=
g 0
>> mmc1: starting CMD8 arg 000001aa flags 000002f5
>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD8, argument 0x000001aa
>> mmc1: req done (CMD8): -110: 00000000 00000000 00000000 00000000
>> mmc1: starting CMD5 arg 00000000 flags 000002e1
>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD5, argument 0x00000000
>> mmc1: req failed (CMD5): -110, retrying...
>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD5, argument 0x00000000
>> mmc1: req failed (CMD5): -110, retrying...
>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD5, argument 0x00000000
>> mmc1: req failed (CMD5): -110, retrying...
>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD5, argument 0x00000000
>> mmc1: req done (CMD5): -110: 00000000 00000000 00000000 00000000
>> mmc1: starting CMD55 arg 00000000 flags 000000f5
>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD55, argument 0x00000000
>> mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
>> mmc1: starting CMD55 arg 00000000 flags 000000f5
>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD55, argument 0x00000000
>> mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
>> mmc1: starting CMD55 arg 00000000 flags 000000f5
>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD55, argument 0x00000000
>> mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
>> mmc1: starting CMD55 arg 00000000 flags 000000f5
>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD55, argument 0x00000000
>> mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
>> mmc1: starting CMD1 arg 00000000 flags 000000e1
>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD1, argument 0x00000000
>> mmc1: req done (CMD1): -110: 00000000 00000000 00000000 00000000
>> mmc1: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
>> -------------------cut---------------------
>>
>> Libertas is powered up and gets reseted properly.
>> On the oscilloscope, I see some communication going
>> on the CMD line and stops after some time.
>>
>> am3517 PSP from TI, does not even registers/enables
>> the wifi combo found on am3517evm.
>>
>> Have anybody got the mmc2 working on am3517?
>> May be with transceiver?
>>
>> Any help will be appreciated.
>>
>> Thanks
>>
>> --
>> Regards,
>> Igor.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>
> Make sure the MMC2_CLK pin is muxed as an input so the clock can
> feedback to the module. Also, you may need to set
> CONTROL_DEVCONF1.MMCSDIO2ADPCLKISEL=3D1 if that exists on the Sitara.=
 I
> had the same problem on the OMAP3x.
>
> --
> Laine Walker-Avina
> Firmware Engineer
> PASCO scientific
>



--=20
Laine Walker-Avina
=46irmware Engineer
PASCO scientific
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Ashwin Bihari <abihari@gmail.com>
Subject: Re: AM3517 (Sitara) MMC2 help
Date: Wed, 25 Aug 2010 09:46:07 -0400
Message-ID: <AANLkTi=3G2DdAFCJQyyAPEsvBeY-3Moxkarpaz41aAai@mail.gmail.com>
References: <4C73BE1C.7080503@compulab.co.il>
	<AANLkTinQWpYbFzDeAdsjpLsiW63q5q9XLkhef0NiujM1@mail.gmail.com>
	<4C74D073.3060105@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41012 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751Ab0HYNqO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 09:46:14 -0400
Received: by wwb34 with SMTP id 34so989901wwb.1
        for <linux-omap@vger.kernel.org>; Wed, 25 Aug 2010 06:46:13 -0700 (PDT)
In-Reply-To: <4C74D073.3060105@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Laine Walker-Avina <lwalkera@ieee.org>, linux-omap@vger.kernel.org

-- Ashwin



On Wed, Aug 25, 2010 at 4:12 AM, Igor Grinberg <grinberg@compulab.co.il=
> wrote:
> =A0On 08/25/10 03:29, Laine Walker-Avina wrote:
>> On Tue, Aug 24, 2010 at 5:42 AM, Igor Grinberg <grinberg@compulab.co=
=2Eil> wrote:
>>> =A0Hi,
>>>
>>> I have am3517 based board and Libertas sdio (4 wires)
>>> wifi connected directly (no transceiver / level shifter) on mmc2
>>> (which is named mmc1 in s/w).
>>>
>>> am3517 is configured (h/w) for 3.3V and so is Libertas wifi.
>>>
>>> dmesg | grep mmc1 shows:
>>>
>>> --------------cut------------------
>>> mux: Setting signal sdmmc1_clk.sdmmc1_clk 0x0000 -> 0x0118
>>> mux: Setting signal sdmmc1_cmd.sdmmc1_cmd 0x0000 -> 0x0118
>>> mux: Setting signal sdmmc1_dat0.sdmmc1_dat0 0x0100 -> 0x0118
>>> mux: Setting signal sdmmc1_dat1.sdmmc1_dat1 0x0100 -> 0x0118
>>> mux: Setting signal sdmmc1_dat2.sdmmc1_dat2 0x0100 -> 0x0118
>>> mux: Setting signal sdmmc1_dat3.sdmmc1_dat3 0x0100 -> 0x0118
>>> mmc1: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
>>> mmc1: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 20 width 0 timing 0
>>> mmc1: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timi=
ng 0
>>> mmc1: starting CMD52 arg 00000c00 flags 00000195
>>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD52, argument 0x00000c00
>>> mmc1: req done (CMD52): -110: 00000000 00000000 00000000 00000000
>>> mmc1: starting CMD52 arg 80000c08 flags 00000195
>>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD52, argument 0x80000c08
>>> mmc1: req done (CMD52): -110: 00000000 00000000 00000000 00000000
>>> mmc1: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 20 width 0 timi=
ng 0
>>> mmc1: starting CMD0 arg 00000000 flags 000000c0
>>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD0, argument 0x00000000
>>> mmc1: req done (CMD0): 0: 00000000 00000000 00000000 00000000
>>> mmc1: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timi=
ng 0
>>> mmc1: starting CMD8 arg 000001aa flags 000002f5
>>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD8, argument 0x000001aa
>>> mmc1: req done (CMD8): -110: 00000000 00000000 00000000 00000000
>>> mmc1: starting CMD5 arg 00000000 flags 000002e1
>>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD5, argument 0x00000000
>>> mmc1: req failed (CMD5): -110, retrying...
>>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD5, argument 0x00000000
>>> mmc1: req failed (CMD5): -110, retrying...
>>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD5, argument 0x00000000
>>> mmc1: req failed (CMD5): -110, retrying...
>>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD5, argument 0x00000000
>>> mmc1: req done (CMD5): -110: 00000000 00000000 00000000 00000000
>>> mmc1: starting CMD55 arg 00000000 flags 000000f5
>>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD55, argument 0x00000000
>>> mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
>>> mmc1: starting CMD55 arg 00000000 flags 000000f5
>>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD55, argument 0x00000000
>>> mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
>>> mmc1: starting CMD55 arg 00000000 flags 000000f5
>>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD55, argument 0x00000000
>>> mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
>>> mmc1: starting CMD55 arg 00000000 flags 000000f5
>>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD55, argument 0x00000000
>>> mmc1: req done (CMD55): -110: 00000000 00000000 00000000 00000000
>>> mmc1: starting CMD1 arg 00000000 flags 000000e1
>>> mmci-omap-hs mmci-omap-hs.1: mmc1: CMD1, argument 0x00000000
>>> mmc1: req done (CMD1): -110: 00000000 00000000 00000000 00000000
>>> mmc1: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
>>> -------------------cut---------------------
>>>
>>> Libertas is powered up and gets reseted properly.
>>> On the oscilloscope, I see some communication going
>>> on the CMD line and stops after some time.
>>>
>>> am3517 PSP from TI, does not even registers/enables
>>> the wifi combo found on am3517evm.
>>>
>>> Have anybody got the mmc2 working on am3517?
>>> May be with transceiver?
>>>
>>> Any help will be appreciated.
>>>
>>> Thanks
>>>
>>> --
>>> Regards,
>>> Igor.
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>> Make sure the MMC2_CLK pin is muxed as an input so the clock can
>> feedback to the module.
>
> omap2_mmc_mux() in arch/arm/mach-omap2/devices.c is handling this
> and I think properly or else any omap will fail using the mmc2.
>
>> Also, you may need to set
>> CONTROL_DEVCONF1.MMCSDIO2ADPCLKISEL=3D1 if that exists on the Sitara=
=2E I
>> had the same problem on the OMAP3x.
>
> I will try that.
>
> Thanks
>
> --
> Regards,
> Igor.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

I've got this exact same problem on a OMAP35x based board. We have
MMC1 connected to a SD card cage and MMC2 connected to an eMMC. I can
detect an inserted SD card and eMMC during boot up, but if I suspend
and resume the device, I get a ton of timeout errors on MMC1 (the SD
slot) and the RFS that's being used from it ends up having lots of
EXT3 journal errors and ends up hosing itself..

I've confirmed that the CONTROL_DEVCONF1.MMCSDIO2ADPCLKISEL is set to
1 as well and that doesn't affect any change.

I was using a 2.6.29 Kernel on this board before and it had no
problems, I then jumped to 2.6.32 and this problem appeared. I'm now
running the latest linux-next (2.6.35) Kernel and it also presents the
problem..

Any guidance would be appreciated..

-- Ashwin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: Question about omap_hsmmc driver
Date: Thu, 7 Jan 2010 12:04:41 +0100
Message-ID: <70c9a9111001070304v307c3107te04bff85e9353f2a@mail.gmail.com>
References: <70c9a9111001050844k6818b832w1f53876a85fb930c@mail.gmail.com>
	 <006201ca8e29$c7be20d0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:43457 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126Ab0AGLEm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 06:04:42 -0500
Received: by pzk1 with SMTP id 1so2854802pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 07 Jan 2010 03:04:41 -0800 (PST)
In-Reply-To: <006201ca8e29$c7be20d0$544ff780@am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

The mux configuration is set at u-boot level and this works with
kernel 2.6.28 so I suppose the mux configuration is setup correctly.

Looking at driver I see new data in twl4030_hsmmc_info struct. Please,
can you explain a bit the transceiver, ocr_mask and ext_clock  ?

Just for information, on IGEP v2 the MMC2 should be at 1.8V and don't
use twl4030 regulator.

Thanks a lot,

  Enric

2010/1/5 Madhusudhan <madhu.cr@ti.com>:
> Hi Enric,
>
> You see from the log there is a timeout on CMD5. This could happen be=
cause
> of multiple reasons. One of them is muxing of CMD/CLK lines. Or it co=
uld be
> due to negotiation of voltage.
>
> I would look at these things first.
>
> Regards,
> Madhu
>
> ________________________________________
> From: Enric Balletb=C3=B2 i Serra [mailto:eballetbo@gmail.com]
> Sent: Tuesday, January 05, 2010 10:44 AM
> To: linux-omap@vger.kernel.org; madhu.cr@ti.com
> Subject: Question about omap_hsmmc driver
>
> Hi all,
>
> I'm having problems trying to run the SDIO WLAN module on my IGEP v2 =
board
> using the latest omap kernel (2.6.33-rc2). The SDIO WLAN module is co=
nnected
> to the MMC2 using 4 wires. With an older kernel ( 2.6.28 ) works fine=
 but
> the same configuration with 2.6.33-rc2 do not detect the SDIO card.
>
>
> Any idea to solve the problem ? There is a substantial modification i=
n this
> driver. Any help will be appreciated. I attached the log.
>
> Thanks in advance,
> =C2=A0=C2=A0 Enric
>
>
> [=C2=A0=C2=A0 24.521484] mmci-omap-hs mmci-omap-hs.1: DISABLED -> ENA=
BLED
> [=C2=A0=C2=A0 24.522003] mmc1: clock 0Hz busmode 1 powermode 0 cs 0 V=
dd 0 width 0
> timing 0
> [=C2=A0=C2=A0 24.522033] mmci-omap-hs mmci-omap-hs.1: ENABLED -> DISA=
BLED
> [=C2=A0=C2=A0 24.522308] mmci-omap-hs mmci-omap-hs.1: DISABLED -> ENA=
BLED
> [=C2=A0=C2=A0 24.522338] mmc1: clock 0Hz busmode 1 powermode 1 cs 0 V=
dd 65535 width 0
> timing 0
> [=C2=A0=C2=A0 24.545104] mmc1: clock 400000Hz busmode 1 powermode 2 c=
s 0 Vdd 65535
> width 0 timing 0
> [=C2=A0=C2=A0 24.568298] mmc1: clock 400000Hz busmode 1 powermode 2 c=
s 1 Vdd 65535
> width 0 timing 0
> [=C2=A0=C2=A0 24.569335] mmc1: starting CMD0 arg 00000000 flags 00000=
0c0
> [=C2=A0=C2=A0 24.569366] mmci-omap-hs mmci-omap-hs.1: mmc1: CMD0, arg=
ument 0x00000000
> [=C2=A0=C2=A0 24.569519] mmci-omap-hs mmci-omap-hs.1: IRQ Status is 1
> [=C2=A0=C2=A0 24.569549] mmc1: req done (CMD0): 0: 00000000 00000000 =
00000000 00000000
> [=C2=A0=C2=A0 24.572540] mmc1: clock 400000Hz busmode 1 powermode 2 c=
s 0 Vdd 65535
> width 0 timing 0
> [=C2=A0=C2=A0 24.573547] mmc1: starting CMD8 arg 000000aa flags 00000=
2f5
> [=C2=A0=C2=A0 24.573577] mmci-omap-hs mmci-omap-hs.1: mmc1: CMD8, arg=
ument 0x000000aa
> [=C2=A0=C2=A0 24.573913] mmci-omap-hs mmci-omap-hs.1: IRQ Status is 1=
8000
> [=C2=A0=C2=A0 24.573913] mmci-omap-hs mmci-omap-hs.1: MMC IRQ 0x18000=
 : ERRI CTO
> [=C2=A0=C2=A0 24.573944] mmc1: req done (CMD8): -110: 00000000 000000=
00 00000000
> 00000000
> [=C2=A0=C2=A0 24.575744] mmc1: starting CMD5 arg 00000000 flags 00000=
2e1
> [=C2=A0=C2=A0 24.575775] mmci-omap-hs mmci-omap-hs.1: mmc1: CMD5, arg=
ument 0x00000000
> [=C2=A0=C2=A0 24.576110] mmci-omap-hs mmci-omap-hs.1: IRQ Status is 1=
8000
> [=C2=A0=C2=A0 24.576141] mmci-omap-hs mmci-omap-hs.1: MMC IRQ 0x18000=
 : ERRI CTO
> [=C2=A0=C2=A0 24.576171] mmc1: req failed (CMD5): -110, retrying...
> [=C2=A0=C2=A0 24.576171] mmci-omap-hs mmci-omap-hs.1: mmc1: CMD5, arg=
ument 0x00000000
> [=C2=A0=C2=A0 24.576507] mmci-omap-hs mmci-omap-hs.1: IRQ Status is 1=
8000
> [=C2=A0=C2=A0 24.576538] mmci-omap-hs mmci-omap-hs.1: MMC IRQ 0x18000=
 : ERRI CTO
> [=C2=A0=C2=A0 24.576568] mmc1: req failed (CMD5): -110, retrying...
> [=C2=A0=C2=A0 24.576568] mmci-omap-hs mmci-omap-hs.1: mmc1: CMD5, arg=
ument 0x00000000
> [=C2=A0=C2=A0 24.576904] mmci-omap-hs mmci-omap-hs.1: IRQ Status is 1=
8000
> [=C2=A0=C2=A0 24.576934] mmci-omap-hs mmci-omap-hs.1: MMC IRQ 0x18000=
 : ERRI CTO
> [=C2=A0=C2=A0 24.576934] mmc1: req failed (CMD5): -110, retrying...
> [=C2=A0=C2=A0 24.576965] mmci-omap-hs mmci-omap-hs.1: mmc1: CMD5, arg=
ument 0x00000000
> [=C2=A0=C2=A0 24.577301] mmci-omap-hs mmci-omap-hs.1: IRQ Status is 1=
8000
> [=C2=A0=C2=A0 24.577331] mmci-omap-hs mmci-omap-hs.1: MMC IRQ 0x18000=
 : ERRI CTO
> [=C2=A0=C2=A0 24.577331] mmc1: req done (CMD5): -110: 00000000 000000=
00 00000000
> 00000000
> [=C2=A0=C2=A0 24.578247] mmc1: starting CMD55 arg 00000000 flags 0000=
00f5
> [=C2=A0=C2=A0 24.578247] mmci-omap-hs mmci-omap-hs.1: mmc1: CMD55, ar=
gument 0x00000000
> [=C2=A0=C2=A0 24.578582] mmci-omap-hs mmci-omap-hs.1: IRQ Status is 1=
8000
> [=C2=A0=C2=A0 24.578613] mmci-omap-hs mmci-omap-hs.1: MMC IRQ 0x18000=
 : ERRI CTO
> [=C2=A0=C2=A0 24.578643] mmc1: req done (CMD55): -110: 00000000 00000=
000 00000000
> 00000000
> [=C2=A0=C2=A0 24.580444] mmc1: starting CMD55 arg 00000000 flags 0000=
00f5
> [=C2=A0=C2=A0 24.580474] mmci-omap-hs mmci-omap-hs.1: mmc1: CMD55, ar=
gument 0x00000000
> [=C2=A0=C2=A0 24.580810] mmci-omap-hs mmci-omap-hs.1: IRQ Status is 1=
8000
> [=C2=A0=C2=A0 24.580810] mmci-omap-hs mmci-omap-hs.1: MMC IRQ 0x18000=
 : ERRI CTO
> [=C2=A0=C2=A0 24.580841] mmc1: req done (CMD55): -110: 00000000 00000=
000 00000000
> 00000000
> [=C2=A0=C2=A0 24.582641] mmc1: starting CMD55 arg 00000000 flags 0000=
00f5
> [=C2=A0=C2=A0 24.582672] mmci-omap-hs mmci-omap-hs.1: mmc1: CMD55, ar=
gument 0x00000000
> [=C2=A0=C2=A0 24.583007] mmci-omap-hs mmci-omap-hs.1: IRQ Status is 1=
8000
> [=C2=A0=C2=A0 24.583007] mmci-omap-hs mmci-omap-hs.1: MMC IRQ 0x18000=
 : ERRI CTO
> [=C2=A0=C2=A0 24.583038] mmc1: req done (CMD55): -110: 00000000 00000=
000 00000000
> 00000000
> [=C2=A0=C2=A0 24.584899] mmc1: starting CMD55 arg 00000000 flags 0000=
00f5
> [=C2=A0=C2=A0 24.584899] mmci-omap-hs mmci-omap-hs.1: mmc1: CMD55, ar=
gument 0x00000000
> [=C2=A0=C2=A0 24.585235] mmci-omap-hs mmci-omap-hs.1: IRQ Status is 1=
8000
> [=C2=A0=C2=A0 24.585266] mmci-omap-hs mmci-omap-hs.1: MMC IRQ 0x18000=
 : ERRI CTO
> [=C2=A0=C2=A0 24.585296] mmc1: req done (CMD55): -110: 00000000 00000=
000 00000000
> 00000000
> [=C2=A0=C2=A0 24.587097] mmc1: starting CMD1 arg 00000000 flags 00000=
0e1
> [=C2=A0=C2=A0 24.587097] mmci-omap-hs mmci-omap-hs.1: mmc1: CMD1, arg=
ument 0x00000000
> [=C2=A0=C2=A0 24.587432] mmci-omap-hs mmci-omap-hs.1: IRQ Status is 1=
8000
> [=C2=A0=C2=A0 24.587463] mmci-omap-hs mmci-omap-hs.1: MMC IRQ 0x18000=
 : ERRI CTO
> [=C2=A0=C2=A0 24.587493] mmc1: req done (CMD1): -110: 00000000 000000=
00 00000000
> 00000000
> [=C2=A0=C2=A0 24.589294] mmc1: clock 0Hz busmode 1 powermode 0 cs 0 V=
dd 0 width 0
> timing 0
> [=C2=A0=C2=A0 24.623962] mmci-omap-hs mmci-omap-hs.1: ENABLED -> DISA=
BLED
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

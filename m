From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: Question about omap_hsmmc driver
Date: Tue, 5 Jan 2010 11:09:02 -0600
Message-ID: <006201ca8e29$c7be20d0$544ff780@am.dhcp.ti.com>
References: <70c9a9111001050844k6818b832w1f53876a85fb930c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37446 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755215Ab0AERJF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 12:09:05 -0500
In-Reply-To: <70c9a9111001050844k6818b832w1f53876a85fb930c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?'Enric_Balletb=F2_i_Serra'?= <eballetbo@gmail.com>, linux-omap@vger.kernel.org

Hi Enric,

You see from the log there is a timeout on CMD5. This could happen beca=
use
of multiple reasons. One of them is muxing of CMD/CLK lines. Or it coul=
d be
due to negotiation of voltage.

I would look at these things first.

Regards,
Madhu

________________________________________
=46rom: Enric Balletb=F2 i Serra [mailto:eballetbo@gmail.com]=20
Sent: Tuesday, January 05, 2010 10:44 AM
To: linux-omap@vger.kernel.org; madhu.cr@ti.com
Subject: Question about omap_hsmmc driver

Hi all,

I'm having problems trying to run the SDIO WLAN module on my IGEP v2 bo=
ard
using the latest omap kernel (2.6.33-rc2). The SDIO WLAN module is conn=
ected
to the MMC2 using 4 wires. With an older kernel ( 2.6.28 ) works fine b=
ut
the same configuration with 2.6.33-rc2 do not detect the SDIO card.


Any idea to solve the problem ? There is a substantial modification in =
this
driver. Any help will be appreciated. I attached the log.

Thanks in advance,
=A0=A0 Enric


[=A0=A0 24.521484] mmci-omap-hs mmci-omap-hs.1: DISABLED -> ENABLED
[=A0=A0 24.522003] mmc1: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 wid=
th 0
timing 0
[=A0=A0 24.522033] mmci-omap-hs mmci-omap-hs.1: ENABLED -> DISABLED
[=A0=A0 24.522308] mmci-omap-hs mmci-omap-hs.1: DISABLED -> ENABLED
[=A0=A0 24.522338] mmc1: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 65535=
 width 0
timing 0
[=A0=A0 24.545104] mmc1: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd =
65535
width 0 timing 0
[=A0=A0 24.568298] mmc1: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd =
65535
width 0 timing 0
[=A0=A0 24.569335] mmc1: starting CMD0 arg 00000000 flags 000000c0
[=A0=A0 24.569366] mmci-omap-hs mmci-omap-hs.1: mmc1: CMD0, argument 0x=
00000000
[=A0=A0 24.569519] mmci-omap-hs mmci-omap-hs.1: IRQ Status is 1
[=A0=A0 24.569549] mmc1: req done (CMD0): 0: 00000000 00000000 00000000=
 00000000
[=A0=A0 24.572540] mmc1: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd =
65535
width 0 timing 0
[=A0=A0 24.573547] mmc1: starting CMD8 arg 000000aa flags 000002f5
[=A0=A0 24.573577] mmci-omap-hs mmci-omap-hs.1: mmc1: CMD8, argument 0x=
000000aa
[=A0=A0 24.573913] mmci-omap-hs mmci-omap-hs.1: IRQ Status is 18000
[=A0=A0 24.573913] mmci-omap-hs mmci-omap-hs.1: MMC IRQ 0x18000 : ERRI =
CTO
[=A0=A0 24.573944] mmc1: req done (CMD8): -110: 00000000 00000000 00000=
000
00000000
[=A0=A0 24.575744] mmc1: starting CMD5 arg 00000000 flags 000002e1
[=A0=A0 24.575775] mmci-omap-hs mmci-omap-hs.1: mmc1: CMD5, argument 0x=
00000000
[=A0=A0 24.576110] mmci-omap-hs mmci-omap-hs.1: IRQ Status is 18000
[=A0=A0 24.576141] mmci-omap-hs mmci-omap-hs.1: MMC IRQ 0x18000 : ERRI =
CTO
[=A0=A0 24.576171] mmc1: req failed (CMD5): -110, retrying...
[=A0=A0 24.576171] mmci-omap-hs mmci-omap-hs.1: mmc1: CMD5, argument 0x=
00000000
[=A0=A0 24.576507] mmci-omap-hs mmci-omap-hs.1: IRQ Status is 18000
[=A0=A0 24.576538] mmci-omap-hs mmci-omap-hs.1: MMC IRQ 0x18000 : ERRI =
CTO
[=A0=A0 24.576568] mmc1: req failed (CMD5): -110, retrying...
[=A0=A0 24.576568] mmci-omap-hs mmci-omap-hs.1: mmc1: CMD5, argument 0x=
00000000
[=A0=A0 24.576904] mmci-omap-hs mmci-omap-hs.1: IRQ Status is 18000
[=A0=A0 24.576934] mmci-omap-hs mmci-omap-hs.1: MMC IRQ 0x18000 : ERRI =
CTO
[=A0=A0 24.576934] mmc1: req failed (CMD5): -110, retrying...
[=A0=A0 24.576965] mmci-omap-hs mmci-omap-hs.1: mmc1: CMD5, argument 0x=
00000000
[=A0=A0 24.577301] mmci-omap-hs mmci-omap-hs.1: IRQ Status is 18000
[=A0=A0 24.577331] mmci-omap-hs mmci-omap-hs.1: MMC IRQ 0x18000 : ERRI =
CTO
[=A0=A0 24.577331] mmc1: req done (CMD5): -110: 00000000 00000000 00000=
000
00000000
[=A0=A0 24.578247] mmc1: starting CMD55 arg 00000000 flags 000000f5
[=A0=A0 24.578247] mmci-omap-hs mmci-omap-hs.1: mmc1: CMD55, argument 0=
x00000000
[=A0=A0 24.578582] mmci-omap-hs mmci-omap-hs.1: IRQ Status is 18000
[=A0=A0 24.578613] mmci-omap-hs mmci-omap-hs.1: MMC IRQ 0x18000 : ERRI =
CTO
[=A0=A0 24.578643] mmc1: req done (CMD55): -110: 00000000 00000000 0000=
0000
00000000
[=A0=A0 24.580444] mmc1: starting CMD55 arg 00000000 flags 000000f5
[=A0=A0 24.580474] mmci-omap-hs mmci-omap-hs.1: mmc1: CMD55, argument 0=
x00000000
[=A0=A0 24.580810] mmci-omap-hs mmci-omap-hs.1: IRQ Status is 18000
[=A0=A0 24.580810] mmci-omap-hs mmci-omap-hs.1: MMC IRQ 0x18000 : ERRI =
CTO
[=A0=A0 24.580841] mmc1: req done (CMD55): -110: 00000000 00000000 0000=
0000
00000000
[=A0=A0 24.582641] mmc1: starting CMD55 arg 00000000 flags 000000f5
[=A0=A0 24.582672] mmci-omap-hs mmci-omap-hs.1: mmc1: CMD55, argument 0=
x00000000
[=A0=A0 24.583007] mmci-omap-hs mmci-omap-hs.1: IRQ Status is 18000
[=A0=A0 24.583007] mmci-omap-hs mmci-omap-hs.1: MMC IRQ 0x18000 : ERRI =
CTO
[=A0=A0 24.583038] mmc1: req done (CMD55): -110: 00000000 00000000 0000=
0000
00000000
[=A0=A0 24.584899] mmc1: starting CMD55 arg 00000000 flags 000000f5
[=A0=A0 24.584899] mmci-omap-hs mmci-omap-hs.1: mmc1: CMD55, argument 0=
x00000000
[=A0=A0 24.585235] mmci-omap-hs mmci-omap-hs.1: IRQ Status is 18000
[=A0=A0 24.585266] mmci-omap-hs mmci-omap-hs.1: MMC IRQ 0x18000 : ERRI =
CTO
[=A0=A0 24.585296] mmc1: req done (CMD55): -110: 00000000 00000000 0000=
0000
00000000
[=A0=A0 24.587097] mmc1: starting CMD1 arg 00000000 flags 000000e1
[=A0=A0 24.587097] mmci-omap-hs mmci-omap-hs.1: mmc1: CMD1, argument 0x=
00000000
[=A0=A0 24.587432] mmci-omap-hs mmci-omap-hs.1: IRQ Status is 18000
[=A0=A0 24.587463] mmci-omap-hs mmci-omap-hs.1: MMC IRQ 0x18000 : ERRI =
CTO
[=A0=A0 24.587493] mmc1: req done (CMD1): -110: 00000000 00000000 00000=
000
00000000
[=A0=A0 24.589294] mmc1: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 wid=
th 0
timing 0
[=A0=A0 24.623962] mmci-omap-hs mmci-omap-hs.1: ENABLED -> DISABLED

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

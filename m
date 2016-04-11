From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 00/10] ARM: DTS/clk: DRA7 family: enable eDMA and audio
 updates
Date: Mon, 11 Apr 2016 16:33:22 +0300
Message-ID: <570BA7A2.3080507@ti.com>
References: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, paul@pwsan.com, robh+dt@kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Tony,

according to Nishanth, linux-next is broken for dra7 family:
http://pastebin.ubuntu.com/15758542/ on x15 next-20160411
because of the missing DT patches.
Do you want me to resend this series w/o the hwmod patch?

--=20
P=E9ter

On 03/07/16 17:17, Peter Ujfalusi wrote:
> Hi,
>=20
> Changes since v1:
> - hwmod patch for eDMA (tpcc/tptc0/tptc1) removed as it is already in=
 linux-next
> - mcasp hwmod changes:
>  - all module have HWMOD_OPT_CLKS_NEEDED and no HWMOD_SWSUP_SIDLE (pe=
r Paul's
>    comment)
>  - mcasp1,2: add ahclkr as opt clock since those modules have fclk, a=
hclkx and
>    ahclkr marked as functional clocks.
>    Same change is added to the DTS patch
>=20
> On dra7 family we have two DMA engine available: sDMA (omap-dma) and =
eDMA.
> For some peripherals the use of eDMA is better due to L3 interconnect=
 limitation
> when using sDMA. Such peripherals are McASP1/2/3. By switching to eDM=
A we can
> enable the AFIFO which will help to avoid under or overruns in audio.
>=20
> This set will:
> - add the hwmod data for eDMA TPCC and TPTCs
> - add the needed DT nodes for eDMA and the crossbar
> - we will enable the AFIFO use for audio
> - add hwmod data and DT nodes for all McASP ports
> - Fix the beagle-x15's clkout2 parent setting for the codec
>=20
> The patch set has been tested on top of linux-next.
>=20
> Regards,
> Peter
> ---
> Misael Lopez Cruz (1):
>   ARM: DTS: dra7: Use eDMA and add DAT port address for McASP3
>=20
> Peter Ujfalusi (9):
>   ARM: DTS: dra7: Move the sDMA crossbar node under l4_cfg/scm
>   ARM: DTS: dra7: Enable eDMA
>   ARM: DTS: dra7-evm: Enable AFIFO use for McASP3
>   ARM: DTS: dra72-evm: Enable AFIFO use for McASP3
>   ARM: DTS: am57xx-beagle-x15: Move clkout2 source selection to codec
>     node
>   ARM: DTS: am57xx-beagle-x15: Enable AFIFO use for McASP3
>   ARM: clk: dra7xx: Correct mcasp8_ahclkx_mux name
>   ARM: DRA7: hwmod: Add data for McASP1/2/4/5/6/7/8
>   ARM: DTS: dra7: Add nodes for McASP1/2/4/5/6/7/8
>=20
>  arch/arm/boot/dts/am57xx-beagle-x15.dts   |   7 +-
>  arch/arm/boot/dts/dra7-evm.dts            |   2 +
>  arch/arm/boot/dts/dra7.dtsi               | 183 ++++++++++++++++++++=
+--
>  arch/arm/boot/dts/dra72-evm.dts           |   2 +
>  arch/arm/boot/dts/dra7xx-clocks.dtsi      |   2 +-
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 237 ++++++++++++++++++++=
++++++++++
>  drivers/clk/ti/clk-7xx.c                  |   2 +-
>  7 files changed, 421 insertions(+), 14 deletions(-)
>=20

From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 00/10] ARM: DTS/clk: DRA7 family: enable eDMA and audio updates
Date: Mon, 7 Mar 2016 17:17:27 +0200
Message-ID: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

Changes since v1:
- hwmod patch for eDMA (tpcc/tptc0/tptc1) removed as it is already in linux-next
- mcasp hwmod changes:
 - all module have HWMOD_OPT_CLKS_NEEDED and no HWMOD_SWSUP_SIDLE (per Paul's
   comment)
 - mcasp1,2: add ahclkr as opt clock since those modules have fclk, ahclkx and
   ahclkr marked as functional clocks.
   Same change is added to the DTS patch

On dra7 family we have two DMA engine available: sDMA (omap-dma) and eDMA.
For some peripherals the use of eDMA is better due to L3 interconnect limitation
when using sDMA. Such peripherals are McASP1/2/3. By switching to eDMA we can
enable the AFIFO which will help to avoid under or overruns in audio.

This set will:
- add the hwmod data for eDMA TPCC and TPTCs
- add the needed DT nodes for eDMA and the crossbar
- we will enable the AFIFO use for audio
- add hwmod data and DT nodes for all McASP ports
- Fix the beagle-x15's clkout2 parent setting for the codec

The patch set has been tested on top of linux-next.

Regards,
Peter
---
Misael Lopez Cruz (1):
  ARM: DTS: dra7: Use eDMA and add DAT port address for McASP3

Peter Ujfalusi (9):
  ARM: DTS: dra7: Move the sDMA crossbar node under l4_cfg/scm
  ARM: DTS: dra7: Enable eDMA
  ARM: DTS: dra7-evm: Enable AFIFO use for McASP3
  ARM: DTS: dra72-evm: Enable AFIFO use for McASP3
  ARM: DTS: am57xx-beagle-x15: Move clkout2 source selection to codec
    node
  ARM: DTS: am57xx-beagle-x15: Enable AFIFO use for McASP3
  ARM: clk: dra7xx: Correct mcasp8_ahclkx_mux name
  ARM: DRA7: hwmod: Add data for McASP1/2/4/5/6/7/8
  ARM: DTS: dra7: Add nodes for McASP1/2/4/5/6/7/8

 arch/arm/boot/dts/am57xx-beagle-x15.dts   |   7 +-
 arch/arm/boot/dts/dra7-evm.dts            |   2 +
 arch/arm/boot/dts/dra7.dtsi               | 183 +++++++++++++++++++++--
 arch/arm/boot/dts/dra72-evm.dts           |   2 +
 arch/arm/boot/dts/dra7xx-clocks.dtsi      |   2 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 237 ++++++++++++++++++++++++++++++
 drivers/clk/ti/clk-7xx.c                  |   2 +-
 7 files changed, 421 insertions(+), 14 deletions(-)

-- 
2.7.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

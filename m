From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 00/11] ARM: DTS/clk: DRA7 family: enable eDMA and audio updates
Date: Thu, 25 Feb 2016 16:50:16 +0200
Message-ID: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, paul@pwsan.com, robh+dt@kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

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

Peter Ujfalusi (10):
  ARM: DTS: dra7: Move the sDMA crossbar node under l4_cfg/scm
  ARM: DRA7: hwmod: Add data for eDMA tpcc, tptc0, tptc1
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
 arch/arm/boot/dts/dra7.dtsi               | 181 ++++++++++++++++-
 arch/arm/boot/dts/dra72-evm.dts           |   2 +
 arch/arm/boot/dts/dra7xx-clocks.dtsi      |   2 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 323 ++++++++++++++++++++++++++++++
 drivers/clk/ti/clk-7xx.c                  |   2 +-
 7 files changed, 505 insertions(+), 14 deletions(-)

-- 
2.7.1

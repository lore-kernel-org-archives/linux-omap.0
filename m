From: "Derald D. Woods" <woods.technical@gmail.com>
Subject: [PATCH v2 0/4] Update TMDSEVM3530 support for omap3-evm
Date: Mon, 11 Sep 2017 22:46:55 -0500
Message-ID: <20170912034659.13184-1-woods.technical@gmail.com>
References: <20170903003816.5536-1-woods.technical@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170903003816.5536-1-woods.technical@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, "Derald D. Woods" <woods.technical@gmail.com>
List-Id: linux-omap@vger.kernel.org

This patch set allows TMDSEVM3530(omap3-evm.dts) to boot using common
processor module data that is shared with 'omap3-evm-37xx.dts'. A new
common file for processor module data is introduced to help facilitate
the updated OMAP3530 support.

Changes in v2
-------------
- Pull in change from linux-next
  (ARM: dts: omap*: Replace deprecated "vmmc_aux" with "vqmmc")
- Add compatible and supply fix for LCD panel
- Add supply references for DSS
- Add "Signed-off-by" for each patch

Derald D. Woods (4):
  ARM: dts: omap3-evm-37xx: Add common processor module support
  ARM: dts: omap3-evm: Add OMAP3530 specific device tree processor data
  ARM: dts: omap3: Fix Sharp LS037V7DW01 compatible string and envdd
    supply
  ARM: dts: omap3-evm: Add DSS {vdds_dsi,vdda_video}-supply references

 arch/arm/boot/dts/omap3-evm-37xx.dts               | 209 +-------------------
 arch/arm/boot/dts/omap3-evm-processor-common.dtsi  | 216 +++++++++++++++++++++
 arch/arm/boot/dts/omap3-evm.dts                    |  76 +++++++-
 .../boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi    |   3 +-
 4 files changed, 291 insertions(+), 213 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-evm-processor-common.dtsi

-- 
2.14.1

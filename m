From: "Derald D. Woods" <woods.technical@gmail.com>
Subject: [PATCH 0/2] Update TMDSEVM3530 support for omap3-evm
Date: Sat,  2 Sep 2017 19:38:14 -0500
Message-ID: <20170903003816.5536-1-woods.technical@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, "Derald D. Woods" <woods.technical@gmail.com>
List-Id: linux-omap@vger.kernel.org

This patch set allows TMDSEVM3530(omap3-evm.dts) to boot using common
processor module data that is shared with 'omap3-evm-37xx.dts'. A new
common file for processor module data is introduced to help facilitate
the updated OMAP3530 support.

Derald D. Woods (2):
  ARM: dts: omap3-evm-37xx: Add common processor module support
  ARM: dts: omap3-evm: Add OMAP3530 specific device tree processor data

 arch/arm/boot/dts/omap3-evm-37xx.dts              | 209 +--------------------
 arch/arm/boot/dts/omap3-evm-processor-common.dtsi | 214 ++++++++++++++++++++++
 arch/arm/boot/dts/omap3-evm.dts                   |  76 +++++++-
 3 files changed, 287 insertions(+), 212 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-evm-processor-common.dtsi

-- 
2.14.1

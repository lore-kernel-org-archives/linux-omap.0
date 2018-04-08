From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 0/3] Add MCAN Support for dra76x
Date: Sun, 8 Apr 2018 15:28:59 +0530
Message-ID: <1523181542-3770-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, paul@pwsan.com, lokeshvutla@ti.com, faiz_abbas@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

The following patches add dts and hwmod support for MCAN in TI's
dra76 SOCs.

The patches depend on the following series:
https://patchwork.kernel.org/patch/10221105/

Tested on linux-next

Franklin S Cooper Jr (1):
  ARM: dts: dra76x: Add MCAN node

Lokesh Vutla (2):
  ARM: dra762: hwmod: Add MCAN support
  ARM: dts: dra762: Add MCAN clock support

 arch/arm/boot/dts/dra76-evm.dts           |  7 +++++
 arch/arm/boot/dts/dra76x.dtsi             | 50 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 32 ++++++++++++++++++++
 3 files changed, 89 insertions(+)

-- 
2.7.4

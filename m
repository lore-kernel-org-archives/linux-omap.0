From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 0/2] arm: hwmod: dra7: Add PCIe data and PCIe PHY data
Date: Wed, 25 Jun 2014 23:32:44 +0530
Message-ID: <1403719366-9656-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, linux@arm.linux.org.uk, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kishon@ti.com
List-Id: linux-omap@vger.kernel.org

[1] is split into separate series in order for individual subsystem
Maintainers to pick up the patches. This series handles the PCIe
hwmod data for DRA7.

Please find the bootlog with these hwmod patches @ [2]

[1] -> https://lkml.org/lkml/2014/5/29/258
[2] -> http://paste.ubuntu.com/7701601/

Kishon Vijay Abraham I (2):
  arm: dra7xx: Add hwmod data for pcie1 phy and pcie2 phy
  arm: dra7xx: Add hwmod data for pcie1 and pcie2 subsystems

 arch/arm/mach-omap2/cm2_7xx.h             |    4 ++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  112 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm7xx.h              |    4 ++
 3 files changed, 120 insertions(+)

-- 
1.7.9.5

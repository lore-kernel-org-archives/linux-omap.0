From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 0/3] dra7xx: get pcie working in mainline
Date: Wed, 13 Jan 2016 12:17:43 +0530
Message-ID: <1452667666-17533-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Bjorn Helgaas <bhelgaas@google.com>, richardcochran@gmail.com
Cc: Russell King <linux@arm.linux.org.uk>, Suman Anna <s-anna@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kishon@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

This series adds pdata-quirk mechanism to reset PCIe as a temporary
fix till reset controller driver is added in mainline.

Without this series, a stall is observed if pci dra7xx driver
is enabled.

Changes from v1:
*) Removed 'HACK' from $subject
*) removed reviewed-by Suman

Kishon Vijay Abraham I (3):
  ARM: DRA7: hwmod: Add reset data for PCIe
  ARM: DRA7: add pdata-quirks to do reset of PCIe
  pci: dra7xx: use pdata callbacks to perform reset

 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |   15 ++++++++++++++
 arch/arm/mach-omap2/pdata-quirks.c        |   11 ++++++++++
 arch/arm/mach-omap2/prm7xx.h              |    1 +
 drivers/pci/host/pci-dra7xx.c             |   32 +++++++++++++++++++++++++++++
 include/linux/platform_data/pci-dra7xx.h  |   22 ++++++++++++++++++++
 5 files changed, 81 insertions(+)
 create mode 100644 include/linux/platform_data/pci-dra7xx.h

-- 
1.7.9.5

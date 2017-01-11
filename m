From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 0/5] PCI: dwc: miscellaneous cleanups and fixes
Date: Wed, 11 Jan 2017 17:36:50 +0530
Message-ID: <1484136415-20798-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

This series includes miscellaneous cleanups and fixes in dra7xx
pci driver and it also adds COMPILE_TEST to all designware
based drivers (except dra7xx driver and hisi driver), since
dra7xx driver doesn't depend on architecture specific config and
hisi driver is compiled based on only ARM64.

These patches have been created after applying [1].

[1] -> https://lkml.org/lkml/2017/1/6/246

Kishon Vijay Abraham I (5):
  PCI: dwc: Add COMPILE_TEST to all designware based drivers
  PCI: dwc: dra7xx: Simplify the probe code
  PCI: dwc: dra7xx: Add support to force RC to work in GEN1 mode
  PCI: dwc: dra7xx: Enable MSI and legacy interrupts simultaneously
  PCI: dwc: dra7xx: Group phy API invocations

 drivers/pci/dwc/Kconfig      |   16 ++--
 drivers/pci/dwc/pci-dra7xx.c |  174 ++++++++++++++++++++++++------------------
 2 files changed, 106 insertions(+), 84 deletions(-)

-- 
1.7.9.5

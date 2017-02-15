From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 00/10] PCI: dwc: Rework and cleanup designware driver
Date: Wed, 15 Feb 2017 18:48:09 +0530
Message-ID: <1487164699-30708-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@axis.com
Cc: nsekhar@ti.com, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

This series reworks designware driver in preparation for adding endpoint
mode support to designware driver.

This series was previously sent as part of endpoint support series
https://lkml.org/lkml/2017/1/13/562

Validate pci host only in pci-dra7xx. Any help in validating other
platforms would be highly appreciated.

This series is created after cherrypicking the following patch and
then applying pci/host-designware.

commit a782b5f986c3fa1cfa7f2b57941200c6a5809242
Author: Murali Karicheri <m-karicheri2@ti.com>
Date:   Wed Jan 4 14:32:30 2017 -0500

    PCI: designware: Check for iATU unroll only on platforms that use ATU

The patches has been pushed to
git://git.ti.com/linux-phy/linux-phy.git dwc-rework

Kishon Vijay Abraham I (10):
  PCI: dwc: designware: Move the register defines to designware header
    file
  PCI: dwc: *all*: Add platform_set_drvdata
  PCI: dwc: *all*: Rename cfg_read/cfg_write to read/write
  PCI: dwc: designware: Get device pointer at the start of
    dw_pcie_host_init
  PCI: dwc: *all*: Split *struct pcie_port* into host only and core
    structures
  PCI: dwc: designware: Parse *num-lanes* property in dw_pcie_setup_rc
  PCI: dwc: designware: Fix style errors in pcie-designware.c
  PCI: dwc: Split pcie-designware.c into host and core files
  PCI: dwc: Create a new config symbol to enable pci dwc host
  PCI: dwc: Remove dependency of designware to CONFIG_PCI

 drivers/Makefile                       |    3 +
 drivers/pci/Makefile                   |    3 -
 drivers/pci/dwc/Kconfig                |   39 +-
 drivers/pci/dwc/Makefile               |    1 +
 drivers/pci/dwc/pci-dra7xx.c           |   91 ++--
 drivers/pci/dwc/pci-exynos.c           |   81 ++--
 drivers/pci/dwc/pci-imx6.c             |  131 ++---
 drivers/pci/dwc/pci-keystone-dw.c      |   87 ++--
 drivers/pci/dwc/pci-keystone.c         |   56 ++-
 drivers/pci/dwc/pci-keystone.h         |    4 +-
 drivers/pci/dwc/pci-layerscape.c       |   93 ++--
 drivers/pci/dwc/pcie-armada8k.c        |   87 ++--
 drivers/pci/dwc/pcie-artpec6.c         |   50 +-
 drivers/pci/dwc/pcie-designware-host.c |  635 ++++++++++++++++++++++++
 drivers/pci/dwc/pcie-designware-plat.c |   29 +-
 drivers/pci/dwc/pcie-designware.c      |  823 +++-----------------------------
 drivers/pci/dwc/pcie-designware.h      |  170 +++++--
 drivers/pci/dwc/pcie-hisi.c            |   57 ++-
 drivers/pci/dwc/pcie-qcom.c            |   72 ++-
 drivers/pci/dwc/pcie-spear13xx.c       |   85 ++--
 20 files changed, 1434 insertions(+), 1163 deletions(-)
 create mode 100644 drivers/pci/dwc/pcie-designware-host.c

-- 
1.7.9.5

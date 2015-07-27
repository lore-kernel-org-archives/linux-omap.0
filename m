From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 0/3] dra7xx: Add PM support to PCIe
Date: Mon, 27 Jul 2015 11:54:51 +0530
Message-ID: <1437978294-22317-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: bhelgaas@google.com, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

This series adds PM support to pci-dra7xx so that PCI clocks can be disabled
during suspend and enabled back during resume without affecting
PCI functionality.

Changes from v2:
*) Used SET_SYSTEM_SLEEP_PM_OPS and SET_NOIRQ_SYSTEM_SLEEP_PM_OPS for
   populating PM ops.

Changes from v1:
*) Moved resetting and setting of MSE bit to pci-dra7xx.

The comment to reset and set ISE is not done now since I don't have a card
with IO space. Once I get to test that, I'll post a separate patch for
handling that.

Kishon Vijay Abraham I (3):
  PCI: host: pci-dra7xx: Disable pm_runtime on get_sync failure
  PCI: host: pci-dra7xx: add pm support to pci dra7xx
  PCI: host: pci-dra7xx: Idle the module by disabling MSE bit

 drivers/pci/host/pci-dra7xx.c |   95 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

-- 
1.7.9.5

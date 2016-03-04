From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH RESEND] Revert "PCI: dra7xx: Mark driver as broken"
Date: Fri, 4 Mar 2016 15:59:19 +0530
Message-ID: <1457087359-16816-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-pci@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kishon@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

From: Sekhar Nori <nsekhar@ti.com>

This reverts commit <5c3b99d057525fe2befe6a7db9b1309035d93eee>
("PCI: dra7xx: Mark driver as broken").

With support to de-assert PCIe reset present in kernel,
DRA7x PCIe is not broken anymore.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Bjorn,

This patch should be merged only after [1] hits linus tree.

Thanks
Kishon

[1] -> git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git
	for-v4.6/omap-hwmod-b

 drivers/pci/host/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 75a6054..6d181ba 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -5,7 +5,6 @@ config PCI_DRA7XX
 	bool "TI DRA7xx PCIe controller"
 	select PCIE_DW
 	depends on OF && HAS_IOMEM && TI_PIPE3
-	depends on BROKEN
 	help
 	 Enables support for the PCIe controller in the DRA7xx SoC.  There
 	 are two instances of PCIe controller in DRA7xx.  This controller can
-- 
1.7.9.5

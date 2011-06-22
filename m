From: Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 1/2] iommu: Move iommu Kconfig entries to submenu
Date: Wed, 22 Jun 2011 12:16:45 +0200
Message-ID: <1308737806-2658-2-git-send-email-joerg.roedel@amd.com>
References: <1307742947-32118-1-git-send-email-ohad@wizery.com>
 <1308737806-2658-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1308737806-2658-1-git-send-email-joerg.roedel@amd.com>
Sender: linux-pci-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de, davidb@codeaurora.org, dwmw2@infradead.org, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>
List-Id: linux-omap@vger.kernel.org

For better navigation this patch moves the drivers/iommu
drivers into its own submenu in Kconfig.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 drivers/iommu/Kconfig |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e2a5f14..b57b3fa 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -2,6 +2,17 @@
 config IOMMU_API
 	bool
 
+menuconfig IOMMU_SUPPORT
+	bool "IOMMU Hardware Support"
+	default y
+	---help---
+	  Say Y here if you want to compile device drivers for IO Memory
+	  Management Units into the kernel. These devices usually allow to
+	  remap DMA requests and/or remap interrupts from other devices on the
+	  system.
+
+if IOMMU_SUPPORT
+
 # MSM IOMMU support
 config MSM_IOMMU
 	bool "MSM IOMMU Support"
@@ -95,3 +106,5 @@ config INTR_REMAP
 	  Supports Interrupt remapping for IO-APIC and MSI devices.
 	  To use x2apic mode in the CPU's which support x2APIC enhancements or
 	  to support platforms with CPU's having > 8 bit APIC ID, say Y.
+
+endif # IOMMU_SUPPORT
-- 
1.7.4.1

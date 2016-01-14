From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 2/3] ARM: DRA7: add pdata-quirks to do reset of PCIe
Date: Thu, 14 Jan 2016 19:41:11 +0530
Message-ID: <1452780672-14339-3-git-send-email-kishon@ti.com>
References: <1452780672-14339-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452780672-14339-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Bjorn Helgaas <bhelgaas@google.com>, richardcochran@gmail.com
Cc: Russell King <linux@arm.linux.org.uk>, Suman Anna <s-anna@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kishon@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Create platform data for PCIe and populate it with function
pointers to perform assert and deassert of PCIe reset lines.
The PCIe driver can use the callbacks provided here to
reset the PCIe.
This will be removed once the reset contoller driver is
available to reset PCIe.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-omap2/pdata-quirks.c       |   11 +++++++++++
 include/linux/platform_data/pci-dra7xx.h |   29 +++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 include/linux/platform_data/pci-dra7xx.h

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 5814477..f5a65fe 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -23,6 +23,7 @@
 #include <linux/platform_data/pinctrl-single.h>
 #include <linux/platform_data/iommu-omap.h>
 #include <linux/platform_data/wkup_m3.h>
+#include <linux/platform_data/pci-dra7xx.h>
 
 #include "common.h"
 #include "common-board-devices.h"
@@ -404,6 +405,14 @@ static void __init omap5_uevm_legacy_init(void)
 }
 #endif
 
+#ifdef CONFIG_SOC_DRA7XX
+static struct pci_dra7xx_platform_data dra7xx_pci_pdata = {
+	.reset_name = "pcie",
+	.assert_reset = omap_device_assert_hardreset,
+	.deassert_reset = omap_device_deassert_hardreset,
+};
+#endif
+
 static struct pcs_pdata pcs_pdata;
 
 void omap_pcs_legacy_init(int irq, void (*rearm)(void))
@@ -474,6 +483,8 @@ static struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 #endif
 #ifdef CONFIG_SOC_DRA7XX
 	OF_DEV_AUXDATA("ti,dra7-padconf", 0x4a003400, "4a003400.pinmux", &pcs_pdata),
+	OF_DEV_AUXDATA("ti,dra7-pcie", 0x51000000, "51000000.pcie", &dra7xx_pci_pdata),
+	OF_DEV_AUXDATA("ti,dra7-pcie", 0x51800000, "51800000.pcie", &dra7xx_pci_pdata),
 #endif
 #ifdef CONFIG_SOC_AM43XX
 	OF_DEV_AUXDATA("ti,am437-padconf", 0x44e10800, "44e10800.pinmux", &pcs_pdata),
diff --git a/include/linux/platform_data/pci-dra7xx.h b/include/linux/platform_data/pci-dra7xx.h
new file mode 100644
index 0000000..a3bab6b
--- /dev/null
+++ b/include/linux/platform_data/pci-dra7xx.h
@@ -0,0 +1,29 @@
+/*
+ * pcie-dra7xx - Platform data for PCIe controller
+ *
+ * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * Authors: Kishon Vijay Abraham I <kishon@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __PCI_DRA7XX_H
+#define __PCI_DRA7XX_H
+
+/**
+ * struct pci_dra7xx_platform_data - platform data specific to pci in dra7xx
+ * @reset_name: name of the reset line
+ * @assert_reset: callback for performing assert reset operation
+ * @deassert_reset: callback for performing deassert reset operation
+ */
+struct pci_dra7xx_platform_data {
+	const char *reset_name;
+
+	int (*assert_reset)(struct platform_device *pdev, const char *name);
+	int (*deassert_reset)(struct platform_device *pdev, const char *name);
+};
+
+#endif /* __PCI_DRA7XX_H */
-- 
1.7.9.5

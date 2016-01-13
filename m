From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 3/3] pci: dra7xx: use pdata callbacks to perform reset
Date: Wed, 13 Jan 2016 12:17:46 +0530
Message-ID: <1452667666-17533-4-git-send-email-kishon@ti.com>
References: <1452667666-17533-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452667666-17533-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Bjorn Helgaas <bhelgaas@google.com>, richardcochran@gmail.com
Cc: Russell King <linux@arm.linux.org.uk>, Suman Anna <s-anna@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kishon@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Use platform populated reset assert and deassert
callbacks to perform reset of PCIe.

Use these callbacks until a reset interface using drivers/reset
is available for the purpose.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/pci/host/pci-dra7xx.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 8c36880..049083d 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -25,6 +25,8 @@
 #include <linux/resource.h>
 #include <linux/types.h>
 
+#include <linux/platform_data/pci-dra7xx.h>
+
 #include "pcie-designware.h"
 
 /* PCIe controller wrapper DRA7XX configuration registers */
@@ -329,6 +331,32 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 	return 0;
 }
 
+static int dra7xx_pcie_reset(struct platform_device *pdev)
+{
+	int ret;
+	struct device *dev = &pdev->dev;
+	struct pci_dra7xx_platform_data *pdata = pdev->dev.platform_data;
+
+	if (!(pdata && pdata->deassert_reset && pdata->assert_reset)) {
+		dev_err(dev, "platform data for reset not found!\n");
+		return -EINVAL;
+	}
+
+	ret = pdata->assert_reset(pdev, pdata->reset_name);
+	if (ret) {
+		dev_err(dev, "assert_reset failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = pdata->deassert_reset(pdev, pdata->reset_name);
+	if (ret) {
+		dev_err(dev, "deassert_reset failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 {
 	u32 reg;
@@ -347,6 +375,10 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	enum of_gpio_flags flags;
 	unsigned long gpio_flags;
 
+	ret = dra7xx_pcie_reset(pdev);
+	if (ret)
+		return ret;
+
 	dra7xx = devm_kzalloc(dev, sizeof(*dra7xx), GFP_KERNEL);
 	if (!dra7xx)
 		return -ENOMEM;
-- 
1.7.9.5

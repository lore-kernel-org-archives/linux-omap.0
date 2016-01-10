From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 3/3] HACK: pci: dra7xx: use pdata callbacks to perform reset
Date: Sun, 10 Jan 2016 21:11:28 +0530
Message-ID: <1452440488-28398-4-git-send-email-kishon@ti.com>
References: <1452440488-28398-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1452440488-28398-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Bjorn Helgaas <bhelgaas@google.com>, richardcochran@gmail.com
Cc: Russell King <linux@arm.linux.org.uk>, nsekhar@ti.com, linux-kernel@vger.kernel.org, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Use platform populated reset assert and deassert
callbacks to perform reset of PCIe.

Use these callbacks until a reset interface using drivers/reset
is available for the purpose.

Reviewed-by: Suman Anna <s-anna@ti.com>
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

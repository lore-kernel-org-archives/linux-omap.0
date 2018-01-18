From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] PCI: dra7xx: Fix potential NULL dereference
Date: Thu, 18 Jan 2018 14:00:37 +0000
Message-ID: <1516284037-81537-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

platform_get_resource_byname() may fail and return NULL, so we should
better check it's return value to avoid a NULL pointer dereference a
bit later in the code.

This is detected by Coccinelle semantic patch.

@@
expression pdev, res, n, t, e, e1, e2;
@@

res = platform_get_resource_byname(pdev, t, n);
+ if (!res)
+   return -EINVAL;
... when != res == NULL
e = devm_ioremap(e1, res->start, e2);

Fixes: 608793e27b33 ("PCI: dwc: dra7xx: Add EP mode support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/dwc/pci-dra7xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 8bf7c27..aafded8 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -409,11 +409,15 @@ static int __init dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
 	ep->ops = &pcie_ep_ops;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics");
+	if (!res)
+		return -EINVAL;
 	pci->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
 	if (!pci->dbi_base)
 		return -ENOMEM;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics2");
+	if (!res)
+		return -EINVAL;
 	pci->dbi_base2 = devm_ioremap(dev, res->start, resource_size(res));
 	if (!pci->dbi_base2)
 		return -ENOMEM;
@@ -462,6 +466,8 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 		return ret;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbics");
+	if (!res)
+		return -EINVAL;
 	pci->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
 	if (!pci->dbi_base)
 		return -ENOMEM;

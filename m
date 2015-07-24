From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 1/3] PCI: host: pci-dra7xx: Disable pm_runtime on get_sync failure
Date: Fri, 24 Jul 2015 17:23:08 +0530
Message-ID: <1437738790-11114-2-git-send-email-kishon@ti.com>
References: <1437738790-11114-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437738790-11114-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bhelgaas@google.com, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Fix the error handling code in case pm_runtime_get_sync fails. Now
when pm_runtime_get_sync fails pm_runtime_disable is invoked so that
there is no unbalanced pm_runtime_enable calls.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/host/pci-dra7xx.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 80db09e..d8b6d66 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -384,7 +384,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(dev);
 	if (IS_ERR_VALUE(ret)) {
 		dev_err(dev, "pm_runtime_get_sync failed\n");
-		goto err_phy;
+		goto err_get_sync;
 	}
 
 	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
@@ -401,6 +401,8 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 
 err_add_port:
 	pm_runtime_put(dev);
+
+err_get_sync:
 	pm_runtime_disable(dev);
 
 err_phy:
-- 
1.7.9.5

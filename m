From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 11/20] mfd: rdc321x: Use devm_mfd_add_devices() for mfd_device registration
Date: Tue, 5 Apr 2016 17:18:23 +0530
Message-ID: <1459856912-17859-12-git-send-email-ldewangan@nvidia.com>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net
Cc: andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>, Florian Fainelli <florian@openwrt.org>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for mfd devices registration and get
rid of .remove callback to remove mfd devices. This is done
by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Florian Fainelli <florian@openwrt.org>
---
 drivers/mfd/rdc321x-southbridge.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mfd/rdc321x-southbridge.c b/drivers/mfd/rdc321x-southbridge.c
index 6575585..3ddb644 100644
--- a/drivers/mfd/rdc321x-southbridge.c
+++ b/drivers/mfd/rdc321x-southbridge.c
@@ -85,16 +85,11 @@ static int rdc321x_sb_probe(struct pci_dev *pdev,
 	rdc321x_gpio_pdata.sb_pdev = pdev;
 	rdc321x_wdt_pdata.sb_pdev = pdev;
 
-	return mfd_add_devices(&pdev->dev, -1,
+	return devm_mfd_add_devices(&pdev->dev, -1,
 			       rdc321x_sb_cells, ARRAY_SIZE(rdc321x_sb_cells),
 			       NULL, 0, NULL);
 }
 
-static void rdc321x_sb_remove(struct pci_dev *pdev)
-{
-	mfd_remove_devices(&pdev->dev);
-}
-
 static const struct pci_device_id rdc321x_sb_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_RDC, PCI_DEVICE_ID_RDC_R6030) },
 	{}
@@ -105,7 +100,6 @@ static struct pci_driver rdc321x_sb_driver = {
 	.name		= "RDC321x Southbridge",
 	.id_table	= rdc321x_sb_table,
 	.probe		= rdc321x_sb_probe,
-	.remove		= rdc321x_sb_remove,
 };
 
 module_pci_driver(rdc321x_sb_driver);
-- 
2.1.4

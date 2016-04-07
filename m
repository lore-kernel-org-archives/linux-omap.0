From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 11/20] mfd: rdc321x: Use devm_mfd_add_devices() for mfd_device registration
Date: Fri, 8 Apr 2016 00:13:05 +0530
Message-ID: <1460054594-32325-12-git-send-email-ldewangan@nvidia.com>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net, andreas.werner@men.de, tony@atomide.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>, Florian Fainelli <florian@openwrt.org>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for MFD devices registration and get
rid of .remove callback to remove MFD child-devices. This is done
by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Florian Fainelli <florian@openwrt.org>

---
Changes from V1:
- Convert mfd to MFD.
- Fix checkpatch --strict error on patch.

 drivers/mfd/rdc321x-southbridge.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/rdc321x-southbridge.c b/drivers/mfd/rdc321x-southbridge.c
index 6575585..2bd8c5b 100644
--- a/drivers/mfd/rdc321x-southbridge.c
+++ b/drivers/mfd/rdc321x-southbridge.c
@@ -85,14 +85,10 @@ static int rdc321x_sb_probe(struct pci_dev *pdev,
 	rdc321x_gpio_pdata.sb_pdev = pdev;
 	rdc321x_wdt_pdata.sb_pdev = pdev;
 
-	return mfd_add_devices(&pdev->dev, -1,
-			       rdc321x_sb_cells, ARRAY_SIZE(rdc321x_sb_cells),
-			       NULL, 0, NULL);
-}
-
-static void rdc321x_sb_remove(struct pci_dev *pdev)
-{
-	mfd_remove_devices(&pdev->dev);
+	return devm_mfd_add_devices(&pdev->dev, -1,
+				    rdc321x_sb_cells,
+				    ARRAY_SIZE(rdc321x_sb_cells),
+				    NULL, 0, NULL);
 }
 
 static const struct pci_device_id rdc321x_sb_table[] = {
@@ -105,7 +101,6 @@ static struct pci_driver rdc321x_sb_driver = {
 	.name		= "RDC321x Southbridge",
 	.id_table	= rdc321x_sb_table,
 	.probe		= rdc321x_sb_probe,
-	.remove		= rdc321x_sb_remove,
 };
 
 module_pci_driver(rdc321x_sb_driver);
-- 
2.1.4


From: Philip Avinash <avinashphilip@ti.com>
Subject: [PATCH 4/4] mtd: nand: omap2: Low power transition support
Date: Wed, 23 Jan 2013 15:15:46 +0530
Message-ID: <1358934346-16822-5-git-send-email-avinashphilip@ti.com>
References: <1358933176-12409-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358933176-12409-1-git-send-email-avinashphilip@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@ti.com, tony@atomide.com, linux@arm.linux.org.uk, dwmw2@infradead.org
Cc: afzal@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, nsekhar@ti.com, gururaja.hebbar@ti.com, Philip Avinash <avinashphilip@ti.com>
List-Id: linux-omap@vger.kernel.org

Add support for Low power transition support in nand driver. Also
ensures the current transaction finishes before going to low power mode
with _suspend support in mtd layer.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
---
 drivers/mtd/nand/omap2.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 8e820dd..790215b 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -2103,9 +2103,28 @@ static int omap_nand_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int omap_nand_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct mtd_info *mtd = platform_get_drvdata(pdev);
+
+	mtd->_suspend(mtd);
+	return 0;
+}
+
+static int omap_nand_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+#endif
+
 static struct platform_driver omap_nand_driver = {
 	.probe		= omap_nand_probe,
 	.remove		= omap_nand_remove,
+#ifdef CONFIG_PM
+	.suspend	= omap_nand_suspend,
+	.resume		= omap_nand_resume,
+#endif
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
-- 
1.7.9.5

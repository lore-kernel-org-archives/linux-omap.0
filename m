From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 05/20] mfd: atmel-hlcdc: Use devm_mfd_add_devices() for mfd_device registration
Date: Fri, 8 Apr 2016 00:12:59 +0530
Message-ID: <1460054594-32325-6-git-send-email-ldewangan@nvidia.com>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net, andreas.werner@men.de, tony@atomide.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for MFD devices registration and get
rid of .remove callback to remove MFD child-devices. This is done
by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

---
Changes from V1:
- Convert mfd to MFD.
- Run checkpatch with --strict option and fix warning.
- Collected acks.

 drivers/mfd/atmel-hlcdc.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
index 06c2058..eca7ea6 100644
--- a/drivers/mfd/atmel-hlcdc.c
+++ b/drivers/mfd/atmel-hlcdc.c
@@ -128,16 +128,9 @@ static int atmel_hlcdc_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, hlcdc);
 
-	return mfd_add_devices(dev, -1, atmel_hlcdc_cells,
-			       ARRAY_SIZE(atmel_hlcdc_cells),
-			       NULL, 0, NULL);
-}
-
-static int atmel_hlcdc_remove(struct platform_device *pdev)
-{
-	mfd_remove_devices(&pdev->dev);
-
-	return 0;
+	return devm_mfd_add_devices(dev, -1, atmel_hlcdc_cells,
+				    ARRAY_SIZE(atmel_hlcdc_cells),
+				    NULL, 0, NULL);
 }
 
 static const struct of_device_id atmel_hlcdc_match[] = {
@@ -152,7 +145,6 @@ MODULE_DEVICE_TABLE(of, atmel_hlcdc_match);
 
 static struct platform_driver atmel_hlcdc_driver = {
 	.probe = atmel_hlcdc_probe,
-	.remove = atmel_hlcdc_remove,
 	.driver = {
 		.name = "atmel-hlcdc",
 		.of_match_table = atmel_hlcdc_match,
-- 
2.1.4

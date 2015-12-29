From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] mfd: twl-core: One function call less in add_numbered_child()
 after error detection
Date: Tue, 29 Dec 2015 19:34:16 +0100
Message-ID: <5682D228.7070902@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 29 Dec 2015 19:29:08 +0100

The platform_device_put() function was called in one case by the
add_numbered_child() function during error handling even if the passed
variable "pdev" contained a null pointer.

Implementation details could be improved by the adjustment of jump targets
according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mfd/twl-core.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 831696e..0d9350c 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -625,7 +625,7 @@ add_numbered_child(unsigned mod_no, const char *name, int num,
 	if (!pdev) {
 		dev_dbg(&twl->client->dev, "can't alloc dev\n");
 		status = -ENOMEM;
-		goto err;
+		goto report_failure;
 	}
 
 	pdev->dev.parent = &twl->client->dev;
@@ -634,7 +634,7 @@ add_numbered_child(unsigned mod_no, const char *name, int num,
 		status = platform_device_add_data(pdev, pdata, pdata_len);
 		if (status < 0) {
 			dev_dbg(&pdev->dev, "can't add platform_data\n");
-			goto err;
+			goto put_device;
 		}
 	}
 
@@ -647,21 +647,20 @@ add_numbered_child(unsigned mod_no, const char *name, int num,
 		status = platform_device_add_resources(pdev, r, irq1 ? 2 : 1);
 		if (status < 0) {
 			dev_dbg(&pdev->dev, "can't add irqs\n");
-			goto err;
+			goto put_device;
 		}
 	}
 
 	status = platform_device_add(pdev);
-	if (status == 0)
+	if (!status) {
 		device_init_wakeup(&pdev->dev, can_wakeup);
-
-err:
-	if (status < 0) {
-		platform_device_put(pdev);
-		dev_err(&twl->client->dev, "can't add %s dev\n", name);
-		return ERR_PTR(status);
+		return &pdev->dev;
 	}
-	return &pdev->dev;
+put_device:
+	platform_device_put(pdev);
+report_failure:
+	dev_err(&twl->client->dev, "can't add %s dev\n", name);
+	return ERR_PTR(status);
 }
 
 static inline struct device *add_child(unsigned mod_no, const char *name,
-- 
2.6.3


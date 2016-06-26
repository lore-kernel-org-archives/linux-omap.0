From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/6] mfd: twl-core: Refactoring for add_numbered_child()
Date: Sun, 26 Jun 2016 15:47:27 +0200
Message-ID: <9cf59380-e999-0cf8-9b8d-106691b86d0b@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5682D228.7070902@users.sourceforge.net> <20160111082922.GB14104@x1>
 <05b7db2a-437a-60ac-d289-71d2150e7f5f@users.sourceforge.net>
 <de3598c4-f85a-6807-303a-55ee0ac707f2@users.sourceforge.net>
 <20160608111442.GB14888@dell>
 <e4eaf0b4-e539-b400-c8a2-70f210cee1fa@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <e4eaf0b4-e539-b400-c8a2-70f210cee1fa@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Jun 2016 13:03:59 +0200

Adjust jump targets according to the Linux coding style convention.
Another check for the variable "status" can be omitted then at the end.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/twl-core.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 9458c6d..a49d3db 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -631,7 +631,7 @@ add_numbered_child(unsigned mod_no, const char *name, int num,
 		status = platform_device_add_data(pdev, pdata, pdata_len);
 		if (status < 0) {
 			dev_dbg(&pdev->dev, "can't add platform_data\n");
-			goto err;
+			goto put_device;
 		}
 	}
 
@@ -644,21 +644,22 @@ add_numbered_child(unsigned mod_no, const char *name, int num,
 		status = platform_device_add_resources(pdev, r, irq1 ? 2 : 1);
 		if (status < 0) {
 			dev_dbg(&pdev->dev, "can't add irqs\n");
-			goto err;
+			goto put_device;
 		}
 	}
 
 	status = platform_device_add(pdev);
-	if (status == 0)
-		device_init_wakeup(&pdev->dev, can_wakeup);
+	if (status)
+		goto put_device;
+
+	device_init_wakeup(&pdev->dev, can_wakeup);
 
-err:
-	if (status < 0) {
-		platform_device_put(pdev);
-		dev_err(&twl->client->dev, "can't add %s dev\n", name);
-		return ERR_PTR(status);
-	}
 	return &pdev->dev;
+
+put_device:
+	platform_device_put(pdev);
+	dev_err(&twl->client->dev, "failed to add device %s\n", name);
+	return ERR_PTR(status);
 }
 
 static inline struct device *add_child(unsigned mod_no, const char *name,
-- 
2.9.0


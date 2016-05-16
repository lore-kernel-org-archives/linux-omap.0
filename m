From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] mfd: twl-core: Refactoring for add_numbered_child()
Date: Mon, 16 May 2016 08:28:59 +0200
Message-ID: <de3598c4-f85a-6807-303a-55ee0ac707f2@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5682D228.7070902@users.sourceforge.net> <20160111082922.GB14104@x1>
 <05b7db2a-437a-60ac-d289-71d2150e7f5f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <05b7db2a-437a-60ac-d289-71d2150e7f5f@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 15 May 2016 19:50:55 +0200

Adjust jump targets according to the Linux coding style convention.
Another check for the variable "status" can be omitted then at the end.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mfd/twl-core.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index dc34e69..3e4f4e4 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -635,7 +635,7 @@ add_numbered_child(unsigned mod_no, const char *name, int num,
 		status = platform_device_add_data(pdev, pdata, pdata_len);
 		if (status < 0) {
 			dev_dbg(&pdev->dev, "can't add platform_data\n");
-			goto err;
+			goto put_device;
 		}
 	}
 
@@ -648,21 +648,20 @@ add_numbered_child(unsigned mod_no, const char *name, int num,
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
 
-err:
-	if (status < 0) {
-		platform_device_put(pdev);
-		dev_err(&twl->client->dev, "can't add %s dev\n", name);
-		return ERR_PTR(status);
-	}
+	device_init_wakeup(&pdev->dev, can_wakeup);
 	return &pdev->dev;
+put_device:
+	platform_device_put(pdev);
+	dev_err(&twl->client->dev, "can't add %s dev\n", name);
+	return ERR_PTR(status);
 }
 
 static inline struct device *add_child(unsigned mod_no, const char *name,
-- 
2.8.2


From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/6] mfd: dm355evm_msp: Return directly after a failed
 platform_device_alloc() in add_child()
Date: Sun, 26 Jun 2016 15:48:48 +0200
Message-ID: <2fec6004-8191-c117-94c3-86524cfb4780@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5682D228.7070902@users.sourceforge.net> <20160111082922.GB14104@x1>
 <05b7db2a-437a-60ac-d289-71d2150e7f5f@users.sourceforge.net>
 <de3598c4-f85a-6807-303a-55ee0ac707f2@users.sourceforge.net>
 <20160608111442.GB14888@dell>
 <e4eaf0b4-e539-b400-c8a2-70f210cee1fa@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e4eaf0b4-e539-b400-c8a2-70f210cee1fa@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Jun 2016 13:40:35 +0200

The platform_device_put() function was called in one case by the
add_child() function during error handling even if the passed
variable "pdev" contained a null pointer.
Return directly in this case.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mfd/dm355evm_msp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/dm355evm_msp.c b/drivers/mfd/dm355evm_msp.c
index 14661ec..270e19c 100644
--- a/drivers/mfd/dm355evm_msp.c
+++ b/drivers/mfd/dm355evm_msp.c
@@ -199,11 +199,8 @@ static struct device *add_child(struct i2c_client *client, const char *name,
 	int			status;
 
 	pdev = platform_device_alloc(name, -1);
-	if (!pdev) {
-		dev_dbg(&client->dev, "can't alloc dev\n");
-		status = -ENOMEM;
-		goto err;
-	}
+	if (!pdev)
+		return ERR_PTR(-ENOMEM);
 
 	device_init_wakeup(&pdev->dev, can_wakeup);
 	pdev->dev.parent = &client->dev;
-- 
2.9.0

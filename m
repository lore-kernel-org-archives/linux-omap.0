From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] mfd: twl-core: Return directly after a failed
 platform_device_alloc() in add_numbered_child()
Date: Mon, 16 May 2016 08:26:11 +0200
Message-ID: <3c168185-ec2d-f1f7-fe70-8a230b884ed2@users.sourceforge.net>
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
Date: Sun, 15 May 2016 19:20:28 +0200

The platform_device_put() function was called in one case by the
add_numbered_child() function during error handling even if the passed
variable "pdev" contained a null pointer.

* Change an error message.

* Return directly in this case.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mfd/twl-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 831696e..dc34e69 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -623,9 +623,10 @@ add_numbered_child(unsigned mod_no, const char *name, int num,
 
 	pdev = platform_device_alloc(name, num);
 	if (!pdev) {
-		dev_dbg(&twl->client->dev, "can't alloc dev\n");
-		status = -ENOMEM;
-		goto err;
+		dev_err(&twl->client->dev,
+			"Allocation failed for device: %s\n",
+			name);
+		return ERR_PTR(-ENOMEM);
 	}
 
 	pdev->dev.parent = &twl->client->dev;
-- 
2.8.2


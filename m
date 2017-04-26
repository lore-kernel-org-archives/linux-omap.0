From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] omapfb: Use devm_kcalloc() in vrfb_probe()
Date: Wed, 26 Apr 2017 11:20:07 +0200
Message-ID: <4a7b1751-4319-4bde-cf26-2de2a4096c68@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 26 Apr 2017 11:08:30 +0200

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "devm_kcalloc".

* Replace the specification of a data structure by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/omap2/omapfb/vrfb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/vrfb.c b/drivers/video/fbdev/omap2/omapfb/vrfb.c
index f346b02eee1d..54b51a7a290a 100644
--- a/drivers/video/fbdev/omap2/omapfb/vrfb.c
+++ b/drivers/video/fbdev/omap2/omapfb/vrfb.c
@@ -358,11 +358,7 @@ static int __init vrfb_probe(struct platform_device *pdev)
 		return PTR_ERR(vrfb_base);
 
 	num_ctxs = pdev->num_resources - 1;
-
-	ctxs = devm_kzalloc(&pdev->dev,
-			sizeof(struct vrfb_ctx) * num_ctxs,
-			GFP_KERNEL);
-
+	ctxs = devm_kcalloc(&pdev->dev, num_ctxs, sizeof(*ctxs), GFP_KERNEL);
 	if (!ctxs)
 		return -ENOMEM;
 
-- 
2.12.2


From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 1/2] video: fbdev: Drop owner assignment from i2c_driver
Date: Fri, 10 Jul 2015 15:37:29 +0900
Message-ID: <1436510250-5633-2-git-send-email-k.kozlowski@samsung.com>
References: <1436510250-5633-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1436510250-5633-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

i2c_driver does not need to set an owner because i2c_register_driver()
will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 drivers/video/fbdev/ssd1307fb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 3e153c06131a..b6edd28b267f 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -719,7 +719,6 @@ static struct i2c_driver ssd1307fb_driver = {
 	.driver = {
 		.name = "ssd1307fb",
 		.of_match_table = ssd1307fb_of_match,
-		.owner = THIS_MODULE,
 	},
 };
 
-- 
1.9.1

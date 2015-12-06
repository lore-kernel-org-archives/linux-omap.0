From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Subject: [PATCH 04/10] omap_hwspinlock: Replace "hweight_long(i & 0xf) != 1" with "!is_power_of_2(i & 0xf)"
Date: Sun,  6 Dec 2015 18:33:26 +0800
Message-ID: <1449398006-14450-1-git-send-email-zhaoxiu.zeng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ohad@wizery.com, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
List-Id: linux-omap@vger.kernel.org

From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
---
 drivers/hwspinlock/omap_hwspinlock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index ad2f8ca..1848a4c 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -29,6 +29,7 @@
 #include <linux/hwspinlock.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/log2.h>
 
 #include "hwspinlock_internal.h"
 
@@ -125,7 +126,7 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 		goto iounmap_base;
 
 	/* one of the four lsb's must be set, and nothing else */
-	if (hweight_long(i & 0xf) != 1 || i > 8) {
+	if (!is_power_of_2(i & 0xf) || i > 8) {
 		ret = -EINVAL;
 		goto iounmap_base;
 	}
-- 
2.5.0

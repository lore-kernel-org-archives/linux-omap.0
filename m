From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH RFC 1/2] mtd : Prevent the NULL pointer access
Date: Mon, 23 Jan 2012 13:42:40 +0530
Message-ID: <1327306361-9803-2-git-send-email-shubhrajyoti@ti.com>
References: <1327306361-9803-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57441 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969Ab2AWIMv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jan 2012 03:12:51 -0500
In-Reply-To: <1327306361-9803-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>

This patch intends to fix the null pointer access.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/mtd/mtdcore.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 6ae9ca0..2b3bda7 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -118,8 +118,9 @@ static void mtd_release(struct device *dev)
 static int mtd_cls_suspend(struct device *dev, pm_message_t state)
 {
 	struct mtd_info *mtd = dev_get_drvdata(dev);
-
-	return mtd_suspend(mtd);
+	if (mtd)
+		return mtd_suspend(mtd);
+	return 0;
 }
 
 static int mtd_cls_resume(struct device *dev)
-- 
1.7.1


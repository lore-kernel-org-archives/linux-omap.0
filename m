From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/2] hwspinlock/omap: enable module before reading SYSSTATUS register
Date: Wed, 2 Jul 2014 18:00:59 -0500
Message-ID: <1404342060-2919-2-git-send-email-s-anna@ti.com>
References: <1404342060-2919-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36019 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbaGBXBg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2014 19:01:36 -0400
In-Reply-To: <1404342060-2919-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

The number of hwspinlocks are determined based on the value read
from the IP block's SYSSTATUS register. However, the module may
not be enabled and clocked, and the read may result in a bus error.

This particular issue is seen rather easily on AM33XX, since the
module wakeup is software controlled, and it is disabled out of
reset. Make sure the module is enabled and clocked before reading
the SYSSTATUS register.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/hwspinlock/omap_hwspinlock.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index 292869c..deb9e13 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -98,10 +98,29 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	if (!io_base)
 		return -ENOMEM;
 
+	/*
+	 * make sure the module is enabled and clocked before reading
+	 * the module SYSSTATUS register
+	 */
+	pm_runtime_enable(&pdev->dev);
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(&pdev->dev);
+		goto iounmap_base;
+	}
+
 	/* Determine number of locks */
 	i = readl(io_base + SYSSTATUS_OFFSET);
 	i >>= SPINLOCK_NUMLOCKS_BIT_OFFSET;
 
+	/*
+	 * runtime PM will make sure the clock of this module is
+	 * enabled again iff at least one lock is requested
+	 */
+	ret = pm_runtime_put_sync(&pdev->dev);
+	if (ret < 0)
+		goto iounmap_base;
+
 	/* one of the four lsb's must be set, and nothing else */
 	if (hweight_long(i & 0xf) != 1 || i > 8) {
 		ret = -EINVAL;
@@ -121,12 +140,6 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	for (i = 0, hwlock = &bank->lock[0]; i < num_locks; i++, hwlock++)
 		hwlock->priv = io_base + LOCK_BASE_OFFSET + sizeof(u32) * i;
 
-	/*
-	 * runtime PM will make sure the clock of this module is
-	 * enabled iff at least one lock is requested
-	 */
-	pm_runtime_enable(&pdev->dev);
-
 	ret = hwspin_lock_register(bank, &pdev->dev, &omap_hwspinlock_ops,
 						pdata->base_id, num_locks);
 	if (ret)
@@ -135,9 +148,9 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	return 0;
 
 reg_fail:
-	pm_runtime_disable(&pdev->dev);
 	kfree(bank);
 iounmap_base:
+	pm_runtime_disable(&pdev->dev);
 	iounmap(io_base);
 	return ret;
 }
-- 
2.0.0


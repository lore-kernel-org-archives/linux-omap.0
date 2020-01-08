From: Baolin Wang <baolin.wang7@gmail.com>
Subject: [PATCH RESEND 3/3] hwspinlock: omap: Use devm_hwspin_lock_register() to register hwlock controller
Date: Wed,  8 Jan 2020 11:14:01 +0800
Message-ID: <315adcc5dfc6aa5c001448401dda4065e33deef2.1578453062.git.baolin.wang7@gmail.com>
References: <cover.1578453062.git.baolin.wang7@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1578453062.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1578453062.git.baolin.wang7@gmail.com>
References: <cover.1578453062.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: baolin.wang7@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Use devm_hwspin_lock_register() to register the hwlock controller instead of
unregistering the hwlock controller explicitly when removing the device.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/hwspinlock/omap_hwspinlock.c |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index 3b05560..9e8a8c2 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -131,8 +131,8 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	for (i = 0, hwlock = &bank->lock[0]; i < num_locks; i++, hwlock++)
 		hwlock->priv = io_base + LOCK_BASE_OFFSET + sizeof(u32) * i;
 
-	ret = hwspin_lock_register(bank, &pdev->dev, &omap_hwspinlock_ops,
-						base_id, num_locks);
+	ret = devm_hwspin_lock_register(&pdev->dev, bank, &omap_hwspinlock_ops,
+					base_id, num_locks);
 	if (ret)
 		goto runtime_err;
 
@@ -148,15 +148,6 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 
 static int omap_hwspinlock_remove(struct platform_device *pdev)
 {
-	struct hwspinlock_device *bank = platform_get_drvdata(pdev);
-	int ret;
-
-	ret = hwspin_lock_unregister(bank);
-	if (ret) {
-		dev_err(&pdev->dev, "%s failed: %d\n", __func__, ret);
-		return ret;
-	}
-
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
-- 
1.7.9.5

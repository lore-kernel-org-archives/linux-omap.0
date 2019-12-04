From: Baolin Wang <baolin.wang7@gmail.com>
Subject: [PATCH 2/3] hwspinlock: omap: Use devm_kzalloc() to allocate memory
Date: Wed,  4 Dec 2019 17:31:30 +0800
Message-ID: <a6611d028d9e48a3da967277ace31a5e7676e797.1575451463.git.baolin.wang7@gmail.com>
References: <cover.1575451463.git.baolin.wang7@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1575451463.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1575451463.git.baolin.wang7@gmail.com>
References: <cover.1575451463.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: baolin.wang7@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Use devm_kzalloc() to allocate memory, which can simplify the error
handling.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/hwspinlock/omap_hwspinlock.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index dbb1a4c..3b05560 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -119,7 +119,8 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 
 	num_locks = i * 32; /* actual number of locks in this device */
 
-	bank = kzalloc(struct_size(bank, lock, num_locks), GFP_KERNEL);
+	bank = devm_kzalloc(&pdev->dev, struct_size(bank, lock, num_locks),
+			    GFP_KERNEL);
 	if (!bank) {
 		ret = -ENOMEM;
 		goto runtime_err;
@@ -133,15 +134,13 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	ret = hwspin_lock_register(bank, &pdev->dev, &omap_hwspinlock_ops,
 						base_id, num_locks);
 	if (ret)
-		goto reg_fail;
+		goto runtime_err;
 
 	dev_dbg(&pdev->dev, "Registered %d locks with HwSpinlock core\n",
 		num_locks);
 
 	return 0;
 
-reg_fail:
-	kfree(bank);
 runtime_err:
 	pm_runtime_disable(&pdev->dev);
 	return ret;
@@ -159,7 +158,6 @@ static int omap_hwspinlock_remove(struct platform_device *pdev)
 	}
 
 	pm_runtime_disable(&pdev->dev);
-	kfree(bank);
 
 	return 0;
 }
-- 
1.7.9.5

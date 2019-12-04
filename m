From: Baolin Wang <baolin.wang7@gmail.com>
Subject: [PATCH 1/3] hwspinlock: omap: Change to use devm_platform_ioremap_resource()
Date: Wed,  4 Dec 2019 17:31:29 +0800
Message-ID: <0f3bb58703fac8b18b4a6b5fc8dc00b21b7c7e07.1575451463.git.baolin.wang7@gmail.com>
References: <cover.1575451463.git.baolin.wang7@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1575451463.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1575451463.git.baolin.wang7@gmail.com>
References: <cover.1575451463.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: baolin.wang7@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together, which can simpify the code.
Meanwhile renaming the error label to make more sense after removing
iounmap().

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/hwspinlock/omap_hwspinlock.c |   24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index 14e1a53..dbb1a4c 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -76,7 +76,6 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct hwspinlock_device *bank;
 	struct hwspinlock *hwlock;
-	struct resource *res;
 	void __iomem *io_base;
 	int num_locks, i, ret;
 	/* Only a single hwspinlock block device is supported */
@@ -85,13 +84,9 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	if (!node)
 		return -ENODEV;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	io_base = ioremap(res->start, resource_size(res));
-	if (!io_base)
-		return -ENOMEM;
+	io_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(io_base))
+		return PTR_ERR(io_base);
 
 	/*
 	 * make sure the module is enabled and clocked before reading
@@ -101,7 +96,7 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
 		pm_runtime_put_noidle(&pdev->dev);
-		goto iounmap_base;
+		goto runtime_err;
 	}
 
 	/* Determine number of locks */
@@ -114,12 +109,12 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	 */
 	ret = pm_runtime_put(&pdev->dev);
 	if (ret < 0)
-		goto iounmap_base;
+		goto runtime_err;
 
 	/* one of the four lsb's must be set, and nothing else */
 	if (hweight_long(i & 0xf) != 1 || i > 8) {
 		ret = -EINVAL;
-		goto iounmap_base;
+		goto runtime_err;
 	}
 
 	num_locks = i * 32; /* actual number of locks in this device */
@@ -127,7 +122,7 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	bank = kzalloc(struct_size(bank, lock, num_locks), GFP_KERNEL);
 	if (!bank) {
 		ret = -ENOMEM;
-		goto iounmap_base;
+		goto runtime_err;
 	}
 
 	platform_set_drvdata(pdev, bank);
@@ -147,16 +142,14 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 
 reg_fail:
 	kfree(bank);
-iounmap_base:
+runtime_err:
 	pm_runtime_disable(&pdev->dev);
-	iounmap(io_base);
 	return ret;
 }
 
 static int omap_hwspinlock_remove(struct platform_device *pdev)
 {
 	struct hwspinlock_device *bank = platform_get_drvdata(pdev);
-	void __iomem *io_base = bank->lock[0].priv - LOCK_BASE_OFFSET;
 	int ret;
 
 	ret = hwspin_lock_unregister(bank);
@@ -166,7 +159,6 @@ static int omap_hwspinlock_remove(struct platform_device *pdev)
 	}
 
 	pm_runtime_disable(&pdev->dev);
-	iounmap(io_base);
 	kfree(bank);
 
 	return 0;
-- 
1.7.9.5

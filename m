From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv7 24/24] i2c: omap: Prevent NULL pointer dereference in remove
Date: Thu, 16 Aug 2012 19:33:55 +0530
Message-ID: <1345125835-15524-25-git-send-email-shubhrajyoti@ti.com>
References: <1345125835-15524-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1345125835-15524-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Prevent the NULL pointer access of pdev. The platform_device is anyways
deleted so remove  platform_set_drvdata(pdev, NULL);.

[  654.961761] Unable to handle kernel NULL pointer dereference at virtual address 00000070
[  654.970611] pgd = df254000
[  654.973480] [00000070] *pgd=9f1da831, *pte=00000000, *ppte=00000000
[  654.980163] Internal error: Oops: 17 [#1] SMP ARM
[  654.985076] Modules linked in:
[  654.988281] CPU: 1    Not tainted  (3.6.0-rc1-00031-ge547de1-dirty #339)
[  654.995330] PC is at omap_i2c_runtime_resume+0x8/0x148
[  655.000732] LR is at omap_i2c_runtime_resume+0x8/0x148

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 3df6f92..9aefd36 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1207,8 +1207,6 @@ err_unuse_clocks:
 	pm_runtime_put(dev->dev);
 	pm_runtime_disable(&pdev->dev);
 err_free_mem:
-	platform_set_drvdata(pdev, NULL);
-
 	return r;
 }
 
@@ -1217,8 +1215,6 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
 	struct omap_i2c_dev	*dev = platform_get_drvdata(pdev);
 	int ret;
 
-	platform_set_drvdata(pdev, NULL);
-
 	i2c_del_adapter(&dev->adapter);
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (IS_ERR_VALUE(ret))
-- 
1.7.5.4

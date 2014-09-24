From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 09/27] i2c: omap: use pm_runtime_last_busy_and_autosuspend helper
Date: Wed, 24 Sep 2014 21:44:59 +0530
Message-ID: <1411575342-31048-10-git-send-email-vinod.koul@intel.com>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: subhransu.s.prusty@intel.com, vinod.koul@intel.com, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Use the new pm_runtime_last_busy_and_autosuspend helper instead of open
coding the same code

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/i2c/busses/i2c-omap.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 0dffb0e..8a7de50 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -661,8 +661,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 		dev->set_mpu_wkup_lat(dev->dev, -1);
 
 out:
-	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
+	pm_runtime_last_busy_and_autosuspend(dev->dev);
 	return r;
 }
 
@@ -1253,8 +1252,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	dev_info(dev->dev, "bus %d rev%d.%d at %d kHz\n", adap->nr,
 		 major, minor, dev->speed);
 
-	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
+	pm_runtime_last_busy_and_autosuspend(dev->dev);
 
 	return 0;
 
-- 
1.7.0.4

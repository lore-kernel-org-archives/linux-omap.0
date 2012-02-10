From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 06/10] OMAP: I2C: Fix the mismatch of pm_runtime enable and disable
Date: Fri, 10 Feb 2012 19:30:01 +0530
Message-ID: <1328882405-15284-7-git-send-email-shubhrajyoti@ti.com>
References: <1328882405-15284-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60124 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754452Ab2BJOAp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Feb 2012 09:00:45 -0500
In-Reply-To: <1328882405-15284-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khali@linux-fr.org, Shubhrajyoti D <shubhrajyoti@ti.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, Ben Dooks <ben-linux@fluff.org>

Currently the i2c driver calls the pm_runtime_enable and never
the disable. This may cause a warning when pm_runtime_enable
checks for the count match.Attempting to fix the same by calling
pm_runtime_disable in the error and the remove path.

Cc: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
previous discurssion 
http://marc.info/?l=linux-arm-kernel&m=132628828411133&w=2

 drivers/i2c/busses/i2c-omap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index c3ca7d9..cb9d4f8 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1122,6 +1122,7 @@ err_unuse_clocks:
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 	pm_runtime_put(dev->dev);
 	iounmap(dev->base);
+	pm_runtime_disable(&pdev->dev);
 err_free_mem:
 	platform_set_drvdata(pdev, NULL);
 	kfree(dev);
@@ -1137,6 +1138,7 @@ omap_i2c_remove(struct platform_device *pdev)
 	struct omap_i2c_dev	*dev = platform_get_drvdata(pdev);
 	struct resource		*mem;
 
+	pm_runtime_disable(&pdev->dev);
 	platform_set_drvdata(pdev, NULL);
 
 	free_irq(dev->irq, dev);
-- 
1.7.1


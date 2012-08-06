From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 4/4] i2c: omap: switch over to autosuspend API
Date: Mon,  6 Aug 2012 17:18:57 +0300
Message-ID: <1344262737-6662-5-git-send-email-balbi@ti.com>
References: <1344262737-6662-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:38645 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756474Ab2HFOWp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Aug 2012 10:22:45 -0400
Received: by lahc1 with SMTP id c1so592847lah.40
        for <linux-omap@vger.kernel.org>; Mon, 06 Aug 2012 07:22:42 -0700 (PDT)
In-Reply-To: <1344262737-6662-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>

this helps us reduce unnecessary pm transitions
in case we have another i2c message been started
soon.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 60928f2..22efaba 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -645,7 +645,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	omap_i2c_wait_for_bb(dev);
 out:
-	pm_runtime_put(dev->dev);
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
 	return r;
 }
 
@@ -1113,6 +1114,9 @@ omap_i2c_probe(struct platform_device *pdev)
 		dev->regs = (u8 *)reg_map_ip_v1;
 
 	pm_runtime_enable(dev->dev);
+	pm_runtime_set_autosuspend_delay(dev->dev, 1000);
+	pm_runtime_use_autosuspend(dev->dev);
+
 	r = pm_runtime_get_sync(dev->dev);
 	if (IS_ERR_VALUE(r))
 		goto err_free_mem;
@@ -1189,7 +1193,7 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	of_i2c_register_devices(adap);
 
-	pm_runtime_put(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
 
 	return 0;
 
-- 
1.7.12.rc0


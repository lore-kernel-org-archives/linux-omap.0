From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv11 3/6] i2c: omap: Do not initialise the completion everytime
Date: Thu, 28 Jun 2012 20:41:29 +0530
Message-ID: <1340896292-12112-4-git-send-email-shubhrajyoti@ti.com>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35302 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754946Ab2F1PM2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 11:12:28 -0400
In-Reply-To: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>

Use INIT_COMPLETION instead of init_completion in transfer.

Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
- Add Felipe's reviewed-by tag

 drivers/i2c/busses/i2c-omap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index b9915bb..6d05f18 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -490,7 +490,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	w |= OMAP_I2C_BUF_RXFIF_CLR | OMAP_I2C_BUF_TXFIF_CLR;
 	omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, w);
 
-	init_completion(&dev->cmd_complete);
+	INIT_COMPLETION(dev->cmd_complete);
 	dev->cmd_err = 0;
 
 	w = OMAP_I2C_CON_EN | OMAP_I2C_CON_MST | OMAP_I2C_CON_STT;
@@ -999,6 +999,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, dev);
+	init_completion(&dev->cmd_complete);
 
 	dev->reg_shift = (dev->flags >> OMAP_I2C_FLAG_BUS_SHIFT__SHIFT) & 3;
 
-- 
1.7.5.4


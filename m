From: Felipe Balbi <balbi@ti.com>
Subject: [rft/rfc/patch 13/22] i2c: omap: if controller is suspended, bail out
Date: Wed, 13 Jun 2012 18:51:02 +0300
Message-ID: <1339602671-8431-14-git-send-email-balbi@ti.com>
References: <1339602671-8431-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:51049 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754195Ab2FMPxv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 11:53:51 -0400
Received: by lbbgk8 with SMTP id gk8so1506995lbb.12
        for <linux-omap@vger.kernel.org>; Wed, 13 Jun 2012 08:53:49 -0700 (PDT)
In-Reply-To: <1339602671-8431-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

same check we had on the threaded IRQ handler,
copy it to the bottom half.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 9dadfb1..e555681 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -871,6 +871,9 @@ omap_i2c_isr(int irq, void *_dev)
 	u16			stat;
 	u16			bits;
 
+	if (pm_runtime_suspended(dev->dev))
+		return IRQ_NONE;
+
 	stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 	bits = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 
-- 
1.7.10.4


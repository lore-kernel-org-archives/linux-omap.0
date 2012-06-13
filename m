From: Felipe Balbi <balbi@ti.com>
Subject: [rft/rfc/patch 14/22] i2c: omap: ack ARDY IRQ
Date: Wed, 13 Jun 2012 18:51:03 +0300
Message-ID: <1339602671-8431-15-git-send-email-balbi@ti.com>
References: <1339602671-8431-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:48266 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754195Ab2FMPxy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 11:53:54 -0400
Received: by lagv3 with SMTP id v3so600740lag.31
        for <linux-omap@vger.kernel.org>; Wed, 13 Jun 2012 08:53:51 -0700 (PDT)
In-Reply-To: <1339602671-8431-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

comment asks us to clear it twice, so let's
do so.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index e555681..f30eb45 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -923,6 +923,9 @@ omap_i2c_threaded_isr(int this_irq, void *dev_id)
 			return IRQ_HANDLED;
 		}
 
+		if (stat & OMAP_I2C_STAT_ARDY)
+			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_ARDY);
+
 		/*
 		 * ProDB0017052: Clear ARDY bit twice
 		 */
-- 
1.7.10.4


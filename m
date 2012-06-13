From: Felipe Balbi <balbi@ti.com>
Subject: [rft/rfc/patch 18/22] i2c: omap: drop errata i207 from RRDY interrupt
Date: Wed, 13 Jun 2012 18:51:07 +0300
Message-ID: <1339602671-8431-19-git-send-email-balbi@ti.com>
References: <1339602671-8431-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:38407 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754248Ab2FMPyF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 11:54:05 -0400
Received: by lahd3 with SMTP id d3so656568lah.33
        for <linux-omap@vger.kernel.org>; Wed, 13 Jun 2012 08:54:02 -0700 (PDT)
In-Reply-To: <1339602671-8431-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

that errata refers only to RDR interrupt. It's safe
to drop it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 20f854d..9274fcb 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -943,9 +943,6 @@ omap_i2c_threaded_isr(int this_irq, void *dev_id)
 		if (stat & OMAP_I2C_STAT_RRDY) {
 			u8 num_bytes = 1;
 
-			if (dev->errata & I2C_OMAP_ERRATA_I207)
-				i2c_omap_errata_i207(dev, stat);
-
 			if (dev->fifo_size)
 				num_bytes = dev->fifo_size;
 
-- 
1.7.10.4


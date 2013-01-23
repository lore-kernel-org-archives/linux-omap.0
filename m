From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/6] i2c: omap: also complete() when stat becomes zero
Date: Wed, 23 Jan 2013 12:23:04 +0200
Message-ID: <1358936588-16375-3-git-send-email-balbi@ti.com>
References: <20130123095813.GG3767@nekote.pengutronix.de>
 <1358936588-16375-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41332 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509Ab3AWKXj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jan 2013 05:23:39 -0500
In-Reply-To: <1358936588-16375-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: w.sang@pengutronix.de
Cc: linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, aaro.koskinen@iki.fi, Felipe Balbi <balbi@ti.com>

In case we loop on IRQ handler until stat is
finally zero, we would end up in a situation
where all I2C transfers would misteriously
timeout because we were not calling complete()
in that situation.

Fix the issue by moving omap_i2c_complete_cmd()
call inside the 'out' label.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index be8c591..53985b4 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1022,9 +1022,8 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 		}
 	} while (stat);
 
-	omap_i2c_complete_cmd(dev, err);
-
 out:
+	omap_i2c_complete_cmd(dev, err);
 	spin_unlock_irqrestore(&dev->lock, flags);
 
 	return IRQ_HANDLED;
-- 
1.8.1.rc1.5.g7e0651a


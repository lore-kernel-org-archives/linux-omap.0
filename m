From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv4 14/18] i2c: omap: always return IRQ_HANDLED
Date: Tue, 3 Jul 2012 20:07:52 +0530
Message-ID: <1341326276-25434-15-git-send-email-shubhrajyoti@ti.com>
References: <1341326276-25434-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40945 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729Ab2GCOlU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Jul 2012 10:41:20 -0400
In-Reply-To: <1341326276-25434-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Felipe Balbi <balbi@ti.com>

otherwise we could get our IRQ line disabled due
to many spurious IRQs.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 7e3502e..81c1c1b 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -981,7 +981,7 @@ complete:
 		}
 	} while (stat);
 
-	return count ? IRQ_HANDLED : IRQ_NONE;
+	return IRQ_HANDLED;
 }
 
 static const struct i2c_algorithm omap_i2c_algo = {
-- 
1.7.5.4


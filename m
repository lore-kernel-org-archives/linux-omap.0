From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 2/2] i2c: omap: use revision check for OMAP_I2C_FLAG_APPLY_ERRATA_I207
Date: Fri, 2 Nov 2012 16:09:45 +0530
Message-ID: <1351852785-16961-3-git-send-email-shubhrajyoti@ti.com>
References: <1351852785-16961-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36028 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223Ab2KBKkN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 06:40:13 -0400
In-Reply-To: <1351852785-16961-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, b-cousson@ti.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>

The errata i207 is enabled for 2430 and 3xxx. Use the revision check
to enable the erratum instead.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d8e7709..44245d4 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1164,7 +1164,8 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	dev->errata = 0;
 
-	if (dev->flags & OMAP_I2C_FLAG_APPLY_ERRATA_I207)
+	if (dev->rev >= OMAP_I2C_REV_ON_2430 &&
+			dev->rev < OMAP_I2C_REV_ON_4430_PLUS)
 		dev->errata |= I2C_OMAP_ERRATA_I207;
 
 	if (dev->rev <= OMAP_I2C_REV_ON_3430_3530)
-- 
1.7.5.4


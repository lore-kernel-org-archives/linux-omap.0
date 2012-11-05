From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv3 2/8] i2c: omap: use revision check for OMAP_I2C_FLAG_APPLY_ERRATA_I207
Date: Mon, 5 Nov 2012 17:53:37 +0530
Message-ID: <1352118223-3796-3-git-send-email-shubhrajyoti@ti.com>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60762 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676Ab2KEMYO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 07:24:14 -0500
In-Reply-To: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, b-cousson@ti.com, balbi@ti.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>

The errata i207 is enabled for 2430 and 3xxx. Use the revision check
to enable the erratum instead.

Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 5c6f538..737d843 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1166,7 +1166,8 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	dev->errata = 0;
 
-	if (dev->flags & OMAP_I2C_FLAG_APPLY_ERRATA_I207)
+	if (dev->rev >= OMAP_I2C_REV_ON_2430 &&
+			dev->rev < OMAP_I2C_REV_ON_4430_PLUS)
 		dev->errata |= I2C_OMAP_ERRATA_I207;
 
 	if (dev->rev <= OMAP_I2C_REV_ON_3430_3530)
-- 
1.7.5.4


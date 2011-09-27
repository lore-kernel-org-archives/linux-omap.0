From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/9] regulator: twl: Remove hardcoded board constraints from driver
Date: Tue, 27 Sep 2011 15:42:44 +0530
Message-ID: <1317118372-17052-2-git-send-email-rnayak@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34743 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770Ab1I0KNd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 06:13:33 -0400
In-Reply-To: <1317118372-17052-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org, Rajendra Nayak <rnayak@ti.com>

Remove the hardcoded .valid_modes_mask and .valid_ops_mask for
each regulator from the twl driver and let the boards pass it.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 drivers/regulator/twl-regulator.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index ee8747f..f696287 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -1027,14 +1027,6 @@ static int __devinit twlreg_probe(struct platform_device *pdev)
 	/* copy the features into regulator data */
 	info->features = (unsigned long)initdata->driver_data;
 
-	/* Constrain board-specific capabilities according to what
-	 * this driver and the chip itself can actually do.
-	 */
-	c = &initdata->constraints;
-	c->valid_modes_mask &= REGULATOR_MODE_NORMAL | REGULATOR_MODE_STANDBY;
-	c->valid_ops_mask &= REGULATOR_CHANGE_VOLTAGE
-				| REGULATOR_CHANGE_MODE
-				| REGULATOR_CHANGE_STATUS;
 	switch (pdev->id) {
 	case TWL4030_REG_VIO:
 	case TWL4030_REG_VDD1:
-- 
1.7.1


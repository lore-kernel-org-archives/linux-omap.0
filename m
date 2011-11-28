From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 5/7] mfd: twl-core: pass driver data from pdata to add_regulator for VDD1 and VDD2
Date: Mon, 28 Nov 2011 16:53:23 +0200
Message-ID: <1322492005-27741-6-git-send-email-t-kristo@ti.com>
References: <1322492005-27741-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39822 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814Ab1K1Oy0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Nov 2011 09:54:26 -0500
In-Reply-To: <1322492005-27741-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, khilman@ti.com, b-cousson@ti.com, rnayak@ti.com, gg@slimlogic.co.uk

This way, we can add custom flags for VDD1 and VDD2 regulators that
get passed all the way to regulator init. This is needed for SMPS
regulator support to select used controller mode for these regulators
(either voltage processor or default.)

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/twl-core.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 01ecfee..af93fce 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -846,12 +846,14 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 			return PTR_ERR(child);
 
 		child = add_regulator(TWL4030_REG_VDD1, pdata->vdd1,
-					features);
+					features |
+					(u32)pdata->vdd1->driver_data);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
 
 		child = add_regulator(TWL4030_REG_VDD2, pdata->vdd2,
-					features);
+					features |
+					(u32)pdata->vdd2->driver_data);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
 
-- 
1.7.4.1


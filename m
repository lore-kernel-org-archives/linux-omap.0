From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 7/7] omap3: twl-common: enable VP SMPS mode for VDD1 and VDD2
Date: Mon, 28 Nov 2011 16:53:25 +0200
Message-ID: <1322492005-27741-8-git-send-email-t-kristo@ti.com>
References: <1322492005-27741-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39830 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814Ab1K1Oye (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Nov 2011 09:54:34 -0500
In-Reply-To: <1322492005-27741-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, khilman@ti.com, b-cousson@ti.com, rnayak@ti.com, gg@slimlogic.co.uk

This changes the control path for VDD1 and VDD2 regulators from
the I2C to be voltage processor.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/twl-common.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 7cf5347..01632aa 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -133,6 +133,7 @@ static struct regulator_init_data omap3_vdd1 = {
 	},
 	.num_consumer_supplies		= ARRAY_SIZE(omap3_vdd1_supply),
 	.consumer_supplies		= omap3_vdd1_supply,
+	.driver_data			= (void *)TWL_VP_SMPS_MODE,
 };
 
 static struct regulator_init_data omap3_vdd2 = {
@@ -145,6 +146,7 @@ static struct regulator_init_data omap3_vdd2 = {
 	},
 	.num_consumer_supplies		= ARRAY_SIZE(omap3_vdd2_supply),
 	.consumer_supplies		= omap3_vdd2_supply,
+	.driver_data			= (void *)TWL_VP_SMPS_MODE,
 };
 
 void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
-- 
1.7.4.1


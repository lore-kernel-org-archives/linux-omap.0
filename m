From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/7] MFD: twl-core: regulator configuration for twl6030 V1V8, V2V1 SMPS
Date: Fri, 10 Feb 2012 12:05:12 +0200
Message-ID: <1328868316-24749-4-git-send-email-peter.ujfalusi@ti.com>
References: <1328868316-24749-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1328868316-24749-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

To be able to attach consumers to these supplies from board
files we need to have regulator_init_data for them.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl-core.c  |   10 ++++++++++
 include/linux/i2c/twl.h |    2 ++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index ac6fdd93..0cb7511 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -937,6 +937,16 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 	/* twl6030 regulators */
 	if (twl_has_regulator() && twl_class_is_6030() &&
 			!(features & TWL6025_SUBCLASS)) {
+		child = add_regulator(TWL6030_REG_V1V8, pdata->v1v8,
+					features);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL6030_REG_V2V1, pdata->v2v1,
+					features);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
 		child = add_regulator(TWL6030_REG_VMMC, pdata->vmmc,
 					features);
 		if (IS_ERR(child))
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 3826a53..35b6d53 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -721,6 +721,8 @@ struct twl4030_platform_data {
 	struct regulator_init_data              *vcxio;
 	struct regulator_init_data              *vusb;
 	struct regulator_init_data		*clk32kg;
+	struct regulator_init_data              *v1v8;
+	struct regulator_init_data              *v2v1;
 	/* TWL6025 LDO regulators */
 	struct regulator_init_data		*ldo1;
 	struct regulator_init_data		*ldo2;
-- 
1.7.8.4

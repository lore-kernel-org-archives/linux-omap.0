From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 4/6] ARM: OMAP: SmartReflex: provide SoC integration API for VP
Date: Mon, 5 Nov 2012 09:02:12 -0600
Message-ID: <1352127734-30103-6-git-send-email-nm@ti.com>
References: <1352127734-30103-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1352127734-30103-1-git-send-email-nm@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Rafael <rjw@sisk.pl>, Kevin Hilman <khilman@ti.com>, Anton Vorontsov <cbouatmailru@gmail.com>, linux-pm <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

SoC integration of SmartReflex AVS block is varied. Some use
Voltage Processor for a hardware loop in certain OMAP SoC (called
hardware loop), while others have just the AVS block without
hardware loop automatic calibration mechanism for AVS block
to talk through. So provide the Voltage Processor API
to allow for SmartReflex class drivers to use the same.

NOTE: SmartReflex class 3 mode of operation mandates VP APIs
so, refuse to enable AVS driver if corresponding APIs are
not available.

As part of this change, remove the inclusion of voltage.h
which is no longer needed as smartreflex.h includes
linux/platform_data/voltage-omap.h which contain relevant
definitions used here.

Acked-by: Jean Pihet <j-pihet@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex-class3.c |   16 +++++++++++++---
 arch/arm/mach-omap2/sr_device.c          |    5 +++++
 drivers/power/avs/smartreflex.c          |    2 ++
 include/linux/power/smartreflex.h        |   18 ++++++++++++++++++
 4 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 1da8f03..7ccf57f 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -12,7 +12,6 @@
  */
 
 #include <linux/power/smartreflex.h>
-#include "voltage.h"
 
 static int sr_class3_enable(struct omap_sr *sr)
 {
@@ -23,15 +22,26 @@ static int sr_class3_enable(struct omap_sr *sr)
 				__func__, sr->name);
 		return -ENODATA;
 	}
+	if (!sr->soc_ops.vp_enable) {
+		pr_warn("%s: no VP enable available. Cannot enable %s!!\n",
+			__func__, sr->name);
+		return -EINVAL;
+	}
 
-	omap_vp_enable(sr->voltdm);
+	sr->soc_ops.vp_enable(sr->voltdm);
 	return sr_enable(sr->voltdm, volt);
 }
 
 static int sr_class3_disable(struct omap_sr *sr, int is_volt_reset)
 {
+	if (!sr->soc_ops.vp_disable) {
+		pr_warn("%s: no VP disable available. Cannot disable %s!!\n",
+			__func__, sr->name);
+		return -EINVAL;
+	}
 	sr_disable_errgen(sr->voltdm);
-	omap_vp_disable(sr->voltdm);
+
+	sr->soc_ops.vp_disable(sr->voltdm);
 	sr_disable(sr->voltdm);
 	if (is_volt_reset)
 		voltdm_reset(sr->voltdm);
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index f8217a5..6aac2c7 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -139,6 +139,11 @@ static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
 
 	sr_data->enable_on_init = sr_enable_on_init;
 
+	if (sr_data->voltdm->vp) {
+		sr_data->soc_ops.vp_enable = omap_vp_enable;
+		sr_data->soc_ops.vp_disable = omap_vp_disable;
+	}
+
 	pdev = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data),
 				 NULL, 0, 0);
 	if (IS_ERR(pdev))
diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
index 24768a2..32a9e3e 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -920,6 +920,8 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	sr_info->pdev = pdev;
 	sr_info->srid = pdev->id;
 	sr_info->voltdm = pdata->voltdm;
+	sr_info->soc_ops.vp_enable =  pdata->soc_ops.vp_enable;
+	sr_info->soc_ops.vp_disable =  pdata->soc_ops.vp_disable;
 	sr_info->nvalue_table = pdata->nvalue_table;
 	sr_info->nvalue_count = pdata->nvalue_count;
 	sr_info->senn_mod = pdata->senn_mod;
diff --git a/include/linux/power/smartreflex.h b/include/linux/power/smartreflex.h
index 4a496eb..203fc64 100644
--- a/include/linux/power/smartreflex.h
+++ b/include/linux/power/smartreflex.h
@@ -143,6 +143,21 @@
 #define OMAP3430_SR_ERRWEIGHT		0x04
 #define OMAP3430_SR_ERRMAXLIMIT		0x02
 
+/**
+ * struct omap_sr_soc_ops - SoC specific APIs
+ * @vp_enable:	Voltage Processor enable
+ * @vp_disable:	Voltage Processor disable
+ *
+ * SmartReflex AVS module integration tends to be SoC
+ * variant. some are integrated with modules like
+ * Voltage Processor (VP), while, some SoC integration
+ * donot use VP. Provide that variance here.
+ */
+struct omap_sr_soc_ops {
+	void (*vp_enable)(struct voltagedomain *voltdm);
+	void (*vp_disable)(struct voltagedomain *voltdm);
+};
+
 struct omap_sr {
 	char				*name;
 	struct list_head		node;
@@ -165,6 +180,7 @@ struct omap_sr {
 	u32				senp_mod;
 	u32				senn_mod;
 	void __iomem			*base;
+	struct omap_sr_soc_ops		soc_ops;
 };
 
 /**
@@ -268,6 +284,7 @@ struct omap_sr_nvalue_table {
  * @nvalue_table:	table containing the  efuse offsets and nvalues
  *			corresponding to them.
  * @voltdm:		Pointer to the voltage domain associated with the SR
+ * @soc_ops:		SoC specific ops to deal with integration variance
  */
 struct omap_sr_data {
 	const char			*name;
@@ -278,6 +295,7 @@ struct omap_sr_data {
 	bool				enable_on_init;
 	struct omap_sr_nvalue_table	*nvalue_table;
 	struct voltagedomain		*voltdm;
+	struct omap_sr_soc_ops		soc_ops;
 };
 
 /* Smartreflex module enable/disable interface */
-- 
1.7.9.5


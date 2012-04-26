From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH V3 06/10] ARM: OMAP2+: Voltage: Move the omap_volt_data structure to plat
Date: Thu, 26 Apr 2012 23:10:37 +0530
Message-ID: <1335462041-4949-7-git-send-email-j-keerthy@ti.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: j-pihet@ti.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

From: J Keerthy <j-keerthy@ti.com>

Move the omap_volt_data structure from mach-omap2/ directory
to arch/arm/plat-omap/include/plat/ so that it is accessible
from both mach-omap2 and drivers directories.

Signed-off-by: J Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/voltage.h             |   21 ++-------------------
 arch/arm/plat-omap/include/plat/voltage.h |   21 ++++++++++++++++++++-
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 16a1b09..34ef504 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -16,6 +16,8 @@
 
 #include <linux/err.h>
 
+#include <plat/voltage.h>
+
 #include "vc.h"
 #include "vp.h"
 
@@ -91,25 +93,6 @@ struct voltagedomain {
 };
 
 /**
- * struct omap_volt_data - Omap voltage specific data.
- * @voltage_nominal:	The possible voltage value in uV
- * @sr_efuse_offs:	The offset of the efuse register(from system
- *			control module base address) from where to read
- *			the n-target value for the smartreflex module.
- * @sr_errminlimit:	Error min limit value for smartreflex. This value
- *			differs at differnet opp and thus is linked
- *			with voltage.
- * @vp_errorgain:	Error gain value for the voltage processor. This
- *			field also differs according to the voltage/opp.
- */
-struct omap_volt_data {
-	u32	volt_nominal;
-	u32	sr_efuse_offs;
-	u8	sr_errminlimit;
-	u8	vp_errgain;
-};
-
-/**
  * struct omap_voltdm_pmic - PMIC specific data required by voltage driver.
  * @slew_rate:	PMIC slew rate (in uv/us)
  * @step_size:	PMIC voltage step size (in uv)
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index 0a6a482..5be4d5d 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -11,10 +11,29 @@
 #ifndef __ARCH_ARM_OMAP_VOLTAGE_H
 #define __ARCH_ARM_OMAP_VOLTAGE_H
 
+/**
+ * struct omap_volt_data - Omap voltage specific data.
+ * @voltage_nominal:	The possible voltage value in uV
+ * @sr_efuse_offs:	The offset of the efuse register(from system
+ *			control module base address) from where to read
+ *			the n-target value for the smartreflex module.
+ * @sr_errminlimit:	Error min limit value for smartreflex. This value
+ *			differs at differnet opp and thus is linked
+ *			with voltage.
+ * @vp_errorgain:	Error gain value for the voltage processor. This
+ *			field also differs according to the voltage/opp.
+ */
+struct omap_volt_data {
+	u32	volt_nominal;
+	u32	sr_efuse_offs;
+	u8	sr_errminlimit;
+	u8	vp_errgain;
+};
 struct voltagedomain;
 
 struct voltagedomain *voltdm_lookup(const char *name);
 int voltdm_scale(struct voltagedomain *voltdm, unsigned long target_volt);
 unsigned long voltdm_get_voltage(struct voltagedomain *voltdm);
-
+struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
+		unsigned long volt);
 #endif
-- 
1.7.5.4

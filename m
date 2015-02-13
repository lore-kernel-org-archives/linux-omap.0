From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 09/33] ARM: OMAP3+: PRM: add common APIs for prm_vp_check/clear_txdone
Date: Fri, 13 Feb 2015 18:12:28 +0200
Message-ID: <1423843973-6050-7-git-send-email-t-kristo@ti.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46907 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753571AbbBMQOC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 11:14:02 -0500
In-Reply-To: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, tomi.valkeinen@ti.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

PRM driver now only exports a generic API for clearing / checking
VP txdone status.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm.h          |   14 ++++++++++++++
 arch/arm/mach-omap2/prm3xxx.c      |    6 ++++--
 arch/arm/mach-omap2/prm3xxx.h      |    4 ----
 arch/arm/mach-omap2/prm44xx.c      |    6 ++++--
 arch/arm/mach-omap2/prm44xx_54xx.h |    4 ----
 arch/arm/mach-omap2/prm_common.c   |   34 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/vp.h           |    9 ---------
 arch/arm/mach-omap2/vp3xxx_data.c  |    4 ++--
 arch/arm/mach-omap2/vp44xx_data.c  |    4 ++--
 9 files changed, 60 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 14d504b..6521eaa 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -146,6 +146,8 @@ struct prm_ll_data {
 				     u16 offset);
 	void (*reset_system)(void);
 	int (*clear_mod_irqs)(s16 module, u8 regs, u32 wkst_mask);
+	u32 (*vp_check_txdone)(u8 vp_id);
+	void (*vp_clear_txdone)(u8 vp_id);
 };
 
 extern int prm_register(struct prm_ll_data *pld);
@@ -163,6 +165,18 @@ void omap_prm_reset_system(void);
 void omap_prm_reconfigure_io_chain(void);
 int omap_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask);
 
+/*
+ * Voltage Processor (VP) identifiers
+ */
+#define OMAP3_VP_VDD_MPU_ID	0
+#define OMAP3_VP_VDD_CORE_ID	1
+#define OMAP4_VP_VDD_CORE_ID	0
+#define OMAP4_VP_VDD_IVA_ID	1
+#define OMAP4_VP_VDD_MPU_ID	2
+
+u32 omap_prm_vp_check_txdone(u8 vp_id);
+void omap_prm_vp_clear_txdone(u8 vp_id);
+
 #endif
 
 
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 95fed03..8993ab7 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -96,7 +96,7 @@ static struct omap3_vp omap3_vp[] = {
 
 #define MAX_VP_ID ARRAY_SIZE(omap3_vp);
 
-u32 omap3_prm_vp_check_txdone(u8 vp_id)
+static u32 omap3_prm_vp_check_txdone(u8 vp_id)
 {
 	struct omap3_vp *vp = &omap3_vp[vp_id];
 	u32 irqstatus;
@@ -106,7 +106,7 @@ u32 omap3_prm_vp_check_txdone(u8 vp_id)
 	return irqstatus & vp->tranxdone_status;
 }
 
-void omap3_prm_vp_clear_txdone(u8 vp_id)
+static void omap3_prm_vp_clear_txdone(u8 vp_id)
 {
 	struct omap3_vp *vp = &omap3_vp[vp_id];
 
@@ -665,6 +665,8 @@ static struct prm_ll_data omap3xxx_prm_ll_data = {
 	.is_hardreset_asserted = &omap2_prm_is_hardreset_asserted,
 	.reset_system = &omap3xxx_prm_dpll3_reset,
 	.clear_mod_irqs = &omap3xxx_prm_clear_mod_irqs,
+	.vp_check_txdone = &omap3_prm_vp_check_txdone,
+	.vp_clear_txdone = &omap3_prm_vp_clear_txdone,
 };
 
 int __init omap3xxx_prm_init(void)
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index 5a09a74..55e4c89 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -132,10 +132,6 @@
 
 #ifndef __ASSEMBLER__
 
-/* OMAP3-specific VP functions */
-u32 omap3_prm_vp_check_txdone(u8 vp_id);
-void omap3_prm_vp_clear_txdone(u8 vp_id);
-
 /*
  * OMAP3 access functions for voltage controller (VC) and
  * voltage proccessor (VP) in the PRM.
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index cc170fb..0f0e49f 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -137,7 +137,7 @@ static struct omap4_vp omap4_vp[] = {
 	},
 };
 
-u32 omap4_prm_vp_check_txdone(u8 vp_id)
+static u32 omap4_prm_vp_check_txdone(u8 vp_id)
 {
 	struct omap4_vp *vp = &omap4_vp[vp_id];
 	u32 irqstatus;
@@ -148,7 +148,7 @@ u32 omap4_prm_vp_check_txdone(u8 vp_id)
 	return irqstatus & vp->tranxdone_status;
 }
 
-void omap4_prm_vp_clear_txdone(u8 vp_id)
+static void omap4_prm_vp_clear_txdone(u8 vp_id)
 {
 	struct omap4_vp *vp = &omap4_vp[vp_id];
 
@@ -698,6 +698,8 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 	.deassert_hardreset	= omap4_prminst_deassert_hardreset,
 	.is_hardreset_asserted	= omap4_prminst_is_hardreset_asserted,
 	.reset_system		= omap4_prminst_global_warm_sw_reset,
+	.vp_check_txdone	= omap4_prm_vp_check_txdone,
+	.vp_clear_txdone	= omap4_prm_vp_clear_txdone,
 };
 
 int __init omap44xx_prm_init(void)
diff --git a/arch/arm/mach-omap2/prm44xx_54xx.h b/arch/arm/mach-omap2/prm44xx_54xx.h
index 7143295..a470185 100644
--- a/arch/arm/mach-omap2/prm44xx_54xx.h
+++ b/arch/arm/mach-omap2/prm44xx_54xx.h
@@ -26,10 +26,6 @@
 /* Function prototypes */
 #ifndef __ASSEMBLER__
 
-/* OMAP4/OMAP5-specific VP functions */
-u32 omap4_prm_vp_check_txdone(u8 vp_id);
-void omap4_prm_vp_clear_txdone(u8 vp_id);
-
 /*
  * OMAP4/OMAP5 access functions for voltage controller (VC) and
  * voltage proccessor (VP) in the PRM.
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 772b8f6..c0bfc92 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -544,6 +544,40 @@ int omap_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask)
 }
 
 /**
+ * omap_prm_vp_check_txdone - check voltage processor TX done status
+ *
+ * Checks if voltage processor transmission has been completed.
+ * Returns non-zero if a transmission has completed, 0 otherwise.
+ */
+u32 omap_prm_vp_check_txdone(u8 vp_id)
+{
+	if (!prm_ll_data->vp_check_txdone) {
+		WARN_ONCE(1, "prm: %s: no mapping function defined\n",
+			  __func__);
+		return 0;
+	}
+
+	return prm_ll_data->vp_check_txdone(vp_id);
+}
+
+/**
+ * omap_prm_vp_clear_txdone - clears voltage processor TX done status
+ *
+ * Clears the status bit for completed voltage processor transmission
+ * returned by prm_vp_check_txdone.
+ */
+void omap_prm_vp_clear_txdone(u8 vp_id)
+{
+	if (!prm_ll_data->vp_clear_txdone) {
+		WARN_ONCE(1, "prm: %s: no mapping function defined\n",
+			  __func__);
+		return;
+	}
+
+	prm_ll_data->vp_clear_txdone(vp_id);
+}
+
+/**
  * prm_register - register per-SoC low-level data with the PRM
  * @pld: low-level per-SoC OMAP PRM data & function pointers to register
  *
diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
index 0fdf7080..7e08296 100644
--- a/arch/arm/mach-omap2/vp.h
+++ b/arch/arm/mach-omap2/vp.h
@@ -21,15 +21,6 @@
 
 struct voltagedomain;
 
-/*
- * Voltage Processor (VP) identifiers
- */
-#define OMAP3_VP_VDD_MPU_ID 0
-#define OMAP3_VP_VDD_CORE_ID 1
-#define OMAP4_VP_VDD_CORE_ID 0
-#define OMAP4_VP_VDD_IVA_ID 1
-#define OMAP4_VP_VDD_MPU_ID 2
-
 /* XXX document */
 #define VP_IDLE_TIMEOUT		200
 #define VP_TRANXDONE_TIMEOUT	300
diff --git a/arch/arm/mach-omap2/vp3xxx_data.c b/arch/arm/mach-omap2/vp3xxx_data.c
index 1914e02..b0590fe 100644
--- a/arch/arm/mach-omap2/vp3xxx_data.c
+++ b/arch/arm/mach-omap2/vp3xxx_data.c
@@ -28,8 +28,8 @@
 #include "prm2xxx_3xxx.h"
 
 static const struct omap_vp_ops omap3_vp_ops = {
-	.check_txdone = omap3_prm_vp_check_txdone,
-	.clear_txdone = omap3_prm_vp_clear_txdone,
+	.check_txdone = omap_prm_vp_check_txdone,
+	.clear_txdone = omap_prm_vp_clear_txdone,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/vp44xx_data.c b/arch/arm/mach-omap2/vp44xx_data.c
index e62f6b0..2448bb9 100644
--- a/arch/arm/mach-omap2/vp44xx_data.c
+++ b/arch/arm/mach-omap2/vp44xx_data.c
@@ -28,8 +28,8 @@
 #include "vp.h"
 
 static const struct omap_vp_ops omap4_vp_ops = {
-	.check_txdone = omap4_prm_vp_check_txdone,
-	.clear_txdone = omap4_prm_vp_clear_txdone,
+	.check_txdone = omap_prm_vp_check_txdone,
+	.clear_txdone = omap_prm_vp_clear_txdone,
 };
 
 /*
-- 
1.7.9.5


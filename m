From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv3 18/22] OMAP3: PM: Optional reset of voltage during Smartreflex disable.
Date: Fri, 16 Apr 2010 14:33:13 +0530
Message-ID: <1271408597-3066-19-git-send-email-thara@ti.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
 <1271408597-3066-2-git-send-email-thara@ti.com>
 <1271408597-3066-3-git-send-email-thara@ti.com>
 <1271408597-3066-4-git-send-email-thara@ti.com>
 <1271408597-3066-5-git-send-email-thara@ti.com>
 <1271408597-3066-6-git-send-email-thara@ti.com>
 <1271408597-3066-7-git-send-email-thara@ti.com>
 <1271408597-3066-8-git-send-email-thara@ti.com>
 <1271408597-3066-9-git-send-email-thara@ti.com>
 <1271408597-3066-10-git-send-email-thara@ti.com>
 <1271408597-3066-11-git-send-email-thara@ti.com>
 <1271408597-3066-12-git-send-email-thara@ti.com>
 <1271408597-3066-13-git-send-email-thara@ti.com>
 <1271408597-3066-14-git-send-email-thara@ti.com>
 <1271408597-3066-15-git-send-email-thara@ti.com>
 <1271408597-3066-16-git-send-email-thara@ti.com>
 <1271408597-3066-17-git-send-email-thara@ti.com>
 <1271408597-3066-18-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55668 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756995Ab0DPJDb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Apr 2010 05:03:31 -0400
In-Reply-To: <1271408597-3066-18-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

Currently whenever smartreflex is disabled the voltage for the
particular VDD is reset to the non-smartreflex compensated level.
This step is unnecessary during dvfs because anyways in the next couple
of steps before re-enabling smartreflex , the voltage level is changed.

This patch adds the flexibility in the smartreflex framework for the user
to specify whether or not a voltage reset is required after disabling
of smartrefelx. The smartreflex driver just passes on this info
to the smartreflex class driver, which ultimately takes the
decision to reset the voltage or not.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c             |    4 ++--
 arch/arm/mach-omap2/smartreflex-class3.c |    5 +++--
 arch/arm/mach-omap2/smartreflex.c        |   10 +++++++---
 arch/arm/mach-omap2/smartreflex.h        |    4 ++--
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index f3994c0..f6c1df3 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -415,9 +415,9 @@ void omap_sram_idle(void)
 	 * Only needed if we are going to enter retention or off.
 	 */
 	if (mpu_next_state <= PWRDM_POWER_RET)
-		omap_smartreflex_disable(VDD1);
+		omap_smartreflex_disable(VDD1, 1);
 	if (core_next_state <= PWRDM_POWER_RET)
-		omap_smartreflex_disable(VDD2);
+		omap_smartreflex_disable(VDD2, 1);
 
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 53bfd05..f1d6027 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -30,11 +30,12 @@ static int sr_class3_enable(int id)
 	return sr_enable(id, volt);
 }
 
-static int sr_class3_disable(int id)
+static int sr_class3_disable(int id, int is_volt_reset)
 {
 	omap_voltageprocessor_disable(id);
 	sr_disable(id);
-	omap_reset_voltage(id);
+	if (is_volt_reset)
+		omap_reset_voltage(id);
 
 	return true;
 }
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index eed7f9b..6b7d9aa 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -226,7 +226,7 @@ static void  sr_stop_vddautocomp(struct omap_sr *sr)
 	}
 
 	if (sr->is_autocomp_active == 1) {
-		sr_class->disable(sr->srid);
+		sr_class->disable(sr->srid, 1);
 		sr_clk_disable(sr);
 		sr->is_autocomp_active = 0;
 	}
@@ -506,12 +506,16 @@ void omap_smartreflex_enable(int srid)
  * omap_smartreflex_disable : API to disable SR clocks and to call into the
  * registered smartreflex class disable API.
  * @srid - The id of the sr module to be disabled.
+ * @is_volt_reset - Whether the voltage needs to be reset after disabling
+ *		    smartreflex module or not. This parameter is directly
+ *		    passed on to the smartreflex class disable which takes the
+ *		    appropriate action.
  *
  * This API is to be called from the kernel in order to disable
  * a particular smartreflex module. This API will in turn call
  * into the registered smartreflex class disable API.
  */
-void omap_smartreflex_disable(int srid)
+void omap_smartreflex_disable(int srid, int is_volt_reset)
 {
 	struct omap_sr *sr = _sr_lookup(srid);
 
@@ -528,7 +532,7 @@ void omap_smartreflex_disable(int srid)
 
 	if (sr->is_autocomp_active == 1) {
 		if (sr->is_sr_reset == 0) {
-			sr_class->disable(srid);
+			sr_class->disable(srid, is_volt_reset);
 			/* Disable SR clk */
 			sr_clk_disable(sr);
 		}
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 9cc3204..476a3b6 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -180,7 +180,7 @@ struct omap_smartreflex_dev_data {
  */
 struct omap_smartreflex_class_data {
 	int (*enable)(int sr_id);
-	int (*disable)(int sr_id);
+	int (*disable)(int sr_id, int is_volt_reset);
 	void (*configure)(int sr_id);
 	int (*notify)(int sr_id, u32 status);
 	u8 notify_flags;
@@ -216,7 +216,7 @@ struct omap_smartreflex_data {
  * do anything.
  */
 void omap_smartreflex_enable(int srid);
-void omap_smartreflex_disable(int srid);
+void omap_smartreflex_disable(int srid, int is_volt_reset);
 
 /*
  * Smartreflex driver hooks to be called from Smartreflex class driver
-- 
1.7.0.rc1.33.g07cf0f


From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 06/55] ARM: OMAP3/4: PRM: add support of late_init call to prm_ll_ops
Date: Mon, 31 Mar 2014 18:15:45 +0300
Message-ID: <1396278994-12624-7-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39084 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752801AbaCaPRX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:17:23 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

SoC specific late_init call is now registered during PRM init, and will
be called automatically by PRM core. This helps to get rid of some
redundant initcalls and cpu_is_X checks from the PRM code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm.h        |    2 ++
 arch/arm/mach-omap2/prm3xxx.c    |    7 +++----
 arch/arm/mach-omap2/prm44xx.c    |    7 +++----
 arch/arm/mach-omap2/prm_common.c |    8 ++++++++
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 04426c4..48480d5 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -126,6 +126,7 @@ struct prm_reset_src_map {
  * @read_reset_sources: ptr to the SoC PRM-specific get_reset_source impl
  * @was_any_context_lost_old: ptr to the SoC PRM context loss test fn
  * @clear_context_loss_flags_old: ptr to the SoC PRM context loss flag clear fn
+ * @late_init: ptr to the late init function
  *
  * XXX @was_any_context_lost_old and @clear_context_loss_flags_old are
  * deprecated.
@@ -134,6 +135,7 @@ struct prm_ll_data {
 	u32 (*read_reset_sources)(void);
 	bool (*was_any_context_lost_old)(u8 part, s16 inst, u16 idx);
 	void (*clear_context_loss_flags_old)(u8 part, s16 inst, u16 idx);
+	int (*late_init)(void);
 };
 
 extern int prm_register(struct prm_ll_data *pld);
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index fcbe854..f92de79 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -634,8 +634,11 @@ struct pwrdm_ops omap3_pwrdm_operations = {
  *
  */
 
+static int omap3xxx_prm_late_init(void);
+
 static struct prm_ll_data omap3xxx_prm_ll_data = {
 	.read_reset_sources = &omap3xxx_prm_read_reset_sources,
+	.late_init = &omap3xxx_prm_late_init,
 };
 
 int __init omap3xxx_prm_init(void)
@@ -650,9 +653,6 @@ static int __init omap3xxx_prm_late_init(void)
 {
 	int ret;
 
-	if (!cpu_is_omap34xx())
-		return 0;
-
 	if (!(prm_features & PRM_HAS_IO_WAKEUP))
 		return 0;
 
@@ -664,7 +664,6 @@ static int __init omap3xxx_prm_late_init(void)
 
 	return ret;
 }
-omap_subsys_initcall(omap3xxx_prm_late_init);
 
 static void __exit omap3xxx_prm_exit(void)
 {
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index dc357df..60b9b05 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -650,6 +650,8 @@ struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_has_voltdm	= omap4_check_vcvp,
 };
 
+static int omap44xx_prm_late_init(void);
+
 /*
  * XXX document
  */
@@ -657,6 +659,7 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 	.read_reset_sources = &omap44xx_prm_read_reset_sources,
 	.was_any_context_lost_old = &omap44xx_prm_was_any_context_lost_old,
 	.clear_context_loss_flags_old = &omap44xx_prm_clear_context_loss_flags_old,
+	.late_init = &omap44xx_prm_late_init,
 };
 
 int __init omap44xx_prm_init(void)
@@ -669,9 +672,6 @@ int __init omap44xx_prm_init(void)
 
 static int __init omap44xx_prm_late_init(void)
 {
-	if (!cpu_is_omap44xx())
-		return 0;
-
 	if (!(prm_features & PRM_HAS_IO_WAKEUP))
 		return 0;
 
@@ -679,7 +679,6 @@ static int __init omap44xx_prm_late_init(void)
 
 	return omap_prcm_register_chain_handler(&omap4_prcm_irq_setup);
 }
-omap_subsys_initcall(omap44xx_prm_late_init);
 
 static void __exit omap44xx_prm_exit(void)
 {
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index f98c01a..76ca320 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -529,3 +529,11 @@ int __init of_prcm_init(void)
 
 	return 0;
 }
+
+static int __init prm_late_init(void)
+{
+	if (prm_ll_data->late_init)
+		return prm_ll_data->late_init();
+	return 0;
+}
+subsys_initcall(prm_late_init);
-- 
1.7.9.5


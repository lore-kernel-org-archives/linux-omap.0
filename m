From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 09/35] ARM: OMAP2+: hwmod: move omap_hwmod_init_postsetup to hwmod driver
Date: Wed, 15 Apr 2015 15:52:56 +0300
Message-ID: <1429102402-5276-10-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35741 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755371AbbDOMwt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 08:52:49 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

Previously this function was incorrectly implemented under low level
IO init. However, this API will be needed for late hwmod data module
init also, so move it to the generic hwmod codebase, and export the
function also for module use.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c         |   20 --------------------
 arch/arm/mach-omap2/omap_hwmod.c |   38 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.h |    2 ++
 3 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index c4871c5..c2b80b8 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -351,26 +351,6 @@ static int __init _omap2_init_reprogram_sdrc(void)
 	return v;
 }
 
-static int _set_hwmod_postsetup_state(struct omap_hwmod *oh, void *data)
-{
-	return omap_hwmod_set_postsetup_state(oh, *(u8 *)data);
-}
-
-static void __init omap_hwmod_init_postsetup(void)
-{
-	u8 postsetup_state;
-
-	/* Set the default postsetup state for all hwmods */
-#ifdef CONFIG_PM
-	postsetup_state = _HWMOD_STATE_IDLE;
-#else
-	postsetup_state = _HWMOD_STATE_ENABLED;
-#endif
-	omap_hwmod_for_each(_set_hwmod_postsetup_state, &postsetup_state);
-
-	omap_pm_if_early_init();
-}
-
 static void __init __maybe_unused omap_common_late_init(void)
 {
 	omap_mux_late_init();
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 6e7b541..d20179a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3879,6 +3879,44 @@ ohsps_unlock:
 }
 
 /**
+ * _set_hwmod_postsetup_state - set postsetup state for a single hwmod
+ * @oh: hwmod to set postsetup state for
+ * @data: postsetup state
+ *
+ * Wrapper function for setting the postsetup state for a single hwmod.
+ * Forces return value to zero, so that we don't bail out with an error
+ * value returned from omap_hwmod_set_postsetup_state(); with hwmod data
+ * split to module + early init portions, the postsetup init will be
+ * called twice for some hwmods, but we still want to setup the state for
+ * all and not abort with the first hwmod complaining about its postsetup
+ * state being set already. Returns 0 always.
+ */
+static int _set_hwmod_postsetup_state(struct omap_hwmod *oh, void *data)
+{
+	omap_hwmod_set_postsetup_state(oh, *(u8 *)data);
+	return 0;
+}
+
+/**
+ * omap_hwmod_init_postsetup - initialize postsetup state for all hwmods
+ *
+ * Sets the hwmod postsetup state for all hwmods based on PM configuration.
+ */
+void omap_hwmod_init_postsetup(void)
+{
+	u8 postsetup_state;
+
+	/* Set the default postsetup state for all hwmods */
+#ifdef CONFIG_PM
+	postsetup_state = _HWMOD_STATE_IDLE;
+#else
+	postsetup_state = _HWMOD_STATE_ENABLED;
+#endif
+	omap_hwmod_for_each(_set_hwmod_postsetup_state, &postsetup_state);
+}
+EXPORT_SYMBOL(omap_hwmod_init_postsetup);
+
+/**
  * omap_hwmod_get_context_loss_count - get lost context count
  * @oh: struct omap_hwmod *
  *
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index fe75d38..6da0524 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -729,6 +729,8 @@ int omap_hwmod_for_each_by_class(const char *classname,
 int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
 int omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
 
+void omap_hwmod_init_postsetup(void);
+
 extern void __init omap_hwmod_init(void);
 
 const char *omap_hwmod_get_main_clk(struct omap_hwmod *oh);
-- 
1.7.9.5


From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] OMAP2/3/4: ioremap address space
Date: Tue, 26 Jan 2010 14:10:10 +0530
Message-ID: <1264495210-17344-2-git-send-email-santosh.shilimkar@ti.com>
References: <1264495210-17344-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40784 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860Ab0AZIkT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jan 2010 03:40:19 -0500
In-Reply-To: <1264495210-17344-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

This patch update the sdrc, prcm, tap and control module to
allocate iospace dynamically

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
CC: Kevin Hilman <khilman@deeprootsystems.com>
CC: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/control.c |    6 +++++-
 arch/arm/mach-omap2/id.c      |    7 ++++++-
 arch/arm/mach-omap2/prcm.c    |   16 +++++++++++++---
 arch/arm/mach-omap2/sdrc.c    |   11 +++++++++--
 4 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index cdd1f35..43f8a33 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -140,7 +140,11 @@ static struct omap3_control_regs control_context;
 
 void __init omap2_set_globals_control(struct omap_globals *omap2_globals)
 {
-	omap2_ctrl_base = omap2_globals->ctrl;
+	/* Static mapping, never released */
+	if (omap2_globals->ctrl) {
+		omap2_ctrl_base = ioremap(omap2_globals->ctrl, SZ_4K);
+		WARN_ON(!omap2_ctrl_base);
+	}
 }
 
 void __iomem *omap_ctrl_base_get(void)
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index a091b53..fb5921b 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -407,7 +407,12 @@ void __init omap2_check_revision(void)
 void __init omap2_set_globals_tap(struct omap_globals *omap2_globals)
 {
 	omap_revision = omap2_globals->class;
-	tap_base = omap2_globals->tap;
+
+	/* Static mapping, never released */
+	if (omap2_globals->tap) {
+		tap_base = ioremap(omap2_globals->tap, SZ_4K);
+		WARN_ON(!tap_base);
+	}
 
 	if (cpu_is_omap34xx())
 		tap_prod_id = 0x0210;
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 3ea8177..56682b8 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -257,9 +257,19 @@ int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, const char *name)
 
 void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
 {
-	prm_base = omap2_globals->prm;
-	cm_base = omap2_globals->cm;
-	cm2_base = omap2_globals->cm2;
+	/* Static mapping, never released */
+	if (omap2_globals->prm) {
+		prm_base = ioremap(omap2_globals->prm, SZ_8K);
+		WARN_ON(!prm_base);
+	}
+	if (omap2_globals->cm) {
+		cm_base = ioremap(omap2_globals->cm, SZ_8K);
+		WARN_ON(!cm_base);
+	}
+	if (omap2_globals->cm2) {
+		cm2_base = ioremap(omap2_globals->cm2, SZ_8K);
+		WARN_ON(!cm2_base);
+	}
 }
 
 #ifdef CONFIG_ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index cbfbd14..4c65f56 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -119,8 +119,15 @@ int omap2_sdrc_get_params(unsigned long r,
 
 void __init omap2_set_globals_sdrc(struct omap_globals *omap2_globals)
 {
-	omap2_sdrc_base = omap2_globals->sdrc;
-	omap2_sms_base = omap2_globals->sms;
+	/* Static mapping, never released */
+	if (omap2_globals->sdrc) {
+		omap2_sdrc_base = ioremap(omap2_globals->sdrc, SZ_64K);
+		WARN_ON(!omap2_sdrc_base);
+	}
+	if (omap2_globals->sms) {
+		omap2_sms_base = ioremap(omap2_globals->sms, SZ_64K);
+		WARN_ON(!omap2_sms_base);
+	}
 }
 
 /**
-- 
1.6.0.4


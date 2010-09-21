From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv3 17/17] dmtimer: remove OCP config code from plat-omap
Date: Tue, 21 Sep 2010 14:26:44 +0530
Message-ID: <1285059404-26718-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48563 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094Ab0ITVzv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Sep 2010 17:55:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Partha Basak <p-basak2@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

This patch removes the ocp config code from omap-plat
because they are supposed to be taken care of by the
hwmod framework. Specifically, following changes are
incorporated:
(1) setting of smart-idle and wakeup-enable is already
taken care in existing code and so they are simply removed
from plat-omap
(2) clockactivity configuration is not present in the present
hwmod database. Therefore this filed is initialized to '1' in
respective database.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Partha Basak <p-basak2@ti.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    1 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    1 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
 arch/arm/plat-omap/dmtimer.c               |   11 -----------
 5 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index fc761a5..25111bf 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -168,6 +168,7 @@ static struct omap_hwmod_class_sysconfig omap2420_timer_sysc = {
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
 			   SYSC_HAS_AUTOIDLE),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.clockact       = 1, /* preserve fclk on idle */
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 2ac463f..93d5c3d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -174,6 +174,7 @@ static struct omap_hwmod_class_sysconfig omap2430_timer_sysc = {
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
 			   SYSC_HAS_AUTOIDLE),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.clockact       = 1, /* preserve fclk on idle */
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 1ce40e0..c64c95b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -147,6 +147,7 @@ static struct omap_hwmod_class_sysconfig omap3xxx_timer_1ms_sysc = {
 				SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
 				SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.clockact       = 1, /* preserve fclk on idle */
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 9edc518..a816d30 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -538,6 +538,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_timer_1ms_sysc = {
 			   SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE |
 			   SYSS_MISSING),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.clockact	= 1, /* preserve fclk on idle */
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 7d57605..6211501 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -157,17 +157,6 @@ static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 	}
 	omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
 
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
-	l |= 0x02 << 3;  /* Set to smart-idle mode */
-	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on idle */
-
-	/*
-	 * Enable wake-up on OMAP2 CPUs.
-	 */
-	if (cpu_class_is_omap2())
-		l |= 1 << 2;
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
-
 	/* Match hardware reset default of posted mode */
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
 			OMAP_TIMER_CTRL_POSTED);
-- 
1.6.0.4


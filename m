From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/3] OMAP3: PM: update DSP reset code to use new SCM DSP boot control functions
Date: Fri, 22 Oct 2010 20:05:00 -0500
Message-ID: <1287795901-28613-2-git-send-email-omar.ramirez@ti.com>
References: <1287795901-28613-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38166 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752618Ab0JWBPO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Oct 2010 21:15:14 -0400
In-Reply-To: <1287795901-28613-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kalle Jokiniemi <kalle.jokiniemi@digia.com>, Rajendra Nayak <rnayak@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Tero Kristo <tero.kristo@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Rene Sapiens <rene.sapiens@ti.com>, Ernesto Ramos <ernesto@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

From: Paul Walmsley <paul@pwsan.com>

Update the DSP reset code in pm34xx.c to use one of the new SCM DSP
boot control functions, omap2430_ctrl_set_dsp_bootmode().

This reset code should be moved out to a separate function to be
called by the hwmod reset process at some point.  Also, 2430
should be initializing the DSP in a similar fashion.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8c8f1ac..b90b1fb 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -37,6 +37,7 @@
 #include <plat/prcm.h>
 #include <plat/gpmc.h>
 #include <plat/dma.h>
+#include <plat/iva2_dsp.h>
 
 #include <asm/tlbflush.h>
 
@@ -614,6 +615,7 @@ static struct platform_suspend_ops omap_pm_ops = {
  * function forces the IVA2 into idle state so it can go
  * into retention/off and thus allow full-chip retention/off.
  *
+ * XXX This should be handled by the hwmod.
  **/
 static void __init omap3_iva_idle(void)
 {
@@ -635,9 +637,7 @@ static void __init omap3_iva_idle(void)
 	cm_write_mod_reg(OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_MASK,
 			 OMAP3430_IVA2_MOD, CM_FCLKEN);
 
-	/* Set IVA2 boot mode to 'idle' */
-	omap_ctrl_writel(OMAP3_IVA2_BOOTMOD_IDLE,
-			 OMAP343X_CONTROL_IVA2_BOOTMOD);
+	omap2430_ctrl_set_dsp_bootmode(OMAP_IVA2_DSP_BOOTMODE_IDLE);
 
 	/* Un-reset IVA2 */
 	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
-- 
1.7.1


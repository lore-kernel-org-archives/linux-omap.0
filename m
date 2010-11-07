From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/5] omap: pm: use control functions in DSP reset code
Date: Sun,  7 Nov 2010 23:43:27 +0200
Message-ID: <1289166209-32251-4-git-send-email-felipe.contreras@gmail.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44122 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab0KGVou (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Nov 2010 16:44:50 -0500
Received: by mail-fx0-f46.google.com with SMTP id 16so3600214fxm.19
        for <linux-omap@vger.kernel.org>; Sun, 07 Nov 2010 13:44:50 -0800 (PST)
In-Reply-To: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

From: Paul Walmsley <paul@pwsan.com>

Update the DSP reset code in pm34xx.c to use one of the new SCM DSP boot
control functions, omap_ctrl_set_dsp_bootmode().

This reset code should be moved out to a separate function to be called
by the hwmod reset process at some point.  Also, 2430 should be
initializing the DSP in a similar fashion.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/pm34xx.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 75c0cd1..86e7e99 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -37,6 +37,7 @@
 #include <plat/prcm.h>
 #include <plat/gpmc.h>
 #include <plat/dma.h>
+#include <plat/dsp.h>
 
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
+	omap_ctrl_set_dsp_bootmode(OMAP_DSP_BOOTMODE_IDLE);
 
 	/* Un-reset IVA2 */
 	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
-- 
1.7.3.2.3.gf8529


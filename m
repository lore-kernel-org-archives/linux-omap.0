From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP3: clock: use std _MASK suffix for CM_FCLKEN_IVA2 defines
Date: Mon, 18 Jan 2010 10:29:43 -0800
Message-ID: <1263839383-12275-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:33800 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067Ab0ARS3r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 13:29:47 -0500
Received: by yxe17 with SMTP id 17so3888753yxe.33
        for <linux-omap@vger.kernel.org>; Mon, 18 Jan 2010 10:29:46 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add _MASK suffix to CM_FCLKEN_IVA2 bitfieds to conform with the rest
of the usage in cm-regbits-34xx.h of using _SHIFT and _MASK suffixes.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/cm-regbits-34xx.h |    2 +-
 arch/arm/mach-omap2/pm34xx.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 6923deb..a76e835 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -55,7 +55,7 @@
 /* Bits specific to each register */
 
 /* CM_FCLKEN_IVA2 */
-#define OMAP3430_CM_FCLKEN_IVA2_EN_IVA2			(1 << 0)
+#define OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_MASK		(1 << 0)
 #define OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_SHIFT		0
 
 /* CM_CLKEN_PLL_IVA2 */
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c6cc809..045fd59 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -675,7 +675,7 @@ static void __init omap3_iva_idle(void)
 			  OMAP3430_IVA2_MOD, RM_RSTCTRL);
 
 	/* Enable IVA2 clock */
-	cm_write_mod_reg(OMAP3430_CM_FCLKEN_IVA2_EN_IVA2,
+	cm_write_mod_reg(OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_MASK,
 			 OMAP3430_IVA2_MOD, CM_FCLKEN);
 
 	/* Set IVA2 boot mode to 'idle' */
-- 
1.6.6


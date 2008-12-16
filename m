From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 3/3] OMAP3: PM: enable gptimer12 as a wakeup source
Date: Tue, 16 Dec 2008 10:34:10 -0800
Message-ID: <1229452450-22497-4-git-send-email-khilman@deeprootsystems.com>
References: <1229452450-22497-1-git-send-email-khilman@deeprootsystems.com>
 <1229452450-22497-2-git-send-email-khilman@deeprootsystems.com>
 <1229452450-22497-3-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f31.google.com ([209.85.219.31]:47421 "EHLO
	mail-ew0-f31.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbYLPSed (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2008 13:34:33 -0500
Received: by mail-ew0-f31.google.com with SMTP id 12so3425524ewy.13
        for <linux-omap@vger.kernel.org>; Tue, 16 Dec 2008 10:34:32 -0800 (PST)
In-Reply-To: <1229452450-22497-3-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

GPT12 is in the WKUP powerdomain and can be useful as the system timer
and thus a wakeup source for sleep while idle.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c      |    6 ++++--
 arch/arm/mach-omap2/prcm-common.h |    2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index bd74183..8e3c257 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -505,10 +505,12 @@ static void __init prcm_setup_regs(void)
 			     OMAP3_PRM_CLKSRC_CTRL_OFFSET);
 
 	/* setup wakup source */
-	prm_write_mod_reg(OMAP3430_EN_IO | OMAP3430_EN_GPIO1 | OMAP3430_EN_GPT1,
+	prm_write_mod_reg(OMAP3430_EN_IO | OMAP3430_EN_GPIO1 |
+			  OMAP3430_EN_GPT1 | OMAP3430_EN_GPT12,
 			  WKUP_MOD, PM_WKEN);
 	/* No need to write EN_IO, that is always enabled */
-	prm_write_mod_reg(OMAP3430_EN_GPIO1 | OMAP3430_EN_GPT1,
+	prm_write_mod_reg(OMAP3430_EN_GPIO1 | OMAP3430_EN_GPT1 |
+			  OMAP3430_EN_GPT12,
 			  WKUP_MOD, OMAP3430_PM_MPUGRPSEL);
 	/* For some reason IO doesn't generate wakeup event even if
 	 * it is selected to mpu wakeup goup */
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 812d50e..cb1ae84 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -276,6 +276,8 @@
 /* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
 #define OMAP3430_EN_GPIO1				(1 << 3)
 #define OMAP3430_EN_GPIO1_SHIFT				3
+#define OMAP3430_EN_GPT12				(1 << 1)
+#define OMAP3430_EN_GPT12_SHIFT				1
 #define OMAP3430_EN_GPT1				(1 << 0)
 #define OMAP3430_EN_GPT1_SHIFT				0
 
-- 
1.6.0.3


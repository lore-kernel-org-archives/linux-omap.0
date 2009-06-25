From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 02/11] OMAP2/3: PM: make PM __init calls static
Date: Thu, 25 Jun 2009 09:41:55 -0700
Message-ID: <1245948124-24111-3-git-send-email-khilman@deeprootsystems.com>
References: <1245948124-24111-1-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f190.google.com ([209.85.216.190]:49012 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287AbZFYQma (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 12:42:30 -0400
Received: by mail-px0-f190.google.com with SMTP id 28so1148479pxi.33
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 09:42:34 -0700 (PDT)
In-Reply-To: <1245948124-24111-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm.h     |    3 ---
 arch/arm/mach-omap2/pm24xx.c |    2 +-
 arch/arm/mach-omap2/pm34xx.c |    2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index f7b3baf..21201cd 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -11,9 +11,6 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_PM_H
 #define __ARCH_ARM_MACH_OMAP2_PM_H
 
-extern int omap2_pm_init(void);
-extern int omap3_pm_init(void);
-
 #ifdef CONFIG_PM_DEBUG
 extern void omap2_pm_dump(int mode, int resume, unsigned int us);
 extern int omap2_pm_debug;
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index db10255..528dbdc 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -470,7 +470,7 @@ static void __init prcm_setup_regs(void)
 			  WKUP_MOD, PM_WKEN);
 }
 
-int __init omap2_pm_init(void)
+static int __init omap2_pm_init(void)
 {
 	u32 l;
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 841d4c5..765cdc0 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -652,7 +652,7 @@ static int __init clkdms_setup(struct clockdomain *clkdm)
 	return 0;
 }
 
-int __init omap3_pm_init(void)
+static int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst, *tmp;
 	int ret;
-- 
1.6.3.2


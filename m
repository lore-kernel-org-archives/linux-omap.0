From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 11/11] OMAP3: PM: prevent module wakeups from waking IVA2
Date: Fri, 15 May 2009 11:40:51 -0700
Message-ID: <1242412851-16606-12-git-send-email-khilman@deeprootsystems.com>
References: <1242412851-16606-1-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-2-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-3-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-4-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-5-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-6-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-7-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-8-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-9-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-10-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-11-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f115.google.com ([209.85.222.115]:64443 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163AbZEOSlb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2009 14:41:31 -0400
Received: by mail-pz0-f115.google.com with SMTP id 13so1205834pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 15 May 2009 11:41:32 -0700 (PDT)
In-Reply-To: <1242412851-16606-11-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

By default, prevent functional wakeups from inside a module from
waking up the IVA2.  Let DSP Bridge code handle this when loaded.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    6 ++++++
 arch/arm/mach-omap2/prm.h    |    2 ++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7ed01e5..22d686e 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -601,6 +601,12 @@ static void __init prcm_setup_regs(void)
 	prm_write_mod_reg(OMAP3430_IO_EN | OMAP3430_WKUP_EN,
 			  OCP_MOD, OMAP3_PRM_IRQENABLE_MPU_OFFSET);
 
+	/* Don't attach IVA interrupts */
+	prm_write_mod_reg(0, WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
+	prm_write_mod_reg(0, CORE_MOD, OMAP3430_PM_IVAGRPSEL1);
+	prm_write_mod_reg(0, CORE_MOD, OMAP3430ES2_PM_IVAGRPSEL3);
+	prm_write_mod_reg(0, OMAP3430_PER_MOD, OMAP3430_PM_IVAGRPSEL);
+
 	/* Clear any pending 'reset' flags */
 	prm_write_mod_reg(0xffffffff, MPU_MOD, RM_RSTST);
 	prm_write_mod_reg(0xffffffff, CORE_MOD, RM_RSTST);
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 7c8e0c4..9937e28 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -203,9 +203,11 @@
 
 #define OMAP3430_PM_MPUGRPSEL				0x00a4
 #define OMAP3430_PM_MPUGRPSEL1				OMAP3430_PM_MPUGRPSEL
+#define OMAP3430ES2_PM_MPUGRPSEL3			0x00f8
 
 #define OMAP3430_PM_IVAGRPSEL				0x00a8
 #define OMAP3430_PM_IVAGRPSEL1				OMAP3430_PM_IVAGRPSEL
+#define OMAP3430ES2_PM_IVAGRPSEL3			0x00f4
 
 #define OMAP3430_PM_PREPWSTST				0x00e8
 
-- 
1.6.2.2


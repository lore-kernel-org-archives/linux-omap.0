From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 13/13] OMAP3: PM: prevent module wakeups from waking IVA2
Date: Wed, 20 May 2009 16:19:36 -0700
Message-ID: <1242861576-13008-14-git-send-email-khilman@deeprootsystems.com>
References: <1242861576-13008-1-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-2-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-3-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-4-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-5-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-6-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-7-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-8-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-9-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-10-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-11-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-12-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-13-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f171.google.com ([209.85.216.171]:43119 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757267AbZETXUK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 19:20:10 -0400
Received: by mail-px0-f171.google.com with SMTP id 1so365239pxi.33
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 16:20:11 -0700 (PDT)
In-Reply-To: <1242861576-13008-13-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

By default, prevent functional wakeups from inside a module from
waking up the IVA2.  Let DSP Bridge code handle this when loaded.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    6 ++++++
 arch/arm/mach-omap2/prm.h    |    2 ++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8442286..deffafd 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -600,6 +600,12 @@ static void __init prcm_setup_regs(void)
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


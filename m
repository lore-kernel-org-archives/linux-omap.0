From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 21/28] ARM: OMAP: Add missing SMS_SYSCONFIG save/restore
Date: Thu,  1 Oct 2009 16:58:51 -0700
Message-ID: <1254441538-9257-22-git-send-email-khilman@deeprootsystems.com>
References: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-2-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-3-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-4-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-5-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-6-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-7-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-8-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-9-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-10-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-11-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-12-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-13-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-14-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-15-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-16-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-17-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-18-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-19-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-20-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-21-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:58920 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244AbZJAX7c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 19:59:32 -0400
Received: by mail-pz0-f177.google.com with SMTP id 7so574597pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 16:59:36 -0700 (PDT)
In-Reply-To: <1254441538-9257-21-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kalle Jokiniemi <kalle.jokiniemi@digia.com>

From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>

SMS_SYSCONFIG register gets reset in off mode, added
a save/restore mechanism for that.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
---
 arch/arm/mach-omap2/pm34xx.c           |    1 +
 arch/arm/mach-omap2/sdrc.c             |   27 +++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/sdrc.h |    2 ++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 43225d7..073af91 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -398,6 +398,7 @@ static void omap_sram_idle(void)
 			omap3_core_restore_context();
 			omap3_prcm_restore_context();
 			omap3_sram_restore_context();
+			omap2_sms_restore_context();
 		}
 		if (per_next_state < PWRDM_POWER_ON) {
 			per_prev_state =
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index 9e3bd4f..1a4f132 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -37,12 +37,38 @@ static struct omap_sdrc_params *sdrc_init_params_cs0, *sdrc_init_params_cs1;
 void __iomem *omap2_sdrc_base;
 void __iomem *omap2_sms_base;
 
+struct omap2_sms_regs {
+	u32	sms_sysconfig;
+};
+
+static struct omap2_sms_regs sms_context;
+
 /* SDRC_POWER register bits */
 #define SDRC_POWER_EXTCLKDIS_SHIFT		3
 #define SDRC_POWER_PWDENA_SHIFT			2
 #define SDRC_POWER_PAGEPOLICY_SHIFT		0
 
 /**
+ * omap2_sms_save_context - Save SMS registers
+ *
+ * Save SMS registers that need to be restored after off mode.
+ */
+void omap2_sms_save_context(void)
+{
+	sms_context.sms_sysconfig = sms_read_reg(SMS_SYSCONFIG);
+}
+
+/**
+ * omap2_sms_restore_context - Restore SMS registers
+ *
+ * Restore SMS registers that need to be Restored after off mode.
+ */
+void omap2_sms_restore_context(void)
+{
+	sms_write_reg(sms_context.sms_sysconfig, SMS_SYSCONFIG);
+}
+
+/**
  * omap2_sdrc_get_params - return SDRC register values for a given clock rate
  * @r: SDRC clock rate (in Hz)
  * @sdrc_cs0: chip select 0 ram timings **
@@ -132,4 +158,5 @@ void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 	l = (1 << SDRC_POWER_EXTCLKDIS_SHIFT) |
 		(1 << SDRC_POWER_PAGEPOLICY_SHIFT);
 	sdrc_write_reg(l, SDRC_POWER);
+	omap2_sms_save_context();
 }
diff --git a/arch/arm/plat-omap/include/mach/sdrc.h b/arch/arm/plat-omap/include/mach/sdrc.h
index 1c09c78..19348fb 100644
--- a/arch/arm/plat-omap/include/mach/sdrc.h
+++ b/arch/arm/plat-omap/include/mach/sdrc.h
@@ -120,6 +120,8 @@ void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 int omap2_sdrc_get_params(unsigned long r,
 			  struct omap_sdrc_params **sdrc_cs0,
 			  struct omap_sdrc_params **sdrc_cs1);
+void omap2_sms_save_context(void);
+void omap2_sms_restore_context(void);
 
 #ifdef CONFIG_ARCH_OMAP2
 
-- 
1.6.4.3


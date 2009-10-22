From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 18/32] ARM: OMAP: SMS: save/restore of SMS_SYSCONFIG for off-mode
Date: Thu, 22 Oct 2009 16:09:39 -0700
Message-ID: <1256252993-24328-19-git-send-email-khilman@deeprootsystems.com>
References: <1256252993-24328-1-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-2-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-3-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-4-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-5-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-6-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-7-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-8-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-9-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-10-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-11-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-12-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-13-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-14-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-15-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-16-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-17-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-18-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f194.google.com ([209.85.221.194]:37878 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755498AbZJVXK7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 19:10:59 -0400
Received: by mail-qy0-f194.google.com with SMTP id 32so5544712qyk.4
        for <linux-omap@vger.kernel.org>; Thu, 22 Oct 2009 16:11:03 -0700 (PDT)
In-Reply-To: <1256252993-24328-18-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kalle Jokiniemi <kalle.jokiniemi@digia.com>

From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>

The SMS_SYSCONFIG register gets reset in off mode, added a
save/restore mechanism for that.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c           |    1 +
 arch/arm/mach-omap2/sdrc.c             |   27 +++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/sdrc.h |    2 ++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a9f4034..90d1dc5 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -399,6 +399,7 @@ static void omap_sram_idle(void)
 			omap3_core_restore_context();
 			omap3_prcm_restore_context();
 			omap3_sram_restore_context();
+			omap2_sms_restore_context();
 		}
 		if (per_next_state < PWRDM_POWER_ON) {
 			per_prev_state =
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index 07000de..9a59219 100644
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
diff --git a/arch/arm/plat-omap/include/plat/sdrc.h b/arch/arm/plat-omap/include/plat/sdrc.h
index 7b58a5f..772b71e 100644
--- a/arch/arm/plat-omap/include/plat/sdrc.h
+++ b/arch/arm/plat-omap/include/plat/sdrc.h
@@ -120,6 +120,8 @@ void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 int omap2_sdrc_get_params(unsigned long r,
 			  struct omap_sdrc_params **sdrc_cs0,
 			  struct omap_sdrc_params **sdrc_cs1);
+void omap2_sms_save_context(void);
+void omap2_sms_restore_context(void);
 
 #ifdef CONFIG_ARCH_OMAP2
 
-- 
1.6.4.3


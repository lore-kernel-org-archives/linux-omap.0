From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH 1/1] ARM: OMAP: Add missing SMS_SYSCONFIG save/restore
Date: Wed, 13 May 2009 13:32:11 +0300
Message-ID: <1242210731-26249-2-git-send-email-kalle.jokiniemi@digia.com>
References: <>
 <1242210731-26249-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:43984 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758334AbZEMKb6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 May 2009 06:31:58 -0400
In-Reply-To: <1242210731-26249-1-git-send-email-kalle.jokiniemi@digia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, jouni.hogander@nokia.com, Kalle Jokiniemi <kalle.jokiniemi@digia.com>

SMS_SYSCONFIG register gets reset in off mode, added
a save/restore mechanism for that.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
---
 arch/arm/mach-omap2/pm34xx.c           |    1 +
 arch/arm/mach-omap2/sdrc.c             |   27 +++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/sdrc.h |    2 ++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 60a1c4c..6e286ef 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -439,6 +439,7 @@ void omap_sram_idle(void)
 			omap3_core_restore_context();
 			omap3_prcm_restore_context();
 			omap3_sram_restore_context();
+			omap2_sms_restore_context();
 		}
 		omap_uart_resume_idle(0);
 		omap_uart_resume_idle(1);
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index 2045441..c832d83 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -37,12 +37,38 @@ static struct omap_sdrc_params *sdrc_init_params;
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
  *
@@ -110,4 +136,5 @@ void __init omap2_sdrc_init(struct omap_sdrc_params *sp)
 		(1 << SDRC_POWER_PWDENA_SHIFT) |
 		(1 << SDRC_POWER_PAGEPOLICY_SHIFT);
 	sdrc_write_reg(l, SDRC_POWER);
+	omap2_sms_save_context();
 }
diff --git a/arch/arm/plat-omap/include/mach/sdrc.h b/arch/arm/plat-omap/include/mach/sdrc.h
index a5a6cf9..a678bc8 100644
--- a/arch/arm/plat-omap/include/mach/sdrc.h
+++ b/arch/arm/plat-omap/include/mach/sdrc.h
@@ -112,6 +112,8 @@ struct omap_sdrc_params {
 	u32 mr;
 };
 
+void omap2_sms_save_context(void);
+void omap2_sms_restore_context(void);
 void __init omap2_sdrc_init(struct omap_sdrc_params *);
 struct omap_sdrc_params *omap2_sdrc_get_params(unsigned long r);
 
-- 
1.5.4.3


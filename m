From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 03/10] ARM: OMAP3: PRM: move modem reset to PRM driver
Date: Fri, 4 Jul 2014 17:10:28 +0300
Message-ID: <1404483035-21666-4-git-send-email-t-kristo@ti.com>
References: <1404483035-21666-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52125 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758631AbaGDOKl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jul 2014 10:10:41 -0400
In-Reply-To: <1404483035-21666-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This is a more proper isolation of the code. Done in preparation of making
PRM an individual driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c  |    5 +----
 arch/arm/mach-omap2/prm3xxx.c |   15 +++++++++++++++
 arch/arm/mach-omap2/prm3xxx.h |    1 +
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 6d02573..acb895d 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -371,10 +371,7 @@ static void __init omap3_d2d_idle(void)
 	omap_ctrl_writew(padconf, OMAP3_PADCONF_SAD2D_IDLEACK);
 
 	/* reset modem */
-	omap2_prm_write_mod_reg(OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RSTPWRON_MASK |
-			  OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RST_MASK,
-			  CORE_MOD, OMAP2_RM_RSTCTRL);
-	omap2_prm_write_mod_reg(0, CORE_MOD, OMAP2_RM_RSTCTRL);
+	omap3_prm_reset_modem();
 }
 
 static void __init prcm_setup_regs(void)
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index a575b69..e46ff71 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -260,6 +260,21 @@ int omap3xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits)
 }
 
 /**
+ * omap3_prm_reset_modem - toggle reset signal for modem
+ *
+ * Toggles the reset signal to modem IP block. Required to allow
+ * OMAP3430 without stacked modem to idle properly.
+ */
+void __init omap3_prm_reset_modem(void)
+{
+	omap2_prm_write_mod_reg(
+		OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RSTPWRON_MASK |
+		OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RST_MASK,
+				CORE_MOD, OMAP2_RM_RSTCTRL);
+	omap2_prm_write_mod_reg(0, CORE_MOD, OMAP2_RM_RSTCTRL);
+}
+
+/**
  * omap3xxx_prm_reconfigure_io_chain - clear latches and reconfigure I/O chain
  *
  * Clear any previously-latched I/O wakeup events and ensure that the
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index 007ff59..21eb1d5 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -164,6 +164,7 @@ extern int __init omap3xxx_prm_init(void);
 extern u32 omap3xxx_prm_get_reset_sources(void);
 int omap3xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits);
 void omap3xxx_prm_iva_idle(void);
+void omap3_prm_reset_modem(void);
 
 #endif /* __ASSEMBLER */
 
-- 
1.7.9.5


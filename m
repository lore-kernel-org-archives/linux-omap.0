From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 06/18] ARM: OMAP3: PRM: move modem reset to PRM driver
Date: Tue, 4 Mar 2014 18:19:06 +0200
Message-ID: <1393949958-816-7-git-send-email-t-kristo@ti.com>
References: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45099 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754311AbaCDQUP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Mar 2014 11:20:15 -0500
In-Reply-To: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@linaro.org
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
index a42f9ea..0eecf6f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -368,10 +368,7 @@ static void __init omap3_d2d_idle(void)
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
index 78ea9a5..92ab46a 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -259,6 +259,21 @@ int omap3xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits)
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
index 543eb63..2a0f089 100644
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


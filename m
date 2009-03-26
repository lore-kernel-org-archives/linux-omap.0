From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH 3/3] ARM: OMAP3: Enable IO-CHAIN wakeup
Date: Thu, 26 Mar 2009 15:59:01 +0200
Message-ID: <1238075941-24931-4-git-send-email-kalle.jokiniemi@digia.com>
References: <>
 <1238075941-24931-1-git-send-email-kalle.jokiniemi@digia.com>
 <1238075941-24931-2-git-send-email-kalle.jokiniemi@digia.com>
 <1238075941-24931-3-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:7713 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753888AbZCZOQE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Mar 2009 10:16:04 -0400
In-Reply-To: <1238075941-24931-3-git-send-email-kalle.jokiniemi@digia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, Kalle Jokiniemi <kalle.jokiniemi@digia.com>

OMAP 3430 ES3.1 chips have a separate bit for IO daisy-chain
wake up enabling. It needs to be enabled when entering
retention or off state, otherwise waking up might not work
in all situations.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
---
 arch/arm/mach-omap2/pm34xx.c           |   37 +++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/prm-regbits-34xx.h |    2 +
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7bbbcce..4345df1 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -101,6 +101,34 @@ static inline void omap3_per_restore_context(void)
 	omap3_gpio_restore_context();
 }
 
+static void omap3_enable_io_chain(void)
+{
+	int timeout = 0;
+
+	if (omap_rev() >= OMAP3430_REV_ES3_1) {
+		prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN, WKUP_MOD, PM_WKEN);
+		/* Do a readback to assure write has been done */
+		prm_read_mod_reg(WKUP_MOD, PM_WKEN);
+
+		while (!(prm_read_mod_reg(WKUP_MOD, PM_WKST) &
+						OMAP3430_ST_IO_CHAIN)) {
+			timeout++;
+			if (timeout > 1000) {
+				printk(KERN_ERR "Wake up daisy chain "
+						"activation failed.\n");
+				return;
+			}
+		prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN, WKUP_MOD, PM_WKST);
+		}
+	}
+}
+
+static void omap3_disable_io_chain(void)
+{
+	if (omap_rev() >= OMAP3430_REV_ES3_1)
+		prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN, WKUP_MOD, PM_WKEN);
+}
+
 static void omap3_core_save_context(void)
 {
 	u32 control_padconf_off;
@@ -358,8 +386,9 @@ void omap_sram_idle(void)
 			omap3_core_save_context();
 			omap3_prcm_save_context();
 		}
-		/* Enable IO-PAD wakeup */
+		/* Enable IO-PAD and IO-CHAIN wakeups */
 		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
+		omap3_enable_io_chain();
 	}
 
 	/*
@@ -425,9 +454,11 @@ void omap_sram_idle(void)
 			pwrdm_set_next_pwrst(per_pwrdm, PWRDM_POWER_OFF);
 	}
 
-	/* Disable IO-PAD wakeup */
-	if (core_next_state < PWRDM_POWER_ON)
+	/* Disable IO-PAD and IO-CHAIN wakeup */
+	if (core_next_state < PWRDM_POWER_ON) {
 		prm_clear_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
+		omap3_disable_io_chain();
+	}
 
 	/* Enable smartreflex after WFI */
 	enable_smartreflex(SR1);
diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
index cb648f9..06fee29 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -365,6 +365,7 @@
 /* PM_PREPWSTST_GFX specific bits */
 
 /* PM_WKEN_WKUP specific bits */
+#define OMAP3430_EN_IO_CHAIN				(1 << 16)
 #define OMAP3430_EN_IO					(1 << 8)
 #define OMAP3430_EN_GPIO1				(1 << 3)
 
@@ -373,6 +374,7 @@
 /* PM_IVA2GRPSEL_WKUP specific bits */
 
 /* PM_WKST_WKUP specific bits */
+#define OMAP3430_ST_IO_CHAIN				(1 << 16)
 #define OMAP3430_ST_IO					(1 << 8)
 
 /* PRM_CLKSEL */
-- 
1.5.4.3


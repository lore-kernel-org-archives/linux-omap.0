From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 2/2] OMAP3: Implemented VFP restore/save context
Date: Tue, 24 Nov 2009 12:37:04 +0200
Message-ID: <1259059024-23719-3-git-send-email-tero.kristo@nokia.com>
References: <>
 <1259059024-23719-1-git-send-email-tero.kristo@nokia.com>
 <1259059024-23719-2-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:31664 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932674AbZKXKj2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 05:39:28 -0500
In-Reply-To: <1259059024-23719-2-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

VFP save context is called before MPU/NEON off. Restore is not needed as
the next VFP trap will restore context automatically. Uses the support
routine implemented in arch/arm/vfp/vfpmodule.c.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/pm.h     |    1 +
 arch/arm/mach-omap2/pm34xx.c |   21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 4f22107..dd5bbaf 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -18,6 +18,7 @@ extern u32 sleep_while_idle;
 extern u32 voltage_off_while_idle;
 
 extern void *omap3_secure_ram_storage;
+extern void vfp_pm_save_context(void);
 extern void omap3_pm_off_mode_enable(int);
 extern void omap_sram_idle(void);
 extern int omap3_can_sleep(void);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b26ae5b..4b01303 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -321,6 +321,18 @@ static void restore_control_register(u32 val)
 	__asm__ __volatile__ ("mcr p15, 0, %0, c1, c0, 0" : : "r" (val));
 }
 
+static inline void omap3_save_neon_context(void)
+{
+#ifdef CONFIG_VFP
+	vfp_pm_save_context();
+#endif
+}
+
+static inline void omap3_restore_neon_context(void)
+{
+	return;
+}
+
 /* Function to restore the table entry that was modified for enabling MMU */
 static void restore_table_entry(void)
 {
@@ -365,6 +377,7 @@ void omap_sram_idle(void)
 	/* save_state = 3 => L1, L2 and logic lost */
 	int save_state = 0;
 	int mpu_next_state = PWRDM_POWER_ON;
+	int neon_next_state = PWRDM_POWER_ON;
 	int per_next_state = PWRDM_POWER_ON;
 	int core_next_state = PWRDM_POWER_ON;
 	int core_prev_state, per_prev_state;
@@ -398,8 +411,12 @@ void omap_sram_idle(void)
 	pwrdm_pre_transition();
 
 	/* NEON control */
-	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
+	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON) {
 		pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
+		neon_next_state = mpu_next_state;
+		if (neon_next_state == PWRDM_POWER_OFF)
+			omap3_save_neon_context();
+	}
 
 	/* PER */
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
@@ -537,6 +554,8 @@ void omap_sram_idle(void)
 		omap3_disable_io_chain();
 	}
 
+	if (neon_next_state == PWRDM_POWER_OFF)
+		omap3_restore_neon_context();
 
 	pwrdm_post_transition();
 }
-- 
1.5.4.3


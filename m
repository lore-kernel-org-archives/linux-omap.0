From: jean.pihet@newoldbits.com
Subject: [PATCH 06/13] OMAP2+: PM: isolate the scratchpad save function from the PM code
Date: Wed, 18 May 2011 19:32:23 +0200
Message-ID: <1305739950-11695-7-git-send-email-j-pihet@ti.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63275 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932910Ab1ERRcv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 13:32:51 -0400
Received: by mail-yw0-f46.google.com with SMTP id 9so445875ywe.19
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 10:32:51 -0700 (PDT)
In-Reply-To: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

This patch provides the omap3_save_scratchpad_contents function as
a service from the common control code.
The PM code calls the service to store the appropriate data in the
scratchpad area, including the restore pointer from OFF/OSWR modes
and the secure RAM restore pointer.

This also cleans up the core PM code, in order to allow it to be used
as a module.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/control.c |   23 +++++------------------
 arch/arm/mach-omap2/control.h |    6 ++----
 arch/arm/mach-omap2/pm.h      |    7 ++++++-
 arch/arm/mach-omap2/pm34xx.c  |   28 +++++++++++++++++++++++++++-
 4 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index da53ba3..23b83bd 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -267,7 +267,8 @@ void omap3_clear_scratchpad_contents(void)
 }
 
 /* Populate the scratchpad structure with restore structure */
-void omap3_save_scratchpad_contents(void)
+void omap3_save_scratchpad_contents(u32 public_restore_ptr,
+				    u32 secure_ram_restore_ptr)
 {
 	void  __iomem *scratchpad_address;
 	u32 arm_context_addr;
@@ -278,27 +279,13 @@ void omap3_save_scratchpad_contents(void)
 	/*
 	 * Populate the Scratchpad contents
 	 *
-	 * The "get_*restore_pointer" functions are used to provide a
+	 * The public_restore_ptr field of the scratchpad data provides a
 	 * physical restore address where the ROM code jumps while waking
 	 * up from MPU OFF/OSWR state.
-	 * The restore pointer is stored into the scratchpad.
 	 */
 	scratchpad_contents.boot_config_ptr = 0x0;
-	if (cpu_is_omap3630())
-		scratchpad_contents.public_restore_ptr =
-			virt_to_phys(get_omap3630_restore_pointer());
-	else if (omap_rev() != OMAP3430_REV_ES3_0 &&
-					omap_rev() != OMAP3430_REV_ES3_1)
-		scratchpad_contents.public_restore_ptr =
-			virt_to_phys(get_restore_pointer());
-	else
-		scratchpad_contents.public_restore_ptr =
-			virt_to_phys(get_es3_restore_pointer());
-	if (omap_type() == OMAP2_DEVICE_TYPE_GP)
-		scratchpad_contents.secure_ram_restore_ptr = 0x0;
-	else
-		scratchpad_contents.secure_ram_restore_ptr =
-			(u32) __pa(omap3_secure_ram_storage);
+	scratchpad_contents.public_restore_ptr = public_restore_ptr;
+	scratchpad_contents.secure_ram_restore_ptr = secure_ram_restore_ptr;
 	scratchpad_contents.sdrc_module_semaphore = 0x0;
 	scratchpad_contents.prcm_block_offset = 0x2C;
 	scratchpad_contents.sdrc_block_offset = 0x64;
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index c2804c1..5f053a4 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -384,11 +384,9 @@ extern void omap_ctrl_writew(u16 val, u16 offset);
 extern void omap_ctrl_writel(u32 val, u16 offset);
 extern void omap4_ctrl_pad_writel(u32 val, u16 offset);
 
-extern void omap3_save_scratchpad_contents(void);
+extern void omap3_save_scratchpad_contents(u32 public_restore_ptr,
+					   u32 secure_ram_restore_ptr);
 extern void omap3_clear_scratchpad_contents(void);
-extern u32 *get_restore_pointer(void);
-extern u32 *get_es3_restore_pointer(void);
-extern u32 *get_omap3630_restore_pointer(void);
 extern u32 omap3_arm_context[128];
 extern void omap3_control_save_context(void);
 extern void omap3_control_restore_context(void);
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 3ed185c..f36f79c 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -91,13 +91,18 @@ extern void omap24xx_cpu_suspend(u32 dll_ctrl, void __iomem *sdrc_dlla_ctrl,
 					void __iomem *sdrc_power);
 extern void omap34xx_cpu_suspend(u32 *addr, int save_state);
 extern int save_secure_ram_context(u32 *addr);
-extern void omap3_save_scratchpad_contents(void);
 
 extern unsigned int omap24xx_idle_loop_suspend_sz;
 extern unsigned int save_secure_ram_context_sz;
 extern unsigned int omap24xx_cpu_suspend_sz;
 extern unsigned int omap34xx_cpu_suspend_sz;
 
+#ifdef CONFIG_PM
+extern u32 *get_restore_pointer(void);
+extern u32 *get_es3_restore_pointer(void);
+extern u32 *get_omap3630_restore_pointer(void);
+#endif
+
 #define PM_RTA_ERRATUM_i608		(1 << 0)
 #define PM_SDRC_WAKEUP_ERRATUM_i583	(1 << 1)
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 74169a2..4c80861 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -885,6 +885,31 @@ static void __init pm_errata_configure(void)
 	}
 }
 
+/*
+ * The "get_*restore_pointer" functions are used to provide a
+ * physical restore address where the ROM code jumps while waking
+ * up from MPU OFF/OSWR state.
+ * The restore pointer is stored into the scratchpad.
+ */
+static inline u32 _get_public_restore_ptr(void)
+{
+	if (cpu_is_omap3630())
+		return virt_to_phys(get_omap3630_restore_pointer());
+	else if (omap_rev() != OMAP3430_REV_ES3_0 &&
+		 omap_rev() != OMAP3430_REV_ES3_1)
+		return virt_to_phys(get_restore_pointer());
+	else
+		return virt_to_phys(get_es3_restore_pointer());
+}
+
+static inline u32 _get_secure_ram_restore_ptr(void)
+{
+	if (omap_type() == OMAP2_DEVICE_TYPE_GP)
+		return 0x0;
+	else
+		return (u32) __pa(omap3_secure_ram_storage);
+}
+
 static int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst, *tmp;
@@ -970,7 +995,8 @@ static int __init omap3_pm_init(void)
 		local_fiq_enable();
 	}
 
-	omap3_save_scratchpad_contents();
+	omap3_save_scratchpad_contents(_get_public_restore_ptr(),
+				       _get_secure_ram_restore_ptr());
 err1:
 	return ret;
 err2:
-- 
1.7.4.1


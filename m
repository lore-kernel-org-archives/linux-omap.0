From: Charles Manning <manningc2@actrix.gen.nz>
Subject: Fix pm24xx.c compilation  problem
Date: Thu, 23 Dec 2010 09:19:26 +1300
Message-ID: <201012230919.26344.manningc2@actrix.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.scorch.co.nz ([27.110.127.199]:39430 "HELO scorch.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751193Ab0LVUTa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Dec 2010 15:19:30 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

arch/arm/mach-omap2/pm24xx.c doesn't compile without CONFIG_SUSPEND

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index aaeea49..ae6abda 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -53,8 +53,8 @@
 #include <plat/powerdomain.h>
 #include <plat/clockdomain.h>
 
-#ifdef CONFIG_SUSPEND
 static suspend_state_t suspend_state = PM_SUSPEND_ON;
+#ifdef CONFIG_SUSPEND
 static inline bool is_suspending(void)
 {
        return (suspend_state != PM_SUSPEND_ON);
@@ -314,6 +314,7 @@ static int omap2_pm_prepare(void)
 
 static int omap2_pm_suspend(void)
 {
+#ifdef CONFIG_SUSPEND
        u32 wken_wkup, mir1;
 
        wken_wkup = prm_read_mod_reg(WKUP_MOD, PM_WKEN);
@@ -329,7 +330,7 @@ static int omap2_pm_suspend(void)
 
        omap_writel(mir1, 0x480fe0a4);
        prm_write_mod_reg(wken_wkup, WKUP_MOD, PM_WKEN);
-
+#endif
        return 0;
 }


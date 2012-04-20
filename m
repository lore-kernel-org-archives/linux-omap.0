From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 8/8] ARM: OMAP4: PM: Added option for enabling OSWR
Date: Fri, 20 Apr 2012 12:19:51 +0300
Message-ID: <1334913591-26312-9-git-send-email-t-kristo@ti.com>
References: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47273 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323Ab2DTJUZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 05:20:25 -0400
In-Reply-To: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

PM debug now contains a file that can be used to control OSWR support
enable / disable on OMAP4. Also removed the off_mode_enable file for
the same platform as it is unsupported.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c |   20 ++++++++++++++++----
 arch/arm/mach-omap2/pm.h       |    1 +
 arch/arm/mach-omap2/pm44xx.c   |   16 ++++++++++++++++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 814bcd9..d9a8e42 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -39,6 +39,7 @@
 #include "pm.h"
 
 u32 enable_off_mode;
+static u32 enable_oswr_mode;
 
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
@@ -247,10 +248,13 @@ static int option_set(void *data, u64 val)
 			omap_pm_enable_off_mode();
 		else
 			omap_pm_disable_off_mode();
-		if (cpu_is_omap34xx())
-			omap3_pm_off_mode_enable(val);
+
+		omap3_pm_off_mode_enable(val);
 	}
 
+	if (option == &enable_oswr_mode)
+		omap4_pm_oswr_mode_enable(val);
+
 	return 0;
 }
 
@@ -274,8 +278,16 @@ static int __init pm_dbg_init(void)
 
 	pwrdm_for_each(pwrdms_setup, (void *)d);
 
-	(void) debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUSR, d,
-				   &enable_off_mode, &pm_dbg_option_fops);
+	if (cpu_is_omap34xx())
+		(void) debugfs_create_file("enable_off_mode",
+			S_IRUGO | S_IWUSR, d, &enable_off_mode,
+			&pm_dbg_option_fops);
+
+	if (cpu_is_omap44xx())
+		(void) debugfs_create_file("enable_oswr_mode",
+			S_IRUGO | S_IWUSR, d, &enable_oswr_mode,
+			&pm_dbg_option_fops);
+
 	pm_dbg_init_done = 1;
 
 	return 0;
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 256e63c..07ad800 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -17,6 +17,7 @@
 
 extern void *omap3_secure_ram_storage;
 extern void omap3_pm_off_mode_enable(int);
+extern void omap4_pm_oswr_mode_enable(int);
 extern void omap_sram_idle(void);
 extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index cc85576..07ac0d3 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -115,6 +115,22 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	return omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
 }
 
+void omap4_pm_oswr_mode_enable(int enable)
+{
+	u32 next_logic_state;
+	struct power_state *pwrst;
+
+	if (enable)
+		next_logic_state = PWRDM_POWER_OFF;
+	else
+		next_logic_state = PWRDM_POWER_RET;
+
+	list_for_each_entry(pwrst, &pwrst_list, node) {
+		pwrst->next_logic_state = next_logic_state;
+		pwrdm_set_logic_retst(pwrst->pwrdm, pwrst->next_logic_state);
+	}
+}
+
 /**
  * omap_default_idle - OMAP4 default ilde routine.'
  *
-- 
1.7.4.1


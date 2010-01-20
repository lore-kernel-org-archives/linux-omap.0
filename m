From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 8/8] OMAP3 PM: Support to enable disable OSWR feature from pm debug fs
Date: Wed, 20 Jan 2010 21:00:42 +0530
Message-ID: <1264001442-20078-9-git-send-email-thara@ti.com>
References: <1264001442-20078-1-git-send-email-thara@ti.com>
 <1264001442-20078-2-git-send-email-thara@ti.com>
 <1264001442-20078-3-git-send-email-thara@ti.com>
 <1264001442-20078-4-git-send-email-thara@ti.com>
 <1264001442-20078-5-git-send-email-thara@ti.com>
 <1264001442-20078-6-git-send-email-thara@ti.com>
 <1264001442-20078-7-git-send-email-thara@ti.com>
 <1264001442-20078-8-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59005 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753399Ab0ATPat (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jan 2010 10:30:49 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o0KFUkHv012769
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 20 Jan 2010 09:30:48 -0600
In-Reply-To: <1264001442-20078-8-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>

This patch adds enable_oswr flag in pm debug fs to enable
disable OSWR feature.
To enable this feature:
	echo 1 > <path>/debug/pm_debug/enable_oswr
To disable this feature
	echo 0 > <path>/debug/pm_debug/enable_oswr

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    9 +++++++++
 arch/arm/mach-omap2/pm-debug.c    |    2 ++
 arch/arm/mach-omap2/pm.h          |    1 +
 arch/arm/mach-omap2/pm34xx.c      |    1 +
 4 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 419f683..91ef0df 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -155,11 +155,20 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	 * bits in case the powerdomain enters retention
 	 */
 	if (mpu_state <= PWRDM_POWER_RET) {
+		if (!enable_oswr) {
+			mpu_logicl1_ret_state = PWRDM_POWER_RET;
+			mpu_l2cache_ret_state = PWRDM_POWER_RET;
+		}
 		pwrdm_set_logic_retst(mpu_pd, mpu_logicl1_ret_state);
 		pwrdm_set_mem_retst(mpu_pd, 0, mpu_l2cache_ret_state);
 	}
 
 	if (core_state <= PWRDM_POWER_RET) {
+		if (!enable_oswr) {
+			core_logic_state = PWRDM_POWER_RET;
+			core_mem1_ret_state = PWRDM_POWER_RET;
+			core_mem2_ret_state = PWRDM_POWER_RET;
+		}
 		pwrdm_set_logic_retst(core_pd, core_logic_state);
 		pwrdm_set_mem_retst(core_pd, 0, core_mem1_ret_state);
 		pwrdm_set_mem_retst(core_pd, 1, core_mem2_ret_state);
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 035cfa7..cdb081b 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -601,6 +601,8 @@ static int __init pm_dbg_init(void)
 				   &enable_off_mode, &pm_dbg_option_fops);
 	(void) debugfs_create_file("sleep_while_idle", S_IRUGO | S_IWUGO, d,
 				   &sleep_while_idle, &pm_dbg_option_fops);
+	(void) debugfs_create_file("enable_oswr", S_IRUGO | S_IWUGO, d,
+				   &enable_oswr, &pm_dbg_option_fops);
 	(void) debugfs_create_file("wakeup_timer_seconds", S_IRUGO | S_IWUGO, d,
 				   &wakeup_timer_seconds, &pm_dbg_option_fops);
 
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 75aa685..03c49a8 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -15,6 +15,7 @@
 
 extern u32 enable_off_mode;
 extern u32 sleep_while_idle;
+extern u32 enable_oswr;
 extern u32 voltage_off_while_idle;
 
 extern void *omap3_secure_ram_storage;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index bfdcac2..53c08a5 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -73,6 +73,7 @@ static inline bool is_suspending(void)
 
 u32 enable_off_mode;
 u32 sleep_while_idle;
+u32 enable_oswr;
 u32 wakeup_timer_seconds;
 u32 voltage_off_while_idle;
 
-- 
1.5.6.3


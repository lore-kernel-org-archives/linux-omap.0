From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 18/23] OMAP3: PM: Added DVFS OPP locking interface for VDD1 and VDD2
Date: Thu, 11 Dec 2008 17:52:37 +0200
Message-ID: <1229010762-3150-19-git-send-email-tero.kristo@nokia.com>
References: <>
 <1229010762-3150-1-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-2-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-3-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-4-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-5-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-6-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-7-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-8-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-9-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-10-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-11-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-12-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-13-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-14-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-15-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-16-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-17-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-18-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34966 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756205AbYLKP7P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 10:59:15 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mBBFwj2q020861
	for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2008 17:59:07 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mBBFwchx011022
	for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2008 17:59:04 +0200
In-Reply-To: <1229010762-3150-18-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Added two new files under /sys/power for controlling OPP locks. vdd1_lock and
vdd2_lock. You can write to these to select desired OPP level and it will be
locked at that level. Lock can be cleared by writing 0 to the same file.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm.c           |   55 ++++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/pm.h           |    8 ++++-
 arch/arm/mach-omap2/resource34xx.c |   24 +++++++++++++--
 3 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 2dd1341..155bd8d 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -43,6 +43,8 @@ unsigned short clocks_off_while_idle;
 unsigned short enable_off_mode;
 unsigned short voltage_off_while_idle;
 atomic_t sleep_block = ATOMIC_INIT(0);
+static int vdd1_locked;
+static int vdd2_locked;
 
 static ssize_t idle_show(struct kobject *, struct kobj_attribute *, char *);
 static ssize_t idle_store(struct kobject *k, struct kobj_attribute *,
@@ -69,6 +71,11 @@ static struct kobj_attribute vdd1_opp_attr =
 
 static struct kobj_attribute vdd2_opp_attr =
 	__ATTR(vdd2_opp, 0644, vdd_opp_show, vdd_opp_store);
+static struct kobj_attribute vdd1_lock_attr =
+	__ATTR(vdd1_lock, 0644, vdd_opp_show, vdd_opp_store);
+static struct kobj_attribute vdd2_lock_attr =
+	__ATTR(vdd2_lock, 0644, vdd_opp_show, vdd_opp_store);
+
 #endif
 
 static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
@@ -127,6 +134,10 @@ static ssize_t vdd_opp_show(struct kobject *kobj, struct kobj_attribute *attr,
 		return sprintf(buf, "%hu\n", resource_get_level("vdd1_opp"));
 	else if (attr == &vdd2_opp_attr)
 		return sprintf(buf, "%hu\n", resource_get_level("vdd2_opp"));
+	else if (attr == &vdd1_lock_attr)
+		return sprintf(buf, "%hu\n", resource_get_opp_lock(VDD1_OPP));
+	else if (attr == &vdd2_lock_attr)
+		return sprintf(buf, "%hu\n", resource_get_opp_lock(VDD2_OPP));
 	else
 		return -EINVAL;
 }
@@ -135,22 +146,50 @@ static ssize_t vdd_opp_store(struct kobject *kobj, struct kobj_attribute *attr,
 			  const char *buf, size_t n)
 {
 	unsigned short value;
+	int flags = 0;
 
 	if (sscanf(buf, "%hu", &value) != 1)
 		return -EINVAL;
 
+	/* Check locks */
+	if (attr == &vdd1_lock_attr) {
+		flags = OPP_IGNORE_LOCK;
+		attr = &vdd1_opp_attr;
+		if (vdd1_locked && value == 0) {
+			resource_unlock_opp(VDD1_OPP);
+			vdd1_locked = 0;
+			return n;
+		}
+		if (vdd1_locked == 0 && value != 0) {
+			resource_lock_opp(VDD1_OPP);
+			vdd1_locked = 1;
+		}
+	} else if (attr == &vdd2_lock_attr) {
+		flags = OPP_IGNORE_LOCK;
+		attr = &vdd2_opp_attr;
+		if (vdd2_locked && value == 0) {
+			resource_unlock_opp(VDD2_OPP);
+			vdd2_locked = 0;
+			return n;
+		}
+		if (vdd2_locked == 0 && value != 0) {
+			resource_lock_opp(VDD2_OPP);
+			vdd2_locked = 1;
+		}
+	}
+
 	if (attr == &vdd1_opp_attr) {
 		if (value < 1 || value > 5) {
 			printk(KERN_ERR "vdd_opp_store: Invalid value\n");
 			return -EINVAL;
 		}
-		set_opp_level(VDD1_OPP, value);
+		resource_set_opp_level(VDD1_OPP, value, flags);
 	} else if (attr == &vdd2_opp_attr) {
 		if (value < 2 || value > 3) {
 			printk(KERN_ERR "vdd_opp_store: Invalid value\n");
 			return -EINVAL;
 		}
-		set_opp_level(VDD2_OPP, value);
+		resource_set_opp_level(VDD2_OPP, value, flags);
 	} else {
 		return -EINVAL;
 	}
@@ -227,6 +266,18 @@ static int __init omap_pm_init(void)
 		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
 		return error;
 	}
+
+	error = sysfs_create_file(power_kobj, &vdd1_lock_attr.attr);
+	if (error) {
+		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
+		return error;
+	}
+
+	error = sysfs_create_file(power_kobj, &vdd2_lock_attr.attr);
+	if (error) {
+		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
+		return error;
+	}
 #endif
 	voltage_off_while_idle = 0;
 	/* Going to 0V on anything under ES2.1 will eventually cause a crash */
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 4c0052f..4f98c86 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -42,7 +42,13 @@ extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 #define omap3_pm_set_suspend_state(pwrdm,state) do {} while (0);
 #endif
 extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
-extern int set_opp_level(int res, u32 target_level);
+extern int resource_set_opp_level(int res, u32 target_level, int flags);
+extern int resource_access_opp_lock(int res, int delta);
+#define resource_lock_opp(res) resource_access_opp_lock(res, 1)
+#define resource_unlock_opp(res) resource_access_opp_lock(res, -1)
+#define resource_get_opp_lock(res) resource_access_opp_lock(res, 0)
+
+#define OPP_IGNORE_LOCK 0x1
 
 #ifdef CONFIG_PM_DEBUG
 extern void omap2_pm_dump(int mode, int resume, unsigned int us);
diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index d2c4e1f..e52260d 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -139,6 +139,8 @@ static struct shared_resource *vdd1_resp;
 static struct shared_resource *vdd2_resp;
 static struct device dummy_mpu_dev;
 static struct device dummy_dsp_dev;
+static int vdd1_lock;
+static int vdd2_lock;
 
 /**
  * init_opp - Initialize the OPP resource
@@ -165,7 +167,19 @@ void init_opp(struct shared_resource *resp)
 	return;
 }
 
-int set_opp_level(int res, u32 target_level)
+int resource_access_opp_lock(int res, int delta)
+{
+	if (res == VDD1_OPP) {
+		vdd1_lock += delta;
+		return vdd1_lock;
+	} else if (res == VDD2_OPP) {
+		vdd2_lock += delta;
+		return vdd2_lock;
+	}
+	return -EINVAL;
+}
+
+int resource_set_opp_level(int res, u32 target_level, int flags)
 {
 	unsigned long mpu_freq, mpu_old_freq, l3_freq, t_opp;
 	struct cpufreq_freqs freqs_notify;
@@ -185,6 +199,8 @@ int set_opp_level(int res, u32 target_level)
 		return 0;
 
 	if (res == VDD1_OPP) {
+		if (flags != OPP_IGNORE_LOCK && vdd1_lock)
+			return 0;
 		mpu_old_freq = get_freq(mpu_opps + MAX_VDD1_OPP,
 					curr_vdd1_prcm_set->opp_id);
 		mpu_freq = get_freq(mpu_opps + MAX_VDD1_OPP,
@@ -219,6 +235,8 @@ int set_opp_level(int res, u32 target_level)
 		cpufreq_notify_transition(&freqs_notify, CPUFREQ_POSTCHANGE);
 #endif
 	} else {
+		if (flags != OPP_IGNORE_LOCK && vdd2_lock)
+			return 0;
 		l3_freq = get_freq(l3_opps + MAX_VDD2_OPP,
 					target_level);
 		t_opp = ID_VDD(PRCM_VDD2) |
@@ -250,7 +268,7 @@ int set_opp(struct shared_resource *resp, u32 target_level)
 	struct bus_throughput_db *tput_db;
 
 	if (resp == vdd1_resp) {
-		set_opp_level(VDD1_OPP, target_level);
+		resource_set_opp_level(VDD1_OPP, target_level, 0);
 	} else if (resp == vdd2_resp) {
 		tput_db = resp->resource_data;
 		tput = target_level;
@@ -262,7 +280,7 @@ int set_opp(struct shared_resource *resp, u32 target_level)
 		/* Set the highest OPP possible */
 		if (ind == MAX_VDD2_OPP)
 			target_level = ind-1;
-		set_opp_level(VDD2_OPP, target_level);
+		resource_set_opp_level(VDD2_OPP, target_level, 0);
 	}
 	return 0;
 }
-- 
1.5.4.3


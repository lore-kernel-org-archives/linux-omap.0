From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 15/16] OMAP3: Dynamic enable/disable of OFF support
Date: Fri, 26 Sep 2008 17:50:16 +0530
Message-ID: <020001c91fd2$3c0c92e0$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34384 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079AbYIZMU0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 08:20:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: 'Kevin Hilman' <khilman@deeprootsystems.com>

This patch adds a runtime sysfs knob (/sys/power/enable_off_mode)
to enable/disbale CORE OFF support for OMAP3. 

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm.c     |   21 +++++++++++++++++----
 arch/arm/mach-omap2/pm.h     |    2 ++
 arch/arm/mach-omap2/pm34xx.c |   26 ++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 4 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2008-09-26 16:39:30.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2008-09-26 16:39:34.000000000 +0530
@@ -395,6 +395,32 @@ static int omap3_can_sleep(void)
 	return 1;
 }
 
+int set_next_pwrst(struct powerdomain *pwrdm)
+{
+	struct power_state *pwrst;
+	int ret = 0;
+	u32 state;
+
+	if (!pwrdm->pwrsts)
+		return 0;
+
+	if (enable_off_mode)
+		state = PWRDM_POWER_OFF;
+	else
+		state = PWRDM_POWER_RET;
+
+	ret = pwrdm_set_next_pwrst(pwrdm, state);
+	if (ret) {
+		printk(KERN_ERR "Unable to set state of powerdomain: %s\n",
+		       pwrdm->name);
+		goto err;
+	}
+	list_for_each_entry(pwrst, &pwrst_list, node)
+		pwrst->next_state = state;
+err:
+	return ret;
+}
+
 /* This sets pwrdm state (other than mpu & core. Currently only ON &
  * RET are supported. Function is assuming that clkdm doesn't have
  * hw_sup mode enabled. */
Index: linux-omap-2.6/arch/arm/mach-omap2/pm.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm.c	2008-09-26 16:39:30.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm.c	2008-09-26 16:39:34.000000000 +0530
@@ -35,6 +35,7 @@
 
 unsigned short enable_dyn_sleep;
 unsigned short clocks_off_while_idle;
+unsigned short enable_off_mode;
 atomic_t sleep_block = ATOMIC_INIT(0);
 
 static ssize_t idle_show(struct kobject *, struct kobj_attribute *, char *);
@@ -47,6 +48,9 @@ static struct kobj_attribute sleep_while
 static struct kobj_attribute clocks_off_while_idle_attr =
 	__ATTR(clocks_off_while_idle, 0644, idle_show, idle_store);
 
+static struct kobj_attribute enable_off_mode_attr =
+	__ATTR(enable_off_mode, 0644, idle_show, idle_store);
+
 static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
 			 char *buf)
 {
@@ -54,6 +58,8 @@ static ssize_t idle_show(struct kobject 
 		return sprintf(buf, "%hu\n", enable_dyn_sleep);
 	else if (attr == &clocks_off_while_idle_attr)
 		return sprintf(buf, "%hu\n", clocks_off_while_idle);
+	else if (attr == &enable_off_mode_attr)
+		return sprintf(buf, "%hu\n", enable_off_mode);
 	else
 		return -EINVAL;
 }
@@ -69,13 +75,16 @@ static ssize_t idle_store(struct kobject
 		return -EINVAL;
 	}
 
-	if (attr == &sleep_while_idle_attr)
+	if (attr == &sleep_while_idle_attr) {
 		enable_dyn_sleep = value;
-	else if (attr == &clocks_off_while_idle_attr)
+	} else if (attr == &clocks_off_while_idle_attr) {
 		clocks_off_while_idle = value;
-	else
+	} else if (attr == &enable_off_mode_attr) {
+		enable_off_mode = value;
+		pwrdm_for_each(set_next_pwrst);
+	} else {
 		return -EINVAL;
-
+	}
 	return n;
 }
 
@@ -114,6 +123,10 @@ static int __init omap_pm_init(void)
 				  &clocks_off_while_idle_attr.attr);
 	if (error)
 		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
+	error = sysfs_create_file(power_kobj,
+				  &enable_off_mode_attr.attr);
+	if (error)
+		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
 
 	return error;
 }
Index: linux-omap-2.6/arch/arm/mach-omap2/pm.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm.h	2008-09-26 16:39:30.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm.h	2008-09-26 16:39:34.000000000 +0530
@@ -18,10 +18,12 @@ extern int omap3_pm_init(void);
 
 extern unsigned short enable_dyn_sleep;
 extern unsigned short clocks_off_while_idle;
+extern unsigned short enable_off_mode;
 extern atomic_t sleep_block;
 
 extern void omap2_block_sleep(void);
 extern void omap2_allow_sleep(void);
+extern int set_next_pwrst(struct powerdomain *pwrdm);
 
 #define OMAP343X_TABLE_ADDRESS_OFFSET 0x31
 #define OMAP343X_TABLE_VALUE_OFFSET   0x30


From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/2] OMAP2/3: PM: remove /sys/power/clocks_off_while_idle
Date: Tue, 19 May 2009 10:14:24 -0700
Message-ID: <1242753264-12600-3-git-send-email-khilman@deeprootsystems.com>
References: <1242753264-12600-1-git-send-email-khilman@deeprootsystems.com>
 <1242753264-12600-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f134.google.com ([209.85.222.134]:43829 "EHLO
	mail-pz0-f134.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564AbZESROg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 13:14:36 -0400
Received: by pzk40 with SMTP id 40so318550pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 10:14:38 -0700 (PDT)
In-Reply-To: <1242753264-12600-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The sysfs control /sys/power/clocks_off_while_idle only affects
the UART clocks.  And these can now be controlled with a UART
specific timeout sysfs control.  The system default behavior
is to have the equivalent of clocks_off_while_idle == 1 and
a UART inactivity timeout of 5 seconds.

Now one can use

  /sys/devices/platform/serial8250.<uart>/sleep_timeout

to set the inactivity timer for the UART in seconds.  Setting
this value to zero disables the timout and is the equivalent
of doing an

  echo 0 > /sys/power/clocks_off_while_idle

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm.c     |   12 ------------
 arch/arm/mach-omap2/pm.h     |    1 -
 arch/arm/mach-omap2/serial.c |    3 ---
 3 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 58ed520..8633f86 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -39,7 +39,6 @@
 #include "pm.h"
 
 unsigned short enable_dyn_sleep;
-unsigned short clocks_off_while_idle;
 unsigned short enable_off_mode;
 unsigned short voltage_off_while_idle;
 unsigned short wakeup_timer_seconds;
@@ -52,9 +51,6 @@ static ssize_t idle_store(struct kobject *k, struct kobj_attribute *,
 static struct kobj_attribute sleep_while_idle_attr =
 	__ATTR(sleep_while_idle, 0644, idle_show, idle_store);
 
-static struct kobj_attribute clocks_off_while_idle_attr =
-	__ATTR(clocks_off_while_idle, 0644, idle_show, idle_store);
-
 static struct kobj_attribute enable_off_mode_attr =
 	__ATTR(enable_off_mode, 0644, idle_show, idle_store);
 
@@ -85,8 +81,6 @@ static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	if (attr == &sleep_while_idle_attr)
 		return sprintf(buf, "%hu\n", enable_dyn_sleep);
-	else if (attr == &clocks_off_while_idle_attr)
-		return sprintf(buf, "%hu\n", clocks_off_while_idle);
 	else if (attr == &enable_off_mode_attr)
 		return sprintf(buf, "%hu\n", enable_off_mode);
 	else if (attr == &voltage_off_while_idle_attr)
@@ -109,8 +103,6 @@ static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 	if (attr == &sleep_while_idle_attr) {
 		enable_dyn_sleep = value;
-	} else if (attr == &clocks_off_while_idle_attr) {
-		clocks_off_while_idle = value;
 	} else if (attr == &enable_off_mode_attr) {
 		enable_off_mode = value;
 		omap3_pm_off_mode_enable(enable_off_mode);
@@ -255,10 +247,6 @@ static int __init omap_pm_init(void)
 	if (error)
 		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
 	error = sysfs_create_file(power_kobj,
-				  &clocks_off_while_idle_attr.attr);
-	if (error)
-		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
-	error = sysfs_create_file(power_kobj,
 				  &enable_off_mode_attr.attr);
 	if (error) {
 		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index e523d75..2547e1b 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -24,7 +24,6 @@ static inline int omap3_idle_init(void) { return 0; }
 #endif
 
 extern unsigned short enable_dyn_sleep;
-extern unsigned short clocks_off_while_idle;
 extern unsigned short enable_off_mode;
 extern unsigned short voltage_off_while_idle;
 extern atomic_t sleep_block;
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index c9059fd..8c27700 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -263,9 +263,6 @@ void omap_uart_prepare_idle(int num)
 	struct omap_uart_state *uart;
 
 	list_for_each_entry(uart, &uart_list, node) {
-		if (!clocks_off_while_idle)
-			continue;
-
 		if (num == uart->num && uart->can_sleep) {
 			omap_uart_disable_clocks(uart);
 			return;
-- 
1.6.2.2


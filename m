From: jean.pihet@newoldbits.com
Subject: [PATCH] PM QoS: add a PM_QOS_MEMORY_THROUGHPUT class
Date: Fri, 30 Sep 2011 16:17:20 +0200
Message-ID: <1317392240-28422-1-git-send-email-j-pihet@ti.com>
References: <CAORVsuXqujs-mdXG0VYb+LKfPVG2AfboxacKFSW1fo0E-3C3sg@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54814 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758651Ab1I3ORn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Sep 2011 10:17:43 -0400
Received: by wyg34 with SMTP id 34so1146673wyg.19
        for <linux-omap@vger.kernel.org>; Fri, 30 Sep 2011 07:17:42 -0700 (PDT)
In-Reply-To: <CAORVsuXqujs-mdXG0VYb+LKfPVG2AfboxacKFSW1fo0E-3C3sg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.ke
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Provide a memory or SDMA throughput constraints class,
which can be applied to the low level platform code using the
callback notification mechanism and
also a MISC /dev entry for the constraints from user space.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 include/linux/pm_qos.h |   14 ++++++++------
 kernel/power/qos.c     |   17 +++++++++++++++++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 83b0ea3..bd3d936 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -9,16 +9,18 @@
 #include <linux/miscdevice.h>
 #include <linux/device.h>
 
-#define PM_QOS_RESERVED 0
-#define PM_QOS_CPU_DMA_LATENCY 1
-#define PM_QOS_NETWORK_LATENCY 2
-#define PM_QOS_NETWORK_THROUGHPUT 3
+#define PM_QOS_RESERVED			0
+#define PM_QOS_CPU_DMA_LATENCY		1
+#define PM_QOS_NETWORK_LATENCY		2
+#define PM_QOS_MEMORY_THROUGHPUT	3
+#define PM_QOS_NETWORK_THROUGHPUT	4
 
-#define PM_QOS_NUM_CLASSES 4
-#define PM_QOS_DEFAULT_VALUE -1
+#define PM_QOS_NUM_CLASSES		5
+#define PM_QOS_DEFAULT_VALUE		-1
 
 #define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
 #define PM_QOS_NETWORK_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
+#define PM_QOS_MEMORY_THROUGHPUT_DEFAULT_VALUE	0
 #define PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE	0
 #define PM_QOS_DEV_LAT_DEFAULT_VALUE		0
 
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 1c1797d..b1b909d 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -84,6 +84,18 @@ static struct pm_qos_object network_lat_pm_qos = {
 	.name = "network_latency",
 };
 
+static BLOCKING_NOTIFIER_HEAD(memory_throughput_notifier);
+static struct pm_qos_constraints memory_tput_constraints = {
+	.list = PLIST_HEAD_INIT(memory_tput_constraints.list),
+	.target_value = PM_QOS_MEMORY_THROUGHPUT_DEFAULT_VALUE,
+	.default_value = PM_QOS_MEMORY_THROUGHPUT_DEFAULT_VALUE,
+	.type = PM_QOS_MAX,
+	.notifiers = &memory_throughput_notifier,
+};
+static struct pm_qos_object memory_throughput_pm_qos = {
+	.constraints = &memory_tput_constraints,
+	.name = "memory_throughput",
+};
 
 static BLOCKING_NOTIFIER_HEAD(network_throughput_notifier);
 static struct pm_qos_constraints network_tput_constraints = {
@@ -103,6 +115,7 @@ static struct pm_qos_object *pm_qos_array[] = {
 	&null_pm_qos,
 	&cpu_dma_pm_qos,
 	&network_lat_pm_qos,
+	&memory_throughput_pm_qos,
 	&network_throughput_pm_qos
 };
 
@@ -479,6 +492,10 @@ static int __init pm_qos_power_init(void)
 		printk(KERN_ERR "pm_qos_param: network_latency setup failed\n");
 		return ret;
 	}
+	ret = register_pm_qos_misc(&memory_throughput_pm_qos);
+	if (ret < 0)
+		printk(KERN_ERR
+			"pm_qos_param: memory_throughput setup failed\n");
 	ret = register_pm_qos_misc(&network_throughput_pm_qos);
 	if (ret < 0)
 		printk(KERN_ERR
-- 
1.7.4.1


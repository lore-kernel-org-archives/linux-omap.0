From: jean.pihet@newoldbits.com
Subject: [PATCH 01/11] PM: add a per-device wake-up latency constraints plist
Date: Thu, 30 Jun 2011 17:11:15 +0200
Message-ID: <1309446685-17502-2-git-send-email-j-pihet@ti.com>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36749 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630Ab1F3PLr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jun 2011 11:11:47 -0400
Received: by wyg8 with SMTP id 8so1617923wyg.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Jun 2011 08:11:46 -0700 (PDT)
In-Reply-To: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foun>
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Add the field wakeup_lat_plist_head in the struct dev_pm_info
and the initialization of the plist in device_pm_init.

This enables the implementation of per-device constraints in
PM QoS.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 drivers/base/power/main.c |    3 +++
 include/linux/pm.h        |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index aa632020..b1fd96b 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -96,6 +96,8 @@ void device_pm_add(struct device *dev)
 			dev_name(dev->parent));
 	list_add_tail(&dev->power.entry, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
+	/* ToDo: call PM QoS to init the per-device wakeup latency constraints */
+	plist_head_init(&dev->power.wakeup_lat_plist_head, &dev->power.lock);
 }
 
 /**
@@ -106,6 +108,7 @@ void device_pm_remove(struct device *dev)
 {
 	pr_debug("PM: Removing info for %s:%s\n",
 		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
+	/* ToDo: call PM QoS to de-init the per-device wakeup latency constraints */
 	complete_all(&dev->power.completion);
 	mutex_lock(&dpm_list_mtx);
 	list_del_init(&dev->power.entry);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 3160648..35fe682 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -22,6 +22,7 @@
 #define _LINUX_PM_H
 
 #include <linux/list.h>
+#include <linux/plist.h>
 #include <linux/workqueue.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
@@ -462,6 +463,7 @@ struct dev_pm_info {
 	unsigned long		accounting_timestamp;
 	void			*subsys_data;  /* Owned by the subsystem. */
 #endif
+	struct plist_head	wakeup_lat_plist_head;
 };
 
 extern void update_pm_runtime_accounting(struct device *dev);
-- 
1.7.4.1


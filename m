From: jean.pihet@newoldbits.com
Subject: [RFC/PATCH 1/9] PM: add a per-device wake-up latency constraints plist
Date: Fri, 24 Jun 2011 16:37:58 +0200
Message-ID: <1308926286-30445-2-git-send-email-j-pihet@ti.com>
References: <1308926286-30445-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45637 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759332Ab1FXOi1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 10:38:27 -0400
Received: by wwe5 with SMTP id 5so2945133wwe.1
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 07:38:26 -0700 (PDT)
In-Reply-To: <1308926286-30445-1-git-send-email-j-pihet@ti.com>
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
 drivers/base/power/main.c |    1 +
 include/linux/pm.h        |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index aa632020..6a096d1 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -64,6 +64,7 @@ void device_pm_init(struct device *dev)
 	spin_lock_init(&dev->power.lock);
 	pm_runtime_init(dev);
 	INIT_LIST_HEAD(&dev->power.entry);
+	plist_head_init(&dev->power.wakeup_lat_plist_head, &dev->power.lock);
 }
 
 /**
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


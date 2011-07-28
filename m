From: jean.pihet@newoldbits.com
Subject: [PATCH 02/13] PM: add a per-device wake-up latency constraints plist
Date: Thu, 28 Jul 2011 10:30:09 +0200
Message-ID: <1311841821-10252-3-git-send-email-j-pihet@ti.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48760 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754958Ab1G1Ia6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jul 2011 04:30:58 -0400
Received: by wwe5 with SMTP id 5so2221867wwe.1
        for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 01:30:57 -0700 (PDT)
In-Reply-To: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foun>
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Add the field latency_constraints in the struct dev_pm_info
and the initialization of the plist in device_pm_init.

This enables the implementation of per-device constraints in
PM QoS.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 drivers/base/power/main.c |    1 +
 include/linux/pm.h        |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 06f09bf..dad2eb9 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -97,6 +97,7 @@ void device_pm_add(struct device *dev)
 			dev_name(dev->parent));
 	list_add_tail(&dev->power.entry, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
+	plist_head_init(&dev->power.latency_constraints, &dev->power.lock);
 }
 
 /**
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 411e4f4..23c85f1 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -22,6 +22,7 @@
 #define _LINUX_PM_H
 
 #include <linux/list.h>
+#include <linux/plist.h>
 #include <linux/workqueue.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
@@ -463,6 +464,7 @@ struct dev_pm_info {
 	unsigned long		accounting_timestamp;
 	void			*subsys_data;  /* Owned by the subsystem. */
 #endif
+	struct plist_head	latency_constraints;
 };
 
 extern void update_pm_runtime_accounting(struct device *dev);
-- 
1.7.2.5


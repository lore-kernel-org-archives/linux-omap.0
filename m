From: jean.pihet@newoldbits.com
Subject: [PATCH 03/15] PM QoS: code re-organization
Date: Tue, 16 Aug 2011 15:43:06 +0200
Message-ID: <1313502198-9298-4-git-send-email-j-pihet@ti.com>
References: <1313502198-9298-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36094 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab1HPNnr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Aug 2011 09:43:47 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so5889599wwf.1
        for <linux-omap@vger.kernel.org>; Tue, 16 Aug 2011 06:43:46 -0700 (PDT)
In-Reply-To: <1313502198-9298-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.ke
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Move around the PM QoS misc devices management code
for better readability.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 kernel/power/qos.c |   45 +++++++++++++++++++++++----------------------
 1 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index aa52c44..788c4cf 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -188,28 +188,6 @@ static void update_target(struct pm_qos_object *o, struct plist_node *node,
 					     NULL);
 }
 
-static int register_pm_qos_misc(struct pm_qos_object *qos)
-{
-	qos->pm_qos_power_miscdev.minor = MISC_DYNAMIC_MINOR;
-	qos->pm_qos_power_miscdev.name = qos->name;
-	qos->pm_qos_power_miscdev.fops = &pm_qos_power_fops;
-
-	return misc_register(&qos->pm_qos_power_miscdev);
-}
-
-static int find_pm_qos_object_by_minor(int minor)
-{
-	int pm_qos_class;
-
-	for (pm_qos_class = 0;
-		pm_qos_class < PM_QOS_NUM_CLASSES; pm_qos_class++) {
-		if (minor ==
-			pm_qos_array[pm_qos_class]->pm_qos_power_miscdev.minor)
-			return pm_qos_class;
-	}
-	return -1;
-}
-
 /**
  * pm_qos_request - returns current system wide qos expectation
  * @pm_qos_class: identification of which qos value is requested
@@ -362,6 +340,29 @@ int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier)
 }
 EXPORT_SYMBOL_GPL(pm_qos_remove_notifier);
 
+/* User space interface to PM QoS classes via misc devices */
+static int register_pm_qos_misc(struct pm_qos_object *qos)
+{
+	qos->pm_qos_power_miscdev.minor = MISC_DYNAMIC_MINOR;
+	qos->pm_qos_power_miscdev.name = qos->name;
+	qos->pm_qos_power_miscdev.fops = &pm_qos_power_fops;
+
+	return misc_register(&qos->pm_qos_power_miscdev);
+}
+
+static int find_pm_qos_object_by_minor(int minor)
+{
+	int pm_qos_class;
+
+	for (pm_qos_class = 0;
+		pm_qos_class < PM_QOS_NUM_CLASSES; pm_qos_class++) {
+		if (minor ==
+			pm_qos_array[pm_qos_class]->pm_qos_power_miscdev.minor)
+			return pm_qos_class;
+	}
+	return -1;
+}
+
 static int pm_qos_power_open(struct inode *inode, struct file *filp)
 {
 	long pm_qos_class;
-- 
1.7.4.1


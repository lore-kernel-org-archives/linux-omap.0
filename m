From: Manikandan Pillai <mani.pillai@ti.com>
Subject: [PATCH 1/1] Relocating struct regulator_dev to include/linux/regulator/driver.h.
Date: Mon,  8 Dec 2008 15:06:49 +0530
Message-ID: <1228729009-6796-1-git-send-email-mani.pillai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43201 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752291AbYLHJhP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Dec 2008 04:37:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, broonie@sirena.org.uk
Cc: Manikandan Pillai <mani.pillai@ti.com>

The struct regulator_dev declaration has been moved from
driver/regulator/core.c to include/linux/regulator/driver.h for
supporting new regulators.

Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
---
 drivers/regulator/core.c         |   27 ---------------------------
 include/linux/regulator/driver.h |   28 +++++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 02a7744..901f402 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -30,33 +30,6 @@ static LIST_HEAD(regulator_list);
 static LIST_HEAD(regulator_map_list);
 
 /**
- * struct regulator_dev
- *
- * Voltage / Current regulator class device. One for each regulator.
- */
-struct regulator_dev {
-	struct regulator_desc *desc;
-	int use_count;
-
-	/* lists we belong to */
-	struct list_head list; /* list of all regulators */
-	struct list_head slist; /* list of supplied regulators */
-
-	/* lists we own */
-	struct list_head consumer_list; /* consumers we supply */
-	struct list_head supply_list; /* regulators we supply */
-
-	struct blocking_notifier_head notifier;
-	struct mutex mutex; /* consumer lock */
-	struct module *owner;
-	struct device dev;
-	struct regulation_constraints *constraints;
-	struct regulator_dev *supply;	/* for tree */
-
-	void *reg_data;		/* regulator_dev data */
-};
-
-/**
  * struct regulator_map
  *
  * Used to provide symbolic supply names to devices.
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index e37d805..276ef41 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -18,10 +18,36 @@
 #include <linux/device.h>
 #include <linux/regulator/consumer.h>
 
-struct regulator_dev;
 struct regulator_init_data;
 
 /**
+ * struct regulator_dev
+ *
+ * Voltage / Current regulator class device. One for each regulator.
+ */
+struct regulator_dev {
+	struct regulator_desc *desc;
+	int use_count;
+
+	/* lists we belong to */
+	struct list_head list;		/* list of all regulators */
+	struct list_head slist;		/* list of supplied regulators */
+
+	/* lists we own */
+	struct list_head consumer_list;	/* consumers we supply */
+	struct list_head supply_list;	/* regulators we supply */
+
+	struct blocking_notifier_head notifier;
+	struct mutex mutex;		/* consumer lock */
+	struct module *owner;
+	struct device dev;
+	struct regulation_constraints *constraints;
+	struct regulator_dev *supply;	/* for tree */
+
+	void *reg_data;			/* regulator_dev data */
+};
+
+/**
  * struct regulator_ops - regulator operations.
  *
  * This struct describes regulator operations.
-- 
1.5.6


From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/4] mailbox/omap: drop legacy platform device support
Date: Wed, 6 Apr 2016 12:37:37 -0500
Message-ID: <1459964260-43054-2-git-send-email-s-anna@ti.com>
References: <1459964260-43054-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459964260-43054-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

OMAP mailbox devices can no longer be created in legacy non-DT
mode, all the relevant code has been cleaned up. The OMAP mailbox
driver will only support devices created from DT going forward,
so drop the legacy platform device support from the driver.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/mailbox/omap-mailbox.c             | 101 ++++++++++++-----------------
 include/linux/platform_data/mailbox-omap.h |  58 -----------------
 2 files changed, 41 insertions(+), 118 deletions(-)
 delete mode 100644 include/linux/platform_data/mailbox-omap.h

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index b7f636f15cac..ea06072c7322 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -2,7 +2,7 @@
  * OMAP mailbox driver
  *
  * Copyright (C) 2006-2009 Nokia Corporation. All rights reserved.
- * Copyright (C) 2013-2014 Texas Instruments Inc.
+ * Copyright (C) 2013-2016 Texas Instruments Incorporated - http://www.ti.com
  *
  * Contact: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
  *          Suman Anna <s-anna@ti.com>
@@ -33,7 +33,6 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <linux/platform_data/mailbox-omap.h>
 #include <linux/omap-mailbox.h>
 #include <linux/mailbox_controller.h>
 #include <linux/mailbox_client.h>
@@ -69,6 +68,10 @@
 #define MBOX_NR_REGS			(MBOX_REG_SIZE / sizeof(u32))
 #define OMAP4_MBOX_NR_REGS		(OMAP4_MBOX_REG_SIZE / sizeof(u32))
 
+/* Interrupt register configuration types */
+#define MBOX_INTR_CFG_TYPE1		(0)
+#define MBOX_INTR_CFG_TYPE2		(1)
+
 struct omap_mbox_fifo {
 	unsigned long msg;
 	unsigned long fifo_stat;
@@ -696,8 +699,6 @@ static int omap_mbox_probe(struct platform_device *pdev)
 	int ret;
 	struct mbox_chan *chnls;
 	struct omap_mbox **list, *mbox, *mboxblk;
-	struct omap_mbox_pdata *pdata = pdev->dev.platform_data;
-	struct omap_mbox_dev_info *info = NULL;
 	struct omap_mbox_fifo_info *finfo, *finfoblk;
 	struct omap_mbox_device *mdev;
 	struct omap_mbox_fifo *fifo;
@@ -710,36 +711,26 @@ static int omap_mbox_probe(struct platform_device *pdev)
 	u32 l;
 	int i;
 
-	if (!node && (!pdata || !pdata->info_cnt || !pdata->info)) {
-		pr_err("%s: platform not supported\n", __func__);
+	if (!node) {
+		pr_err("%s: only DT-based devices are supported\n", __func__);
 		return -ENODEV;
 	}
 
-	if (node) {
-		match = of_match_device(omap_mailbox_of_match, &pdev->dev);
-		if (!match)
-			return -ENODEV;
-		intr_type = (u32)match->data;
+	match = of_match_device(omap_mailbox_of_match, &pdev->dev);
+	if (!match)
+		return -ENODEV;
+	intr_type = (u32)match->data;
 
-		if (of_property_read_u32(node, "ti,mbox-num-users",
-					 &num_users))
-			return -ENODEV;
+	if (of_property_read_u32(node, "ti,mbox-num-users", &num_users))
+		return -ENODEV;
 
-		if (of_property_read_u32(node, "ti,mbox-num-fifos",
-					 &num_fifos))
-			return -ENODEV;
+	if (of_property_read_u32(node, "ti,mbox-num-fifos", &num_fifos))
+		return -ENODEV;
 
-		info_count = of_get_available_child_count(node);
-		if (!info_count) {
-			dev_err(&pdev->dev, "no available mbox devices found\n");
-			return -ENODEV;
-		}
-	} else { /* non-DT device creation */
-		info_count = pdata->info_cnt;
-		info = pdata->info;
-		intr_type = pdata->intr_type;
-		num_users = pdata->num_users;
-		num_fifos = pdata->num_fifos;
+	info_count = of_get_available_child_count(node);
+	if (!info_count) {
+		dev_err(&pdev->dev, "no available mbox devices found\n");
+		return -ENODEV;
 	}
 
 	finfoblk = devm_kzalloc(&pdev->dev, info_count * sizeof(*finfoblk),
@@ -750,38 +741,28 @@ static int omap_mbox_probe(struct platform_device *pdev)
 	finfo = finfoblk;
 	child = NULL;
 	for (i = 0; i < info_count; i++, finfo++) {
-		if (node) {
-			child = of_get_next_available_child(node, child);
-			ret = of_property_read_u32_array(child, "ti,mbox-tx",
-							 tmp, ARRAY_SIZE(tmp));
-			if (ret)
-				return ret;
-			finfo->tx_id = tmp[0];
-			finfo->tx_irq = tmp[1];
-			finfo->tx_usr = tmp[2];
-
-			ret = of_property_read_u32_array(child, "ti,mbox-rx",
-							 tmp, ARRAY_SIZE(tmp));
-			if (ret)
-				return ret;
-			finfo->rx_id = tmp[0];
-			finfo->rx_irq = tmp[1];
-			finfo->rx_usr = tmp[2];
-
-			finfo->name = child->name;
-
-			if (of_find_property(child, "ti,mbox-send-noirq", NULL))
-				finfo->send_no_irq = true;
-		} else {
-			finfo->tx_id = info->tx_id;
-			finfo->rx_id = info->rx_id;
-			finfo->tx_usr = info->usr_id;
-			finfo->tx_irq = info->irq_id;
-			finfo->rx_usr = info->usr_id;
-			finfo->rx_irq = info->irq_id;
-			finfo->name = info->name;
-			info++;
-		}
+		child = of_get_next_available_child(node, child);
+		ret = of_property_read_u32_array(child, "ti,mbox-tx", tmp,
+						 ARRAY_SIZE(tmp));
+		if (ret)
+			return ret;
+		finfo->tx_id = tmp[0];
+		finfo->tx_irq = tmp[1];
+		finfo->tx_usr = tmp[2];
+
+		ret = of_property_read_u32_array(child, "ti,mbox-rx", tmp,
+						 ARRAY_SIZE(tmp));
+		if (ret)
+			return ret;
+		finfo->rx_id = tmp[0];
+		finfo->rx_irq = tmp[1];
+		finfo->rx_usr = tmp[2];
+
+		finfo->name = child->name;
+
+		if (of_find_property(child, "ti,mbox-send-noirq", NULL))
+			finfo->send_no_irq = true;
+
 		if (finfo->tx_id >= num_fifos || finfo->rx_id >= num_fifos ||
 		    finfo->tx_usr >= num_users || finfo->rx_usr >= num_users)
 			return -EINVAL;
diff --git a/include/linux/platform_data/mailbox-omap.h b/include/linux/platform_data/mailbox-omap.h
deleted file mode 100644
index 4631dbb4255e..000000000000
--- a/include/linux/platform_data/mailbox-omap.h
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- * mailbox-omap.h
- *
- * Copyright (C) 2013 Texas Instruments, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#ifndef _PLAT_MAILBOX_H
-#define _PLAT_MAILBOX_H
-
-/* Interrupt register configuration types */
-#define MBOX_INTR_CFG_TYPE1	(0)
-#define MBOX_INTR_CFG_TYPE2	(1)
-
-/**
- * struct omap_mbox_dev_info - OMAP mailbox device attribute info
- * @name:	name of the mailbox device
- * @tx_id:	mailbox queue id used for transmitting messages
- * @rx_id:	mailbox queue id on which messages are received
- * @irq_id:	irq identifier number to use from the hwmod data
- * @usr_id:	mailbox user id for identifying the interrupt into
- *			the MPU interrupt controller.
- */
-struct omap_mbox_dev_info {
-	const char *name;
-	u32 tx_id;
-	u32 rx_id;
-	u32 irq_id;
-	u32 usr_id;
-};
-
-/**
- * struct omap_mbox_pdata - OMAP mailbox platform data
- * @intr_type:	type of interrupt configuration registers used
-			while programming mailbox queue interrupts
- * @num_users:	number of users (processor devices) that the mailbox
- *			h/w block can interrupt
- * @num_fifos:	number of h/w fifos within the mailbox h/w block
- * @info_cnt:	number of mailbox devices for the platform
- * @info:	array of mailbox device attributes
- */
-struct omap_mbox_pdata {
-	u32 intr_type;
-	u32 num_users;
-	u32 num_fifos;
-	u32 info_cnt;
-	struct omap_mbox_dev_info *info;
-};
-
-#endif /* _PLAT_MAILBOX_H */
-- 
2.7.4

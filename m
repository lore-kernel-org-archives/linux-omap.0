From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 10/10] omap mailbox: Set a device in logical mbox instance for traceability
Date: Thu,  3 Jun 2010 09:34:18 +0300
Message-ID: <1275546858-29507-11-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35369 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932279Ab0FCGev (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 02:34:51 -0400
In-Reply-To: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

With this patch, you'll get the following sysfs directories. This
structure implies that a single platform device, "omap2-mailbox" holds
multiple logical mbox instances. This could be the base to add sysfs
files for each logical mboxes. Then userland application can access a
mbox through sysfs entries if necessary(ex: setting kfifo size
dynamically)

  ~# tree -d -L 2 /sys/devices/platform/omap2-mailbox/
  /sys/devices/platform/omap2-mailbox/
  |-- driver -> ../../../bus/platform/drivers/omap2-mailbox
  |-- mbox
  |   |-- dsp      <- they are each instances of logical mailbox.
  |   |-- ducati
  |   |-- iva2
  |   |-- mbox01
  |   |-- mbox02
  |   |-- mbox03
  |   |-- .....
  |   `-- tesla
  |-- power
  `-- subsystem -> ../../../bus/platform

This was wrongly dropped by:
     commit c7c158e57bce6220644f2bcd65d82e1468aa40ec

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/mailbox.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index ec0e159..87e0cde 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -347,6 +347,8 @@ void omap_mbox_put(struct omap_mbox *mbox)
 }
 EXPORT_SYMBOL(omap_mbox_put);
 
+static struct class omap_mbox_class = { .name = "mbox", };
+
 int omap_mbox_register(struct device *parent, struct omap_mbox *mbox)
 {
 	int ret = 0;
@@ -357,6 +359,11 @@ int omap_mbox_register(struct device *parent, struct omap_mbox *mbox)
 	if (mbox->next)
 		return -EBUSY;
 
+	mbox->dev = device_create(&omap_mbox_class,
+				  parent, 0, mbox, "%s", mbox->name);
+	if (IS_ERR(mbox->dev))
+		return PTR_ERR(mbox->dev);
+
 	spin_lock(&mboxes_lock);
 	tmp = find_mboxes(mbox->name);
 	if (*tmp) {
@@ -385,6 +392,7 @@ int omap_mbox_unregister(struct omap_mbox *mbox)
 			*tmp = mbox->next;
 			mbox->next = NULL;
 			spin_unlock(&mboxes_lock);
+			device_unregister(mbox->dev);
 			return 0;
 		}
 		tmp = &(*tmp)->next;
@@ -397,6 +405,12 @@ EXPORT_SYMBOL(omap_mbox_unregister);
 
 static int __init omap_mbox_init(void)
 {
+	int err;
+
+	err = class_register(&omap_mbox_class);
+	if (err)
+		return err;
+
 	mboxd = create_workqueue("mboxd");
 	if (!mboxd)
 		return -ENOMEM;
@@ -407,11 +421,12 @@ static int __init omap_mbox_init(void)
 
 	return 0;
 }
-module_init(omap_mbox_init);
+subsys_initcall(omap_mbox_init);
 
 static void __exit omap_mbox_exit(void)
 {
 	destroy_workqueue(mboxd);
+	class_unregister(&omap_mbox_class);
 }
 module_exit(omap_mbox_exit);
 
-- 
1.7.1.rc1


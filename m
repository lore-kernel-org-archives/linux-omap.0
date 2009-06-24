From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 07/07] pm: remove platform device suspend_late()/resume_early() V2
Date: Wed, 24 Jun 2009 18:24:09 +0900
Message-ID: <20090624092409.14276.96577.sendpatchset@rx1.opensource.se>
References: <20090624092306.14276.127.sendpatchset@rx1.opensource.se>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f190.google.com ([209.85.216.190]:47156 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756758AbZFXJfj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jun 2009 05:35:39 -0400
In-Reply-To: <20090624092306.14276.127.sendpatchset@rx1.opensource.se>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@suse.de, ben-linux@fluff.org, hskinnemoen@atmel.com, anemo@mba.ocn.ne.jp, linux-usb@vger.kernel.org, rjw@sisk.pl, stern@rowland.harvard.edu, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, felipe.balbi@nokia.com

From: Magnus Damm <damm@igel.co.jp>

This is V2 of the platform driver power management late/early
callback removal patch. The callbacks ->suspend_late() and
->resume_early() are removed since all in-tree users now have
been migrated to dev_pm_ops.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Untested but compiles fine.

 Changes since V1:
 - none, just rediff to fit upstream changes

 drivers/base/platform.c         |   36 ------------------------------------
 include/linux/platform_device.h |    2 --
 2 files changed, 38 deletions(-)

--- 0001/drivers/base/platform.c
+++ work/drivers/base/platform.c	2009-06-24 17:27:33.000000000 +0900
@@ -628,30 +628,6 @@ static int platform_legacy_suspend(struc
 	return ret;
 }
 
-static int platform_legacy_suspend_late(struct device *dev, pm_message_t mesg)
-{
-	struct platform_driver *pdrv = to_platform_driver(dev->driver);
-	struct platform_device *pdev = to_platform_device(dev);
-	int ret = 0;
-
-	if (dev->driver && pdrv->suspend_late)
-		ret = pdrv->suspend_late(pdev, mesg);
-
-	return ret;
-}
-
-static int platform_legacy_resume_early(struct device *dev)
-{
-	struct platform_driver *pdrv = to_platform_driver(dev->driver);
-	struct platform_device *pdev = to_platform_device(dev);
-	int ret = 0;
-
-	if (dev->driver && pdrv->resume_early)
-		ret = pdrv->resume_early(pdev);
-
-	return ret;
-}
-
 static int platform_legacy_resume(struct device *dev)
 {
 	struct platform_driver *pdrv = to_platform_driver(dev->driver);
@@ -714,8 +690,6 @@ static int platform_pm_suspend_noirq(str
 	if (drv->pm) {
 		if (drv->pm->suspend_noirq)
 			ret = drv->pm->suspend_noirq(dev);
-	} else {
-		ret = platform_legacy_suspend_late(dev, PMSG_SUSPEND);
 	}
 
 	return ret;
@@ -750,8 +724,6 @@ static int platform_pm_resume_noirq(stru
 	if (drv->pm) {
 		if (drv->pm->resume_noirq)
 			ret = drv->pm->resume_noirq(dev);
-	} else {
-		ret = platform_legacy_resume_early(dev);
 	}
 
 	return ret;
@@ -797,8 +769,6 @@ static int platform_pm_freeze_noirq(stru
 	if (drv->pm) {
 		if (drv->pm->freeze_noirq)
 			ret = drv->pm->freeze_noirq(dev);
-	} else {
-		ret = platform_legacy_suspend_late(dev, PMSG_FREEZE);
 	}
 
 	return ret;
@@ -833,8 +803,6 @@ static int platform_pm_thaw_noirq(struct
 	if (drv->pm) {
 		if (drv->pm->thaw_noirq)
 			ret = drv->pm->thaw_noirq(dev);
-	} else {
-		ret = platform_legacy_resume_early(dev);
 	}
 
 	return ret;
@@ -869,8 +837,6 @@ static int platform_pm_poweroff_noirq(st
 	if (drv->pm) {
 		if (drv->pm->poweroff_noirq)
 			ret = drv->pm->poweroff_noirq(dev);
-	} else {
-		ret = platform_legacy_suspend_late(dev, PMSG_HIBERNATE);
 	}
 
 	return ret;
@@ -905,8 +871,6 @@ static int platform_pm_restore_noirq(str
 	if (drv->pm) {
 		if (drv->pm->restore_noirq)
 			ret = drv->pm->restore_noirq(dev);
-	} else {
-		ret = platform_legacy_resume_early(dev);
 	}
 
 	return ret;
--- 0001/include/linux/platform_device.h
+++ work/include/linux/platform_device.h	2009-06-24 17:27:33.000000000 +0900
@@ -57,8 +57,6 @@ struct platform_driver {
 	int (*remove)(struct platform_device *);
 	void (*shutdown)(struct platform_device *);
 	int (*suspend)(struct platform_device *, pm_message_t state);
-	int (*suspend_late)(struct platform_device *, pm_message_t state);
-	int (*resume_early)(struct platform_device *);
 	int (*resume)(struct platform_device *);
 	struct device_driver driver;
 	struct platform_device_id *id_table;

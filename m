From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/4] platform_bus: allow custom extensions to system PM methods
Date: Thu, 27 May 2010 14:13:16 -0700
Message-ID: <1274994799-30297-2-git-send-email-khilman@deeprootsystems.com>
References: <1274994799-30297-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45584 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756760Ab0E0VNX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 17:13:23 -0400
Received: by pwi7 with SMTP id 7so248809pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 14:13:23 -0700 (PDT)
In-Reply-To: <1274994799-30297-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

When runtime PM for platform_bus was added, it allowed for platforms
to customize the runtime PM methods since they are defined as weak
symbols.

This patch allows platforms to also extend the system PM methods with
custom hooks so runtime PM and system PM extensions can be managed
together by custom platform-specific code.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Magnus Damm <damm@opensource.se>
Cc: Rafael Wysocki <rjw@sisk.pl>
Cc: Dmitry Torokhov <dtor@mail.ru>
Cc: Eric Miao <eric.y.miao@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/platform.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 4b4b565..0bc478a 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -735,7 +735,7 @@ static void platform_pm_complete(struct device *dev)
 
 #ifdef CONFIG_SUSPEND
 
-static int platform_pm_suspend(struct device *dev)
+int __weak platform_pm_suspend(struct device *dev)
 {
 	struct device_driver *drv = dev->driver;
 	int ret = 0;
@@ -753,7 +753,7 @@ static int platform_pm_suspend(struct device *dev)
 	return ret;
 }
 
-static int platform_pm_suspend_noirq(struct device *dev)
+int __weak platform_pm_suspend_noirq(struct device *dev)
 {
 	struct device_driver *drv = dev->driver;
 	int ret = 0;
@@ -769,7 +769,7 @@ static int platform_pm_suspend_noirq(struct device *dev)
 	return ret;
 }
 
-static int platform_pm_resume(struct device *dev)
+int __weak platform_pm_resume(struct device *dev)
 {
 	struct device_driver *drv = dev->driver;
 	int ret = 0;
@@ -787,7 +787,7 @@ static int platform_pm_resume(struct device *dev)
 	return ret;
 }
 
-static int platform_pm_resume_noirq(struct device *dev)
+int __weak platform_pm_resume_noirq(struct device *dev)
 {
 	struct device_driver *drv = dev->driver;
 	int ret = 0;
-- 
1.7.0.2


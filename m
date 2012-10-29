From: Raffaele Recalcati <lamiaposta71@gmail.com>
Subject: [PATCH] watchdog: omap_wdt: removed disabling in the probe
Date: Mon, 29 Oct 2012 12:11:27 +0100
Message-ID: <1351509087-6606-1-git-send-email-lamiaposta71@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:58359 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758294Ab2J2KLh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Oct 2012 06:11:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, wim@iguana.be, linux-watchdog@vger.kernel.org
Cc: Raffaele Recalcati <lamiaposta71@gmail.com>

In NOWAYOUT case it is better to have watchdog always enabled at boot,
in order not to leave the system in undefined state in case of userspace
failure.

Signed-off-by: Raffaele Recalcati <lamiaposta71@gmail.com>
---
Tested using http://arago-project.org/git/projects/linux-omap3.git
v2.6.37_OMAPPSP_04.02.00.07 commit.

 drivers/watchdog/omap_wdt.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 27ab8db..181b939 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -304,8 +304,16 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 	pm_runtime_enable(wdev->dev);
 	pm_runtime_get_sync(wdev->dev);
 
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
 	omap_wdt_disable(wdev);
 	omap_wdt_adjust_timeout(timer_margin);
+#else
+	omap_wdt_adjust_timeout(timer_margin);
+	omap_wdt_disable(wdev);
+	omap_wdt_set_timeout(wdev);
+	omap_wdt_enable(wdev);
+	omap_wdt_ping(wdev);
+#endif
 
 	wdev->omap_wdt_miscdev.parent = &pdev->dev;
 	wdev->omap_wdt_miscdev.minor = WATCHDOG_MINOR;
-- 
1.7.9.5


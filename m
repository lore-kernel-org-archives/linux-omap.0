From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] twl4030_wdt: Disable watchdog while probing
Date: Mon, 17 May 2010 14:12:15 +0300
Message-ID: <7fcfe2bbdbad2e7c330c219fa1e27497a5fd0f89.1274094577.git.ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:57479 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab0EQLMt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 07:12:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: timo.t.kokkonen@nokia.com, wim@iguana.be

If we are not able to register then it is better to have watchdog in disabled
state than noticing a system reboot.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/watchdog/twl4030_wdt.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index dcabe77..b5045ca 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -190,6 +190,8 @@ static int __devinit twl4030_wdt_probe(struct platform_device *pdev)
 
 	twl4030_wdt_dev = pdev;
 
+	twl4030_wdt_disable(wdt);
+
 	ret = misc_register(&wdt->miscdev);
 	if (ret) {
 		dev_err(wdt->miscdev.parent,
-- 
1.6.3.3


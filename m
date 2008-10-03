From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] i2c: change twl4030-usb back to subsys_initcall
Date: Fri,  3 Oct 2008 12:45:54 +0300
Message-ID: <1223027154-20385-1-git-send-email-felipe.balbi@nokia.com>
References: <200810030136.33838.david-b@pacbell.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:36401 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbYJCJq0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 05:46:26 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m939kG0k012775
	for <linux-omap@vger.kernel.org>; Fri, 3 Oct 2008 12:46:23 +0300
In-Reply-To: <200810030136.33838.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

without it, otg_get/set_transceiver won't be useful and
twl4030-usb transceiver won't get to musb code.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-usb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-usb.c b/drivers/i2c/chips/twl4030-usb.c
index 133cc0f..922d7d6 100644
--- a/drivers/i2c/chips/twl4030-usb.c
+++ b/drivers/i2c/chips/twl4030-usb.c
@@ -774,7 +774,7 @@ static int __init twl4030_usb_init(void)
 {
 	return platform_driver_register(&twl4030_driver);
 }
-module_init(twl4030_usb_init);
+subsys_init(twl4030_usb_init);
 
 static void __exit twl4030_usb_exit(void)
 {
-- 
1.6.0.2.307.gc427


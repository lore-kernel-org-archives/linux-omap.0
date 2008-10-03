From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH] i2c: change twl4030-usb back to subsys_initcall
Date: Sat, 4 Oct 2008 02:50:04 +0300
Message-ID: <20081003235001.GH10743@frodo>
References: <200810030136.33838.david-b@pacbell.net> <1223027154-20385-1-git-send-email-felipe.balbi@nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:35648 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbYJCXuV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 19:50:21 -0400
Content-Disposition: inline
In-Reply-To: <1223027154-20385-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

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
+subsys_initcall(twl4030_usb_init);
 
 static void __exit twl4030_usb_exit(void)
 {
-- 
1.6.0.2.307.gc427

-- 
balbi

From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 1/2] usb: musb: Remove usb_disable() check in module_init()
Date: Thu, 26 Dec 2013 09:24:52 -0300
Message-ID: <1388060693-2716-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1388060693-2716-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:56682 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752877Ab3LZMYt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Dec 2013 07:24:49 -0500
In-Reply-To: <1388060693-2716-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Removing the check to usb_disable() before registering the platform
driver allows to build this driver when !USB && USB_GADGET, to be
used in gadget-only mode.

Also, use module_platform_driver() to register the platform driver.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/usb/musb/musb_core.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 4d4499b..74d547a 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2283,19 +2283,4 @@ static struct platform_driver musb_driver = {
 	.shutdown	= musb_shutdown,
 };
 
-/*-------------------------------------------------------------------------*/
-
-static int __init musb_init(void)
-{
-	if (usb_disabled())
-		return 0;
-
-	return platform_driver_register(&musb_driver);
-}
-module_init(musb_init);
-
-static void __exit musb_cleanup(void)
-{
-	platform_driver_unregister(&musb_driver);
-}
-module_exit(musb_cleanup);
+module_platform_driver(musb_driver);
-- 
1.8.1.5


From: Kamal Mostafa <kamal@canonical.com>
Subject: [3.13.y-ckt stable] Patch "usb: musb: omap2plus bus glue needs USB host support" has been added to staging queue
Date: Tue, 31 Mar 2015 11:45:46 -0700
Message-ID: <1427827546-23453-1-git-send-email-kamal@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:37971 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbbCaSpv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Mar 2015 14:45:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Kamal Mostafa <kamal@canonical.com>, kernel-team@lists.ubuntu.com

This is a note to let you know that I have just added a patch titled

    usb: musb: omap2plus bus glue needs USB host support

to the linux-3.13.y-queue branch of the 3.13.y-ckt extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.13.y-queue

This patch is scheduled to be released in version 3.13.11-ckt18.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.13.y-ckt tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Kamal

------

>From d2711f357bc9387a10a1ac2151b3bae75ca5a35e Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 8 May 2014 15:52:16 +0200
Subject: usb: musb: omap2plus bus glue needs USB host support

commit a8d191c8bb2f11a8f381e7cb98f978b7288c1401 upstream.

The musb/omap2430.c bus glue driver calls usb_hcd_poll_rh_status,
which is only available if CONFIG_USB is also set, i.e. we
are building USB host mode and not just endpoint mode.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 drivers/usb/musb/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 57dfc0c..a70f46f 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -74,7 +74,7 @@ config USB_MUSB_TUSB6010

 config USB_MUSB_OMAP2PLUS
 	tristate "OMAP2430 and onwards"
-	depends on ARCH_OMAP2PLUS
+	depends on ARCH_OMAP2PLUS && USB
 	select GENERIC_PHY

 config USB_MUSB_AM35X
--
1.9.1


From: Bill Gatliff <bgat@billgatliff.com>
Subject: [PATCH] Fix double-linking of drivers/usb/otg when ULPI is selected
Date: Fri, 18 Dec 2009 09:57:22 -0600
Message-ID: <1261151842-577-1-git-send-email-bgat@billgatliff.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:42694 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbZLRP5a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 10:57:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: beagleboard@googlegroups.com, daniel@caiaq.de, Bill Gatliff <bgat@billgatliff.com>

This patch corrects a problem where drivers/usb/otg is linked twice
if CONFIG_USB_ULPI is selected, resulting in a build error (symbol
conflict). The files in that directory are properly linked already
as part of CONFIG_USB, and need not be indicated specifically for
CONFIG_USB_ULPI.

Signed-off-by: Bill Gatliff <bgat@billgatliff.com>
---
 drivers/usb/Makefile |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index 473aa1a..be3c9b8 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -44,5 +44,3 @@ obj-y				+= early/
 
 obj-$(CONFIG_USB_ATM)		+= atm/
 obj-$(CONFIG_USB_SPEEDTOUCH)	+= atm/
-
-obj-$(CONFIG_USB_ULPI)		+= otg/
-- 
1.6.5


From: Thomas Weber <weber@corscience.de>
Subject: [PATCH] USB ehci: replace mach header with plat
Date: Tue,  8 Dec 2009 13:15:06 +0100
Message-ID: <1260274506-8805-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:49428 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754257AbZLHMPi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 07:15:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>

Replace the mach/usb.h with plat/usb.h

Patch was already done in commit:
801db9180010676f97bb3fbd7074291128b7b5fc , but overwritten.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 drivers/usb/host/ehci-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 7ba8df3..5cfed78 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -37,7 +37,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
-#include <mach/usb.h>
+#include <plat/usb.h>
 
 /*
  * OMAP USBHOST Register addresses: VIRTUAL ADDRESSES
-- 
1.6.4.4


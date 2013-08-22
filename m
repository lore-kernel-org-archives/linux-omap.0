From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] usb: dwc3: Remove duplicate inclusion of otg.h
Date: Thu, 22 Aug 2013 13:46:58 +0530
Message-ID: <1377159419-3145-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:56203 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892Ab3HVIeS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Aug 2013 04:34:18 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so1885518pab.25
        for <linux-omap@vger.kernel.org>; Thu, 22 Aug 2013 01:34:17 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, sachin.kamat@linaro.org

otg.h header file was included twice.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/usb/dwc3/core.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 577af1b..474162e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -33,7 +33,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/of.h>
 
-#include <linux/usb/otg.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/of.h>
-- 
1.7.9.5


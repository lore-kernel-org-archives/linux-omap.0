From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 21/23] USB: MUSB: checkpatch.pl fixes to musb_io.h
Date: Fri, 11 Apr 2008 11:28:34 +0300
Message-ID: <1207902516-6374-22-git-send-email-felipe.balbi@nokia.com>
References: <1207902516-6374-1-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-2-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-3-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-4-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-5-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-6-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-7-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-8-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-9-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-10-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-11-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-12-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-13-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-14-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-15-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-16-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-17-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-18-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-19-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-20-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-21-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26615 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757837AbYDKIaR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 04:30:17 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3B8TpFG021901
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 11:30:14 +0300
In-Reply-To: <1207902516-6374-21-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_io.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_io.h b/drivers/usb/musb/musb_io.h
index 9d06ed7..6bbedae 100644
--- a/drivers/usb/musb/musb_io.h
+++ b/drivers/usb/musb/musb_io.h
@@ -35,7 +35,7 @@
 #ifndef __MUSB_LINUX_PLATFORM_ARCH_H__
 #define __MUSB_LINUX_PLATFORM_ARCH_H__
 
-#include <asm/io.h>
+#include <linux/io.h>
 
 #ifndef	CONFIG_ARM
 static inline void readsl(const void __iomem *addr, void *buf, int len)
-- 
1.5.5.23.g2a5fe


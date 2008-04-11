From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 23/23] USB: MUSB: checkpatch.pl fixes to musb_debug.h
Date: Fri, 11 Apr 2008 11:28:36 +0300
Message-ID: <1207902516-6374-24-git-send-email-felipe.balbi@nokia.com>
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
 <1207902516-6374-22-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-23-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40307 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757553AbYDKIaW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 04:30:22 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3B8WRRt001264
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 03:32:39 -0500
In-Reply-To: <1207902516-6374-23-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_debug.h |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/musb/musb_debug.h b/drivers/usb/musb/musb_debug.h
index a9a0055..0743972 100644
--- a/drivers/usb/musb/musb_debug.h
+++ b/drivers/usb/musb/musb_debug.h
@@ -37,15 +37,15 @@
 
 #define yprintk(facility, format, args...) \
 	do { printk(facility "%s %d: " format , \
-	__FUNCTION__, __LINE__ , ## args); } while (0)
-#define WARN(fmt, args...) yprintk(KERN_WARNING,fmt, ## args)
-#define INFO(fmt,args...) yprintk(KERN_INFO,fmt, ## args)
-#define ERR(fmt,args...) yprintk(KERN_ERR,fmt, ## args)
+	__func__, __LINE__ , ## args); } while (0)
+#define WARN(fmt, args...) yprintk(KERN_WARNING, fmt, ## args)
+#define INFO(fmt, args...) yprintk(KERN_INFO, fmt, ## args)
+#define ERR(fmt, args...) yprintk(KERN_ERR, fmt, ## args)
 
 #define xprintk(level, facility, format, args...) do { \
-	if ( _dbg_level(level) ) { \
+	if (_dbg_level(level)) { \
 		printk(facility "%s %d: " format , \
-				__FUNCTION__, __LINE__ , ## args); \
+				__func__, __LINE__ , ## args); \
 	} } while (0)
 
 #if MUSB_DEBUG > 0
@@ -59,7 +59,7 @@ static inline int _dbg_level(unsigned l)
 	return debug >= l;
 }
 
-#define DBG(level,fmt,args...) xprintk(level,KERN_DEBUG,fmt, ## args)
+#define DBG(level, fmt, args...) xprintk(level, KERN_DEBUG, fmt, ## args)
 
 extern const char *otg_state_string(struct musb *);
 
-- 
1.5.5.23.g2a5fe


From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 05/23] I2C: TLW4030: checkpatch.pl fixes to tlw4030-rtc.h
Date: Fri, 11 Apr 2008 11:28:18 +0300
Message-ID: <1207902516-6374-6-git-send-email-felipe.balbi@nokia.com>
References: <1207902516-6374-1-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-2-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-3-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-4-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-5-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:40654 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757382AbYDKIaI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 04:30:08 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3B8Tqed015773
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 11:30:05 +0300
In-Reply-To: <1207902516-6374-5-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 include/linux/i2c/twl4030-rtc.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/i2c/twl4030-rtc.h b/include/linux/i2c/twl4030-rtc.h
index f3d96b3..fa74613 100644
--- a/include/linux/i2c/twl4030-rtc.h
+++ b/include/linux/i2c/twl4030-rtc.h
@@ -223,8 +223,8 @@
 
 
 struct twl4030rtc_platform_data {
-        int (*init)(void);
-        void (*exit)(void);
+	int (*init)(void);
+	void (*exit)(void);
 };
 
 #endif				/* End of __TWL4030_RTC_H__ */
-- 
1.5.5.23.g2a5fe


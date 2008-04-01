From: Roman Tereshonkov <roman.tereshonkov@nokia.com>
Subject: [PATCH] 	Tiny fix. No comma after KERN_INFO.
Date: Tue,  1 Apr 2008 14:54:10 +0300
Message-ID: <1207050850-926-1-git-send-email-roman.tereshonkov@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45483 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbYDALyW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Apr 2008 07:54:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Roman Tereshonkov <roman.tereshonkov@nokia.com>


Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
---
 drivers/misc/sti/sdti.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/sti/sdti.c b/drivers/misc/sti/sdti.c
index 9b20ccd..adfbcbc 100644
--- a/drivers/misc/sti/sdti.c
+++ b/drivers/misc/sti/sdti.c
@@ -120,7 +120,7 @@ static int __init omap_sdti_init(void)
 	i = sti_readl(SDTI_REVISION);
 	snprintf(buf, sizeof(buf), "OMAP SDTI support loaded (HW v%u.%u)\n",
 		(i >> 4) & 0x0f, i & 0x0f);
-	printk(KERN_INFO, "%s", buf);
+	printk(KERN_INFO "%s", buf);
 	omap_sti_channel_write_trace(strlen(buf), 0xc3, buf, 239);
 
 	return 0;
-- 
1.5.3.7


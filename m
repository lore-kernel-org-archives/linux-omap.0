From: felipe.balbi@nokia.com
Subject: [RFC PATCH 30/37] cbus: retu-rtc: split MODULE_AUTHOR into several entries
Date: Wed,  7 Apr 2010 19:04:21 +0300
Message-ID: <1270656268-7034-31-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58635 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932852Ab0DGQGU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:06:20 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G5wgT005211
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 19:06:18 +0300
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

it's easier to read, no functional changes.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/retu-rtc.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
index 2947c80..2a1623b 100644
--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -452,4 +452,6 @@ module_exit(retu_rtc_exit);
 
 MODULE_DESCRIPTION("Retu RTC");
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Paul Mundt and Igor Stoppa");
+MODULE_AUTHOR("Paul Mundt");
+MODULE_AUTHOR("Igor Stoppa");
+
-- 
1.7.0.rc0.33.g7c3932


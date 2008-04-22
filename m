From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH] ARM: OMAP: Refrain compile warning for lm8323.c
Date: Tue, 22 Apr 2008 16:21:53 +0300
Message-ID: <1208870513-13351-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31693 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365AbYDVNWY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2008 09:22:24 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3MDNTGw008261
	for <linux-omap@vger.kernel.org>; Tue, 22 Apr 2008 08:24:51 -0500
Received: from oreo.research.nokia.com (esdhcp041142.research.nokia.com [172.21.41.142])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m3MDLrES000658
	for <linux-omap@vger.kernel.org>; Tue, 22 Apr 2008 16:21:54 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

drivers/input/keyboard/lm8323.c: In function 'lm8323_pwm_store_time':
drivers/input/keyboard/lm8323.c:590: warning: passing argument 3 of 'strict_strtoul' from incompatible pointer type
drivers/input/keyboard/lm8323.c: In function 'lm8323_set_disable':
drivers/input/keyboard/lm8323.c:664: warning: passing argument 3 of 'strict_strtoul' from incompatible pointer type

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/input/keyboard/lm8323.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 3040622..c9ede10 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -587,7 +587,7 @@ static ssize_t lm8323_pwm_store_time(struct device *dev,
 	int ret;
 	int time;
 
-	ret = strict_strtoul(buf, 10, &time);
+	ret = sscanf(buf, "%d", &time);
 	/* Numbers only, please. */
 	if (ret)
 		return -EINVAL;
@@ -661,7 +661,7 @@ static ssize_t lm8323_set_disable(struct device *dev,
 	int ret;
 	int i;
 
-	i = strict_strtoul(buf, 10, &ret);
+	i = sscanf(buf, "%d", &ret);
 
 	mutex_lock(&lm->lock);
 	lm->kp_enabled = !i;
-- 
1.5.5.rc2.6.gf58d


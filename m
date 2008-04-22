From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH] ARM: OMAP: Add return value check for input_register_device()
Date: Tue, 22 Apr 2008 16:21:42 +0300
Message-ID: <1208870502-13321-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:44682 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758598AbYDVNVx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2008 09:21:53 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3MDLfpH007597
	for <linux-omap@vger.kernel.org>; Tue, 22 Apr 2008 16:21:51 +0300
Received: from oreo.research.nokia.com (esdhcp041142.research.nokia.com [172.21.41.142])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m3MDLgBU000596
	for <linux-omap@vger.kernel.org>; Tue, 22 Apr 2008 16:21:42 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

drivers/cbus/retu-pwrbutton.c:100: warning: ignoring return value of 'input_register_device', declared with attribute warn_unused_result

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/cbus/retu-pwrbutton.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/cbus/retu-pwrbutton.c b/drivers/cbus/retu-pwrbutton.c
index 283d9ca..38d7aa4 100644
--- a/drivers/cbus/retu-pwrbutton.c
+++ b/drivers/cbus/retu-pwrbutton.c
@@ -97,9 +97,7 @@ static int __init retubutton_init(void)
 	pwrbtn_dev->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);
 	pwrbtn_dev->name = "retu-pwrbutton";
 
-	input_register_device(pwrbtn_dev);
-
-	return 0;
+	return input_register_device(pwrbtn_dev);
 }
 
 /**
-- 
1.5.5.rc2.6.gf58d


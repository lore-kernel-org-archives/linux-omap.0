From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 1/1] DSPBRIDGE: don't use potential invalid pointer
Date: Mon,  7 Sep 2009 11:02:35 +0300
Message-ID: <1252310555-20952-1-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:30289 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbZIGICj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Sep 2009 04:02:39 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n8782O0F024253
	for <linux-omap@vger.kernel.org>; Mon, 7 Sep 2009 11:02:27 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 drivers/dsp/bridge/rmgr/proc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 832930e..52e2d54 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -323,6 +323,7 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
 			 "PROC_Attach: Could not allocate "
 			 "storage for notification \n");
 		MEM_FreeObject(pProcObject);
+		goto func_end;
 	}
 #ifndef RES_CLEANUP_DISABLE
 	spin_lock(&pr_ctxt->proc_list_lock);
-- 
1.5.6.5


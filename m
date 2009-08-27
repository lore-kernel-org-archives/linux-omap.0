From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 5/8] dspbridge: Check pointer before dereferencing it
Date: Thu, 27 Aug 2009 15:18:58 +0300
Message-ID: <1251375541-1866-6-git-send-email-andy.shevchenko@gmail.com>
References: <1251375541-1866-1-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-2-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-3-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-4-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-5-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:17393 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbZH0MTM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Aug 2009 08:19:12 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n7RCIXRB016599
	for <linux-omap@vger.kernel.org>; Thu, 27 Aug 2009 15:18:59 +0300
In-Reply-To: <1251375541-1866-5-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 drivers/dsp/bridge/rmgr/nldr.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index 79f7505..8c162a1 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -1560,6 +1560,13 @@ static DSP_STATUS LoadOvly(struct NLDR_NODEOBJECT *hNldrNode,
 	}
 
 	DBC_Assert(i < hNldr->nOvlyNodes);
+
+	if (!pONode) {
+		/* Should we print warning here? */
+		status = DSP_ENOTFOUND;
+		goto func_end;
+	}
+
 	switch (phase) {
 	case NLDR_CREATE:
 		pRefCount = &(pONode->createRef);
@@ -1877,6 +1884,13 @@ static void UnloadOvly(struct NLDR_NODEOBJECT *hNldrNode, enum NLDR_PHASE phase)
 	}
 
 	DBC_Assert(i < hNldr->nOvlyNodes);
+
+	if (!pONode) {
+		/* Should we print warning here? */
+		status = DSP_ENOTFOUND;
+		goto func_end;
+	}
+
 	switch (phase) {
 	case NLDR_CREATE:
 		pRefCount = &(pONode->createRef);
@@ -1917,7 +1931,6 @@ static void UnloadOvly(struct NLDR_NODEOBJECT *hNldrNode, enum NLDR_PHASE phase)
 	}
 	if (pOtherRef && *pOtherRef == 0)
 		FreeSects(hNldr, pOtherSects, nOtherAlloc);
-
 }
 
 /*
-- 
1.5.6.5


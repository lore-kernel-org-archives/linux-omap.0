From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: Removal of unreachable code
Date: Tue, 19 May 2009 16:47:56 +0530
Message-ID: <1242731876-16119-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:38145 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbZESLSI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 07:18:08 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n4JBI9ub015017
	for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 06:18:10 -0500
Received: from localhost.localdomain (essapo-nirac253106.europe.nokia.com [10.162.253.106])
	by mgw-da02.ext.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n4JBHtOJ008352
	for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 14:17:57 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Ameya Palande <ameya.palande@nokia.com>

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/wmd/io_sm.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 8d106e1..6f7e338 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -1742,9 +1742,6 @@ DSP_STATUS IO_SHMsetting(IN struct IO_MGR *hIOMgr, IN enum SHM_DESCTYPE desc,
 		break;
 	default:
 		break;
-
-				queue_work(bridge_workqueue,
-							 &(hIOMgr->io_workq));
 	}
 #endif
 	return DSP_SOK;
-- 
1.6.2.4


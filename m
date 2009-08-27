From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 7/8] DSPBRIDGE: Check return value
Date: Thu, 27 Aug 2009 15:19:00 +0300
Message-ID: <1251375541-1866-8-git-send-email-andy.shevchenko@gmail.com>
References: <1251375541-1866-1-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-2-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-3-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-4-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-5-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-6-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-7-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:17391 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbZH0MTM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Aug 2009 08:19:12 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n7RCIXDB016597
	for <linux-omap@vger.kernel.org>; Thu, 27 Aug 2009 15:18:59 +0300
In-Reply-To: <1251375541-1866-7-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

PROC_GetProcessorId() potentially could return different to DSP_SOK status. We
need to check it.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 44d7f2d..d21071c 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -990,8 +990,12 @@ static DSP_STATUS PrintProcessInformation(void)
 		spin_lock(&pCtxtList->proc_list_lock);
 		list_for_each_entry(proc_obj_ptr, &pCtxtList->processor_list,
 				proc_object) {
-			PROC_GetProcessorId(proc_obj_ptr, &procID);
-			if (procID == DSP_UNIT) {
+			DSP_STATUS status2 = PROC_GetProcessorId(proc_obj_ptr,
+								 &procID);
+			if (DSP_FAILED(status2)) {
+				GT_0trace(curTrace, GT_7CLASS, "\n***ERROR:"
+					  "Unable to get Processor Id***\n");
+			} else if (procID == DSP_UNIT) {
 				GT_0trace(curTrace, GT_4CLASS,
 					"\nProcess connected to"
 					" DSP Processor\n");
-- 
1.5.6.5


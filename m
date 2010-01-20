From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] DSPBRIDGE: dont pass invalid DSP OPP requests
Date: Tue, 19 Jan 2010 19:44:08 -0600
Message-ID: <1263951848-16822-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45389 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754033Ab0ATBoR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jan 2010 20:44:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Deepak Chitriki <deepak.chitriki@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

If DSP baseimage requests for invalid OPPs, do not pass them
to the rest of the linux kernel subsystem. with a test baseimage
it was found to send
IO_DispatchPM: WMDIOCTL_CONSTRAINT_REQUEST with parameter 0.
this is an invalid OPP ID and should not be passed anywhere.
we add a param check for this prior to passing it along to the
workqueue.

Cc: Ameya Palande <ameya.palande@nokia.com>
Cc: Deepak Chitriki <deepak.chitriki@ti.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>
Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/dsp/bridge/wmd/io_sm.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 6c140c5..618bedb 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -960,9 +960,12 @@ static void IO_DispatchPM(struct work_struct *work)
 			pArg[1] = pIOMgr->pSharedMem->oppRequest.rqstOppPt;
 			DBG_Trace(DBG_LEVEL7, "IO_DispatchPM : Value of OPP "
 				 "value =0x%x \n", pArg[1]);
-			status = pIOMgr->pIntfFxns->pfnDevCntrl(pIOMgr->
-				 hWmdContext, WMDIOCTL_CONSTRAINT_REQUEST,
-				 pArg);
+			if (!pArg[1])
+				status = DSP_EINVALIDARG;
+			else
+				status = pIOMgr->pIntfFxns->pfnDevCntrl(pIOMgr->
+					 hWmdContext,
+					 WMDIOCTL_CONSTRAINT_REQUEST, pArg);
 			if (DSP_FAILED(status)) {
 				DBG_Trace(DBG_LEVEL7, "IO_DispatchPM : Failed "
 					 "to set constraint = 0x%x \n",
-- 
1.6.3.3


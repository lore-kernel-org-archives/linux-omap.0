From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] BRIDGE: use more detail name for interrupt claiming device
Date: Sat,  8 Nov 2008 06:35:54 +0200
Message-ID: <1226118954-2832-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:56101 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbYKHEgE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 23:36:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: x00omar@ti.com, h-kanigeri2@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/wmd/io_sm.c  |    2 +-
 drivers/dsp/bridge/wmd/ue_deh.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 08bc4d3..6843a42 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -341,7 +341,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 		if (devType == DSP_UNIT) {
 			/* Plug the channel ISR:. */
                        if ((request_irq(INT_MAIL_MPU_IRQ, IO_ISR, 0,
-                                           "DspBridge", (void *)pIOMgr)) == 0)
+                                           "DspBridge\tmailbox", (void *)pIOMgr)) == 0)
                                status = DSP_SOK;
                        else
                                status = DSP_EFAIL;
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 7e450b3..2110353 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -121,7 +121,7 @@ DSP_STATUS WMD_DEH_Create(OUT struct DEH_MGR **phDehMgr,
 			pDehMgr->errInfo.dwVal3 = 0L;
 			/* Install ISR function for DSP MMU fault */
                        if ((request_irq(INT_DSP_MMU_IRQ, MMU_FaultIsr, 0,
-                                           "DspBridge", (void *)pDehMgr)) == 0)
+                                           "DspBridge\tiommu fault", (void *)pDehMgr)) == 0)
                                status = DSP_SOK;
                        else
                                status = DSP_EFAIL;
-- 
1.5.5.1.357.g1af8b


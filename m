From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [OMAPZOOM][PATCH 2/4] DSPBRIDGE: LM Timer release for hibernation
Date: Wed, 14 Jan 2009 11:17:15 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303F21B0D71@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49027 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763248AbZANRRX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 12:17:23 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0EHHHMj018328
	for <linux-omap@vger.kernel.org>; Wed, 14 Jan 2009 11:17:22 -0600
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n0EHHH2h010449
	for <linux-omap@vger.kernel.org>; Wed, 14 Jan 2009 11:17:17 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Ramesh Gupta <grgupta@ti.com>
Date: Mon, 17 Nov 2008 16:11:19 -0600
Subject: [PATCH] DSPBRIDGE: LM Timer release for hibernation

Release load monitor timer when the DSP is
inactive and goes to hibernation

Signed-off-by: Ramesh Gupta <grgupta@ti.com>
Signed-off-by: SuiLun Lam <s-lam@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap_sm.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 63655d9..edc3bcf 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -190,7 +190,6 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 
 	if  (pDevContext->dwBrdState == BRD_DSP_HIBERNATION ||
 	    pDevContext->dwBrdState == BRD_HIBERNATION) {
-		pDevContext->dwBrdState = BRD_RUNNING;
 #ifndef CONFIG_DISABLE_BRIDGE_PM
 #ifndef CONFIG_DISABLE_BRIDGE_DVFS
 #ifndef CONFIG_OMAP3_PM
@@ -235,9 +234,12 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 			  mboxsetting.irqEnable0);
 		DBG_Trace(DBG_LEVEL6, "MailBoxSettings: IRQENABLE1 = 0x%x\n",
 			 mboxsetting.irqEnable1);
-		/* Restart the peripheral clocks that were disabled */
-		DSP_PeripheralClocks_Enable(hDevContext, NULL);
+		/* Restart the peripheral clocks that were disabled only
+		 * in DSP initiated Hibernation case.*/
+		if (pDevContext->dwBrdState == BRD_DSP_HIBERNATION)
+			DSP_PeripheralClocks_Enable(hDevContext, NULL);
 
+		pDevContext->dwBrdState = BRD_RUNNING;
 	}
 	while (--cnt) {
 		hwStatus = HW_MBOX_IsFull(resources.dwMboxBase,
-- 
1.6.0


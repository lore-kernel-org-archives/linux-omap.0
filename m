From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 2/5] BRIDGE Save mailbox settings for suspend-resume
Date: Thu, 13 Nov 2008 20:11:23 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303E11EBF3D@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56186 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432AbYKNCLa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 21:11:30 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAE2BOh2005920
	for <linux-omap@vger.kernel.org>; Thu, 13 Nov 2008 20:11:29 -0600
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id mAE2BOxm000935
	for <linux-omap@vger.kernel.org>; Thu, 13 Nov 2008 20:11:24 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Ramesh Gupta <grgupta@ti.com>
Date: Fri, 31 Oct 2008 20:04:41 -0500
Subject: [PATCH] BRIDGE Save mailbox settings for suspend-resume

Save the mailbox settings whenever a call for suspend is
issued, previously if within 30 seconds (time for the dsp
to go hibernate) a suspend call was made, mailbox settings
were lost, this produced some problems in bridge behavior.

Signed-off-by: Ramesh Gupta <grgupta@ti.com>
Signed-off-by: Fernando Guzman <x0095840@ti.com>
Signed-off-by: Omar Ramirez Luna <x00omar@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 992d6db..623cc9b 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -237,6 +237,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 	}
 	switch (pDevContext->dwBrdState) {
 	case BRD_RUNNING:
+		status = HW_MBOX_saveSettings(resources.dwMboxBase);
 		if (dsp_test_sleepstate == HW_PWR_STATE_OFF) {
 			IO_InterruptDSP2(pDevContext,
 					 MBX_PM_DSPHIBERNATE);
@@ -251,6 +252,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 		}
 		break;
 	case BRD_RETENTION:
+		status = HW_MBOX_saveSettings(resources.dwMboxBase);
 		if (dsp_test_sleepstate == HW_PWR_STATE_OFF) {
 			IO_InterruptDSP2(pDevContext,
 					 MBX_PM_DSPHIBERNATE);
-- 
1.6.0

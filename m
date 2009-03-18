From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH A 14/15] tidspbridge: remove wIntrVal2Dsp
Date: Wed, 18 Mar 2009 03:23:10 +0200
Message-ID: <1237339391-20543-15-git-send-email-felipe.contreras@gmail.com>
References: <1237339391-20543-1-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-2-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-3-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-4-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-5-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-6-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-7-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-8-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-9-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-10-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-11-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-12-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-13-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-14-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:63018 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756580AbZCRBYe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 21:24:34 -0400
Received: by mail-fx0-f158.google.com with SMTP id 2so304246fxm.37
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 18:24:32 -0700 (PDT)
In-Reply-To: <1237339391-20543-14-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>

From: Felipe Contreras <felipe.contreras@nokia.com>

Not really used.

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 drivers/dsp/bridge/wmd/_tiomap.h    |    1 -
 drivers/dsp/bridge/wmd/tiomap3430.c |    2 --
 drivers/dsp/bridge/wmd/tiomap_sm.c  |    6 ++----
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index 10fd9cd..815f695 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -361,7 +361,6 @@ struct WMD_DEV_CONTEXT {
 	u32 dwBrdState;	/* Last known board state.      */
 	u32 ulIntMask;	/* int mask                     */
 	u16 ioBase;	/* Board I/O base               */
-	u16 wIntrVal2Dsp;	/* MBX value to DSP. See mbx_sh.h */
 	u32 numTLBEntries;	/* DSP MMU TLB entry counter    */
 	u32 fixedTLBEntries;	/* Fixed DSPMMU TLB entry count */
 
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index e2b590f..c0f4ffc 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -1035,8 +1035,6 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
 
 	if (DSP_SUCCEEDED(status)) {
 		/* Set the Endianism Register */ /* Need to set this */
-		/* default to Proc-copy */
-		pDevContext->wIntrVal2Dsp = MBX_PCPY_CLASS;
 		/* Retrieve the TC u16 SWAP Option */
 		status = REG_GetValue(NULL, CURRENTCONFIG, TCWORDSWAP,
 				     (u8 *)&tcWordSwap, &tcWordSwapSize);
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 5ae94ea..da90821 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -152,12 +152,10 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
 		}
 	}
 	DBG_Trace(DBG_LEVEL3, "writing %x to Mailbox\n",
-		  pDevContext->wIntrVal2Dsp);
+		  wMbVal);
 
 	HW_MBOX_MsgWrite(resources.dwMboxBase, MBOX_ARM2DSP,
-			 pDevContext->wIntrVal2Dsp);
-	/* set the Mailbox interrupt to default value */
-	pDevContext->wIntrVal2Dsp = MBX_PCPY_CLASS;
+			 wMbVal);
 	return DSP_SOK;
 }
 
-- 
1.6.2.1.287.g9a8be


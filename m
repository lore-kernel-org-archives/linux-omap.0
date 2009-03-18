From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH A 11/15] tidspbridge: Remove IO_InterruptDSP
Date: Wed, 18 Mar 2009 03:23:07 +0200
Message-ID: <1237339391-20543-12-git-send-email-felipe.contreras@gmail.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:56149 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756571AbZCRBY2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 21:24:28 -0400
Received: by mail-bw0-f169.google.com with SMTP id 17so321490bwz.37
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 18:24:26 -0700 (PDT)
In-Reply-To: <1237339391-20543-11-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>

From: Felipe Contreras <felipe.contreras@nokia.com>

IO_InterruptDSP2 can do the same.

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/io_sm.h |    1 -
 drivers/dsp/bridge/wmd/io_sm.c               |   10 +++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
index 81f7d93..02010d0 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -77,7 +77,6 @@
 
 #define IO_DisableInterrupt(h)  CHNLSM_DisableInterrupt(h)
 #define IO_EnableInterrupt(h)   CHNLSM_EnableInterrupt(h)
-#define IO_InterruptDSP(h)      CHNLSM_InterruptDSP(h)
 #define IO_InterruptDSP2(h, v)  CHNLSM_InterruptDSP2(h, v)
 #define IO_CALLISR(h, pFlag, pwMBRegVal)   CHNLSM_ISR(h, pFlag, pwMBRegVal)
 
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 9050862..e4d8528 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -831,7 +831,7 @@ void IO_CancelChnl(struct IO_MGR *hIOMgr, u32 ulChnl)
 	IO_AndValue(pIOMgr->hWmdContext, struct SHM, sm, hostFreeMask,
 		   (~(1 << ulChnl)));
 
-	IO_InterruptDSP(pIOMgr->hWmdContext);
+	IO_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
 }
 
 /*
@@ -1201,7 +1201,7 @@ static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 	if (fClearChnl) {
 		/* Indicate to the DSP we have read the input: */
 		IO_SetValue(pIOMgr->hWmdContext, struct SHM, sm, inputFull, 0);
-		IO_InterruptDSP(pIOMgr->hWmdContext);
+		IO_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
 	}
 	if (fNotifyClient) {
 		/* Notify client with IO completion record:  */
@@ -1303,7 +1303,7 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 			   true);
 		IO_SetValue(pIOMgr->hWmdContext, struct MSG, pCtrl, postSWI,
 			   true);
-		IO_InterruptDSP(pIOMgr->hWmdContext);
+		IO_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
 	}
 }
 
@@ -1406,7 +1406,7 @@ static void OutputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 #endif
 	IO_SetValue(pIOMgr->hWmdContext, struct SHM, sm, outputFull, 1);
 	/* Indicate to the DSP we have written the output: */
-	IO_InterruptDSP(pIOMgr->hWmdContext);
+	IO_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
 	/* Notify client with IO completion record (keep EOS) */
 	pChirp->status &= CHNL_IOCSTATEOS;
 	NotifyChnlComplete(pChnl, pChirp);
@@ -1493,7 +1493,7 @@ static void OutputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 			IO_SetValue(pIOMgr->hWmdContext, struct MSG, pCtrl,
 				   postSWI, true);
 			/* Tell the DSP we have written the output. */
-			IO_InterruptDSP(pIOMgr->hWmdContext);
+			IO_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
 		}
 	}
 }
-- 
1.6.2.1.287.g9a8be


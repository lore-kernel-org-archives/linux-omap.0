From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCHv2 02/18] DSPBRIDGE: enable smart/autoidle for mailbox sysconfig
Date: Wed, 16 Dec 2009 20:15:47 -0600
Message-ID: <1261016163-11091-3-git-send-email-omar.ramirez@ti.com>
References: <1261016163-11091-1-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36705 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763888AbZLQCIr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Dec 2009 21:08:47 -0500
In-Reply-To: <1261016163-11091-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Enable smart/autoidle for mailbox sysconfig register.

Original patch:
http://patchwork.kernel.org/patch/35628/

Reported-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
[ fg: remove wrapper around restoreSettings ]
Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/hw/hw_mbox.c |   14 +++++++++++++-
 drivers/dsp/bridge/hw/hw_mbox.h |   22 ++++++++++++++++++++++
 drivers/dsp/bridge/wmd/io_sm.c  |    1 +
 3 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/hw/hw_mbox.c b/drivers/dsp/bridge/hw/hw_mbox.c
index ee79032..5e8e15e 100644
--- a/drivers/dsp/bridge/hw/hw_mbox.c
+++ b/drivers/dsp/bridge/hw/hw_mbox.c
@@ -33,7 +33,19 @@
 /* width in bits of MBOX Id */
 #define HW_MBOX_ID_WIDTH	   2
 
-struct MAILBOX_CONTEXT mboxsetting = {0x4, 0x1, 0x1};
+/* SYSCONFIG: register bit definition */
+#define AUTOIDLE	(1 << 0)
+#define SMARTIDLE	(2 << 3)
+
+struct MAILBOX_CONTEXT mboxsetting = {
+	.sysconfig = SMARTIDLE | AUTOIDLE,
+};
+
+HW_STATUS HW_MBOX_initSettings(void __iomem *baseAddress)
+{
+	MLBMAILBOX_SYSCONFIGWriteRegister32(baseAddress, SMARTIDLE | AUTOIDLE);
+	return RET_OK;
+}
 
 /* Saves the mailbox context */
 HW_STATUS HW_MBOX_saveSettings(void __iomem *baseAddress)
diff --git a/drivers/dsp/bridge/hw/hw_mbox.h b/drivers/dsp/bridge/hw/hw_mbox.h
index ad1a89c..203964c 100644
--- a/drivers/dsp/bridge/hw/hw_mbox.h
+++ b/drivers/dsp/bridge/hw/hw_mbox.h
@@ -277,6 +277,28 @@ extern HW_STATUS HW_MBOX_EventAck(
 		  );
 
 /*
+* FUNCTION      : HW_MBOX_initSettings
+*
+* INPUTS:
+*
+*   Identifier  : baseAddress
+*   Type	: const u32
+*   Description : Base Address of instance of Mailbox module
+*
+*
+* RETURNS:
+*
+*   Type	: ReturnCode_t
+*   Description : RET_OK	      No errors occured
+*		 RET_BAD_NULL_PARAM  Address/pointer Paramater was set to 0/NULL
+*		 RET_INVALID_ID      Invalid Id used
+*		 RET_EMPTY	   Mailbox empty
+*
+* PURPOSE:      : This function initialize the mailbox configuration.
+*/
+extern HW_STATUS HW_MBOX_initSettings(void __iomem *baseAddres);
+
+/*
 * FUNCTION      : HW_MBOX_saveSettings
 *
 * INPUTS:
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 0daf93d..a2da528 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -284,6 +284,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 		pIOMgr->fSharedIRQ = pMgrAttrs->fShared;
 		IO_DisableInterrupt(hWmdContext);
 		if (devType == DSP_UNIT) {
+			HW_MBOX_initSettings(hostRes.dwMboxBase);
 			/* Plug the channel ISR:. */
                        if ((request_irq(INT_MAIL_MPU_IRQ, IO_ISR, 0,
                                "DspBridge\tmailbox", (void *)pIOMgr)) == 0)
-- 
1.6.2.4


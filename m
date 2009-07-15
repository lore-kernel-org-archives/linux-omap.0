From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 05/13] DSPBRIDGE: enable smart/autoidle for mailbox sysconfig
Date: Wed, 15 Jul 2009 17:56:28 +0300
Message-ID: <1247669795-23895-6-git-send-email-ameya.palande@nokia.com>
References: <1247669795-23895-1-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-2-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-3-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-4-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-5-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61032 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207AbZGOO4k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jul 2009 10:56:40 -0400
In-Reply-To: <1247669795-23895-5-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com, x0095840@ti.com, nm@ti.com, hiroshi.doyu@nokia.com

From: Doyu Hiroshi (Nokia-D/Helsinki) <hiroshi.doyu@nokia.com>

Reported-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/hw/hw_mbox.c |    4 +++-
 drivers/dsp/bridge/hw/hw_mbox.h |    5 +++++
 drivers/dsp/bridge/wmd/io_sm.c  |    1 +
 3 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/hw/hw_mbox.c b/drivers/dsp/bridge/hw/hw_mbox.c
index ee79032..5a87597 100644
--- a/drivers/dsp/bridge/hw/hw_mbox.c
+++ b/drivers/dsp/bridge/hw/hw_mbox.c
@@ -33,7 +33,9 @@
 /* width in bits of MBOX Id */
 #define HW_MBOX_ID_WIDTH	   2
 
-struct MAILBOX_CONTEXT mboxsetting = {0x4, 0x1, 0x1};
+static struct MAILBOX_CONTEXT mboxsetting = {
+	.sysconfig = 2 << 3 | 1, /* SMART/AUTO-IDLE */
+};
 
 /* Saves the mailbox context */
 HW_STATUS HW_MBOX_saveSettings(void __iomem *baseAddress)
diff --git a/drivers/dsp/bridge/hw/hw_mbox.h b/drivers/dsp/bridge/hw/hw_mbox.h
index ad1a89c..8a5f6bd 100644
--- a/drivers/dsp/bridge/hw/hw_mbox.h
+++ b/drivers/dsp/bridge/hw/hw_mbox.h
@@ -320,4 +320,9 @@ extern HW_STATUS HW_MBOX_saveSettings(void __iomem *baseAddres);
 */
 extern HW_STATUS HW_MBOX_restoreSettings(void __iomem *baseAddres);
 
+static inline void HW_MBOX_initSettings(void __iomem *baseAddres)
+{
+	HW_MBOX_restoreSettings(baseAddres);
+}
+
 #endif  /* __MBOX_H */
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 39c34f7..d8ae1f1 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -282,6 +282,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 		pIOMgr->fSharedIRQ = pMgrAttrs->fShared;
 		IO_DisableInterrupt(hWmdContext);
 		if (devType == DSP_UNIT) {
+			HW_MBOX_initSettings(hostRes.dwMboxBase);
 			/* Plug the channel ISR:. */
 			if ((request_irq(INT_MAIL_MPU_IRQ, IO_ISR, 0,
 				"DspBridge\tmailbox", (void *)pIOMgr)) == 0)
-- 
1.6.2.4


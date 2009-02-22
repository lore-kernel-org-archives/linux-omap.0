From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/4] dsp-bridge: wait less and check the mailbox more
Date: Sun, 22 Feb 2009 11:32:24 +0200
Message-ID: <1235295144-22097-4-git-send-email-felipe.contreras@gmail.com>
References: <94a0d4530902212246h4160ae83pf435b5c6faf88237@mail.gmail.com>
 <1235295144-22097-1-git-send-email-felipe.contreras@gmail.com>
 <1235295144-22097-2-git-send-email-felipe.contreras@gmail.com>
 <1235295144-22097-3-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:64397 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbZBVJcf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Feb 2009 04:32:35 -0500
Received: by mail-bw0-f161.google.com with SMTP id 5so3877969bwz.13
        for <linux-omap@vger.kernel.org>; Sun, 22 Feb 2009 01:32:34 -0800 (PST)
In-Reply-To: <1235295144-22097-3-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, h-kanigeri2@ti.com, ameya.palande@nokia.com, Felipe Contreras <felipe.contreras@nokia.com>

From: Felipe Contreras <felipe.contreras@nokia.com>

Profiling showed the __delay function is called a lot; checking the mbox
more often seems to decrease the usage by 2/3's according to OProfile.

The changes are based on 'arch/arm/plat-omap/mailbox.c'. Tested on OMAP3430.

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 drivers/dsp/bridge/wmd/tiomap_sm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 4ad893b..03d9195 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -179,7 +179,7 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 #endif
 	HW_STATUS hwStatus;
 	struct CFG_HOSTRES resources;
-	u16 cnt = 10;
+	u16 cnt = 1000;
 	u32 temp;
 	/* We are waiting indefinitely here. This needs to be fixed in the
 	 * second phase */
@@ -222,7 +222,7 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 	while (--cnt) {
 		if (!fifo_full((void __iomem *) resources.dwMboxBase, 0))
 			break;
-		mdelay(1);
+		udelay(1);
 	}
 	if (!cnt) {
 		DBG_Trace(DBG_LEVEL7, "Timed out waiting for DSP mailbox \n");
-- 
1.6.1.3


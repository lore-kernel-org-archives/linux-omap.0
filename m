From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH A 15/15] tidspbridge: print an error when timing out
Date: Wed, 18 Mar 2009 03:23:11 +0200
Message-ID: <1237339391-20543-16-git-send-email-felipe.contreras@gmail.com>
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
 <1237339391-20543-15-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:51851 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756304AbZCRBYh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 21:24:37 -0400
Received: by fxm2 with SMTP id 2so304319fxm.37
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 18:24:33 -0700 (PDT)
In-Reply-To: <1237339391-20543-15-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>

From: Felipe Contreras <felipe.contreras@nokia.com>

We really want to catch these.

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 drivers/dsp/bridge/wmd/tiomap_sm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index da90821..1b31162 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -147,7 +147,7 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
 	timeout = jiffies + msecs_to_jiffies(10);
 	while (fifo_full((void __iomem *) resources.dwMboxBase, 0)) {
 		if (time_after(jiffies, timeout)) {
-			DBG_Trace(DBG_LEVEL7, "Timed out waiting for DSP mailbox \n");
+			printk(KERN_ERR "dspbridge: timed out waiting for mailbox\n");
 			return WMD_E_TIMEOUT;
 		}
 	}
-- 
1.6.2.1.287.g9a8be


From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH B 3/3] tidspbridge: decreate timeout to a saner value
Date: Wed, 18 Mar 2009 03:26:45 +0200
Message-ID: <1237339605-20697-4-git-send-email-felipe.contreras@gmail.com>
References: <1237339605-20697-1-git-send-email-felipe.contreras@gmail.com>
 <1237339605-20697-2-git-send-email-felipe.contreras@gmail.com>
 <1237339605-20697-3-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:57314 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110AbZCRB1A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 21:27:00 -0400
Received: by bwz17 with SMTP id 17so322081bwz.37
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 18:26:57 -0700 (PDT)
In-Reply-To: <1237339605-20697-3-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>

From: Felipe Contreras <felipe.contreras@nokia.com>

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 drivers/dsp/bridge/wmd/tiomap_sm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 1b31162..535dc13 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -144,7 +144,7 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
 
 		pDevContext->dwBrdState = BRD_RUNNING;
 	}
-	timeout = jiffies + msecs_to_jiffies(10);
+	timeout = jiffies + msecs_to_jiffies(1);
 	while (fifo_full((void __iomem *) resources.dwMboxBase, 0)) {
 		if (time_after(jiffies, timeout)) {
 			printk(KERN_ERR "dspbridge: timed out waiting for mailbox\n");
-- 
1.6.2.1.287.g9a8be


From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH B 3/3] tidspbridge: decreate timeout to a saner value
Date: Thu, 19 Mar 2009 15:42:14 -0500
Message-ID: <496565EC904933469F292DDA3F1663E60287D6286E@dlee06.ent.ti.com>
References: <1237339605-20697-1-git-send-email-felipe.contreras@gmail.com>
 <1237339605-20697-2-git-send-email-felipe.contreras@gmail.com>
 <1237339605-20697-3-git-send-email-felipe.contreras@gmail.com>
 <1237339605-20697-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49025 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761434AbZCSUma convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 16:42:30 -0400
In-Reply-To: <1237339605-20697-4-git-send-email-felipe.contreras@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>



Hi Felipe,

	I am seeing with this patch because of the timeout:

DSP device detected !!
DSPProcessor_Attach succeeded.
dspbridge: timed out waiting for mailbox
dspbridge: timed out waiting for mailbox
dspbridge: timed out waiting for mailbox
dspbridge: timed out waiting for mailbox
dspbridge: timed out waiting for mailbox
dspbridge: timed out waiting for mailbox
dspbridge: timed out waiting for mailbox
dspbridge: timed out waiting for mailbox
dspbridge: timed out waiting for mailbox
dspbridge: timed out waiting for mailbox
dspbridge: timed out waiting for mailbox
...

Did you see any issue when you change to 1ms? Maybe we can use a bigger timeout.

Please let me know your comments.

Regards,
Fernando.

-----Original Message-----
From: Felipe Contreras [mailto:felipe.contreras@gmail.com] 
Sent: Tuesday, March 17, 2009 7:27 PM
To: linux-omap@vger.kernel.org
Cc: Kanigeri, Hari; Hiroshi DOYU; Ameya Palande; Guzman Lugo, Fernando; Felipe Contreras
Subject: [PATCH B 3/3] tidspbridge: decreate timeout to a saner value

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



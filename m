From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [OMAPZOOM][PATCH 3/3] DSPBRIDGE: changed mail box timeout to avoid
 losing messages.
Date: Mon, 23 Mar 2009 16:06:19 -0500
Message-ID: <496565EC904933469F292DDA3F1663E60287E2B12D@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44639 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756022AbZCWVG2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 17:06:28 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2NL6LkS008243
	for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2009 16:06:26 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2NL6LQu029244
	for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2009 16:06:21 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "Aguilar Pena, Leed" <leed.aguilar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Mon, 23 Mar 2009 13:30:36 -0500
Subject: [PATCH] DSPBRIDGE: changed mail box timeout to avoid losing messages.

This patch is based on Felipe Contreras patch, but chanegd the mail box
timeout to 35ms to avoid losing messages.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap_sm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 91930a8..c536f4d 100755
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -168,7 +168,7 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
 
 		pDevContext->dwBrdState = BRD_RUNNING;
 	}
-	timeout = jiffies + msecs_to_jiffies(10);
+	timeout = jiffies + msecs_to_jiffies(35);
 	while (HW_MBOX_IsFull(resources.dwMboxBase, MBOX_ARM2DSP)) {
 		if (time_after(jiffies, timeout)) {
 			printk(KERN_ERR "dspbridge: "
-- 
1.5.6.4


From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 4/4] dspbridge: use mailbox API to set rx callback
Date: Wed, 23 Jun 2010 03:11:36 +0300
Message-ID: <1277251896-6890-4-git-send-email-ohad@wizery.com>
References: <1277251896-6890-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:46372 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914Ab0FWALt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 20:11:49 -0400
Received: by wwc33 with SMTP id 33so584186wwc.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Jun 2010 17:11:48 -0700 (PDT)
In-Reply-To: <1277251896-6890-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

use mailbox API to set rx callback

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
I can also be contacted at < ohadb at ti dot com >

 drivers/dsp/bridge/core/tiomap3430.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/dsp/bridge/core/tiomap3430.c b/drivers/dsp/bridge/core/tiomap3430.c
index 35c6678..1190c79 100644
--- a/drivers/dsp/bridge/core/tiomap3430.c
+++ b/drivers/dsp/bridge/core/tiomap3430.c
@@ -555,7 +555,7 @@ static int bridge_brd_start(struct bridge_dev_context *hDevContext,
 		 * Enable Mailbox events and also drain any pending
 		 * stale messages.
 		 */
-		dev_context->mbox = omap_mbox_get("dsp");
+		dev_context->mbox = omap_mbox_get("dsp", (int (*)(void *))io_mbox_msg);
 		if (IS_ERR(dev_context->mbox)) {
 			dev_context->mbox = NULL;
 			pr_err("%s: Failed to get dsp mailbox handle\n",
@@ -565,8 +565,6 @@ static int bridge_brd_start(struct bridge_dev_context *hDevContext,
 
 	}
 	if (DSP_SUCCEEDED(status)) {
-		dev_context->mbox->rxq->callback = (int (*)(void *))io_mbox_msg;
-
 /*PM_IVA2GRPSEL_PER = 0xC0;*/
 		temp = (u32) *((reg_uword32 *)
 				((u32) (resources->dw_per_pm_base) + 0xA8));
-- 
1.7.0.4


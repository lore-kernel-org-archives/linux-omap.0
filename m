From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/3] DSPBRIDGE: Fix obvious wrong comment formats in mbox migration
Date: Tue, 23 Mar 2010 16:48:29 -0600
Message-ID: <1269384510-1526-3-git-send-email-omar.ramirez@ti.com>
References: <1269384510-1526-1-git-send-email-omar.ramirez@ti.com>
 <1269384510-1526-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58457 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753467Ab0CWWdJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Mar 2010 18:33:09 -0400
In-Reply-To: <1269384510-1526-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Fix obvious wrong comment formats in mbox migration.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com
---
 drivers/dsp/bridge/wmd/_tiomap.h    |    2 +-
 drivers/dsp/bridge/wmd/tiomap3430.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index e853777..71ef731 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -326,7 +326,7 @@ struct wmd_dev_context {
 	u32 dw_dsp_start_add;	/* API Boot vector */
 	u32 dw_internal_size;	/* Internal memory size */
 
-	struct omap_mbox *mbox;		/* Mail box handle*/
+	struct omap_mbox *mbox;		/* Mail box handle */
 
 	/*
 	 * Processor specific info is set when prog loaded and read from DCD.
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index d90518a..a972ea2 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -663,7 +663,7 @@ static dsp_status bridge_brd_start(struct wmd_dev_context *hDevContext,
 					       ul_dsp_clk_addr, sizeof(u32), 0);
 		}
 		/*
-		 *Enable Mailbox events and also drain any pending
+		 * Enable Mailbox events and also drain any pending
 		 * stale messages.
 		 */
 		dev_context->mbox = omap_mbox_get("dsp");
-- 
1.6.2.4


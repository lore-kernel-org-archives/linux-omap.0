From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/10] dsp-bridge: deh: fix obvious return codes
Date: Tue, 23 Mar 2010 23:25:39 +0200
Message-ID: <1269379542-11892-8-git-send-email-felipe.contreras@gmail.com>
References: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:46268 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab0CWV0b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 17:26:31 -0400
Received: by mail-bw0-f209.google.com with SMTP id 1so2292192bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 23 Mar 2010 14:26:30 -0700 (PDT)
In-Reply-To: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Now that the code is cleaner is easy to spot them.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/wmd/ue_deh.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 0a03e09..1add675 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -139,7 +139,7 @@ dsp_status bridge_deh_destroy(struct deh_mgr *hdeh_mgr)
 	struct deh_mgr *deh_mgr_obj = (struct deh_mgr *)hdeh_mgr;
 
 	if (!MEM_IS_VALID_HANDLE(deh_mgr_obj, SIGNATURE))
-		return DSP_SOK;
+		return DSP_EHANDLE;
 
 	/* Release dummy VA buffer */
 	bridge_deh_release_dummy_mem();
@@ -165,7 +165,7 @@ dsp_status bridge_deh_register_notify(struct deh_mgr *hdeh_mgr, u32 event_mask,
 	struct deh_mgr *deh_mgr_obj = (struct deh_mgr *)hdeh_mgr;
 
 	if (!MEM_IS_VALID_HANDLE(deh_mgr_obj, SIGNATURE))
-		return DSP_SOK;
+		return DSP_EHANDLE;
 
 	return ntfy_register(deh_mgr_obj->ntfy_obj, hnotification,
 			event_mask, notify_type);
-- 
1.7.0.3


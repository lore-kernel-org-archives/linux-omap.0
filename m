From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 05/10] dsp-bridge: deh: report mmu faults as errors
Date: Tue, 23 Mar 2010 23:25:37 +0200
Message-ID: <1269379542-11892-6-git-send-email-felipe.contreras@gmail.com>
References: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:35757 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab0CWV0P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 17:26:15 -0400
Received: by mail-bw0-f209.google.com with SMTP id 1so2292212bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 23 Mar 2010 14:26:14 -0700 (PDT)
In-Reply-To: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/wmd/ue_deh.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 0c29442..4708c10 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -203,7 +203,7 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 			 * structure.
 			 */
 			deh_mgr_obj->err_info.dw_err_mask = DSP_MMUFAULT;
-			dev_info(bridge, "%s: %s, err_info = 0x%x\n",
+			dev_err(bridge, "%s: %s, err_info = 0x%x\n",
 					__func__, "DSP_MMUFAULT", dwErrInfo);
 			dev_info(bridge, "%s: %s, high=0x%x, low=0x%x, fault=0x%x\n",
 					__func__, "DSP_MMUFAULT",
-- 
1.7.0.3


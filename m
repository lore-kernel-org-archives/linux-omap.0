From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/10] dsp-bridge: deh: remove obvious comments
Date: Tue, 23 Mar 2010 23:25:33 +0200
Message-ID: <1269379542-11892-2-git-send-email-felipe.contreras@gmail.com>
References: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:46268 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080Ab0CWV0G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 17:26:06 -0400
Received: by bwz1 with SMTP id 1so2292192bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 23 Mar 2010 14:26:05 -0700 (PDT)
In-Reply-To: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

They are weirdly formatted and don't provide any useful information.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/wmd/ue_deh.c |   25 +------------------------
 1 files changed, 1 insertions(+), 24 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 5edcce9..8d44180 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -60,10 +60,7 @@ static struct hw_mmu_map_attrs_t map_attrs = { HW_LITTLE_ENDIAN,
 #define VIRT_TO_PHYS(x)       ((x) - PAGE_OFFSET + PHYS_OFFSET)
 
 static u32 dummy_va_addr;
-/*
- *  ======== bridge_deh_create ========
- *      Creates DEH manager object.
- */
+
 dsp_status bridge_deh_create(OUT struct deh_mgr **phDehMgr,
 			     struct dev_object *hdev_obj)
 {
@@ -126,10 +123,6 @@ dsp_status bridge_deh_create(OUT struct deh_mgr **phDehMgr,
 	return status;
 }
 
-/*
- *  ======== bridge_deh_destroy ========
- *      Destroys DEH manager object.
- */
 dsp_status bridge_deh_destroy(struct deh_mgr *hdeh_mgr)
 {
 	dsp_status status = DSP_SOK;
@@ -154,10 +147,6 @@ dsp_status bridge_deh_destroy(struct deh_mgr *hdeh_mgr)
 	return status;
 }
 
-/*
- *  ======== bridge_deh_register_notify ========
- *      Registers for DEH notifications.
- */
 dsp_status bridge_deh_register_notify(struct deh_mgr *hdeh_mgr, u32 event_mask,
 				   u32 notify_type,
 				   struct dsp_notification *hnotification)
@@ -173,10 +162,6 @@ dsp_status bridge_deh_register_notify(struct deh_mgr *hdeh_mgr, u32 event_mask,
 	return status;
 }
 
-/*
- *  ======== bridge_deh_notify ========
- *      DEH error notification function. Informs user about the error.
- */
 void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 {
 	struct deh_mgr *deh_mgr_obj = (struct deh_mgr *)hdeh_mgr;
@@ -290,10 +275,6 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 	}
 }
 
-/*
- *  ======== bridge_deh_get_info ========
- *      Retrieves error information.
- */
 dsp_status bridge_deh_get_info(struct deh_mgr *hdeh_mgr,
 			    struct dsp_errorinfo *pErrInfo)
 {
@@ -317,10 +298,6 @@ dsp_status bridge_deh_get_info(struct deh_mgr *hdeh_mgr,
 	return status;
 }
 
-/*
- *  ======== bridge_deh_release_dummy_mem ========
- *      Releases memory allocated for dummy page
- */
 void bridge_deh_release_dummy_mem(void)
 {
 	kfree((void *)dummy_va_addr);
-- 
1.7.0.3


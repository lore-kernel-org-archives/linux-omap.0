From: Archit Taneja <archit@ti.com>
Subject: [RFC 08/11] OMAPDSS: APPLY: Check if overlay is connected in mem to mem mode
Date: Wed, 7 Nov 2012 20:14:26 +0530
Message-ID: <1352299469-17609-9-git-send-email-archit@ti.com>
References: <n>
 <1352299469-17609-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33926 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128Ab2KGOpQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 09:45:16 -0500
In-Reply-To: <1352299469-17609-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

When a manager is connected to writeback in mem to mem mode, all the connected
fetch and process data at rate suitable for the scalar to perform the required
downscaling. This is because there isn't any display connected here, and hence
no real time constraints. When calling dispc_ovl_setup, pass the correct value
of mem_to_mem parameter so that it can discard pixel clock related scaling
limitations.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 2fd08d8..e1c589c 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -615,10 +615,13 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 
 static void dss_ovl_write_regs(struct omap_overlay *ovl)
 {
+	struct omap_overlay_manager *mgr = ovl->manager;
+	struct omap_dss_output *out = mgr->output;
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
 	struct omap_overlay_info *oi;
 	bool replication;
 	struct mgr_priv_data *mp;
+	bool mem_to_mem;
 	int r;
 
 	DSSDBG("writing ovl %d regs", ovl->id);
@@ -628,11 +631,13 @@ static void dss_ovl_write_regs(struct omap_overlay *ovl)
 
 	oi = &op->info;
 
-	mp = get_mgr_priv(ovl->manager);
+	mp = get_mgr_priv(mgr);
 
 	replication = dss_ovl_use_replication(mp->lcd_config, oi->color_mode);
 
-	r = dispc_ovl_setup(ovl->id, oi, replication, &mp->timings, false);
+	mem_to_mem = output_is_wb(out) ? wb_manual_update(out) : false;
+
+	r = dispc_ovl_setup(ovl->id, oi, replication, &mp->timings, mem_to_mem);
 	if (r) {
 		/*
 		 * We can't do much here, as this function can be called from
-- 
1.7.9.5


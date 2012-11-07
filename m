From: Archit Taneja <archit@ti.com>
Subject: [PATCH 1/3] OMAPDSS: APPLY: Don't treat an overlay's channel out as shadow bits
Date: Wed, 7 Nov 2012 14:47:22 +0530
Message-ID: <1352279844-10494-2-git-send-email-archit@ti.com>
References: <n>
 <1352279844-10494-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48673 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab2KGJRv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 04:17:51 -0500
In-Reply-To: <1352279844-10494-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

An overlay's channel out field isn't a shadow register. The TRM says that it's
taken into effect immediately. This understanding was missing and channel out
was treated as a shadow parameter, and in overlay's private data as extra info.

Program channel out bits directly in dss_ovl_set_manager(). In order to do this
safely, we need to be totally sure that the overlay is disabled in hardware. For
auto update managers, we can assume that the overlay was truly disabled at
dss_ovl_unset_manager() through the wait_pending_extra_info_updates() call.
However, when unsetting manager for an overlay that was previously connected to
a manager in manual update, we can't be sure if the overlay is truly disabled.
That is, op->enabled might not reflect the actual state of the overlay in
hardware. The older manager may require a manual update transfer to truly
disable the overlay. We expect the user of OMAPDSS to take care of this, in
OMAPDSS, we make sure that an overlay's manager isn't unset if there if
extra_info is still dirty for that overlay.

The wrong understanding of channel out bits also explains the reason why we see
sync lost when changing an overlay's manager which was previously connected to a
manual update manager. The following sequence of events caused this:

- When we disable the overlay, no register writes are actually done since the
  manager is manual update, op->enabled is set to false, and the
  extra_info_dirty flag is set. However, in hardware, the overlay is still
  enabled in both shadow and working registers.

- When we unset the manager, the software just configures the overlay's manager
  to point to NULL.

- When we set the overlay to a new manager(which is in auto update) through
  dss_ovl_set_manager, the check  for op->enabled passes, the channel field in
  extra info is set to the new manager. When we do an apply on this manager,
  the new channel out field is set in the hardware immediately, and since the
  overlay enable bit is still set in hardware, the new manager sees that the
  overlay is enabled, and tries to retrieve pixels from it, this leads to sync
  lost as it might be in the middle of processing a frame when we set the
  channel out bit.

The solution to this was to ensure that user space does another update after
disabling the overlay, this actually worked because the overlay was now truly
disabled, and an immediate write to channel out didn't impact since the manager
saw the new overlay as disabled, and doesn't try to retrieve pixels from it.

Remove channel as an extra_info field. Make dss_ovl_unset_manager more strict
about the overlay being disabled when detaching the manager. For overlays
connected to a manual update manager, unset_manager fails if we need another
update to disable the overlay.

We still need to a manual update to ensure the overlay is disabled to get change
the overlay's manager. We could work on doing a dummy update by using DISPC's
capability to gate the different video port signals. This is left for later.

Remove the comment about the sync lost issue.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c |   44 +++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 6a21443..b64a083 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -70,7 +70,6 @@ struct ovl_priv_data {
 	bool shadow_extra_info_dirty;
 
 	bool enabled;
-	enum omap_channel channel;
 	u32 fifo_low, fifo_high;
 
 	/*
@@ -617,7 +616,6 @@ static void dss_ovl_write_regs_extra(struct omap_overlay *ovl)
 	 * disabled */
 
 	dispc_ovl_enable(ovl->id, op->enabled);
-	dispc_ovl_set_channel_out(ovl->id, op->channel);
 	dispc_ovl_set_fifo_threshold(ovl->id, op->fifo_low, op->fifo_high);
 
 	mp = get_mgr_priv(ovl->manager);
@@ -1278,39 +1276,34 @@ int dss_ovl_set_manager(struct omap_overlay *ovl,
 		goto err;
 	}
 
+	r = dispc_runtime_get();
+	if (r)
+		goto err;
+
 	spin_lock_irqsave(&data_lock, flags);
 
 	if (op->enabled) {
 		spin_unlock_irqrestore(&data_lock, flags);
 		DSSERR("overlay has to be disabled to change the manager\n");
 		r = -EINVAL;
-		goto err;
+		goto err1;
 	}
 
-	op->channel = mgr->id;
-	op->extra_info_dirty = true;
+	dispc_ovl_set_channel_out(ovl->id, mgr->id);
 
 	ovl->manager = mgr;
 	list_add_tail(&ovl->list, &mgr->overlays);
 
 	spin_unlock_irqrestore(&data_lock, flags);
 
-	/* XXX: When there is an overlay on a DSI manual update display, and
-	 * the overlay is first disabled, then moved to tv, and enabled, we
-	 * seem to get SYNC_LOST_DIGIT error.
-	 *
-	 * Waiting doesn't seem to help, but updating the manual update display
-	 * after disabling the overlay seems to fix this. This hints that the
-	 * overlay is perhaps somehow tied to the LCD output until the output
-	 * is updated.
-	 *
-	 * Userspace workaround for this is to update the LCD after disabling
-	 * the overlay, but before moving the overlay to TV.
-	 */
+	dispc_runtime_put();
 
 	mutex_unlock(&apply_lock);
 
 	return 0;
+
+err1:
+	dispc_runtime_put();
 err:
 	mutex_unlock(&apply_lock);
 	return r;
@@ -1344,9 +1337,24 @@ int dss_ovl_unset_manager(struct omap_overlay *ovl)
 	/* wait for pending extra_info updates to ensure the ovl is disabled */
 	wait_pending_extra_info_updates();
 
+	/*
+	 * For a manual update display, there is no guarantee that the overlay
+	 * is really disabled in HW, we may need an extra update from this
+	 * manager before the configurations can go in. Return an error if the
+	 * overlay needed an update from the manager.
+	 *
+	 * TODO: Instead of returning an error, try to do a dummy manager update
+	 * here to disable the overlay in hardware. Use the *GATED fields in
+	 * the DISPC_CONFIG registers to do a dummy update.
+	 */
 	spin_lock_irqsave(&data_lock, flags);
 
-	op->channel = -1;
+	if (ovl_manual_update(ovl) && op->extra_info_dirty) {
+		spin_unlock_irqrestore(&data_lock, flags);
+		DSSERR("need an update to change the manager\n");
+		r = -EINVAL;
+		goto err;
+	}
 
 	ovl->manager = NULL;
 	list_del(&ovl->list);
-- 
1.7.9.5


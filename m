From: Ernesto Ramos <ernesto@ti.com>
Subject: [PATCH] staging:ti dspbridge: avoid possible NULL dereference panic
Date: Tue, 20 Jul 2010 12:55:49 -0500
Message-ID: <1279648549-16603-1-git-send-email-ernesto@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57090 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630Ab0GTRv3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jul 2010 13:51:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.contreras@nokia.com, ameya.palande@nokia.com, Hiroshi.DOYU@nokia.com, nm@ti.com, Ernesto Ramos <ernesto@ti.com>

When dsp_notifications array is received from user,
dspbridge verifies the array has valid pointers
and dsp_notification structures. However, these
structures contain pointers that need to be
checked for valid handles.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/staging/tidspbridge/pmgr/dspapi.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/tidspbridge/pmgr/dspapi.c b/drivers/staging/tidspbridge/pmgr/dspapi.c
index 8a568b3..71b9b5b 100644
--- a/drivers/staging/tidspbridge/pmgr/dspapi.c
+++ b/drivers/staging/tidspbridge/pmgr/dspapi.c
@@ -539,7 +539,7 @@ func_end:
  */
 u32 mgrwrap_wait_for_bridge_events(union Trapped_Args *args, void *pr_ctxt)
 {
-	int status = 0, real_status = 0;
+	int status = 0;
 	struct dsp_notification *anotifications[MAX_EVENTS];
 	struct dsp_notification notifications[MAX_EVENTS];
 	u32 index, i;
@@ -554,19 +554,21 @@ u32 mgrwrap_wait_for_bridge_events(union Trapped_Args *args, void *pr_ctxt)
 	/* get the events */
 	for (i = 0; i < count; i++) {
 		CP_FM_USR(&notifications[i], anotifications[i], status, 1);
-		if (!status) {
-			/* set the array of pointers to kernel structures */
-			anotifications[i] = &notifications[i];
+		if (status || !notifications[i].handle) {
+			status = -EINVAL;
+			break;
 		}
+		/* set the array of pointers to kernel structures */
+		anotifications[i] = &notifications[i];
 	}
 	if (!status) {
-		real_status = mgr_wait_for_bridge_events(anotifications, count,
+		status = mgr_wait_for_bridge_events(anotifications, count,
 							 &index,
 							 args->args_mgr_wait.
 							 utimeout);
 	}
 	CP_TO_USR(args->args_mgr_wait.pu_index, &index, status, 1);
-	return real_status;
+	return status;
 }
 
 /*
-- 
1.5.4.5


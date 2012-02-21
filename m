From: Archit Taneja <archit@ti.com>
Subject: [PATCH 3/3] OMAPDSS: DSS: Add runtime_pm protection around wait_for_vsync.
Date: Tue, 21 Feb 2012 19:36:32 +0530
Message-ID: <1329833192-16529-4-git-send-email-archit@ti.com>
References: <1329833192-16529-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43998 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755440Ab2BUOG7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Feb 2012 09:06:59 -0500
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q1LE6xWV023715
	for <linux-omap@vger.kernel.org>; Tue, 21 Feb 2012 08:06:59 -0600
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q1LE6xOx025718
	for <linux-omap@vger.kernel.org>; Tue, 21 Feb 2012 08:06:59 -0600 (CST)
In-Reply-To: <1329833192-16529-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: lajos@ti.com, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

From: Lajos Molnar <lajos@ti.com>

If DSS is suspended during a wait_for_vsync operation, it may loose its clock.
Request runtime_pm around wait_for_vsync.

Signed-off-by: Lajos Molnar <lajos@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index df6259e..dd08356 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3228,11 +3228,15 @@ int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
 	int r;
 	DECLARE_COMPLETION_ONSTACK(completion);
 
+	r = dispc_runtime_get();
+	if (r)
+		return r;
+
 	r = omap_dispc_register_isr(dispc_irq_wait_handler, &completion,
 			irqmask);
 
 	if (r)
-		return r;
+		goto done;
 
 	timeout = wait_for_completion_interruptible_timeout(&completion,
 			timeout);
@@ -3240,12 +3244,14 @@ int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
 	omap_dispc_unregister_isr(dispc_irq_wait_handler, &completion, irqmask);
 
 	if (timeout == 0)
-		return -ETIMEDOUT;
+		r = -ETIMEDOUT;
+	else if (timeout == -ERESTARTSYS)
+		r = timeout;
 
-	if (timeout == -ERESTARTSYS)
-		return -ERESTARTSYS;
+done:
+	dispc_runtime_put();
 
-	return 0;
+	return r;
 }
 
 #ifdef CONFIG_OMAP2_DSS_FAKE_VSYNC
-- 
1.7.5.4


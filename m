From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: [PATCH 5/5] DSPBRIDGE: Avoid errors if stream id is zero
Date: Fri, 16 Apr 2010 22:28:16 -0500
Message-ID: <B852767254C5C94EBB1040EE0EFA060092D76404@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43541 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758713Ab0DQD2W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 23:28:22 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>

>From e8b0597f602aa501cdda039c609a5f4fe31b3281 Mon Sep 17 00:00:00 2001
From: Ernesto Ramos <ernesto@ti.com>
Date: Fri, 16 Apr 2010 18:40:53 -0500
Subject: [PATCH 5/5] DSPBRIDGE: Avoid errors if stream id is zero

As 'zero' can be a perfectly good id, it can be picked up as
a NULL from userspace, avoid issues in API and user apps if stream
handle is zero.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 9d63b1f..43e8186 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -1498,7 +1498,7 @@ inline void find_strm_handle(struct strm_res_object **strmres,
 {
 	rcu_read_lock();
 	*strmres = idr_find(((struct process_context *)pr_ctxt)->strm_idp,
-							(int)hstream);
+							(int)hstream - 1);
 	rcu_read_unlock();
 	return;
 }
@@ -1713,6 +1713,8 @@ u32 strmwrap_open(union Trapped_Args *args, void *pr_ctxt)
 			   args->args_strm_open.index, &attr, &strm_res_obj,
 			   pr_ctxt);
 	CP_TO_USR(args->args_strm_open.ph_stream, &strm_res_obj->id, status, 1);
+	if (DSP_SUCCEEDED(status))
+		*args->args_strm_open.ph_stream += 1;
 	return status;
 }
 
-- 
1.5.4.5


From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 11/17] DSPBRIDGE: Memory leak in Node Register Notify
Date: Tue, 15 Dec 2009 00:19:52 -0600
Message-ID: <1260857998-19349-12-git-send-email-omar.ramirez@ti.com>
References: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43255 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753186AbZLOGMx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Dec 2009 01:12:53 -0500
In-Reply-To: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>

From: Ernesto Ramos Falcon <ernesto@ti.com>

Fix for memory leak in DSPNode_RegisterNotify when
unregistering an object.

Signed-off-by: Ernesto Ramos Falcon <ernesto@ti.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index bb28cd2..c211b64 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -1403,6 +1403,11 @@ u32 NODEWRAP_RegisterNotify(union Trapped_Args *args)
 	notification.psName = NULL;
 	notification.handle = NULL;
 
+	if (!args->ARGS_PROC_REGISTER_NOTIFY.uEventMask)
+		cp_fm_usr(&notification,
+			args->ARGS_PROC_REGISTER_NOTIFY.hNotification,
+			status, 1);
+
 	status = NODE_RegisterNotify(args->ARGS_NODE_REGISTERNOTIFY.hNode,
 				    args->ARGS_NODE_REGISTERNOTIFY.uEventMask,
 				    args->ARGS_NODE_REGISTERNOTIFY.uNotifyType,
-- 
1.6.2.4


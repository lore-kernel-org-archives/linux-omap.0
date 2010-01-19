From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH] DSPBRIDGE: Fix wrong condition on NODE_GetUUIDProps
Date: Mon, 18 Jan 2010 19:58:04 -0600
Message-ID: <1263866284-5587-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43056 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932122Ab0ASBsB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jan 2010 20:48:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Fix wrong condition because of a wrong patch included.

Discovered-by: Ernesto Ramos Falcon <ernesto@ti.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/node.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 72c2411..e8ba0dd 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -3252,7 +3252,7 @@ DSP_STATUS NODE_GetUUIDProps(DSP_HPROCESSOR hProcessor,
 		 pNodeId, pNodeProps);
 
 	status = PROC_GetDevObject(hProcessor, &hDevObject);
-	if (!hDevObject) {
+	if (hDevObject) {
 		status = DEV_GetNodeManager(hDevObject, &hNodeMgr);
 		if (hNodeMgr == NULL) {
 			status = DSP_EHANDLE;
-- 
1.6.2.4


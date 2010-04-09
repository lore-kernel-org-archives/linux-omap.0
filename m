From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH] DSPBRIDGE: Avoid possible buffer overflow in load_lib
Date: Thu, 8 Apr 2010 19:19:22 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CB048972@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51168 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758086Ab0DIAT0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 20:19:26 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From 770bb122ac96f6f87a4b0d93b98db683ae16eb36 Mon Sep 17 00:00:00 2001
From: Ernesto Ramos <ernesto@ti.com>
Date: Wed, 24 Mar 2010 16:40:02 -0600
Subject: [PATCH] DSPBRIDGE: Avoid possible buffer overflow in load_lib

Avoid possible buffer overflow in load_lib.
Array pers_lib_table may use index 5.
Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/rmgr/nldr.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index f796d37..d8ba424 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -1390,7 +1390,7 @@ static dsp_status load_lib(struct nldr_nodeobject *nldr_node_obj,
 			 * the deplib is already included */
 			if (!rootPersistent && persistent_dep_libs[i] &&
 			    *nldr_node_obj->pf_phase_split) {
-				if ((nldr_node_obj->pers_libs) > MAXLIBS) {
+				if ((nldr_node_obj->pers_libs) >= MAXLIBS) {
 					status = DSP_EDYNLOAD;
 					break;
 				}
-- 
1.6.0.4


From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 22/40] DSPBRIDGE: err code replace DSP_EBADSEGID with EBADR
Date: Thu,  3 Jun 2010 00:47:35 -0500
Message-ID: <1275544073-20418-23-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37602 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753187Ab0FCF4U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:20 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace DSP_EBADSEGID with EBADR

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/node.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 159ea2b..1c7742a 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -731,7 +731,7 @@ DBAPI node_alloc_msg_buf(struct node_object *hnode, u32 usize,
 	if (DSP_SUCCEEDED(status) && (!va_flag)) {
 		if (pattr->segment_id != 1) {
 			/* Node supports single SM segment only. */
-			status = DSP_EBADSEGID;
+			status = -EBADR;
 		}
 		/*  Arbitrary SM buffer alignment not supported for host side
 		 *  allocs, but guaranteed for the following alignment
@@ -1695,7 +1695,7 @@ dsp_status node_free_msg_buf(struct node_object *hnode, IN u8 * pbuffer,
 			}
 			/* Node supports single SM segment only */
 			if (pattr->segment_id != 1)
-				status = DSP_EBADSEGID;
+				status = -EBADR;
 
 			/* pbuffer is clients Va. */
 			status = cmm_xlator_free_buf(pnode->xlator, pbuffer);
-- 
1.7.1


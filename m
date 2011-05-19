From: Amber Jain <amber@ti.com>
Subject: [PATCH 2/5] OMAP: DSS2: configuring non-zero values for fir_hinc/fir_vinc
Date: Thu, 19 May 2011 11:01:27 +0530
Message-ID: <1305783090-21214-3-git-send-email-amber@ti.com>
References: <1305783090-21214-1-git-send-email-amber@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44548 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384Ab1ESFbl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 May 2011 01:31:41 -0400
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4J5Vf1Z005014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 00:31:41 -0500
In-Reply-To: <1305783090-21214-1-git-send-email-amber@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, molnar@ti.com, Amber Jain <amber@ti.com>

fir_hinc and fir_vinc can only have a non-zero value as per TRM.
Hence removed the if...else condition and also made the necesary changes
caused as the result of the condition removal.

Signed-off-by: Amber Jain <amber@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index e680528..92169bb 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1128,15 +1128,8 @@ static void _dispc_set_scaling(enum omap_plane plane,
 
 	_dispc_set_scale_coef(plane, hscaleup, vscaleup, five_taps);
 
-	if (!orig_width || orig_width == out_width)
-		fir_hinc = 0;
-	else
-		fir_hinc = 1024 * orig_width / out_width;
-
-	if (!orig_height || orig_height == out_height)
-		fir_vinc = 0;
-	else
-		fir_vinc = 1024 * orig_height / out_height;
+	fir_hinc = 1024 * orig_width / out_width;
+	fir_vinc = 1024 * orig_height / out_height;
 
 	_dispc_set_fir(plane, fir_hinc, fir_vinc);
 
@@ -1144,8 +1137,8 @@ static void _dispc_set_scaling(enum omap_plane plane,
 
 	/* RESIZEENABLE and VERTICALTAPS */
 	l &= ~((0x3 << 5) | (0x1 << 21));
-	l |= fir_hinc ? (1 << 5) : 0;
-	l |= fir_vinc ? (1 << 6) : 0;
+	l |= (orig_width != out_width) ? (1 << 5) : 0;
+	l |= (orig_height != out_height) ? (1 << 6) : 0;
 	l |= five_taps ? (1 << 21) : 0;
 
 	/* VRESIZECONF and HRESIZECONF */
-- 
1.7.1


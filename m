From: Amber Jain <amber@ti.com>
Subject: [PATCH v2 2/5] OMAP: DSS2: Ensure non-zero FIR values are configured
Date: Thu, 19 May 2011 19:47:51 +0530
Message-ID: <1305814674-21589-3-git-send-email-amber@ti.com>
References: <1305814674-21589-1-git-send-email-amber@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38228 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933305Ab1ESOSE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 10:18:04 -0400
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4JEI4Ds025780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 09:18:04 -0500
In-Reply-To: <1305814674-21589-1-git-send-email-amber@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, molnar@ti.com, Amber Jain <amber@ti.com>

FIR values can never be zero as per TRM, and the current code writes zero
when scaling is not used. It was not causing any problem as scaling was
disabled when zero was written. Its still safer to not write zero to 
it in any case.
Now we configure correct FIR values even when scaling is not used (i.e. set FIR
to 1024 when scaling is not used), but the scaling enable bits are still kept 
off if the scaling is not needed.

Signed-off-by: Amber Jain <amber@ti.com>
---
Changes from v1:
- updated commit message to make it more descriptive.

 drivers/video/omap2/dss/dispc.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 79c1c0a..fd8f68e 100644
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


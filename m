From: Archit Taneja <archit@ti.com>
Subject: [PATCH 08/10] OMAP2PLUS: DSS2: DISPC: Remove hardcoded use of PPL in five tap clock calculation
Date: Wed, 14 Sep 2011 17:55:12 +0530
Message-ID: <1316003114-24291-5-git-send-email-archit@ti.com>
References: <1316003114-24291-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38886 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932370Ab1INMYa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 08:24:30 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8ECOT9N024129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:24:29 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p8ECOTPq021766
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:24:29 -0500 (CDT)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8ECOTOB001427
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:24:29 -0500 (CDT)
In-Reply-To: <1316003114-24291-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The function calc_fclk_five_taps() uses a fixed value of pixels per line which
is used in calculations to get the minimum fclk needed for scaling with five
taps to work.

Remove this by providing the width of the panel connected to the manager.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 1a8a12c..307e70e 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1654,8 +1654,8 @@ static unsigned long calc_fclk_five_taps(enum omap_channel channel, u16 width,
 	u64 tmp, pclk = dispc_mgr_pclk_rate(channel);
 
 	if (height > out_height) {
-		/* FIXME get real display PPL */
-		unsigned int ppl = 800;
+		struct omap_dss_device *dssdev = dispc_mgr_get_device(channel);
+		unsigned int ppl = dssdev->panel.timings.x_res;
 
 		tmp = pclk * height * out_width;
 		do_div(tmp, 2 * out_height * ppl);
-- 
1.7.1


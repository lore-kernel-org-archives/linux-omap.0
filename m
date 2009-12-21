From: "Y, Kishore" <kishore.y@ti.com>
Subject: [PATCH] OMAP3630:DSS2:Enable Pre-Multiplied Alpha Support
Date: Mon, 21 Dec 2009 20:36:35 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026AD3FF3B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54654 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703AbZLUPGO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Dec 2009 10:06:14 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 2f873819a4b9eb0bd658db1e59408d8f0aeb14b6 Mon Sep 17 00:00:00 2001
From: Sudeep Basavaraj <sudeep.basavaraj@ti.com>
Date: Mon, 14 Dec 2009 18:54:51 +0530
Subject: [PATCH] OMAP3630:DSS2:Enable Pre-Multiplied Alpha Support

Enables dss to process color formats with pre-mulitplied alpha values.
With this we can have alpha values defined for each pixel
and hence can have different blending values for each pixel.

Signed-off-by: Sudeep Basavaraj <sudeep.basavaraj@ti.com>
Signed-off-by: Kishore Y <kishore.y@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 6dabf4b..5f7819b 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -913,6 +913,11 @@ static void _dispc_set_vid_color_conv(enum omap_plane plane, bool enable)
 	dispc_write_reg(dispc_reg_att[plane], val);
 }
 
+static void _dispc_set_alpha_blend_attrs(enum omap_plane plane, bool enable)
+{
+	REG_FLD_MOD(dispc_reg_att[plane], enable ? 1 : 0, 28, 28);
+}
+
 void dispc_enable_replication(enum omap_plane plane, bool enable)
 {
 	int bit;
@@ -1689,6 +1694,9 @@ static int _dispc_setup_plane(enum omap_plane plane,
 
 	_dispc_set_rotation_attrs(plane, rotation, mirror, color_mode);
 
+	if (cpu_is_omap3630() && (plane != OMAP_DSS_VIDEO1))
+		_dispc_set_alpha_blend_attrs(plane, 1);
+
 	if (plane != OMAP_DSS_VIDEO1)
 		_dispc_setup_global_alpha(plane, global_alpha);
 
-- 
1.5.4.3


Regards,
Kishore Y


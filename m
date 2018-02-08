From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: [PATCHv2 8/8] drm/omap: plane: update fifo size on ovl setup
Date: Thu,  8 Feb 2018 19:30:35 +0100
Message-ID: <20180208183035.8461-9-sebastian.reichel@collabora.co.uk>
References: <20180208183035.8461-1-sebastian.reichel@collabora.co.uk>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180208183035.8461-1-sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This is a workaround for a hardware bug occuring on OMAP3
with manually updated panels. Details about the HW bug are
unknown to me, but without this fix the panel refresh does
not work at all on Nokia N950. This is not the case for the
OMAP4 based Droid 4, which works perfectly fine with default
settings.

Signed-off-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
---
 drivers/gpu/drm/omapdrm/dss/dispc.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
index 4e8f68efd169..0904c3201914 100644
--- a/drivers/gpu/drm/omapdrm/dss/dispc.c
+++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
@@ -157,6 +157,8 @@ struct dispc_features {
 	bool has_gamma_table:1;
 
 	bool has_gamma_i734_bug:1;
+
+	bool has_fifo_stallmode_bug:1;
 };
 
 #define DISPC_MAX_NR_FIFOS 5
@@ -1489,6 +1491,18 @@ void dispc_ovl_compute_fifo_thresholds(enum omap_plane_id plane,
 	}
 }
 
+static void dispc_ovl_set_manual_fifo_threshold(enum omap_plane_id plane)
+{
+	u32 fifo_low, fifo_high;
+	bool use_fifo_merge = false;
+	bool use_manual_update = true;
+
+	dispc_ovl_compute_fifo_thresholds(plane, &fifo_low, &fifo_high,
+					  use_fifo_merge, use_manual_update);
+
+	dispc_ovl_set_fifo_threshold(plane, fifo_low, fifo_high);
+}
+
 static void dispc_ovl_set_mflag(enum omap_plane_id plane, bool enable)
 {
 	int bit;
@@ -2651,8 +2665,21 @@ static int dispc_ovl_setup(enum omap_plane_id plane,
 		oi->out_width, oi->out_height, oi->fourcc, oi->rotation,
 		oi->zorder, oi->pre_mult_alpha, oi->global_alpha,
 		oi->rotation_type, replication, vm, mem_to_mem);
+	if (r)
+		return r;
 
-	return r;
+	/*
+	 * OMAP3 chips have non-working FIFO thresholds for manually updated
+	 * displays. The issue is not fully understood, but this workaround
+	 * fixes the issue. OMAP4 is known to work with default thresholds.
+	 */
+	if (mgr_fld_read(channel, DISPC_MGR_FLD_STALLMODE) &&
+	    dispc.feat->has_fifo_stallmode_bug) {
+		DSSDBG("Enable OMAP3 FIFO stallmode bug workaround!\n");
+		dispc_ovl_set_manual_fifo_threshold(plane);
+	}
+
+	return 0;
 }
 
 int dispc_wb_setup(const struct omap_dss_writeback_info *wi,
@@ -4067,6 +4094,7 @@ static const struct dispc_features omap24xx_dispc_feats = {
 	.no_framedone_tv	=	true,
 	.set_max_preload	=	false,
 	.last_pixel_inc_missing	=	true,
+	.has_fifo_stallmode_bug	=	true,
 };
 
 static const struct dispc_features omap34xx_rev1_0_dispc_feats = {
@@ -4101,6 +4129,7 @@ static const struct dispc_features omap34xx_rev1_0_dispc_feats = {
 	.no_framedone_tv	=	true,
 	.set_max_preload	=	false,
 	.last_pixel_inc_missing	=	true,
+	.has_fifo_stallmode_bug	=	true,
 };
 
 static const struct dispc_features omap34xx_rev3_0_dispc_feats = {
@@ -4135,6 +4164,7 @@ static const struct dispc_features omap34xx_rev3_0_dispc_feats = {
 	.no_framedone_tv	=	true,
 	.set_max_preload	=	false,
 	.last_pixel_inc_missing	=	true,
+	.has_fifo_stallmode_bug	=	true,
 };
 
 static const struct dispc_features omap36xx_dispc_feats = {
@@ -4169,6 +4199,7 @@ static const struct dispc_features omap36xx_dispc_feats = {
 	.no_framedone_tv	=	true,
 	.set_max_preload	=	false,
 	.last_pixel_inc_missing	=	true,
+	.has_fifo_stallmode_bug	=	true,
 };
 
 static const struct dispc_features am43xx_dispc_feats = {
@@ -4203,6 +4234,7 @@ static const struct dispc_features am43xx_dispc_feats = {
 	.no_framedone_tv	=	true,
 	.set_max_preload	=	false,
 	.last_pixel_inc_missing	=	true,
+	.has_fifo_stallmode_bug	=	false,
 };
 
 static const struct dispc_features omap44xx_dispc_feats = {
@@ -4242,6 +4274,7 @@ static const struct dispc_features omap44xx_dispc_feats = {
 	.reverse_ilace_field_order =	true,
 	.has_gamma_table	=	true,
 	.has_gamma_i734_bug	=	true,
+	.has_fifo_stallmode_bug	=	false,
 };
 
 static const struct dispc_features omap54xx_dispc_feats = {
@@ -4282,6 +4315,7 @@ static const struct dispc_features omap54xx_dispc_feats = {
 	.reverse_ilace_field_order =	true,
 	.has_gamma_table	=	true,
 	.has_gamma_i734_bug	=	true,
+	.has_fifo_stallmode_bug	=	false,
 };
 
 static irqreturn_t dispc_irq_handler(int irq, void *arg)
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

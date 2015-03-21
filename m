From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCHv2 1/4] lis3lv02d: DT: use s32 to support negative values
Date: Sat, 21 Mar 2015 21:19:02 +0100
Message-ID: <1426969145-4478-2-git-send-email-sre@kernel.org>
References: <1426969145-4478-1-git-send-email-sre@kernel.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426969145-4478-1-git-send-email-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Piel <eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2yhQFI55V6+gNQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Sebastian Reichel <sre-DgEjT+Ai2yhQFI55V6+gNQ@public.gmane.org>

st,axis-{x,y,z} can be negative to imply inverted
axis.

Apart from that the minimal and maximal threshold
may be negative.

Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/misc/lis3lv02d/lis3lv02d.c | 39 +++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/lis3lv02d/lis3lv02d.c b/drivers/misc/lis3lv02d/lis3lv02d.c
index 3ef4627..d2b0968 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d.c
@@ -950,6 +950,7 @@ int lis3lv02d_init_dt(struct lis3lv02d *lis3)
 	struct lis3lv02d_platform_data *pdata;
 	struct device_node *np = lis3->of_node;
 	u32 val;
+	s32 sval;
 
 	if (!lis3->of_node)
 		return 0;
@@ -1054,29 +1055,29 @@ int lis3lv02d_init_dt(struct lis3lv02d *lis3)
 	if (of_get_property(np, "st,hipass2-disable", NULL))
 		pdata->hipass_ctrl |= LIS3_HIPASS2_DISABLE;
 
-	if (of_get_property(np, "st,axis-x", &val))
-		pdata->axis_x = val;
-	if (of_get_property(np, "st,axis-y", &val))
-		pdata->axis_y = val;
-	if (of_get_property(np, "st,axis-z", &val))
-		pdata->axis_z = val;
+	if (of_property_read_s32(np, "st,axis-x", &sval) == 0)
+		pdata->axis_x = sval;
+	if (of_property_read_s32(np, "st,axis-y", &sval) == 0)
+		pdata->axis_y = sval;
+	if (of_property_read_s32(np, "st,axis-z", &sval) == 0)
+		pdata->axis_z = sval;
 
 	if (of_get_property(np, "st,default-rate", NULL))
 		pdata->default_rate = val;
 
-	if (of_get_property(np, "st,min-limit-x", &val))
-		pdata->st_min_limits[0] = val;
-	if (of_get_property(np, "st,min-limit-y", &val))
-		pdata->st_min_limits[1] = val;
-	if (of_get_property(np, "st,min-limit-z", &val))
-		pdata->st_min_limits[2] = val;
-
-	if (of_get_property(np, "st,max-limit-x", &val))
-		pdata->st_max_limits[0] = val;
-	if (of_get_property(np, "st,max-limit-y", &val))
-		pdata->st_max_limits[1] = val;
-	if (of_get_property(np, "st,max-limit-z", &val))
-		pdata->st_max_limits[2] = val;
+	if (of_property_read_s32(np, "st,min-limit-x", &sval) == 0)
+		pdata->st_min_limits[0] = sval;
+	if (of_property_read_s32(np, "st,min-limit-y", &sval) == 0)
+		pdata->st_min_limits[1] = sval;
+	if (of_property_read_s32(np, "st,min-limit-z", &sval) == 0)
+		pdata->st_min_limits[2] = sval;
+
+	if (of_property_read_s32(np, "st,max-limit-x", &sval) == 0)
+		pdata->st_max_limits[0] = sval;
+	if (of_property_read_s32(np, "st,max-limit-y", &sval) == 0)
+		pdata->st_max_limits[1] = sval;
+	if (of_property_read_s32(np, "st,max-limit-z", &sval) == 0)
+		pdata->st_max_limits[2] = sval;
 
 
 	lis3->pdata = pdata;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/3] ARM: dra762: hwmod: Register package specific hwmod
Date: Mon, 18 Dec 2017 11:50:02 +0530
Message-ID: <20171218062003.9024-3-lokeshvutla@ti.com>
References: <20171218062003.9024-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171218062003.9024-1-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Register dra762 abz package specific hwmod. Also move registering rtc hwmod
into respective SoC conditional statements instead of doing it separately.

Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index d05e553d6346..f33afcaec77e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -4019,6 +4019,10 @@ static struct omap_hwmod_ocp_if *dra76x_hwmod_ocp_ifs[] __initdata = {
 	NULL,
 };
 
+static struct omap_hwmod_ocp_if *acd_76x_hwmod_ocp_ifs[] __initdata = {
+	NULL,
+};
+
 static struct omap_hwmod_ocp_if *dra74x_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_per3__usb_otg_ss4,
 	NULL,
@@ -4028,7 +4032,7 @@ static struct omap_hwmod_ocp_if *dra72x_hwmod_ocp_ifs[] __initdata = {
 	NULL,
 };
 
-static struct omap_hwmod_ocp_if *dra74x_dra72x_hwmod_ocp_ifs[] __initdata = {
+static struct omap_hwmod_ocp_if *rtc_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_per3__rtcss,
 	NULL,
 };
@@ -4040,19 +4044,26 @@ int __init dra7xx_hwmod_init(void)
 	omap_hwmod_init();
 	ret = omap_hwmod_register_links(dra7xx_hwmod_ocp_ifs);
 
-	if (!ret && soc_is_dra74x())
+	if (!ret && soc_is_dra74x()) {
 		ret = omap_hwmod_register_links(dra74x_hwmod_ocp_ifs);
-	else if (!ret && soc_is_dra72x())
+		if (!ret)
+			ret = omap_hwmod_register_links(rtc_hwmod_ocp_ifs);
+	} else if (!ret && soc_is_dra72x()) {
 		ret = omap_hwmod_register_links(dra72x_hwmod_ocp_ifs);
-	else if (!ret && soc_is_dra76x())
+		if (!ret && !of_machine_is_compatible("ti,dra718"))
+			ret = omap_hwmod_register_links(rtc_hwmod_ocp_ifs);
+	} else if (!ret && soc_is_dra76x()) {
 		ret = omap_hwmod_register_links(dra76x_hwmod_ocp_ifs);
 
+		if (!ret && soc_is_dra76x_acd()) {
+			ret = omap_hwmod_register_links(acd_76x_hwmod_ocp_ifs);
+		} else if (!ret && soc_is_dra76x_abz()) {
+			ret = omap_hwmod_register_links(rtc_hwmod_ocp_ifs);
+		}
+	}
+
 	if (!ret && omap_type() == OMAP2_DEVICE_TYPE_GP)
 		ret = omap_hwmod_register_links(dra7xx_gp_hwmod_ocp_ifs);
 
-	/* now for the IPs available only in dra74 and dra72 */
-	if (!ret && !of_machine_is_compatible("ti,dra718") && !soc_is_dra76x())
-		ret = omap_hwmod_register_links(dra74x_dra72x_hwmod_ocp_ifs);
-
 	return ret;
 }
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 3/8] ARM: dra7: hwmod: Register dra76x specific hwmod
Date: Sat, 12 Aug 2017 09:36:00 +0530
Message-ID: <20170812040605.21259-4-lokeshvutla@ti.com>
References: <20170812040605.21259-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170812040605.21259-1-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Praneeth Bajjuri <praneeth-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Certain IPs are available on dra76 which are not present
either in dra74 or dra72. So add provision to register dra76
specific IPs separately.

Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index b3abb8d8b2f6..f040244c57e7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -4070,6 +4070,11 @@ static struct omap_hwmod_ocp_if *dra7xx_gp_hwmod_ocp_ifs[] __initdata = {
 };
 
 /* SoC variant specific hwmod links */
+static struct omap_hwmod_ocp_if *dra76x_hwmod_ocp_ifs[] __initdata = {
+	&dra7xx_l4_per3__usb_otg_ss4,
+	NULL,
+};
+
 static struct omap_hwmod_ocp_if *dra74x_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_per3__usb_otg_ss4,
 	NULL,
@@ -4095,12 +4100,14 @@ int __init dra7xx_hwmod_init(void)
 		ret = omap_hwmod_register_links(dra74x_hwmod_ocp_ifs);
 	else if (!ret && soc_is_dra72x())
 		ret = omap_hwmod_register_links(dra72x_hwmod_ocp_ifs);
+	else if (!ret && soc_is_dra76x())
+		ret = omap_hwmod_register_links(dra76x_hwmod_ocp_ifs);
 
 	if (!ret && omap_type() == OMAP2_DEVICE_TYPE_GP)
 		ret = omap_hwmod_register_links(dra7xx_gp_hwmod_ocp_ifs);
 
-	/* now for the IPs *NOT* in dra71 */
-	if (!ret && !of_machine_is_compatible("ti,dra718"))
+	/* now for the IPs available only in dra74 and dra72 */
+	if (!ret && !of_machine_is_compatible("ti,dra718") && !soc_is_dra76x())
 		ret = omap_hwmod_register_links(dra74x_dra72x_hwmod_ocp_ifs);
 
 	return ret;
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

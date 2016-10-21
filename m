From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 6/9] ARM: DRA7: hwmod: Do not register RTC on DRA71
Date: Fri, 21 Oct 2016 16:08:38 +0530
Message-ID: <20161021103841.8044-7-lokeshvutla@ti.com>
References: <20161021103841.8044-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161021103841.8044-1-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux ARM Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

RTC is not available on DRA71x, so accessing any of the RTC
register or clkctrl register will lead to a crash. So, do not
register RTC hwmod for DRA71x.

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 1ab7096..7f48577 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -3845,7 +3845,6 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l3_main_1__pciess2,
 	&dra7xx_l4_cfg__pciess2,
 	&dra7xx_l3_main_1__qspi,
-	&dra7xx_l4_per3__rtcss,
 	&dra7xx_l4_cfg__sata,
 	&dra7xx_l4_cfg__smartreflex_core,
 	&dra7xx_l4_cfg__smartreflex_mpu,
@@ -3905,6 +3904,11 @@ static struct omap_hwmod_ocp_if *dra72x_hwmod_ocp_ifs[] __initdata = {
 	NULL,
 };
 
+static struct omap_hwmod_ocp_if *dra74x_dra72x_hwmod_ocp_ifs[] __initdata = {
+	&dra7xx_l4_per3__rtcss,
+	NULL,
+};
+
 int __init dra7xx_hwmod_init(void)
 {
 	int ret;
@@ -3920,5 +3924,9 @@ int __init dra7xx_hwmod_init(void)
 	if (!ret && omap_type() == OMAP2_DEVICE_TYPE_GP)
 		ret = omap_hwmod_register_links(dra7xx_gp_hwmod_ocp_ifs);
 
+	/* now for the IPs *NOT* in dra71 */
+	if (!ret && !of_machine_is_compatible("ti,dra718"))
+		ret = omap_hwmod_register_links(dra74x_dra72x_hwmod_ocp_ifs);
+
 	return ret;
 }
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

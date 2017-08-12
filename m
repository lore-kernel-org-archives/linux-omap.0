From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 5/8] ARM: OMAP: dra7: powerdomain data: Register SoC specific powerdomains
Date: Sat, 12 Aug 2017 09:36:02 +0530
Message-ID: <20170812040605.21259-6-lokeshvutla@ti.com>
References: <20170812040605.21259-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170812040605.21259-1-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Praneeth Bajjuri <praneeth-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Custom efuse powerdomain is always on in dra72 ES2.0
and dra76 SoCs. So register it as aon for these SoCs.

Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/powerdomains7xx_data.c | 33 +++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/powerdomains7xx_data.c b/arch/arm/mach-omap2/powerdomains7xx_data.c
index eb350a673133..f50963916a21 100644
--- a/arch/arm/mach-omap2/powerdomains7xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains7xx_data.c
@@ -29,6 +29,7 @@
 #include "prcm44xx.h"
 #include "prm7xx.h"
 #include "prcm_mpu7xx.h"
+#include "soc.h"
 
 /* iva_7xx_pwrdm: IVA-HD power domain */
 static struct powerdomain iva_7xx_pwrdm = {
@@ -63,6 +64,14 @@ static struct powerdomain custefuse_7xx_pwrdm = {
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
 
+/* custefuse_aon_7xx_pwrdm: Customer efuse controller power domain */
+static struct powerdomain custefuse_aon_7xx_pwrdm = {
+	.name		  = "custefuse_pwrdm",
+	.prcm_offs	  = DRA7XX_PRM_CUSTEFUSE_INST,
+	.prcm_partition	  = DRA7XX_PRM_PARTITION,
+	.pwrsts		  = PWRSTS_ON,
+};
+
 /* ipu_7xx_pwrdm: Audio back end power domain */
 static struct powerdomain ipu_7xx_pwrdm = {
 	.name		  = "ipu_pwrdm",
@@ -350,7 +359,6 @@ static struct powerdomain eve1_7xx_pwrdm = {
 static struct powerdomain *powerdomains_dra7xx[] __initdata = {
 	&iva_7xx_pwrdm,
 	&rtc_7xx_pwrdm,
-	&custefuse_7xx_pwrdm,
 	&ipu_7xx_pwrdm,
 	&dss_7xx_pwrdm,
 	&l4per_7xx_pwrdm,
@@ -374,9 +382,32 @@ static struct powerdomain *powerdomains_dra7xx[] __initdata = {
 	NULL
 };
 
+static struct powerdomain *powerdomains_dra76x[] __initdata = {
+	&custefuse_aon_7xx_pwrdm,
+	NULL
+};
+
+static struct powerdomain *powerdomains_dra74x[] __initdata = {
+	&custefuse_7xx_pwrdm,
+	NULL
+};
+
+static struct powerdomain *powerdomains_dra72x[] __initdata = {
+	&custefuse_aon_7xx_pwrdm,
+	NULL
+};
+
 void __init dra7xx_powerdomains_init(void)
 {
 	pwrdm_register_platform_funcs(&omap4_pwrdm_operations);
 	pwrdm_register_pwrdms(powerdomains_dra7xx);
+
+	if (soc_is_dra76x())
+		pwrdm_register_pwrdms(powerdomains_dra76x);
+	else if (soc_is_dra74x())
+		pwrdm_register_pwrdms(powerdomains_dra74x);
+	else if (soc_is_dra72x())
+		pwrdm_register_pwrdms(powerdomains_dra72x);
+
 	pwrdm_complete_init();
 }
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

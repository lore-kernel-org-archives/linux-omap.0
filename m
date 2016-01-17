From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/5] ARM: OMAP2+: hwmod data: Add SSI data for omap36xx
Date: Sun, 17 Jan 2016 16:49:05 +0100
Message-ID: <1453045749-22642-2-git-send-email-sre@kernel.org>
References: <1453045749-22642-1-git-send-email-sre@kernel.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453045749-22642-1-git-send-email-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch enables Synchronous Serial Interface (SSI)
hwmod support for OMAP36xx SoCs (used by Nokia N950/N9).

Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index aff78d5198d2..ed972029dce1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3625,14 +3625,14 @@ static struct omap_hwmod_class_sysconfig omap34xx_ssi_sysc = {
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
-static struct omap_hwmod_class omap34xx_ssi_hwmod_class = {
+static struct omap_hwmod_class omap3xxx_ssi_hwmod_class = {
 	.name	= "ssi",
 	.sysc	= &omap34xx_ssi_sysc,
 };
 
-static struct omap_hwmod omap34xx_ssi_hwmod = {
+static struct omap_hwmod omap3xxx_ssi_hwmod = {
 	.name		= "ssi",
-	.class		= &omap34xx_ssi_hwmod_class,
+	.class		= &omap3xxx_ssi_hwmod_class,
 	.clkdm_name	= "core_l4_clkdm",
 	.main_clk	= "ssi_ssr_fck",
 	.prcm		= {
@@ -3647,9 +3647,9 @@ static struct omap_hwmod omap34xx_ssi_hwmod = {
 };
 
 /* L4 CORE -> SSI */
-static struct omap_hwmod_ocp_if omap34xx_l4_core__ssi = {
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__ssi = {
 	.master		= &omap3xxx_l4_core_hwmod,
-	.slave		= &omap34xx_ssi_hwmod,
+	.slave		= &omap3xxx_ssi_hwmod,
 	.clk		= "ssi_ick",
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
@@ -3802,7 +3802,7 @@ static struct omap_hwmod_ocp_if *omap34xx_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_sad2d__l3,
 	&omap3xxx_l4_core__mmu_isp,
 	&omap3xxx_l3_main__mmu_iva,
-	&omap34xx_l4_core__ssi,
+	&omap3xxx_l4_core__ssi,
 	NULL
 };
 
@@ -3826,6 +3826,7 @@ static struct omap_hwmod_ocp_if *omap36xx_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_sad2d__l3,
 	&omap3xxx_l4_core__mmu_isp,
 	&omap3xxx_l3_main__mmu_iva,
+	&omap3xxx_l4_core__ssi,
 	NULL
 };
 
-- 
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

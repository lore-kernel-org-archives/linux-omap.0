From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/8] ARM: dra76: Enable SMP for dra76
Date: Wed, 19 Jul 2017 01:24:59 +0530
Message-ID: <20170718195503.1700-5-lokeshvutla@ti.com>
References: <20170718195503.1700-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170718195503.1700-1-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Praneeth Bajjuri <praneeth-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

smp specific routines are called based on soc_is_*() api in omap-smc.c.
Add soc_is_dra76x() to the condition so that smp specific routines are
called for dra76 SoC.

Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/omap-smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 33e4953c61a8..69df3620eca5 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -342,7 +342,7 @@ static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
 		c = &omap443x_cfg;
 	else if (soc_is_omap446x())
 		c = &omap446x_cfg;
-	else if (soc_is_dra74x() || soc_is_omap54xx())
+	else if (soc_is_dra74x() || soc_is_omap54xx() || soc_is_dra76x())
 		c = &omap5_cfg;
 
 	if (!c) {
@@ -355,7 +355,7 @@ static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
 	cfg.startup_addr = c->startup_addr;
 	cfg.wakeupgen_base = omap_get_wakeupgen_base();
 
-	if (soc_is_dra74x() || soc_is_omap54xx()) {
+	if (soc_is_dra74x() || soc_is_omap54xx() || soc_is_dra76x()) {
 		if ((__boot_cpu_mode & MODE_MASK) == HYP_MODE)
 			cfg.startup_addr = omap5_secondary_hyp_startup;
 		omap5_erratum_workaround_801819();
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

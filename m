From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH] ARM: OMAP: PM: stop early on systems without twl
Date: Sat, 10 Jun 2017 00:32:23 +0200
Message-ID: <20170609223223.19079-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Motorola Droid 4 has an OMAP4, but no TWL6030. It currently
complains verbosely about this during boot:

twl: not initialized
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1410000 Vs max 1316660
omap2_set_init_voltage: unable to find boot up OPP for vdd_core
omap2_set_init_voltage: unable to set vdd_core
omap2_set_init_voltage: unable to find boot up OPP for vdd_iva
omap2_set_init_voltage: unable to set vdd_iva

While proper support for CPCAP should be added at some point,
let's exit early in omap2_common_pm_late_init() until that
has been implemented to avoid the above errors. There is still
a reminder about missing PM in dmesg:

Missing OMAP4 PM for this platform!

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/mach-omap2/pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 63027e60cc20..4e4313cecc26 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -240,6 +240,9 @@ omap_postcore_initcall(omap2_common_pm_init);
 
 int __init omap2_common_pm_late_init(void)
 {
+	if (!twl_rev())
+		return -ENODEV;
+
 	/* Init the voltage layer */
 	omap3_twl_init();
 	omap4_twl_init();
-- 
2.11.0

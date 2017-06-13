From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2] ARM: OMAP: PM: stop early on systems without twl
Date: Tue, 13 Jun 2017 11:46:17 +0200
Message-ID: <20170613094617.29166-1-sre@kernel.org>
References: <20170612102527.GX3730@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170612102527.GX3730@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

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

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
Changes since PATCHv1:
 * actually add the message about missing PM support
 * check if TWL is enabled at all
---
 arch/arm/mach-omap2/pm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 63027e60cc20..92e335decc61 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -240,6 +240,10 @@ omap_postcore_initcall(omap2_common_pm_init);
 
 int __init omap2_common_pm_late_init(void)
 {
+#if IS_BUILTIN(CONFIG_TWL6040_CORE) || IS_BUILTIN(CONFIG_TWL4030_CORE)
+	if (!twl_rev())
+		goto no_twl;
+
 	/* Init the voltage layer */
 	omap3_twl_init();
 	omap4_twl_init();
@@ -253,4 +257,9 @@ int __init omap2_common_pm_late_init(void)
 	omap_devinit_smartreflex();
 
 	return 0;
+
+no_twl:
+#endif
+	pr_err("OMAP4 PM not supported!\n");
+	return -ENODEV;
 }
-- 
2.11.0

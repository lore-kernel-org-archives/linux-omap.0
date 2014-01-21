From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 02/41] ARM: OMAP2+: DT 'compatible' tweak for displays
Date: Tue, 21 Jan 2014 12:56:34 +0200
Message-ID: <1390301833-24944-3-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33363 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754091AbaAUK7K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jan 2014 05:59:10 -0500
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

As there is no common panel framework in the kernel, we have OMAP
specific panel drivers. However, the DT data should be generic. This
brings the issue that some other platform could use the same panels, and
would need to create a driver with the same 'compatible' string as the
OMAP driver.

In the long run, we have to get a common panel framework. For the time
being, this patch solves the issue:

At early boot time, we go through the DT nodes looking for the panels
the kernel supports for OMAP. For each found node, the 'compatible'
string is prepended with "omapdss,", i.e. "sony,acx565akm" becomes
"omapdss,sony,acx565akm". The OMAP display drivers all have "omapdss,"
at the beginning of their compatible field.

This allows us to have generic DT data, but OMAP specific display
drivers.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-generic.c |  2 ++
 arch/arm/mach-omap2/common.h        |  1 +
 arch/arm/mach-omap2/display.c       | 56 +++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 842e4f21ab09..08921d0d63d4 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -35,6 +35,8 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
 
 static void __init omap_generic_init(void)
 {
+	omapdss_early_init_of();
+
 	pdata_quirks_init(omap_dt_match_table);
 
 	omapdss_init_of();
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 04a4d360dd20..e21702e2e82e 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -308,6 +308,7 @@ extern int omap_dss_reset(struct omap_hwmod *);
 extern int (*omap_clk_init)(void);
 
 int __init omapdss_init_of(void);
+void __init omapdss_early_init_of(void);
 
 #endif /* __ASSEMBLER__ */
 #endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 77cd927e5acb..9a729bd3d28b 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/slab.h>
 
 #include <video/omapdss.h>
 #include "omap_hwmod.h"
@@ -555,6 +556,61 @@ int omap_dss_reset(struct omap_hwmod *oh)
 	return r;
 }
 
+/* list of 'compatible' nodes to convert to omapdss specific */
+static const char * const dss_compat_conv_list[] __initconst = {
+	"composite-connector",
+	"dvi-connector",
+	"hdmi-connector",
+	"panel-dpi",
+	"panel-dsi-cm",
+	"sony,acx565akm",
+	"svideo-connector",
+	"ti,tfp410",
+	"ti,tpd12s015",
+};
+
+/* prepend compatible string with "omapdss," */
+static __init void omapdss_omapify_node(struct device_node *node,
+	const char *compat)
+{
+	char *new_compat;
+	struct property *prop;
+
+	new_compat = kasprintf(GFP_KERNEL, "omapdss,%s", compat);
+
+	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+	prop->name = "compatible";
+	prop->value = new_compat;
+	prop->length = strlen(new_compat) + 1;
+
+	of_update_property(node, prop);
+}
+
+/*
+ * As omapdss panel drivers are omapdss specific, but we want to define the
+ * DT-data in generic manner, we convert the compatible strings of the panel
+ * nodes from "panel-foo" to "omapdss,panel-foo". This way we can have both
+ * correct DT data and omapdss specific drivers.
+ *
+ * When we get generic panel drivers to the kernel, this will be removed.
+ */
+void __init omapdss_early_init_of(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dss_compat_conv_list); ++i) {
+		const char *compat = dss_compat_conv_list[i];
+		struct device_node *node = NULL;
+
+		while ((node = of_find_compatible_node(node, NULL, compat))) {
+			if (!of_device_is_available(node))
+				continue;
+
+			omapdss_omapify_node(node, compat);
+		}
+	}
+}
+
 int __init omapdss_init_of(void)
 {
 	int r;
-- 
1.8.3.2


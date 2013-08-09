From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC 03/22] ARM: OMAP2+: add omapdss_init_of()
Date: Fri, 9 Aug 2013 11:38:48 +0300
Message-ID: <1376037547-10859-4-git-send-email-tomi.valkeinen@ti.com>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51324 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030596Ab3HIIjc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Aug 2013 04:39:32 -0400
In-Reply-To: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapdss driver uses a omapdss platform device to pass platform specific
function pointers and DSS hardware version from the arch code to the
driver. This device is needed also when booting with DT.

This patch adds omapdss_init_of() function, called from board-generic at
init time, which creates the omapdss device.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-generic.c |  2 ++
 arch/arm/mach-omap2/common.h        |  2 ++
 arch/arm/mach-omap2/display.c       | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index d388d33..aaf1125 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -61,6 +61,8 @@ static void __init omap_generic_init(void)
 		legacy_init_ehci_clk("auxclk3_ck");
 	else if (of_machine_is_compatible("ti,omap5-uevm"))
 		legacy_init_ehci_clk("auxclk1_ck");
+
+	omapdss_init_of();
 }
 
 #ifdef CONFIG_SOC_OMAP2420
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index dfcc182..377900c 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -300,5 +300,7 @@ extern int omap_dss_reset(struct omap_hwmod *);
 /* SoC specific clock initializer */
 extern int (*omap_clk_init)(void);
 
+int __init omapdss_init_of(void);
+
 #endif /* __ASSEMBLER__ */
 #endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index ff37be1..c62aee0 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -23,6 +23,8 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 
 #include <video/omapdss.h>
 #include "omap_hwmod.h"
@@ -564,3 +566,35 @@ int omap_dss_reset(struct omap_hwmod *oh)
 
 	return r;
 }
+
+int __init omapdss_init_of(void)
+{
+	int r;
+	enum omapdss_version ver;
+
+	static struct omap_dss_board_info board_data = {
+		.dsi_enable_pads = omap_dsi_enable_pads,
+		.dsi_disable_pads = omap_dsi_disable_pads,
+		.get_context_loss_count = omap_pm_get_dev_context_loss_count,
+		.set_min_bus_tput = omap_dss_set_min_bus_tput,
+	};
+
+	ver = omap_display_get_version();
+
+	if (ver == OMAPDSS_VER_UNKNOWN) {
+		pr_err("DSS not supported on this SoC\n");
+		return -ENODEV;
+	}
+
+	board_data.version = ver;
+
+	omap_display_device.dev.platform_data = &board_data;
+
+	r = platform_device_register(&omap_display_device);
+	if (r < 0) {
+		pr_err("Unable to register omapdss device\n");
+		return r;
+	}
+
+	return 0;
+}
-- 
1.8.1.2


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC 02/14] ARM: OMAP2+: add omapdss_init_of()
Date: Wed, 27 Mar 2013 10:45:09 +0200
Message-ID: <1364373921-7599-3-git-send-email-tomi.valkeinen@ti.com>
References: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36038 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab3C0IqU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 04:46:20 -0400
In-Reply-To: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: Archit Taneja <archit@ti.com>, Andy Gross <andy.gross@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapdss driver uses a omapdss platform device to pass platform specific
function pointers and DSS hardware version from the arch code to the
driver. This device is needed also when booting with DT.

This patch adds omapdss_init_of() function, called from board-generic at
init time, which creates the omapdss device.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-generic.c |    1 +
 arch/arm/mach-omap2/common.h        |    2 ++
 arch/arm/mach-omap2/display.c       |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index a61544b..29eb085 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -41,6 +41,7 @@ static void __init omap_generic_init(void)
 
 	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
 
+	omapdss_init_of();
 }
 
 #ifdef CONFIG_SOC_OMAP2420
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 40f4a03..e9ac1fd 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -293,5 +293,7 @@ extern void omap_reserve(void);
 struct omap_hwmod;
 extern int omap_dss_reset(struct omap_hwmod *);
 
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
1.7.10.4


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 05/26] ARM: OMAP2+: add omapdss_init_of()
Date: Wed, 4 Dec 2013 14:28:32 +0200
Message-ID: <1386160133-24026-6-git-send-email-tomi.valkeinen@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52190 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753663Ab3LDMaC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Dec 2013 07:30:02 -0500
In-Reply-To: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapdss driver uses a omapdss platform device to pass platform specific
function pointers and DSS hardware version from the arch code to the
driver. This device is needed also when booting with DT.

This patch adds omapdss_init_of() function, called from board-generic at
init time, which creates the omapdss device.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-generic.c |  2 ++
 arch/arm/mach-omap2/common.h        |  2 ++
 arch/arm/mach-omap2/display.c       | 62 +++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 19f1652e94cf..0e06771d7bee 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -36,6 +36,8 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
 static void __init omap_generic_init(void)
 {
 	pdata_quirks_init(omap_dt_match_table);
+
+	omapdss_init_of();
 }
 
 #ifdef CONFIG_SOC_OMAP2420
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index f7644febee81..48e9cd34cae0 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -308,5 +308,7 @@ extern int omap_dss_reset(struct omap_hwmod *);
 /* SoC specific clock initializer */
 extern int (*omap_clk_init)(void);
 
+int __init omapdss_init_of(void);
+
 #endif /* __ASSEMBLER__ */
 #endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index a4e536b11ec9..3279afc5f0b5 100644
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
@@ -592,3 +594,63 @@ int omap_dss_reset(struct omap_hwmod *oh)
 
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
+	/* create DRM device */
+	r = omap_init_drm();
+	if (r < 0) {
+		pr_err("Unable to register omapdrm device\n");
+		return r;
+	}
+
+	/* create vrfb device */
+	r = omap_init_vrfb();
+	if (r < 0) {
+		pr_err("Unable to register omapvrfb device\n");
+		return r;
+	}
+
+	/* create FB device */
+	r = omap_init_fb();
+	if (r < 0) {
+		pr_err("Unable to register omapfb device\n");
+		return r;
+	}
+
+	/* create V4L2 display device */
+	r = omap_init_vout();
+	if (r < 0) {
+		pr_err("Unable to register omap_vout device\n");
+		return r;
+	}
+
+	return 0;
+}
-- 
1.8.3.2


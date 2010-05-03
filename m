From: Jani Nikula <ext-jani.1.nikula@Nokia.com>
Subject: [PATCH v2 15/21] OMAP: DSS2: Add Nokia DSI command mode panel configuration struct
Date: Mon,  3 May 2010 09:18:35 +0300
Message-ID: <df2ca92a00d718b95aa6a7875a4199882c86f513.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
 <1ef57e99d69aaf89b8e61074aa8ce2e5f6632d28.1272621452.git.ext-jani.1.nikula@nokia.com>
 <c95257e8042f471c55a38133020d1d63e22161f3.1272621452.git.ext-jani.1.nikula@nokia.com>
 <db2b972d4fa08c2f5b3cd06392ef62415890a188.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b57a3f4ccf68e8c8faf332a25b699b92a5604509.1272621452.git.ext-jani.1.nikula@nokia.com>
 <7a01973540a3afa79701ee08a3d8732db4687d5b.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b88fcf26f978d38a25000c2f472a4ad8f79ac285.1272621452.git.ext-jani.1.nikula@nokia.com>
 <ba3a895d56c242fe4edbcfc4abd3c608da3db77a.1272621452.git.ext-jani.1.nikula@nokia.com>
 <1a68710812da041ef583944411a1b7027d216c96.1272621452.git.ext-jani.1.nikula@nokia.com>
 <85172e14c23339065e319230f9707353409a901e.1272621452.git.ext-jani.1.nikula@nokia.com>
 <6e9febe4d2179309dcf93b7a8e897890c871f086.1272621452.git.ext-jani.1.nikula@nokia.com>
 <ad1917b1c316a85051c4a908705d403956ca1720.1272621452.git.ext-jani.1.nikula@nokia.com>
 <4004b06a47d3c1d20d6d8a30ddccdf536faeb5a0.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b88e1b382ddf14870c7a44e7ca620ad84d883b50.1272621452.git.ext-jani.1.nikula@nokia.com>
 <5a5dc1e253df571477551b8f63560ad9d1a3ab2b.1272621452.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34472 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755810Ab0ECGS5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 02:18:57 -0400
In-Reply-To: <5a5dc1e253df571477551b8f63560ad9d1a3ab2b.1272621452.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@Nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@Nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Introduce a configuration struct for platform/board specific information
of Nokia DSI command mode panels, to be used in addition to struct
omap_dss_device (passed via the 'void *data' member).

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 arch/arm/plat-omap/include/plat/nokia-dsi-panel.h |   31 +++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/nokia-dsi-panel.h

diff --git a/arch/arm/plat-omap/include/plat/nokia-dsi-panel.h b/arch/arm/plat-omap/include/plat/nokia-dsi-panel.h
new file mode 100644
index 0000000..01ab657
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/nokia-dsi-panel.h
@@ -0,0 +1,31 @@
+#ifndef __ARCH_ARM_PLAT_OMAP_NOKIA_DSI_PANEL_H
+#define __ARCH_ARM_PLAT_OMAP_NOKIA_DSI_PANEL_H
+
+#include "display.h"
+
+/**
+ * struct nokia_dsi_panel_data - Nokia DSI panel driver configuration
+ * @name: panel name
+ * @use_ext_te: use external TE
+ * @ext_te_gpio: external TE GPIO
+ * @use_esd_check: perform ESD checks
+ * @max_backlight_level: maximum backlight level
+ * @set_backlight: pointer to backlight set function
+ * @get_backlight: pointer to backlight get function
+ */
+struct nokia_dsi_panel_data {
+	const char *name;
+
+	int reset_gpio;
+
+	bool use_ext_te;
+	int ext_te_gpio;
+
+	bool use_esd_check;
+
+	int max_backlight_level;
+	int (*set_backlight)(struct omap_dss_device *dssdev, int level);
+	int (*get_backlight)(struct omap_dss_device *dssdev);
+};
+
+#endif /* __ARCH_ARM_PLAT_OMAP_NOKIA_DSI_PANEL_H */
-- 
1.6.5.2


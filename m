From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v3 15/21] OMAP: DSS2: Add Nokia DSI command mode panel configuration struct
Date: Wed,  5 May 2010 17:27:35 +0300
Message-ID: <4f2a95d67d2b8004f4a2055681690920ebeb8e8f.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
 <e28a022b7d3a53dbdf3f1329119b1de300d08c6b.1273067195.git.ext-jani.1.nikula@nokia.com>
 <1dfb7728d4d3ba8ceff808563e5a9f4c40aa3e9f.1273067195.git.ext-jani.1.nikula@nokia.com>
 <6b813e9f0008e23e7981f6ca35501f56c292858a.1273067195.git.ext-jani.1.nikula@nokia.com>
 <b32669a58d60491c3be4f7e52a52c27406cec877.1273067195.git.ext-jani.1.nikula@nokia.com>
 <94d9d7bebbf7588bd77b65e6a46044240140a350.1273067195.git.ext-jani.1.nikula@nokia.com>
 <61a89461654fe44174902f6e29b8acded7529b67.1273067195.git.ext-jani.1.nikula@nokia.com>
 <16a98ca1b45ba9b9bb30f23d242449c1d440df07.1273067195.git.ext-jani.1.nikula@nokia.com>
 <aa1e310d0d385db39b5d53ba4d3dcf02b7e2f47f.1273067195.git.ext-jani.1.nikula@nokia.com>
 <0cfff2a3cbb4231b41b382caf8aab7c52f47b0d5.1273067195.git.ext-jani.1.nikula@nokia.com>
 <adb61d94ee2a25284f6bd3f55ec4213501cbe8e3.1273067195.git.ext-jani.1.nikula@nokia.com>
 <4cb510ffbc3216e2a7dac16edaff5fb1980b3315.1273067195.git.ext-jani.1.nikula@nokia.com>
 <8665676eca5bbd3be35b63f7110f629e94a6babe.1273067195.git.ext-jani.1.nikula@nokia.com>
 <a4e7d90e0f036e227a29d94e28b7036c2f9d419b.1273067195.git.ext-jani.1.nikula@nokia.com>
 <ca7ff2e5a165ca8488190520f1f75e6e37642d3b.1273067195.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34150 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932540Ab0EEO2U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 10:28:20 -0400
In-Reply-To: <ca7ff2e5a165ca8488190520f1f75e6e37642d3b.1273067195.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

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


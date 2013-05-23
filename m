From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v2 4/5] ARM: dts: OMAP2+: header file for pinctrl constants
Date: Thu, 23 May 2013 17:37:00 +0200
Message-ID: <1369323421-4180-5-git-send-email-florian.vaussard@epfl.ch>
References: <1369323421-4180-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:35977 "HELO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754876Ab3EWPhU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 May 2013 11:37:20 -0400
In-Reply-To: <1369323421-4180-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Most of the constants are taken from arch/arm/mach-omap2/mux.h.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 include/dt-bindings/pinctrl/omap.h |   54 ++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/omap.h

diff --git a/include/dt-bindings/pinctrl/omap.h b/include/dt-bindings/pinctrl/omap.h
new file mode 100644
index 0000000..253ce95
--- /dev/null
+++ b/include/dt-bindings/pinctrl/omap.h
@@ -0,0 +1,54 @@
+/*
+ * This header provides constants for OMAP pinctrl bindings.
+ *
+ * Copyright (C) 2009 Nokia
+ * Copyright (C) 2009-2010 Texas Instruments
+ */
+
+/* 34xx mux mode options for each pin. See TRM for options */
+#define OMAP_MUX_MODE0      0
+#define OMAP_MUX_MODE1      1
+#define OMAP_MUX_MODE2      2
+#define OMAP_MUX_MODE3      3
+#define OMAP_MUX_MODE4      4
+#define OMAP_MUX_MODE5      5
+#define OMAP_MUX_MODE6      6
+#define OMAP_MUX_MODE7      7
+
+/* 24xx/34xx mux bit defines */
+#define OMAP_PULL_ENA			(1 << 3)
+#define OMAP_PULL_UP			(1 << 4)
+#define OMAP_ALTELECTRICALSEL		(1 << 5)
+
+/* 34xx specific mux bit defines */
+#define OMAP_INPUT_EN			(1 << 8)
+#define OMAP_OFF_EN			(1 << 9)
+#define OMAP_OFFOUT_EN			(1 << 10)
+#define OMAP_OFFOUT_VAL			(1 << 11)
+#define OMAP_OFF_PULL_EN		(1 << 12)
+#define OMAP_OFF_PULL_UP		(1 << 13)
+#define OMAP_WAKEUP_EN			(1 << 14)
+
+/* 44xx specific mux bit defines */
+#define OMAP_WAKEUP_EVENT		(1 << 15)
+
+/* Active pin states */
+#define OMAP_PIN_OUTPUT			0
+#define OMAP_PIN_OUTPUT_PULLUP		(OMAP_PIN_OUTPUT | OMAP_PULL_ENA \
+						| OMAP_PULL_UP)
+#define OMAP_PIN_OUTPUT_PULLDOWN	(OMAP_PIN_OUTPUT | OMAP_PULL_ENA)
+#define OMAP_PIN_INPUT			OMAP_INPUT_EN
+#define OMAP_PIN_INPUT_PULLUP		(OMAP_PULL_ENA | OMAP_INPUT_EN \
+						| OMAP_PULL_UP)
+#define OMAP_PIN_INPUT_PULLDOWN		(OMAP_PULL_ENA | OMAP_INPUT_EN)
+
+/* Off mode states */
+#define OMAP_PIN_OFF_NONE		0
+#define OMAP_PIN_OFF_OUTPUT_HIGH	(OMAP_OFF_EN | OMAP_OFFOUT_EN \
+						| OMAP_OFFOUT_VAL)
+#define OMAP_PIN_OFF_OUTPUT_LOW		(OMAP_OFF_EN | OMAP_OFFOUT_EN)
+#define OMAP_PIN_OFF_INPUT_PULLUP	(OMAP_OFF_EN | OMAP_OFF_PULL_EN \
+						| OMAP_OFF_PULL_UP)
+#define OMAP_PIN_OFF_INPUT_PULLDOWN	(OMAP_OFF_EN | OMAP_OFF_PULL_EN)
+#define OMAP_PIN_OFF_WAKEUPENABLE	OMAP_WAKEUP_EN
+
-- 
1.7.5.4


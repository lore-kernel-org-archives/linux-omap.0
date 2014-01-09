From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 17/18] ARM: dts: Add support for the Overo Summit
Date: Thu,  9 Jan 2014 17:48:11 +0100
Message-ID: <1389286092-27087-18-git-send-email-florian.vaussard@epfl.ch>
References: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:41104 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755450AbaAIQs5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jan 2014 11:48:57 -0500
In-Reply-To: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, florian.vaussard@epfl.ch

Summit is an expansion board for Gumstix Overo products.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/Makefile               |  1 +
 arch/arm/boot/dts/omap3-overo-summit.dts | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-overo-summit.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3f6ef70..d00f023 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -193,6 +193,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap3-overo-chestnut43.dtb \
 	omap3-overo-gallop43.dtb \
 	omap3-overo-palo43.dtb \
+	omap3-overo-summit.dtb \
 	omap3-overo-tobi.dtb \
 	omap3-gta04.dtb \
 	omap3-igep0020.dtb \
diff --git a/arch/arm/boot/dts/omap3-overo-summit.dts b/arch/arm/boot/dts/omap3-overo-summit.dts
new file mode 100644
index 0000000..fd8b47c
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-overo-summit.dts
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2014 Florian Vaussard, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Summit expansion board is manufactured by Gumstix Inc.
+ */
+
+#include "omap3-overo-common.dtsi"
+
+/ {
+	model = "TI OMAP3 Gumstix Overo on Summit";
+	compatible = "gumstix,omap3-overo-summit", "gumstix,omap3-overo", "ti,omap3";
+
+	leds {
+		compatible = "gpio-leds";
+		heartbeat {
+			label = "overo:red:gpio21";
+			gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
-- 
1.8.1.2


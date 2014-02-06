From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 3/3] ARM: dts: Add support for both OMAP35xx and OMAP36xx Overo/Tobi
Date: Thu,  6 Feb 2014 10:10:18 +0100
Message-ID: <1391677818-21154-4-git-send-email-florian.vaussard@epfl.ch>
References: <1391677818-21154-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:51866 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932304AbaBFJKn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Feb 2014 04:10:43 -0500
In-Reply-To: <1391677818-21154-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@linaro.org>, Mike Turquette <mturquette@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Unfortunatly the device tree for older OMAP35xx Overo cannot be used
with newer OMAP36xx and vice-versa. To address this issue, move most of
the Tobi DTS to a common include file, and create model-specific Tobi
DTS.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/Makefile                         |  3 ++-
 arch/arm/boot/dts/omap3-overo-storm-tobi.dts       | 22 ++++++++++++++++++++++
 ...omap3-tobi.dts => omap3-overo-tobi-common.dtsi} |  6 ------
 arch/arm/boot/dts/omap3-overo-tobi.dts             | 22 ++++++++++++++++++++++
 4 files changed, 46 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm-tobi.dts
 rename arch/arm/boot/dts/{omap3-tobi.dts => omap3-overo-tobi-common.dtsi} (91%)
 create mode 100644 arch/arm/boot/dts/omap3-overo-tobi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b9d6a8b..e8355f4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -208,7 +208,8 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap3-n900.dtb \
 	omap3-n9.dtb \
 	omap3-n950.dtb \
-	omap3-tobi.dtb \
+	omap3-overo-tobi.dtb \
+	omap3-overo-storm-tobi.dtb \
 	omap3-gta04.dtb \
 	omap3-igep0020.dtb \
 	omap3-igep0030.dtb \
diff --git a/arch/arm/boot/dts/omap3-overo-storm-tobi.dts b/arch/arm/boot/dts/omap3-overo-storm-tobi.dts
new file mode 100644
index 0000000..966b5c9
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-overo-storm-tobi.dts
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2012 Florian Vaussard, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Tobi expansion board is manufactured by Gumstix Inc.
+ */
+
+/dts-v1/;
+
+#include "omap36xx.dtsi"
+#include "omap3-overo-tobi-common.dtsi"
+
+/ {
+	model = "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Tobi";
+	compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap36xx", "ti,omap3";
+};
+
diff --git a/arch/arm/boot/dts/omap3-tobi.dts b/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
similarity index 91%
rename from arch/arm/boot/dts/omap3-tobi.dts
rename to arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
index c742afa..4edc013 100644
--- a/arch/arm/boot/dts/omap3-tobi.dts
+++ b/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
@@ -10,15 +10,9 @@
  * Tobi expansion board is manufactured by Gumstix Inc.
  */
 
-/dts-v1/;
-
-#include "omap36xx.dtsi"
 #include "omap3-overo.dtsi"
 
 / {
-	model = "TI OMAP3 Gumstix Overo on Tobi";
-	compatible = "gumstix,omap3-tobi", "gumstix,omap3-overo", "ti,omap36xx", "ti,omap3";
-
 	leds {
 		compatible = "gpio-leds";
 		heartbeat {
diff --git a/arch/arm/boot/dts/omap3-overo-tobi.dts b/arch/arm/boot/dts/omap3-overo-tobi.dts
new file mode 100644
index 0000000..2f82192
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-overo-tobi.dts
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2012 Florian Vaussard, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Tobi expansion board is manufactured by Gumstix Inc.
+ */
+
+/dts-v1/;
+
+#include "omap34xx.dtsi"
+#include "omap3-overo-tobi-common.dtsi"
+
+/ {
+	model = "OMAP35xx Gumstix Overo on Tobi";
+	compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3";
+};
+
-- 
1.8.1.2


From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v4 3/3] ARM/dts: omap3: Add support for IGEP COM Module
Date: Wed, 19 Dec 2012 14:33:10 +0100
Message-ID: <1355923990-21240-4-git-send-email-javier.martinez@collabora.co.uk>
References: <1355923990-21240-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:41669 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab2LSNde (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 08:33:34 -0500
In-Reply-To: <1355923990-21240-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, grant.likely@secretlab.ca, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Jon Hunter <jon-hunter@ti.com>, Matthias Brugger <matthias.bgg@googlemail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

ISEE IGEP COM Module is an TI OMAP3 SoC computer on module.

This patch adds an initial device tree support to boot an
IGEP COM Module from the MMC/SD.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---

Changes since v1:
    - Use default-state = "on" instead default-trigger = "default-on" for LED
    - Update GPIO mapping according to latest IGEP COM Module rev.E instead D

 arch/arm/boot/dts/Makefile           |    1 +
 arch/arm/boot/dts/omap3-igep0030.dts |   44 ++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-igep0030.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 24b28ba..8880c55 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -107,6 +107,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap3-evm.dtb \
 	omap3-tobi.dtb \
 	omap3-igep0020.dtb \
+	omap3-igep0030.dtb \
 	omap4-panda.dtb \
 	omap4-panda-es.dtb \
 	omap4-var-som.dtb \
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
new file mode 100644
index 0000000..9dc48d2
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -0,0 +1,44 @@
+/*
+ * Device Tree Source for IGEP COM Module
+ *
+ * Copyright (C) 2012 Javier Martinez Canillas <javier@collabora.co.uk>
+ * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/include/ "omap3-igep.dtsi"
+
+/ {
+	model = "IGEP COM Module";
+	compatible = "isee,omap3-igep0030", "ti,omap3";
+
+	leds {
+		compatible = "gpio-leds";
+		boot {
+			 label = "omap3:green:boot";
+			 gpios = <&twl_gpio 13 1>;
+			 default-state = "on";
+		};
+
+		user0 {
+			 label = "omap3:red:user0";
+			 gpios = <&twl_gpio 18 1>; /* LEDA */
+			 default-state = "off";
+		};
+
+		user1 {
+			 label = "omap3:green:user1";
+			 gpios = <&twl_gpio 19 1>; /* LEDB */
+			 default-state = "off";
+		};
+
+		user2 {
+			 label = "omap3:red:user1";
+			 gpios = <&gpio1 16 1>;
+			 default-state = "off";
+		};
+	};
+};
-- 
1.7.7.6


From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: [PATCH v2 3/3] ARM/dts: omap3: Add support for IGEP COM Module
Date: Fri, 30 Nov 2012 11:08:57 +0100
Message-ID: <1354270137-31538-4-git-send-email-javier.martinez@collabora.co.uk>
References: <1354270137-31538-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1354270137-31538-1-git-send-email-javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Enrico Butera <ebutera-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

ISEE IGEP COM Module is an TI OMAP3 SoC computer on module.

This patch adds an initial device tree support to boot an
IGEP COM Module from the MMC/SD.

Signed-off-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Acked-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---

Changes since v1:
    - Use default-state = "on" instead default-trigger = "default-on" for LED
    - Update GPIO mapping according to latest IGEP COM Module rev.E instead D

 arch/arm/boot/dts/Makefile           |    1 +
 arch/arm/boot/dts/omap3-igep0030.dts |   44 ++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-igep0030.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 1dc0f39..78c99bc 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -67,6 +67,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap3-evm.dtb \
 	omap3-tobi.dtb \
 	omap3-igep0020.dtb \
+	omap3-igep0030.dtb \
 	omap4-panda.dtb \
 	omap4-pandaES.dtb \
 	omap4-var_som.dtb \
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
new file mode 100644
index 0000000..9dc48d2
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -0,0 +1,44 @@
+/*
+ * Device Tree Source for IGEP COM Module
+ *
+ * Copyright (C) 2012 Javier Martinez Canillas <javier-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
+ * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

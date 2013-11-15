From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/11] ARM: dts: Add basic Nokia N8X0 support
Date: Thu, 14 Nov 2013 16:09:49 -0800
Message-ID: <1384474198-20756-3-git-send-email-tony@atomide.com>
References: <1384474198-20756-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42121 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909Ab3KOAKD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Nov 2013 19:10:03 -0500
In-Reply-To: <1384474198-20756-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>

Add minimal device tree support for n8x0 boards so we
can make omap2 device tree only. Note that we still need
to initialize various platform data quirks to keep
things working until n8x0 drivers support device tree.

Here's a rough todo list for the people using n8x0:

1. Update menelaus for device tree and set up
   regulators at least for the MMC driver

2. Remove the MMC regulator platform data callback
   by using the Menlaus regulators directly in the
   driver passed from the .dts file

3. Update GPMC connected devices for onenand and
   tusb6010 for device tree

We're planning to remove all legacy platform data
for mach-omap2 over next few merge cycles, so if
people are still using n8x0, please fix the issues
above.

Cc: devicetree@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "Beno=C3=AEt Cousson" <bcousson@baylibre.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/Makefile                  |  3 +++
 arch/arm/boot/dts/omap2420-n800.dts         |  8 +++++++
 arch/arm/boot/dts/omap2420-n810-wimax.dts   |  8 +++++++
 arch/arm/boot/dts/omap2420-n810.dts         |  8 +++++++
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi | 34 +++++++++++++++++++++=
++++++++
 5 files changed, 61 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap2420-n800.dts
 create mode 100644 arch/arm/boot/dts/omap2420-n810-wimax.dts
 create mode 100644 arch/arm/boot/dts/omap2420-n810.dts
 create mode 100644 arch/arm/boot/dts/omap2420-n8x0-common.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 73022b1..de37094 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -174,6 +174,9 @@ dtb-$(CONFIG_ARCH_NSPIRE) +=3D nspire-cx.dtb \
 	nspire-clp.dtb
 dtb-$(CONFIG_ARCH_OMAP2PLUS) +=3D omap2420-h4.dtb \
 	omap2430-sdp.dtb \
+	omap2420-n800.dtb \
+	omap2420-n810.dtb \
+	omap2420-n810-wimax.dtb \
 	omap3430-sdp.dtb \
 	omap3-beagle.dtb \
 	omap3-devkit8000.dtb \
diff --git a/arch/arm/boot/dts/omap2420-n800.dts b/arch/arm/boot/dts/om=
ap2420-n800.dts
new file mode 100644
index 0000000..d8c1b42
--- /dev/null
+++ b/arch/arm/boot/dts/omap2420-n800.dts
@@ -0,0 +1,8 @@
+/dts-v1/;
+
+#include "omap2420-n8x0-common.dtsi"
+
+/ {
+	model =3D "Nokia N800";
+	compatible =3D "nokia,n800", "nokia,n8x0", "ti,omap2420", "ti,omap2";
+};
diff --git a/arch/arm/boot/dts/omap2420-n810-wimax.dts b/arch/arm/boot/=
dts/omap2420-n810-wimax.dts
new file mode 100644
index 0000000..6b25b03
--- /dev/null
+++ b/arch/arm/boot/dts/omap2420-n810-wimax.dts
@@ -0,0 +1,8 @@
+/dts-v1/;
+
+#include "omap2420-n8x0-common.dtsi"
+
+/ {
+	model =3D "Nokia N810 WiMax";
+	compatible =3D "nokia,n810-wimax", "nokia,n8x0", "ti,omap2420", "ti,o=
map2";
+};
diff --git a/arch/arm/boot/dts/omap2420-n810.dts b/arch/arm/boot/dts/om=
ap2420-n810.dts
new file mode 100644
index 0000000..21baec1
--- /dev/null
+++ b/arch/arm/boot/dts/omap2420-n810.dts
@@ -0,0 +1,8 @@
+/dts-v1/;
+
+#include "omap2420-n8x0-common.dtsi"
+
+/ {
+	model =3D "Nokia N810";
+	compatible =3D "nokia,n810", "nokia,n8x0", "ti,omap2420", "ti,omap2";
+};
diff --git a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi b/arch/arm/boo=
t/dts/omap2420-n8x0-common.dtsi
new file mode 100644
index 0000000..c539693
--- /dev/null
+++ b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
@@ -0,0 +1,34 @@
+#include "omap2420.dtsi"
+
+/ {
+	memory {
+		device_type =3D "memory";
+		reg =3D <0x80000000 0x8000000>; /* 128 MB */
+	};
+
+	ocp {
+		i2c@0 {
+			compatible =3D "i2c-cbus-gpio";
+			gpios =3D <&gpio3 2 0 /* gpio66 clk */
+				 &gpio3 1 0 /* gpio65 dat */
+				 &gpio3 0 0 /* gpio64 sel */
+				>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			retu_mfd: retu@1 {
+				compatible =3D "retu-mfd";
+				interrupt-parent =3D <&gpio4>;
+				interrupts =3D <12 IRQ_TYPE_EDGE_RISING>;
+				reg =3D <0x1>;
+			};
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency =3D <400000>;
+};
+
+&i2c2 {
+	clock-frequency =3D <400000>;
+};
--=20
1.8.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

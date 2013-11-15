From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/11] ARM: dts: Add basic device tree support for omap2430 sdp
Date: Thu, 14 Nov 2013 16:09:48 -0800
Message-ID: <1384474198-20756-2-git-send-email-tony@atomide.com>
References: <1384474198-20756-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42056 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451Ab3KOAKC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Nov 2013 19:10:02 -0500
In-Reply-To: <1384474198-20756-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>

I doubt that there are many people using 2430 sdp, but as
that's been historically an important acid test platform
for omap2+ related changes, let's add minimal device
tree support for it.

If anybody is using it beyond minimal boot testing, patches
for more complete device tree support are welcome.

Cc: devicetree@vger.kernel.org
Cc: "Beno=C3=AEt Cousson" <bcousson@baylibre.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/Makefile         |  1 +
 arch/arm/boot/dts/omap2430-sdp.dts | 49 ++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap2430-sdp.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d57c1a6..73022b1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -173,6 +173,7 @@ dtb-$(CONFIG_ARCH_NSPIRE) +=3D nspire-cx.dtb \
 	nspire-tp.dtb \
 	nspire-clp.dtb
 dtb-$(CONFIG_ARCH_OMAP2PLUS) +=3D omap2420-h4.dtb \
+	omap2430-sdp.dtb \
 	omap3430-sdp.dtb \
 	omap3-beagle.dtb \
 	omap3-devkit8000.dtb \
diff --git a/arch/arm/boot/dts/omap2430-sdp.dts b/arch/arm/boot/dts/oma=
p2430-sdp.dts
new file mode 100644
index 0000000..2c90d29
--- /dev/null
+++ b/arch/arm/boot/dts/omap2430-sdp.dts
@@ -0,0 +1,49 @@
+/*
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.c=
om/
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "omap2430.dtsi"
+
+/ {
+	model =3D "TI OMAP2430 SDP";
+	compatible =3D "ti,omap2430-sdp", "ti,omap2430", "ti,omap2";
+
+	memory {
+		device_type =3D "memory";
+		reg =3D <0x80000000 0x8000000>; /* 128 MB */
+	};
+};
+
+&i2c2 {
+	clock-frequency =3D <100000>;
+
+	twl: twl@48 {
+		reg =3D <0x48>;
+		interrupts =3D <7>; /* SYS_NIRQ cascaded to intc */
+	};
+};
+
+#include "twl4030.dtsi"
+
+&mmc1 {
+	vmmc-supply =3D <&vmmc1>;
+	bus-width =3D <4>;
+};
+
+&gpmc {
+	ranges =3D <5 0 0x08000000 0x01000000>;
+	ethernet@gpmc {
+		compatible =3D "smsc,lan91c94";
+		interrupt-parent =3D <&gpio5>;
+		interrupts =3D <21 IRQ_TYPE_LEVEL_LOW>;	/* gpio149 */
+		reg =3D <5 0x300 0xf>;
+		bank-width =3D <2>;
+		gpmc,mux-add-data;
+        };
+};
+
--=20
1.8.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

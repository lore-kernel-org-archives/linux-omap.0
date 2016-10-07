From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 6/7] ARM: dts: am57xx-idk: Add Industrial input support
Date: Fri, 7 Oct 2016 09:44:27 -0500
Message-ID: <20161007144428.16671-6-afd@ti.com>
References: <20161007144428.16671-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161007144428.16671-1-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The SN65HVS882 is available on both the AM572x and AM571x IDKs and is
attached to SPI1. Input is attached to the I/O header. The load trigger
is attached to GPIO3_19 on the AM572x IDK.

Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am572x-idk.dts         |  4 ++++
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index 87bbc66..27d9149 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -83,3 +83,7 @@
 	bus-width = <4>;
 	cd-gpios = <&gpio6 27 0>; /* gpio 219 */
 };
+
+&sn65hvs882 {
+	load-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 03cec62..438076e 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -253,6 +253,21 @@
 	};
 };
 
+&mcspi3 {
+	status = "okay";
+	ti,pindir-d0-out-d1-in;
+
+	sn65hvs882: sn65hvs882@0 {
+		compatible = "pisosr-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		spi-cpol;
+	};
+};
+
 &uart3 {
 	status = "okay";
 	interrupts-extended = <&crossbar_mpu GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH
-- 
2.10.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

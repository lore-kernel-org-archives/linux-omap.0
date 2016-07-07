From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Subject: [RFC] [PATCH v3 4/4] ARM: dts: am335x-icev2: Add SPI based NOR
Date: Thu,  7 Jul 2016 12:17:51 -0500
Message-ID: <1467911871-4508-5-git-send-email-fcooper@ti.com>
References: <1467911871-4508-1-git-send-email-fcooper@ti.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467911871-4508-1-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
Cc: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Enable support for W25Q64CVSSIG which is a Winbond 64 Mbit SPI NOR.

At boot you will see the following message:
m25p80 spi1.0: found s25fl064k, expected w25q64

This is because the JEDEC ID for this chip is the same as s25fl064k.
However, this should be harmless since both chips are essentially the
same.

Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am335x-icev2.dts | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index e271013..e4d2d13 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -208,6 +208,45 @@
 	};
 };
 
+&spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins_default>;
+
+	spi_nor: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "winbond,w25q64", "jedec,spi-nor";
+		spi-max-frequency = <80000000>;
+		m25p,fast-read;
+		reg = <0>;
+
+		partition@0 {
+			label = "u-boot-spl";
+			reg = <0x0 0x80000>;
+			read-only;
+		};
+
+		partition@1 {
+			label = "u-boot";
+			reg = <0x80000 0x100000>;
+			read-only;
+		};
+
+		partition@2 {
+			label = "u-boot-env";
+			reg = <0x180000 0x20000>;
+			read-only;
+		};
+
+		partition@3 {
+			label = "misc";
+			reg = <0x1A0000 0x660000>;
+		};
+	};
+
+};
+
 #include "tps65910.dtsi"
 
 &tps {
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

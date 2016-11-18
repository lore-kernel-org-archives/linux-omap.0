From: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC 4/6] ARM: dts: dra7: add entry for bb2d module
Date: Thu, 17 Nov 2016 20:44:34 -0600
Message-ID: <20161118024436.13447-4-robertcnelson@gmail.com>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161118024436.13447-1-robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Gowtham Tammana <g-tammana-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Gowtham Tammana <g-tammana-l0cyMroinI0@public.gmane.org>

BB2D entry is added to the dts file. Crossbar index number is used
for interrupt mapping.

Signed-off-by: Gowtham Tammana <g-tammana-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index addb753..43488b6 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -959,6 +959,16 @@
 			ti,hwmods = "dmm";
 		};
 
+		bb2d: bb2d@59000000 {
+			compatible = "ti,dra7-bb2d";
+			reg = <0x59000000 0x0700>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "bb2d";
+			clocks = <&dpll_core_h24x2_ck>;
+			clock-names = "fclk";
+			status = "disabled";
+		};
+
 		i2c1: i2c@48070000 {
 			compatible = "ti,omap4-i2c";
 			reg = <0x48070000 0x100>;
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

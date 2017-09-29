From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 6/7] ARM: dts: Configure SmartReflex only to idle the interconnect target module
Date: Fri, 29 Sep 2017 15:34:10 -0700
Message-ID: <20170929223411.9691-7-tony@atomide.com>
References: <20170929223411.9691-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170929223411.9691-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The TRM has marked dra7 SmartReflex as reserved and we should not
touch those registers as pointed out by Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>.
We do still want to idle the related interconnect target modules on
init though.

Let's do this by only configuring the generic interconnect target modules
and not add the child SmartReflex devices.

Cc: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1497,6 +1497,32 @@
 			};
 		};
 
+		target-module@4a0dd000 {
+			compatible = "ti,sysc-omap4-sr";
+			ti,hwmods = "smartreflex_core";
+			reg = <0x4a0dd000 0x4>,
+			      <0x4a0dd008 0x4>;
+			reg-names = "rev", "sysc";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x4a0dd000 0x001000>;
+
+			/* SmartReflex child device marked reserved in TRM */
+		};
+
+		target-module@4a0d9000 {
+			compatible = "ti,sysc-omap4-sr";
+			ti,hwmods = "smartreflex_mpu";
+			reg = <0x4a0d9000 0x4>,
+			      <0x4a0d9008 0x4>;
+			reg-names = "rev", "sysc";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x4a0d9000 0x001000>;
+
+			/* SmartReflex child device marked reserved in TRM */
+		};
+
 		omap_dwc3_1: omap_dwc3_1@48880000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss1";
-- 
2.14.2
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 3/5] ARM: dts: am43xx: Add stdout-path property
Date: Wed, 18 Jan 2017 09:33:24 +0530
Message-ID: <20170118040326.29259-4-lokeshvutla@ti.com>
References: <20170118040326.29259-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170118040326.29259-1-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add stdout-path property in /chosen node so that earlycon can be
used by just adding earlycon in bootargs.

Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am437x-gp-evm.dts  | 4 ++++
 arch/arm/boot/dts/am437x-idk-evm.dts | 4 ++++
 arch/arm/boot/dts/am437x-sk-evm.dts  | 4 ++++
 arch/arm/boot/dts/am43x-epos-evm.dts | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 957840cc7b78..a4f31739057f 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -23,6 +23,10 @@
 		display0 = &lcd0;
 	};
 
+	chosen {
+		stdout-path = &uart0;
+	};
+
 	evm_v3_3d: fixedregulator-v3_3d {
 		compatible = "regulator-fixed";
 		regulator-name = "evm_v3_3d";
diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
index b76a7c0264a5..c1f7f9336e64 100644
--- a/arch/arm/boot/dts/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/am437x-idk-evm.dts
@@ -18,6 +18,10 @@
 	model = "TI AM437x Industrial Development Kit";
 	compatible = "ti,am437x-idk-evm","ti,am4372","ti,am43";
 
+	chosen {
+		stdout-path = &uart0;
+	};
+
 	v24_0d: fixed-regulator-v24_0d {
 		compatible = "regulator-fixed";
 		regulator-name = "V24_0D";
diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 319d94205350..4dc54bee2f36 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -24,6 +24,10 @@
 		display0 = &lcd0;
 	};
 
+	chosen {
+		stdout-path = &uart0;
+	};
+
 	/* fixed 32k external oscillator clock */
 	clk_32k_rtc: clk_32k_rtc {
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 9d35c3f07cad..9acd4ccdec4e 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -24,6 +24,10 @@
 		display0 = &lcd0;
 	};
 
+	chosen {
+		stdout-path = &uart0;
+	};
+
 	vmmcsd_fixed: fixedregulator-sd {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmcsd_fixed";
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 5/5] ARM: dts: dra7xx: Add stdout-path property
Date: Wed, 18 Jan 2017 09:33:26 +0530
Message-ID: <20170118040326.29259-6-lokeshvutla@ti.com>
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

Tested-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7-evm.dts          | 4 ++++
 arch/arm/boot/dts/dra72-evm-common.dtsi | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 132f2be10889..b3923c049edb 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -21,6 +21,10 @@
 		reg = <0x0 0x80000000 0x0 0x60000000>; /* 1536 MB */
 	};
 
+	chosen {
+		stdout-path = &uart1;
+	};
+
 	evm_3v3_sd: fixedregulator-sd {
 		compatible = "regulator-fixed";
 		regulator-name = "evm_3v3_sd";
diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index e50fbeea96e0..45b62138cbde 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -18,6 +18,10 @@
 		display0 = &hdmi0;
 	};
 
+	chosen {
+		stdout-path = &uart1;
+	};
+
 	evm_12v0: fixedregulator-evm12v0 {
 		/* main supply */
 		compatible = "regulator-fixed";
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

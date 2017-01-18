From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 4/5] ARM: dts: am57xx: Add stdout-path property
Date: Wed, 18 Jan 2017 09:33:25 +0530
Message-ID: <20170118040326.29259-5-lokeshvutla@ti.com>
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
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 4 ++++
 arch/arm/boot/dts/am57xx-idk-common.dtsi        | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index 78bee26361f1..3a95db7da71f 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -22,6 +22,10 @@
 		display0 = &hdmi0;
 	};
 
+	chosen {
+		stdout-path = &uart3;
+	};
+
 	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x80000000>;
diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 814a720d5c3d..0d341c545b01 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -14,6 +14,10 @@
 		rtc1 = &rtc;
 	};
 
+	chosen {
+		stdout-path = &uart3;
+	};
+
 	vmain: fixedregulator-vmain {
 		compatible = "regulator-fixed";
 		regulator-name = "VMAIN";
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

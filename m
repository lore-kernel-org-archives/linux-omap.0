From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 2/5] ARM: dts: am33xx: Add stdout-path property
Date: Wed, 18 Jan 2017 09:33:23 +0530
Message-ID: <20170118040326.29259-3-lokeshvutla@ti.com>
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
 arch/arm/boot/dts/am335x-evm.dts   | 4 ++++
 arch/arm/boot/dts/am335x-evmsk.dts | 4 ++++
 arch/arm/boot/dts/am335x-icev2.dts | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index c2186ec2834b..1c37a7c1ea17 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -25,6 +25,10 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
+	chosen {
+		stdout-path = &uart0;
+	};
+
 	vbat: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vbat";
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index e2548d1ce753..9e43c443738a 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -32,6 +32,10 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
+	chosen {
+		stdout-path = &uart0;
+	};
+
 	vbat: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vbat";
diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index 1463df3b5b19..ff9417ce93c0 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -24,6 +24,10 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
+	chosen {
+		stdout-path = &uart3;
+	};
+
 	vbat: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vbat";
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 3/3] ARM: omap: pass minimal SoC/board data for UART from dt
Date: Wed, 16 Nov 2011 16:32:26 +0530
Message-ID: <1321441346-19591-4-git-send-email-rnayak@ti.com>
References: <1321441346-19591-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1321441346-19591-1-git-send-email-rnayak@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: tony@atomide.com, khilman@ti.com, govindraj.raja@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Pass minimal data needed for console boot, from dt, for
OMAP4 panda/sdp and OMAP3 beagle boards, and get rid of the
static initialization from generic board file.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/boot/dts/omap3-beagle.dts  |   17 +++++++++++++++++
 arch/arm/boot/dts/omap3.dtsi        |   27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4-panda.dts   |   17 +++++++++++++++++
 arch/arm/boot/dts/omap4-sdp.dts     |   17 +++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi        |   24 ++++++++++++++++++++++++
 arch/arm/mach-omap2/board-generic.c |    1 -
 6 files changed, 102 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 9486be6..4c8f11e 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -27,3 +27,20 @@
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
 };
+
+&uart1 {
+	clock-frequency = <48000000>;
+};
+
+&uart2 {
+	clock-frequency = <48000000>;
+};
+
+&uart3 {
+	ti,console_hwmod;
+	clock-frequency = <48000000>;
+};
+
+&uart4 {
+	clock-frequency = <48000000>;
+};
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index d202bb5..ea591c5 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -13,6 +13,13 @@
 / {
 	compatible = "ti,omap3430", "ti,omap3";
 
+	aliases {
+		uart1 = &uart1;
+		uart2 = &uart2;
+		uart3 = &uart3;
+		uart4 = &uart4;
+	};
+
 	cpus {
 		cpu@0 {
 			compatible = "arm,cortex-a8";
@@ -59,5 +66,25 @@
 			interrupt-controller;
 			#interrupt-cells = <1>;
 		};
+
+		uart1: uart@1 {
+			compatible = "ti,omap-uart";
+			ti,hwmods = "uart1";
+		};
+
+		uart2: uart@2 {
+			compatible = "ti,omap-uart";
+			ti,hwmods = "uart2";
+		};
+
+		uart3: uart@3 {
+			compatible = "ti,omap-uart";
+			ti,hwmods = "uart3";
+		};
+
+		uart4: uart@4 {
+			compatible = "ti,omap-uart";
+			ti,hwmods = "uart4";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index c702657..aa65449 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -27,3 +27,20 @@
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
 };
+
+&uart1 {
+	clock-frequency = <48000000>;
+};
+
+&uart2 {
+	clock-frequency = <48000000>;
+};
+
+&uart3 {
+	ti,console_hwmod;
+	clock-frequency = <48000000>;
+};
+
+&uart4 {
+	clock-frequency = <48000000>;
+};
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 066e28c..524f5bf 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -27,3 +27,20 @@
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
 };
+
+&uart1 {
+	clock-frequency = <48000000>;
+};
+
+&uart2 {
+	clock-frequency = <48000000>;
+};
+
+&uart3 {
+	ti,console_hwmod;
+	clock-frequency = <48000000>;
+};
+
+&uart4 {
+	clock-frequency = <48000000>;
+};
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 4c61c82..2378d1e 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -21,6 +21,10 @@
 	interrupt-parent = <&gic>;
 
 	aliases {
+		uart1 = &uart1;
+		uart2 = &uart2;
+		uart3 = &uart3;
+		uart4 = &uart4;
 	};
 
 	cpus {
@@ -99,5 +103,25 @@
 			reg = <0x48241000 0x1000>,
 			      <0x48240100 0x0100>;
 		};
+
+		uart1: uart@1 {
+			compatible = "ti,omap-uart";
+			ti,hwmods = "uart1";
+		};
+
+		uart2: uart@2 {
+			compatible = "ti,omap-uart";
+			ti,hwmods = "uart2";
+		};
+
+		uart3: uart@3 {
+			compatible = "ti,omap-uart";
+			ti,hwmods = "uart3";
+		};
+
+		uart4: uart@4 {
+			compatible = "ti,omap-uart";
+			ti,hwmods = "uart4";
+		};
 	};
 };
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index fb55fa3..bb72809 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -70,7 +70,6 @@ static void __init omap_generic_init(void)
 	if (node)
 		irq_domain_add_simple(node, 0);
 
-	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
 
 	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
-- 
1.7.1


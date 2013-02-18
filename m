From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH, RFC 7/8] ARM: dts: am4372: initial support
Date: Mon, 18 Feb 2013 17:08:16 +0530
Message-ID: <c9c131c0508b875c0893e8557504372a1564568a.1361186097.git.afzal@ti.com>
References: <cover.1361186097.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1361186097.git.afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Marc Zyngier <marc.zyngier@arm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Will Deacon <will.deacon@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Sekhar Nori <nsekhar@ti.com>, Syed Mohammed Khasim <khasim@ti.com>
List-Id: linux-omap@vger.kernel.org

DT source (minimal) for AM4372 SoC. Those represented here are the
minimal DT nodes necessary to get kernel booting.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 55 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 arch/arm/boot/dts/am4372.dtsi

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
new file mode 100644
index 0000000..178c41f
--- /dev/null
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -0,0 +1,55 @@
+/*
+ * Device Tree Source for AM4372 SoC
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "ti,am4372", "ti,am43";
+	interrupt-parent = <&gic>;
+
+
+	aliases {
+		serial0 = &uart1;
+	};
+
+	cpus {
+		cpu@0 {
+			compatible = "arm,cortex-a9";
+		};
+	};
+
+	gic: interrupt-controller@48241000 {
+		compatible = "arm,cortex-a9-gic";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0x48241000 0x1000>,
+		      <0x48240100 0x0100>;
+	};
+
+	twd1: local-timer@0x48240600 {
+		compatible = "arm,cortex-a9-twd-timer";
+		reg = <0x48240600 0x20>;
+		interrupts = <1 13 0x304>;
+	};
+
+	ocp {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		uart1: serial@44e09000 {
+			compatible = "ti,am4372-uart","ti,omap2-uart";
+			clock-frequency = <48000000>;
+			reg = <0x44e09000 0x2000>;
+			interrupts = <0 72 0x4>;
+		};
+	};
+};
-- 
1.7.12

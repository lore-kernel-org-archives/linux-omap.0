From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] arm/dts: Add minimal device tree support for omap2420 and
 omap2430
Date: Thu, 15 Dec 2011 13:39:41 -0800
Message-ID: <20111215213940.GW32251@atomide.com>
References: <1323863746-18145-1-git-send-email-rnayak@ti.com>
 <1323863746-18145-5-git-send-email-rnayak@ti.com>
 <20111214192509.GH32251@atomide.com>
 <4EE99923.4030902@ti.com>
 <4EE9C697.4010604@ti.com>
 <20111215211320.GU32251@atomide.com>
 <4EEA6686.3010504@ti.com>
 <20111215213722.GV32251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111215213722.GV32251@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, khilman@ti.com, govindraj.raja@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, robherring2@gmail.com
List-Id: linux-omap@vger.kernel.org

Add minimal device tree support for omap2420 and omap2430

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- /dev/null
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -0,0 +1,67 @@
+/*
+ * Device Tree Source for OMAP2 SoC
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "ti,omap2430", "ti,omap2420", "ti,omap2";
+
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+	};
+
+	cpus {
+		cpu@0 {
+			compatible = "arm,arm1136jf-s";
+		};
+	};
+
+	soc {
+		compatible = "ti,omap-infra";
+		mpu {
+			compatible = "ti,omap2-mpu";
+			ti,hwmods = "mpu";
+		};
+	};
+
+	ocp {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		ti,hwmods = "l3_main";
+
+		intc: interrupt-controller@1 {
+			compatible = "ti,omap2-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		uart1: serial@4806a000 {
+			compatible = "ti,omap2-uart";
+			ti,hwmods = "uart1";
+			clock-frequency = <48000000>;
+		};
+
+		uart2: serial@4806c000 {
+			compatible = "ti,omap2-uart";
+			ti,hwmods = "uart2";
+			clock-frequency = <48000000>;
+		};
+
+		uart3: serial@4806e000 {
+			compatible = "ti,omap2-uart";
+			ti,hwmods = "uart3";
+			clock-frequency = <48000000>;
+		};
+	};
+};

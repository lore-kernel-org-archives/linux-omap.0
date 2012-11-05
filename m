From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: [PATCH 7/8] ARM: dts: AM33XX: Add PWMSS device tree nodes
Date: Mon, 5 Nov 2012 14:42:28 +0530
Message-ID: <1352106749-9437-8-git-send-email-avinashphilip@ti.com>
References: <1352106749-9437-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352106749-9437-1-git-send-email-avinashphilip@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@avionic-design.de, paul@pwsan.com, tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com
Cc: hvaibhav@ti.com, anilkumar@ti.com, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, gururaja.hebbar@ti.com, "Philip, Avinash" <avinashphilip@ti.com>
List-Id: linux-omap@vger.kernel.org

Add PWMSS device tree nodes in relation with ECAP & EHRPWM DT nodes to
AM33XX SoC family. Also populates device tree nodes for ECAP & EHRPWM by
adding necessary properties like pwm-cells, base reg & set disabled as
status.

Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
---
Second version
	- Combined with HWMOD changes & DT bindings.
	- Handling Parent<-> child relation ship for PWM subsystem

:100644 100644 bb31bff... cf5e049... M	arch/arm/boot/dts/am33xx.dtsi
 arch/arm/boot/dts/am33xx.dtsi |   90 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index bb31bff..cf5e049 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -210,5 +210,95 @@
 			interrupt-parent = <&intc>;
 			interrupts = <91>;
 		};
+
+		epwmss0: epwmss@48300000 {
+			compatible = "ti,am33xx-pwmss";
+			reg = <0x48300000 0x10
+				0x48300100 0x80
+				0x48300180 0x80
+				0x48300200 0x80>;
+			ti,hwmods = "epwmss0";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges;
+
+			ecap0: ecap@48300100 {
+				compatible = "ti,am33xx-ecap";
+				#pwm-cells = <3>;
+				reg = <0x48300100 0x80>;
+				ti,hwmods = "ecap0";
+				status = "disabled";
+			};
+
+			ehrpwm0: ehrpwm@48300200 {
+				compatible = "ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x48300200 0x80>;
+				ti,hwmods = "ehrpwm0";
+				status = "disabled";
+				tbclkgating;
+			};
+		};
+
+		epwmss1: epwmss@48302000 {
+			compatible = "ti,am33xx-pwmss";
+			reg = <0x48302000 0x10
+				0x48302100 0x80
+				0x48302180 0x80
+				0x48302200 0x80>;
+			ti,hwmods = "epwmss1";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges;
+
+			ecap1: ecap@48302100 {
+				compatible = "ti,am33xx-ecap";
+				#pwm-cells = <3>;
+				reg = <0x48302100 0x80>;
+				ti,hwmods = "ecap1";
+				status = "disabled";
+			};
+
+			ehrpwm1: ehrpwm@48302200 {
+				compatible = "ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x48302200 0x80>;
+				ti,hwmods = "ehrpwm1";
+				status = "disabled";
+				tbclkgating;
+			};
+		};
+
+		epwmss2: epwmss@48304000 {
+			compatible = "ti,am33xx-pwmss";
+			reg = <0x48304000 0x10
+				0x48304100 0x80
+				0x48304180 0x80
+				0x48304200 0x80>;
+			ti,hwmods = "epwmss2";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges;
+
+			ecap2: ecap@48304100 {
+				compatible = "ti,am33xx-ecap";
+				#pwm-cells = <3>;
+				reg = <0x48304100 0x80>;
+				ti,hwmods = "ecap2";
+				status = "disabled";
+			};
+
+			ehrpwm2: ehrpwm@48304200 {
+				compatible = "ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x48304200 0x80>;
+				ti,hwmods = "ehrpwm2";
+				status = "disabled";
+				tbclkgating;
+			};
+		};
 	};
 };
-- 
1.7.0.4

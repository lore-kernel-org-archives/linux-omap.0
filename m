From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [Patch v4 2/6] ARM: dts: am437x/am33xx: Remove eCAP and ePWM hwmod
 properties
Date: Mon,  7 Mar 2016 14:39:43 -0600
Message-ID: <1457383187-17166-3-git-send-email-fcooper@ti.com>
References: <1457383187-17166-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1457383187-17166-1-git-send-email-fcooper@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vigneshr@ti.com, thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, paul@pwsan.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

ECAP and ePWM do not have OCP integration registers, have L3/L4 ports, etc.
Therefore, they shouldn't be using hwmod at all. Remove their hwmod
properties.

For ePWM add the tbclk to the node rather than depending on hwmod to do so.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 12 ++++++------
 arch/arm/boot/dts/am4372.dtsi | 21 ++++++++++++---------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 82c0976..1dd6c78 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -682,7 +682,6 @@
 				reg = <0x48300100 0x80>;
 				interrupts = <31>;
 				interrupt-names = "ecap0";
-				ti,hwmods = "ecap0";
 				status = "disabled";
 			};
 
@@ -690,7 +689,8 @@
 				compatible = "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48300200 0x80>;
-				ti,hwmods = "ehrpwm0";
+				clocks = <&ehrpwm0_tbclk>;
+				clock-names = "tbclk";
 				status = "disabled";
 			};
 		};
@@ -710,7 +710,6 @@
 				reg = <0x48302100 0x80>;
 				interrupts = <47>;
 				interrupt-names = "ecap1";
-				ti,hwmods = "ecap1";
 				status = "disabled";
 			};
 
@@ -718,7 +717,8 @@
 				compatible = "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48302200 0x80>;
-				ti,hwmods = "ehrpwm1";
+				clocks = <&ehrpwm1_tbclk>;
+				clock-names = "tbclk";
 				status = "disabled";
 			};
 		};
@@ -738,7 +738,6 @@
 				reg = <0x48304100 0x80>;
 				interrupts = <61>;
 				interrupt-names = "ecap2";
-				ti,hwmods = "ecap2";
 				status = "disabled";
 			};
 
@@ -746,7 +745,8 @@
 				compatible = "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48304200 0x80>;
-				ti,hwmods = "ehrpwm2";
+				clocks = <&ehrpwm2_tbclk>;
+				clock-names = "tbclk";
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 33f417c..685c8db 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -675,7 +675,6 @@
 				compatible = "ti,am4372-ecap","ti,am33xx-ecap";
 				#pwm-cells = <3>;
 				reg = <0x48300100 0x80>;
-				ti,hwmods = "ecap0";
 				status = "disabled";
 			};
 
@@ -683,7 +682,8 @@
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48300200 0x80>;
-				ti,hwmods = "ehrpwm0";
+				clocks = <&ehrpwm0_tbclk>;
+				clock-names = "tbclk";
 				status = "disabled";
 			};
 		};
@@ -701,7 +701,6 @@
 				compatible = "ti,am4372-ecap","ti,am33xx-ecap";
 				#pwm-cells = <3>;
 				reg = <0x48302100 0x80>;
-				ti,hwmods = "ecap1";
 				status = "disabled";
 			};
 
@@ -709,7 +708,8 @@
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48302200 0x80>;
-				ti,hwmods = "ehrpwm1";
+				clocks = <&ehrpwm1_tbclk>;
+				clock-names = "tbclk";
 				status = "disabled";
 			};
 		};
@@ -727,7 +727,6 @@
 				compatible = "ti,am4372-ecap","ti,am33xx-ecap";
 				#pwm-cells = <3>;
 				reg = <0x48304100 0x80>;
-				ti,hwmods = "ecap2";
 				status = "disabled";
 			};
 
@@ -735,7 +734,8 @@
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48304200 0x80>;
-				ti,hwmods = "ehrpwm2";
+				clocks = <&ehrpwm2_tbclk>;
+				clock-names = "tbclk";
 				status = "disabled";
 			};
 		};
@@ -753,7 +753,8 @@
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48306200 0x80>;
-				ti,hwmods = "ehrpwm3";
+				clocks = <&ehrpwm3_tbclk>;
+				clock-names = "tbclk";
 				status = "disabled";
 			};
 		};
@@ -771,7 +772,8 @@
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48308200 0x80>;
-				ti,hwmods = "ehrpwm4";
+				clocks = <&ehrpwm4_tbclk>;
+				clock-names = "tbclk";
 				status = "disabled";
 			};
 		};
@@ -789,7 +791,8 @@
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x4830a200 0x80>;
-				ti,hwmods = "ehrpwm5";
+				clocks = <&ehrpwm5_tbclk>;
+				clock-names = "tbclk";
 				status = "disabled";
 			};
 		};
-- 
2.7.0

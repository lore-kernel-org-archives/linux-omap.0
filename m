From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 11/11] arm: boot: dts: omap: add missing default status for 32k counter
Date: Tue, 29 Sep 2015 15:44:06 -0500
Message-ID: <1443559446-26969-12-git-send-email-balbi@ti.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443559446-26969-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, daniel.lezcano@linaro.org, tglx@linutronix.de, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

All devices should have a default status. Ignoring
the arguments if it should be 'okay' or 'disabled'
by default, let's set them all the 'disabled' and
have boards enable 32k counter.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi         | 1 +
 arch/arm/boot/dts/am437x-gp-evm.dts   | 4 ++++
 arch/arm/boot/dts/am437x-idk-evm.dts  | 4 ++++
 arch/arm/boot/dts/am437x-sk-evm.dts   | 4 ++++
 arch/arm/boot/dts/am43x-epos-evm.dts  | 4 ++++
 arch/arm/boot/dts/dra7.dtsi           | 1 +
 arch/arm/boot/dts/omap2420-h4.dts     | 4 ++++
 arch/arm/boot/dts/omap2420.dtsi       | 1 +
 arch/arm/boot/dts/omap2430.dtsi       | 1 +
 arch/arm/boot/dts/omap3-beagle-xm.dts | 4 ++++
 arch/arm/boot/dts/omap3-beagle.dts    | 4 ++++
 arch/arm/boot/dts/omap3-ldp.dts       | 4 ++++
 arch/arm/boot/dts/omap3-n900.dts      | 4 ++++
 arch/arm/boot/dts/omap3.dtsi          | 1 +
 arch/arm/boot/dts/omap3430-sdp.dts    | 4 ++++
 arch/arm/boot/dts/omap4-sdp.dts       | 4 ++++
 arch/arm/boot/dts/omap4.dtsi          | 1 +
 arch/arm/boot/dts/omap5-cm-t54.dts    | 4 ++++
 arch/arm/boot/dts/omap5-uevm.dts      | 4 ++++
 arch/arm/boot/dts/omap5.dtsi          | 1 +
 20 files changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 0447c04a40cc..0a3e0a82ea96 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -349,6 +349,7 @@
 			compatible = "ti,am4372-counter32k","ti,omap-counter32k";
 			reg = <0x44e86000 0x40>;
 			ti,hwmods = "counter_32k";
+			status = "disabled";
 		};
 
 		rtc: rtc@44e3e000 {
diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 22038f21f228..f4b6cb6efde3 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -954,3 +954,7 @@
 	clock-names = "ext-clk", "int-clk";
 	status = "okay";
 };
+
+&counter32k {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
index af25801418b4..17c429d4e136 100644
--- a/arch/arm/boot/dts/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/am437x-idk-evm.dts
@@ -413,3 +413,7 @@
 &cpu {
 	cpu0-supply = <&tps>;
 };
+
+&counter32k {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 7da7c2da4af1..f0d9d26e644e 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -734,3 +734,7 @@
 		};
 	};
 };
+
+&counter32k {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 86c2dfbe8875..9a0cd866e3ab 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -792,3 +792,7 @@
 	tx-num-evt = <32>;
 	rx-num-evt = <32>;
 };
+
+&counter32k {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 5d65db9ebc2b..a6f2072b6c46 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -193,6 +193,7 @@
 				compatible = "ti,omap-counter32k";
 				reg = <0x4000 0x40>;
 				ti,hwmods = "counter_32k";
+				status = "disabled";
 			};
 
 			prm: prm@6000 {
diff --git a/arch/arm/boot/dts/omap2420-h4.dts b/arch/arm/boot/dts/omap2420-h4.dts
index 34cdecb4fdda..f41d95836dcf 100644
--- a/arch/arm/boot/dts/omap2420-h4.dts
+++ b/arch/arm/boot/dts/omap2420-h4.dts
@@ -64,3 +64,7 @@
 		};
 	};
 };
+
+&counter32k {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index 5b9a376cc31e..abef0670e7e6 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -70,6 +70,7 @@
 				compatible = "ti,omap-counter32k";
 				reg = <0x4000 0x20>;
 				ti,hwmods = "counter_32k";
+				status = "disabled";
 			};
 		};
 
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index 2390f387c271..f501b6f355a4 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -82,6 +82,7 @@
 				compatible = "ti,omap-counter32k";
 				reg = <0x20000 0x20>;
 				ti,hwmods = "counter_32k";
+				status = "disabled";
 			};
 		};
 
diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 7c4dca122a91..47a354f22363 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -390,3 +390,7 @@
 		};
 	};
 };
+
+&counter32k {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index a5474113cd50..3a50baa56399 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -429,3 +429,7 @@
 		};
 	};
 };
+
+&counter32k {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index bd6e6769c7ce..58ef3e86c31f 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -302,3 +302,7 @@
 	/* Needed for ads7846 */
         regulator-name = "vcc";
 };
+
+&counter32k {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 5f5e0f3d5b64..0f9405ef4dc7 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -988,3 +988,7 @@
 &ssi_port2 {
 	status = "disabled";
 };
+
+&counter32k {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 69a40cfc1f29..1bc8fb05d4bd 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -181,6 +181,7 @@
 			compatible = "ti,omap-counter32k";
 			reg = <0x48320000 0x20>;
 			ti,hwmods = "counter_32k";
+			status = "disabled";
 		};
 
 		intc: interrupt-controller@48200000 {
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
index 16b0cdfbee9c..8344e1d01ac6 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -191,3 +191,7 @@
 		};
 	};
 };
+
+&counter32k {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index dac86ed7481f..d54ee6605af0 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -697,3 +697,7 @@
 		};
 	};
 };
+
+&counter32k {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index abc4473e6f8a..76371eb9fa02 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -220,6 +220,7 @@
 					compatible = "ti,omap-counter32k";
 					reg = <0x4000 0x20>;
 					ti,hwmods = "counter_32k";
+					status = "disabled";
 				};
 
 				prm: prm@6000 {
diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index 61ad2ea34720..d88f9bf1ce28 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -677,3 +677,7 @@
 		};
 	};
 };
+
+&counter32k {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 3cc8f357d5b8..ecf8db4ea64b 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -641,3 +641,7 @@
 		};
 	};
 };
+
+&counter32k {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 4205a8ac9ddb..aa8216a5bf4f 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -236,6 +236,7 @@
 				compatible = "ti,omap-counter32k";
 				reg = <0x4000 0x40>;
 				ti,hwmods = "counter_32k";
+				status = "disabled";
 			};
 
 			prm: prm@6000 {
-- 
2.5.3

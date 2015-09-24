From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 03/17] ARM: dts: omap3: add reset data
Date: Thu, 24 Sep 2015 17:26:44 +0300
Message-ID: <1443104818-993-4-git-send-email-t-kristo@ti.com>
References: <1443104818-993-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1443104818-993-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, s-anna@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Copy over the reset data from hwmod database to DT. After this is taken
into use, the data in hwmod database can be removed.

A new node has been also added for sad2d to support sad2d resets.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 69a40cf..5be9aaa 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -64,11 +64,23 @@
 		iva: iva {
 			compatible = "ti,iva2.2";
 			ti,hwmods = "iva";
+			reset-names = "logic", "seq0", "seq1";
+			resets = <&prm 0x0000 0 0 0 8>,
+				 <&prm 0x0000 0 1 0 9>,
+				 <&prm 0x0000 0 2 0 10>;
 
 			dsp {
 				compatible = "ti,omap3-c64";
 			};
 		};
+
+		sad2d: sad2d {
+			compatible = "ti,sad2d";
+			ti,hwmods = "sad2d";
+			reset-names = "rst_modem_sw", "rst_modem_pwron_sw";
+			resets = <&prm 0x0a00 0 0 0 8>,
+				 <&prm 0x0a00 0 1 0 9>;
+		};
 	};
 
 	/*
@@ -154,6 +166,7 @@
 			compatible = "ti,omap3-prm";
 			reg = <0x48306000 0x4000>;
 			interrupts = <11>;
+			#reset-cells = <5>;
 
 			prm_clocks: clocks {
 				#address-cells = <1>;
@@ -162,6 +175,12 @@
 
 			prm_clockdomains: clockdomains {
 			};
+
+			system_reset: system_reset {
+				compatible = "ti,system-reset";
+				reset-names = "system";
+				resets = <&prm 0x1200 0 2 0 0>;
+			};
 		};
 
 		cm: cm@48004000 {
@@ -471,6 +490,8 @@
 			interrupts = <28>;
 			ti,hwmods = "mmu_iva";
 			status = "disabled";
+			reset-names = "mmu";
+			resets = <&prm 0x0000 0 1 0 9>;
 		};
 
 		wdt2: wdt@48314000 {
-- 
1.7.9.5

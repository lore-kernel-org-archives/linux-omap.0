From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 04/17] ARM: dts: omap4: add reset data
Date: Thu, 24 Sep 2015 17:26:45 +0300
Message-ID: <1443104818-993-5-git-send-email-t-kristo@ti.com>
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

A new node has been also added for ipu to support ipu resets.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index abc4473..d14c485 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -97,11 +97,25 @@
 		dsp {
 			compatible = "ti,omap3-c64";
 			ti,hwmods = "dsp";
+			reset-names = "dsp";
+			resets = <&prm 0x0400 0x10 0 0x14 0>;
 		};
 
 		iva {
 			compatible = "ti,ivahd";
 			ti,hwmods = "iva";
+			reset-names = "seq0", "seq1", "logic";
+			resets = <&prm 0x0f00 0x10 0 0x14 0>,
+				 <&prm 0x0f00 0x10 1 0x14 1>,
+				 <&prm 0x0f00 0x10 2 0x14 2>;
+		};
+
+		ipu {
+			compatible = "ti,omap4-ipu";
+			ti,hwmods = "ipu";
+			reset-names = "cpu0", "cpu1";
+			resets = <&prm 0x0700 0x210 0 0x214 0>,
+				 <&prm 0x0700 0x210 1 0x214 1>;
 		};
 	};
 
@@ -226,6 +240,7 @@
 					compatible = "ti,omap4-prm";
 					reg = <0x6000 0x3000>;
 					interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+					#reset-cells = <5>;
 
 					prm_clocks: clocks {
 						#address-cells = <1>;
@@ -234,6 +249,14 @@
 
 					prm_clockdomains: clockdomains {
 					};
+
+					system_reset: system_reset {
+						compatible = "ti,system-reset";
+						reset-names = "system",
+							      "cold_sw";
+						resets = <&prm 0x1b00 0 0 4 0>,
+							 <&prm 0x1b00 0 1 4 1>;
+					};
 				};
 
 				scrm: scrm@a000 {
@@ -553,6 +576,8 @@
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmu_dsp";
 			#iommu-cells = <0>;
+			reset-names = "mmu_cache";
+			resets = <&prm 0x400 0x10 1 0x14 1>;
 		};
 
 		mmu_ipu: mmu@55082000 {
@@ -562,6 +587,8 @@
 			ti,hwmods = "mmu_ipu";
 			#iommu-cells = <0>;
 			ti,iommu-bus-err-back;
+			reset-names = "mmu_cache";
+			resets = <&prm 0x700 0x210 2 0x214 2>;
 		};
 
 		wdt2: wdt@4a314000 {
-- 
1.7.9.5

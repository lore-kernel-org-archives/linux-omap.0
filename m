From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 08/10] ARM: dts: dra74x: convert IOMMUs to use ti-sysc
Date: Wed, 28 Aug 2019 10:56:42 +0300
Message-ID: <20190828075644.4493-9-t-kristo@ti.com>
References: <20190828075644.4493-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190828075644.4493-1-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Convert dra74x IOMMUs to use ti-sysc instead of legacy omap-hwmod based
implementation. Enable the IOMMUs also while doing this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/dra74x.dtsi | 71 +++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index d1b5b76bc5a8..c5abc436ca1f 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -66,24 +66,63 @@
 			};
 		};
 
-		mmu0_dsp2: mmu@41501000 {
-			compatible = "ti,dra7-dsp-iommu";
-			reg = <0x41501000 0x100>;
-			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "mmu0_dsp2";
-			#iommu-cells = <0>;
-			ti,syscon-mmuconfig = <&dsp2_system 0x0>;
-			status = "disabled";
+		target-module@41501000 {
+			compatible = "ti,sysc-omap2", "ti,sysc";
+			reg = <0x41501000 0x4>,
+			      <0x41501010 0x4>,
+			      <0x41501014 0x4>;
+			reg-names = "rev", "sysc", "syss";
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
+					 SYSC_OMAP2_SOFTRESET |
+					 SYSC_OMAP2_AUTOIDLE)>;
+			clocks = <&dsp2_clkctrl DRA7_DSP2_MMU0_DSP2_CLKCTRL 0>;
+			clock-names = "fck";
+			resets = <&prm_dsp2 1>;
+			reset-names = "rstctrl";
+			ranges = <0x0 0x41501000 0x1000>;
+			#size-cells = <1>;
+			#address-cells = <1>;
+
+			mmu0_dsp2: mmu@0 {
+				compatible = "ti,dra7-dsp-iommu";
+				reg = <0x0 0x100>;
+				interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+				#iommu-cells = <0>;
+				ti,syscon-mmuconfig = <&dsp2_system 0x0>;
+			};
 		};
 
-		mmu1_dsp2: mmu@41502000 {
-			compatible = "ti,dra7-dsp-iommu";
-			reg = <0x41502000 0x100>;
-			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "mmu1_dsp2";
-			#iommu-cells = <0>;
-			ti,syscon-mmuconfig = <&dsp2_system 0x1>;
-			status = "disabled";
+		target-module@41502000 {
+			compatible = "ti,sysc-omap2", "ti,sysc";
+			reg = <0x41502000 0x4>,
+			      <0x41502010 0x4>,
+			      <0x41502014 0x4>;
+			reg-names = "rev", "sysc", "syss";
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
+					 SYSC_OMAP2_SOFTRESET |
+					 SYSC_OMAP2_AUTOIDLE)>;
+
+			clocks = <&dsp2_clkctrl DRA7_DSP2_MMU0_DSP2_CLKCTRL 0>;
+			clock-names = "fck";
+			resets = <&prm_dsp2 1>;
+			reset-names = "rstctrl";
+			ranges = <0x0 0x41502000 0x1000>;
+			#size-cells = <1>;
+			#address-cells = <1>;
+
+			mmu1_dsp2: mmu@0 {
+				compatible = "ti,dra7-dsp-iommu";
+				reg = <0x0 0x100>;
+				interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+				#iommu-cells = <0>;
+				ti,syscon-mmuconfig = <&dsp2_system 0x1>;
+			};
 		};
 	};
 };
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

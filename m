From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 07/10] ARM: dts: dra7: convert IOMMUs to use ti-sysc
Date: Wed, 28 Aug 2019 10:56:41 +0300
Message-ID: <20190828075644.4493-8-t-kristo@ti.com>
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

Convert dra7 IOMMUs to use ti-sysc instead of legacy omap-hwmod based
implementation. Enable the IOMMUs also while doing this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 140 +++++++++++++++++++++++++++---------
 1 file changed, 108 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 95147289be9c..98c01f204a1a 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -377,44 +377,120 @@
 			ti,hwmods = "dmm";
 		};
 
-		mmu0_dsp1: mmu@40d01000 {
-			compatible = "ti,dra7-dsp-iommu";
-			reg = <0x40d01000 0x100>;
-			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "mmu0_dsp1";
-			#iommu-cells = <0>;
-			ti,syscon-mmuconfig = <&dsp1_system 0x0>;
-			status = "disabled";
+		target-module@40d01000 {
+			compatible = "ti,sysc-omap2", "ti,sysc";
+			reg = <0x40d01000 0x4>,
+			      <0x40d01010 0x4>,
+			      <0x40d01014 0x4>;
+			reg-names = "rev", "sysc", "syss";
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
+					 SYSC_OMAP2_SOFTRESET |
+					 SYSC_OMAP2_AUTOIDLE)>;
+			clocks = <&dsp1_clkctrl DRA7_DSP1_MMU0_DSP1_CLKCTRL 0>;
+			clock-names = "fck";
+			resets = <&prm_dsp1 1>;
+			reset-names = "rstctrl";
+			ranges = <0x0 0x40d01000 0x1000>;
+			#size-cells = <1>;
+			#address-cells = <1>;
+
+			mmu0_dsp1: mmu@0 {
+				compatible = "ti,dra7-dsp-iommu";
+				reg = <0x0 0x100>;
+				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+				#iommu-cells = <0>;
+				ti,syscon-mmuconfig = <&dsp1_system 0x0>;
+			};
 		};
 
-		mmu1_dsp1: mmu@40d02000 {
-			compatible = "ti,dra7-dsp-iommu";
-			reg = <0x40d02000 0x100>;
-			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "mmu1_dsp1";
-			#iommu-cells = <0>;
-			ti,syscon-mmuconfig = <&dsp1_system 0x1>;
-			status = "disabled";
+		target-module@40d02000 {
+			compatible = "ti,sysc-omap2", "ti,sysc";
+			reg = <0x40d02000 0x4>,
+			      <0x40d02010 0x4>,
+			      <0x40d02014 0x4>;
+			reg-names = "rev", "sysc", "syss";
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
+					 SYSC_OMAP2_SOFTRESET |
+					 SYSC_OMAP2_AUTOIDLE)>;
+			clocks = <&dsp1_clkctrl DRA7_DSP1_MMU0_DSP1_CLKCTRL 0>;
+			clock-names = "fck";
+			resets = <&prm_dsp1 1>;
+			reset-names = "rstctrl";
+			ranges = <0x0 0x40d02000 0x1000>;
+			#size-cells = <1>;
+			#address-cells = <1>;
+
+			mmu1_dsp1: mmu@0 {
+				compatible = "ti,dra7-dsp-iommu";
+				reg = <0x0 0x100>;
+				interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+				#iommu-cells = <0>;
+				ti,syscon-mmuconfig = <&dsp1_system 0x1>;
+			};
 		};
 
-		mmu_ipu1: mmu@58882000 {
-			compatible = "ti,dra7-iommu";
-			reg = <0x58882000 0x100>;
-			interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "mmu_ipu1";
-			#iommu-cells = <0>;
-			ti,iommu-bus-err-back;
-			status = "disabled";
+		target-module@58882000 {
+			compatible = "ti,sysc-omap2", "ti,sysc";
+			reg = <0x58882000 0x4>,
+			      <0x58882010 0x4>,
+			      <0x58882014 0x4>;
+			reg-names = "rev", "sysc", "syss";
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
+					 SYSC_OMAP2_SOFTRESET |
+					 SYSC_OMAP2_AUTOIDLE)>;
+			clocks = <&ipu1_clkctrl DRA7_IPU1_MMU_IPU1_CLKCTRL 0>;
+			clock-names = "fck";
+			resets = <&prm_ipu 2>;
+			reset-names = "rstctrl";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x58882000 0x100>;
+
+			mmu_ipu1: mmu@0 {
+				compatible = "ti,dra7-iommu";
+				reg = <0x0 0x100>;
+				interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>;
+				#iommu-cells = <0>;
+				ti,iommu-bus-err-back;
+			};
 		};
 
-		mmu_ipu2: mmu@55082000 {
-			compatible = "ti,dra7-iommu";
-			reg = <0x55082000 0x100>;
-			interrupts = <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "mmu_ipu2";
-			#iommu-cells = <0>;
-			ti,iommu-bus-err-back;
-			status = "disabled";
+		target-module@55082000 {
+			compatible = "ti,sysc-omap2", "ti,sysc";
+			reg = <0x55082000 0x4>,
+			      <0x55082010 0x4>,
+			      <0x55082014 0x4>;
+			reg-names = "rev", "sysc", "syss";
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
+					 SYSC_OMAP2_SOFTRESET |
+					 SYSC_OMAP2_AUTOIDLE)>;
+			clocks = <&ipu2_clkctrl DRA7_IPU2_MMU_IPU2_CLKCTRL 0>;
+			clock-names = "fck";
+			resets = <&prm_core 2>;
+			reset-names = "rstctrl";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x55082000 0x100>;
+
+			mmu_ipu2: mmu@0 {
+				compatible = "ti,dra7-iommu";
+				reg = <0x0 0x100>;
+				interrupts = <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>;
+				#iommu-cells = <0>;
+				ti,iommu-bus-err-back;
+			};
 		};
 
 		abb_mpu: regulator-abb-mpu {
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

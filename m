From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 06/10] ARM: dts: omap5: Add PRM data
Date: Wed, 28 Aug 2019 10:56:40 +0300
Message-ID: <20190828075644.4493-7-t-kristo@ti.com>
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

Add PRM data for OMAP54xx SoC. Initially this is used to provide reset
support, but will be expanded later to support also powerdomain control.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index edfd26c03462..c8bde171a949 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -412,3 +412,33 @@
 
 #include "omap5-l4-abe.dtsi"
 #include "omap54xx-clocks.dtsi"
+
+&prm {
+	prm_dsp: prm@400 {
+		compatible = "ti,omap5-prm-inst";
+		reg = <0x400 0x100>;
+		#reset-cells = <1>;
+		clocks = <&dsp_clkctrl OMAP5_MMU_DSP_CLKCTRL 0>;
+
+	};
+
+	prm_core: prm@700 {
+		compatible = "ti,omap5-prm-inst";
+		reg = <0x700 0x100>;
+		#reset-cells = <1>;
+		clocks = <&ipu_clkctrl OMAP5_MMU_IPU_CLKCTRL 0>;
+	};
+
+	prm_iva: prm@1200 {
+		compatible = "ti,omap5-prm-inst";
+		reg = <0x1200 0x100>;
+		#reset-cells = <1>;
+		clocks = <&iva_clkctrl OMAP5_IVA_CLKCTRL 0>;
+	};
+
+	prm_device: prm@1c00 {
+		compatible = "ti,omap5-prm-inst";
+		reg = <0x1c00 0x100>;
+		#reset-cells = <1>;
+	};
+};
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

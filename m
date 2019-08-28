From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 05/10] ARM: dts: am43xx: Add PRM data
Date: Wed, 28 Aug 2019 10:56:39 +0300
Message-ID: <20190828075644.4493-6-t-kristo@ti.com>
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

Add PRM data for AM43xx SoC. Initially this is used to provide reset
support, but will be expanded later to support also powerdomain control.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 55aff4db9c7c..4bd22c6ba3ff 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -353,3 +353,32 @@
 
 #include "am437x-l4.dtsi"
 #include "am43xx-clocks.dtsi"
+
+&prcm {
+	prm_gfx: prm@400 {
+		compatible = "ti,am4-prm-inst";
+		reg = <0x400 0x100>;
+		#reset-cells = <1>;
+		clocks = <&gfx_l3_clkctrl AM4_GFX_L3_GFX_CLKCTRL 0>;
+	};
+
+	prm_per: prm@800 {
+		compatible = "ti,am4-prm-inst";
+		reg = <0x800 0x100>;
+		#reset-cells = <1>;
+		clocks = <&pruss_ocp_clkctrl AM4_PRUSS_OCP_PRUSS_CLKCTRL 0>;
+	};
+
+	prm_wkup: prm@2000 {
+		compatible = "ti,am4-prm-inst";
+		reg = <0x2000 0x100>;
+		#reset-cells = <1>;
+		clocks = <&l4_wkup_aon_clkctrl AM4_L4_WKUP_AON_WKUP_M3_CLKCTRL 0>;
+	};
+
+	prm_device: prm@4000 {
+		compatible = "ti,am4-prm-inst";
+		reg = <0x4000 0x100>;
+		#reset-cells = <1>;
+	};
+};
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

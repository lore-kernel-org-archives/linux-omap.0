From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 1/5] ARM: dts: dra7: add PRM nodes
Date: Thu, 10 Oct 2019 11:21:04 +0300
Message-ID: <20191010082108.15448-2-t-kristo@ti.com>
References: <20191010082108.15448-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191010082108.15448-1-t-kristo@ti.com>
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

Add PRM nodes for dra7 series of SoCs. These are initially used to
support reset control for some of the nodes, but will be extended
later to add powerdomain control and support for PRCM irqs among
other things.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 55 +++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 953f0ffce2a9..f4c73cca6354 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -763,3 +763,54 @@
 
 #include "dra7-l4.dtsi"
 #include "dra7xx-clocks.dtsi"
+
+&prm {
+	prm_dsp1: prm@400 {
+		compatible = "ti,dra7-prm-inst", "ti,omap-prm-inst";
+		reg = <0x400 0x100>;
+		#reset-cells = <1>;
+	};
+
+	prm_ipu: prm@500 {
+		compatible = "ti,dra7-prm-inst", "ti,omap-prm-inst";
+		reg = <0x500 0x100>;
+		#reset-cells = <1>;
+	};
+
+	prm_core: prm@700 {
+		compatible = "ti,dra7-prm-inst", "ti,omap-prm-inst";
+		reg = <0x700 0x100>;
+		#reset-cells = <1>;
+	};
+
+	prm_iva: prm@f00 {
+		compatible = "ti,dra7-prm-inst", "ti,omap-prm-inst";
+		reg = <0xf00 0x100>;
+	};
+
+	prm_dsp2: prm@1b00 {
+		compatible = "ti,dra7-prm-inst", "ti,omap-prm-inst";
+		reg = <0x1b00 0x40>;
+		#reset-cells = <1>;
+	};
+
+	prm_eve1: prm@1b40 {
+		compatible = "ti,dra7-prm-inst", "ti,omap-prm-inst";
+		reg = <0x1b40 0x40>;
+	};
+
+	prm_eve2: prm@1b80 {
+		compatible = "ti,dra7-prm-inst", "ti,omap-prm-inst";
+		reg = <0x1b80 0x40>;
+	};
+
+	prm_eve3: prm@1bc0 {
+		compatible = "ti,dra7-prm-inst", "ti,omap-prm-inst";
+		reg = <0x1bc0 0x40>;
+	};
+
+	prm_eve4: prm@1c00 {
+		compatible = "ti,dra7-prm-inst", "ti,omap-prm-inst";
+		reg = <0x1c00 0x60>;
+	};
+};
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

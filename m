From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RESEND PATCH 4/8] ARM: dts: dra7xx-clocks: rename pcie clocks to
 accommodate second PHY instance
Date: Mon, 14 Jul 2014 16:12:19 +0530
Message-ID: <1405334543-25509-5-git-send-email-kishon@ti.com>
References: <1405334543-25509-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1405334543-25509-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, tony@atomide.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul@pwsan.com>, Pawel Moll <pawel.moll@arm.com>, Keerthy <j-keerthy@ti.com>, Rajendra Nayak <rnayak@ti.com>, kishon@ti.com, Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

There are two instances of PCIe PHY in DRA7xx. So renamed
optfclk_pciephy_32khz, optfclk_pciephy_clk and optfclk_pciephy_div_clk to
optfclk_pciephy1_32khz, optfclk_pciephy1_clk and optfclk_pciephy1_div_clk
respectively. This is needed for adding the clocks for second PCIe PHY
instance.

Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 3ff6d7c..fe5db55 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1165,7 +1165,7 @@
 		reg = <0x021c>, <0x0220>;
 	};
 
-	optfclk_pciephy_32khz: optfclk_pciephy_32khz@4a0093b0 {
+	optfclk_pciephy1_32khz: optfclk_pciephy1_32khz@4a0093b0 {
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
 		#clock-cells = <0>;
@@ -1183,7 +1183,7 @@
 		ti,max-div = <2>;
 	};
 
-	optfclk_pciephy_clk: optfclk_pciephy_clk@4a0093b0 {
+	optfclk_pciephy1_clk: optfclk_pciephy1_clk@4a0093b0 {
 		compatible = "ti,gate-clock";
 		clocks = <&apll_pcie_ck>;
 		#clock-cells = <0>;
@@ -1191,7 +1191,7 @@
 		ti,bit-shift = <9>;
 	};
 
-	optfclk_pciephy_div_clk: optfclk_pciephy_div_clk@4a0093b0 {
+	optfclk_pciephy1_div_clk: optfclk_pciephy1_div_clk@4a0093b0 {
 		compatible = "ti,gate-clock";
 		clocks = <&optfclk_pciephy_div>;
 		#clock-cells = <0>;
-- 
1.7.9.5

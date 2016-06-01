From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 4/5] ARM: dts: omap5: add fref_xtal_ck support
Date: Wed, 1 Jun 2016 20:35:25 +0300
Message-ID: <1464802526-16372-5-git-send-email-t-kristo@ti.com>
References: <1464802526-16372-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1464802526-16372-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, peter.ujfalusi@ti.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The clock is directly sourced from sys_clkin, and provides an external
output clock for (typically) TWL6040 chip.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap54xx-clocks.dtsi | 10 ++++++++++
 drivers/clk/ti/clk-54xx.c              |  1 +
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi b/arch/arm/boot/dts/omap54xx-clocks.dtsi
index 4899c23..a8153b4 100644
--- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
@@ -1388,3 +1388,13 @@
 		reg = <0x021c>;
 	};
 };
+
+&scm_wkup_pad_conf_clocks {
+	fref_xtal_ck: fref_xtal_ck {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&sys_clkin>;
+		ti,bit-shift = <28>;
+		reg = <0x14>;
+	};
+};
diff --git a/drivers/clk/ti/clk-54xx.c b/drivers/clk/ti/clk-54xx.c
index 294bc03..20f6985 100644
--- a/drivers/clk/ti/clk-54xx.c
+++ b/drivers/clk/ti/clk-54xx.c
@@ -222,6 +222,7 @@ static struct ti_dt_clk omap54xx_clks[] = {
 	DT_CLK("4013a000.timer", "timer_sys_ck", "dss_syc_gfclk_div"),
 	DT_CLK("4013c000.timer", "timer_sys_ck", "dss_syc_gfclk_div"),
 	DT_CLK("4013e000.timer", "timer_sys_ck", "dss_syc_gfclk_div"),
+	DT_CLK(NULL, "fref_xtal_ck", "fref_xtal_ck"),
 	{ .node_name = NULL },
 };
 
-- 
1.9.1

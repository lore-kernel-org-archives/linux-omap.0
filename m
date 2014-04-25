From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 09/10] ARM: dts: OMAP4: clk: Add clk node for DES IP
Date: Fri, 25 Apr 2014 18:02:47 -0500
Message-ID: <1398466968-29506-10-git-send-email-joelf@ti.com>
References: <1398466968-29506-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1398466968-29506-1-git-send-email-joelf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Joel Fernandes <joelf@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Lokesh Vutla <lokeshvutla@ti.com>

DES IP already has main and interface clk as des_fck.
Node for des_fck is missing in clk tree. Adding the same.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/boot/dts/omap44xx-clocks.dtsi |    8 ++++++++
 drivers/clk/ti/clk-44xx.c              |    1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/omap44xx-clocks.dtsi b/arch/arm/boot/dts/omap44xx-clocks.dtsi
index c821ff5..83cf189 100644
--- a/arch/arm/boot/dts/omap44xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap44xx-clocks.dtsi
@@ -985,6 +985,14 @@
 		reg = <0x15a8>;
 	};
 
+	des_fck: des_fck@4a0095b0 {
+	       #clock-cells = <0>;
+	       compatible = "gate-clock";
+	       clocks = <&l3_div_ck>;
+	       bit-shift = <1>;
+	       reg = <0x4a0095b0 0x4>;
+	};
+
 	dss_sys_clk: dss_sys_clk {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
index 02517a8..85d97c3 100644
--- a/drivers/clk/ti/clk-44xx.c
+++ b/drivers/clk/ti/clk-44xx.c
@@ -120,6 +120,7 @@ static struct ti_dt_clk omap44xx_clks[] = {
 	DT_CLK(NULL, "syc_clk_div_ck", "syc_clk_div_ck"),
 	DT_CLK(NULL, "aes1_fck", "aes1_fck"),
 	DT_CLK(NULL, "aes2_fck", "aes2_fck"),
+	DT_CLK(NULL, "des_fck", "des_fck"),
 	DT_CLK(NULL, "dmic_sync_mux_ck", "dmic_sync_mux_ck"),
 	DT_CLK(NULL, "func_dmic_abe_gfclk", "func_dmic_abe_gfclk"),
 	DT_CLK(NULL, "dss_sys_clk", "dss_sys_clk"),
-- 
1.7.9.5

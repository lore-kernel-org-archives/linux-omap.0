From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 06/10] ARM: DTS: am57xx-beagle-x15: Move clkout2 source
 selection to codec node
Date: Mon, 7 Mar 2016 17:17:33 +0200
Message-ID: <1457363857-20797-7-git-send-email-peter.ujfalusi@ti.com>
References: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, paul@pwsan.com, robh+dt@kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The assigned-clock* needs to be in the root of the device's node. If it is
in the sub-node the CCF will ignore it.
Since the clkout2 is used by the codec as MCLK, move the clock parent
selection to that node.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 0a5fc5d02ce2..2bbc8ae00ada 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -173,8 +173,6 @@
 
 		sound0_master: simple-audio-card,codec {
 			sound-dai = <&tlv320aic3104>;
-			assigned-clocks = <&clkoutmux2_clk_mux>;
-			assigned-clock-parents = <&sys_clk2_dclk_div>;
 			clocks = <&clkout2_clk>;
 		};
 	};
@@ -584,6 +582,9 @@
 		pinctrl-names = "default", "sleep";
 		pinctrl-0 = <&clkout2_pins_default>;
 		pinctrl-1 = <&clkout2_pins_sleep>;
+		assigned-clocks = <&clkoutmux2_clk_mux>;
+		assigned-clock-parents = <&sys_clk2_dclk_div>;
+
 		status = "okay";
 		adc-settle-ms = <40>;
 
-- 
2.7.2

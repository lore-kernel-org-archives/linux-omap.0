From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 07/11] ARM: DTS: am57xx-beagle-x15: Move clkout2 source selection to codec node
Date: Thu, 25 Feb 2016 16:50:23 +0200
Message-ID: <1456411827-23962-8-git-send-email-peter.ujfalusi@ti.com>
References: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, paul@pwsan.com, robh+dt@kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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
index b25d68496c7d..86351372174f 100644
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
2.7.1

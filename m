From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] ARM: dts: omap3-pandora: Add fixed 26MHz clock as fck for twl
Date: Thu,  5 Apr 2018 18:01:59 +0200
Message-ID: <cfb1ac64f31a2b01a506390ecb665a1e66d7ce5d.1522944118.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>, linux-kernel@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

The board uses 26MHz oscillator for the twl4030 HFCLK.
This way we will not depend on the bootloader to configure the
CFG_BOOT:HFCLK_FREQ

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-pandora-common.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index c8d58752e15e..5d9be7d43f05 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -28,6 +28,13 @@
 		display1 = &tv;
 	};
 
+	/* fixed 26MHz oscillator */
+	hfclk_26m: oscillator {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <26000000>;
+	};
+
 	tv: connector {
 		compatible = "connector-analog-tv";
 		label = "tv";
@@ -417,6 +424,9 @@
 		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
 		interrupt-parent = <&intc>;
 
+		clocks = <&hfclk_26m>;
+		clock-names = "fck";
+
 		twl_power: power {
 			compatible = "ti,twl4030-power-reset";
 			ti,use_poweroff;
-- 
2.12.2

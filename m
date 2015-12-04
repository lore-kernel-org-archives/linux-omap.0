From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/7] ARM: dts: Add mmc support for dra62x j5-eco evm
Date: Thu,  3 Dec 2015 17:25:34 -0800
Message-ID: <1449192335-10137-7-git-send-email-tony@atomide.com>
References: <1449192335-10137-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449192335-10137-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>, Delio Brignoli <dbrignoli@audioscience.com>, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

There's mmc interface on j5-eco evm that's wired to the
sd_1 interface.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra62x-j5eco-evm.dts | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/dra62x-j5eco-evm.dts b/arch/arm/boot/dts/dra62x-j5eco-evm.dts
index 49a05d2..97ac839 100644
--- a/arch/arm/boot/dts/dra62x-j5eco-evm.dts
+++ b/arch/arm/boot/dts/dra62x-j5eco-evm.dts
@@ -15,6 +15,14 @@
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>;	/* 1 GB */
 	};
+
+	/* MIC94060YC6 controlled by SD1_POW pin */
+	vmmcsd_fixed: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmcsd_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 &cpsw_emac0 {
@@ -26,3 +34,26 @@
 	phy_id = <&davinci_mdio>, <1>;
 	phy-mode = "rgmii";
 };
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd1_pins>;
+	vmmc-supply = <&vmmcsd_fixed>;
+	bus-width = <4>;
+	cd-gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
+};
+
+&pincntl {
+	sd1_pins: pinmux_sd1_pins {
+		pinctrl-single,pins = <
+			DM814X_IOPAD(0x0800, PIN_INPUT | 0x1)	/* SD1_CLK */
+			DM814X_IOPAD(0x0804, PIN_INPUT_PULLUP |  0x1)	/* SD1_CMD */
+			DM814X_IOPAD(0x0808, PIN_INPUT_PULLUP |  0x1)	/* SD1_DAT[0] */
+			DM814X_IOPAD(0x080c, PIN_INPUT_PULLUP |  0x1)	/* SD1_DAT[1] */
+			DM814X_IOPAD(0x0810, PIN_INPUT_PULLUP |  0x1)	/* SD1_DAT[2] */
+			DM814X_IOPAD(0x0814, PIN_INPUT_PULLUP |  0x1)	/* SD1_DAT[3] */
+			DM814X_IOPAD(0x0924, PIN_OUTPUT |  0x40)	/* SD1_POW */
+			DM814X_IOPAD(0x093C, PIN_INPUT_PULLUP |  0x80)	/* GP1[6] */
+			>;
+	};
+};
-- 
2.6.2

From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/7] ARM: dts: Enable emmc on hp t410
Date: Thu,  3 Dec 2015 17:25:35 -0800
Message-ID: <1449192335-10137-8-git-send-email-tony@atomide.com>
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

There's a 2GB emmc on hp t410 that's wired to the sd_2 interface.
Note that we also need to configure the evtmux using edma_xbar for
edma channels.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm8148-t410.dts | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/dm8148-t410.dts b/arch/arm/boot/dts/dm8148-t410.dts
index 79838dd..d1927a7 100644
--- a/arch/arm/boot/dts/dm8148-t410.dts
+++ b/arch/arm/boot/dts/dm8148-t410.dts
@@ -15,6 +15,13 @@
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>;	/* 1 GB */
 	};
+
+	vmmcsd_fixed: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmcsd_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 &cpsw_emac0 {
@@ -26,3 +33,31 @@
 	phy_id = <&davinci_mdio>, <1>;
 	phy-mode = "rgmii";
 };
+
+&mmc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd2_pins>;
+	vmmc-supply = <&vmmcsd_fixed>;
+	bus-width = <8>;
+	dmas = <&edma_xbar 8 0 1	/* use SDTXEVT1 instead of MCASP0TX */
+		&edma_xbar 9 0 2>;	/* use SDRXEVT1 instead of MCASP0RX */
+	dma-names = "tx", "rx";
+};
+
+&pincntl {
+	sd2_pins: pinmux_sd2_pins {
+		pinctrl-single,pins = <
+			DM814X_IOPAD(0x09c0, PIN_INPUT_PULLUP | 0x1)	/* SD2_DAT[7] */
+			DM814X_IOPAD(0x09c4, PIN_INPUT_PULLUP | 0x1)	/* SD2_DAT[6] */
+			DM814X_IOPAD(0x09c8, PIN_INPUT_PULLUP | 0x1)	/* SD2_DAT[5] */
+			DM814X_IOPAD(0x09cc, PIN_INPUT_PULLUP | 0x1)	/* SD2_DAT[4] */
+			DM814X_IOPAD(0x09d0, PIN_INPUT_PULLUP | 0x1)	/* SD2_DAT[3] */
+			DM814X_IOPAD(0x09d4, PIN_INPUT_PULLUP | 0x1)	/* SD2_DAT[2] */
+			DM814X_IOPAD(0x09d8, PIN_INPUT_PULLUP | 0x1)	/* SD2_DAT[1] */
+			DM814X_IOPAD(0x09dc, PIN_INPUT_PULLUP | 0x1)	/* SD2_DAT[0] */
+			DM814X_IOPAD(0x09e0, PIN_INPUT | 0x1)		/* SD2_CLK */
+			DM814X_IOPAD(0x09f4, PIN_INPUT_PULLUP | 0x2)	/* SD2_CMD */
+			DM814X_IOPAD(0x0920, PIN_INPUT | 40)	/* SD2_SDCD */
+			>;
+	};
+};
-- 
2.6.2

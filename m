From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Fix uart wakeirq on omap5 by removing WAKEUP_EN for
 omaps
Date: Thu,  5 May 2016 12:01:29 -0700
Message-ID: <1462474889-22800-1-git-send-email-tony@atomide.com>
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
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The padconf register WAKEUP_EN is now handled in a generic way using
Linux wakeirqs where pinctrl-single toggles the WAKEUP_EN bit when
a wakeirq is enabled or disabled.

At least omap5 gets confused if the WAKEUP_EN bit is set and the pin
is not claimed as a wakeirq. The end result is that wakeirqs don't
work properly as there is nothing handling the wakeirq.

So let's just remove the WAKEUP_EN usage from dts files.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-evm-37xx.dts      | 2 +-
 arch/arm/boot/dts/omap3-n900.dts          | 4 ++--
 arch/arm/boot/dts/omap3-n950-n9.dtsi      | 6 +++---
 arch/arm/boot/dts/omap3-zoom3.dts         | 6 +++---
 arch/arm/boot/dts/omap5-board-common.dtsi | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-evm-37xx.dts b/arch/arm/boot/dts/omap3-evm-37xx.dts
index cd11c56..792a876 100644
--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -85,7 +85,7 @@
 			OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk.sdmmc2_clk */
 			OMAP3_CORE1_IOPAD(0x215a, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd.sdmmc2_cmd */
 			OMAP3_CORE1_IOPAD(0x215c, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat0.sdmmc2_dat0 */
-			OMAP3_CORE1_IOPAD(0x215e, WAKEUP_EN | PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat1.sdmmc2_dat1 */
+			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat1.sdmmc2_dat1 */
 			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat2.sdmmc2_dat2 */
 			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat3.sdmmc2_dat3 */
 		>;
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index d9e2d9c..2b74a81 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -288,7 +288,7 @@
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x2180, PIN_INPUT_PULLUP | MUX_MODE1)	/* ssi1_rdy_tx */
 			OMAP3_CORE1_IOPAD(0x217e, PIN_OUTPUT | MUX_MODE1)		/* ssi1_flag_tx */
-			OMAP3_CORE1_IOPAD(0x2182, PIN_INPUT | WAKEUP_EN | MUX_MODE4) /* ssi1_wake_tx (cawake) */
+			OMAP3_CORE1_IOPAD(0x2182, PIN_INPUT | MUX_MODE4)		/* ssi1_wake_tx (cawake) */
 			OMAP3_CORE1_IOPAD(0x217c, PIN_OUTPUT | MUX_MODE1)		/* ssi1_dat_tx */
 			OMAP3_CORE1_IOPAD(0x2184, PIN_INPUT | MUX_MODE1)		/* ssi1_dat_rx */
 			OMAP3_CORE1_IOPAD(0x2186, PIN_INPUT | MUX_MODE1)		/* ssi1_flag_rx */
@@ -300,7 +300,7 @@
 	modem_pins: pinmux_modem {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x20dc, PIN_OUTPUT | MUX_MODE4)		/* gpio 70 => cmt_apeslpx */
-			OMAP3_CORE1_IOPAD(0x20e0, PIN_INPUT | WAKEUP_EN | MUX_MODE4) /* gpio 72 => ape_rst_rq */
+			OMAP3_CORE1_IOPAD(0x20e0, PIN_INPUT | MUX_MODE4)		/* gpio 72 => ape_rst_rq */
 			OMAP3_CORE1_IOPAD(0x20e2, PIN_OUTPUT | MUX_MODE4)		/* gpio 73 => cmt_rst_rq */
 			OMAP3_CORE1_IOPAD(0x20e4, PIN_OUTPUT | MUX_MODE4)		/* gpio 74 => cmt_en */
 			OMAP3_CORE1_IOPAD(0x20e6, PIN_OUTPUT | MUX_MODE4)		/* gpio 75 => cmt_rst */
diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
index a00ca76..927b17f 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -97,7 +97,7 @@
 			OMAP3_CORE1_IOPAD(0x217c, PIN_OUTPUT | MUX_MODE1)            /* ssi1_dat_tx */
 			OMAP3_CORE1_IOPAD(0x217e, PIN_OUTPUT | MUX_MODE1)            /* ssi1_flag_tx */
 			OMAP3_CORE1_IOPAD(0x2180, PIN_INPUT_PULLUP | MUX_MODE1)      /* ssi1_rdy_tx */
-			OMAP3_CORE1_IOPAD(0x2182, PIN_INPUT | WAKEUP_EN | MUX_MODE4) /* ssi1_wake_tx (cawake) */
+			OMAP3_CORE1_IOPAD(0x2182, PIN_INPUT | MUX_MODE4)	/* ssi1_wake_tx (cawake) */
 			OMAP3_CORE1_IOPAD(0x2184, PIN_INPUT | MUX_MODE1)             /* ssi1_dat_rx */
 			OMAP3_CORE1_IOPAD(0x2186, PIN_INPUT | MUX_MODE1)             /* ssi1_flag_rx */
 			OMAP3_CORE1_IOPAD(0x2188, PIN_OUTPUT | MUX_MODE1)            /* ssi1_rdy_rx */
@@ -110,7 +110,7 @@
 			OMAP3_CORE1_IOPAD(0x217c, PIN_OUTPUT | MUX_MODE7)            /* ssi1_dat_tx */
 			OMAP3_CORE1_IOPAD(0x217e, PIN_OUTPUT | MUX_MODE7)            /* ssi1_flag_tx */
 			OMAP3_CORE1_IOPAD(0x2180, PIN_INPUT_PULLDOWN | MUX_MODE7)    /* ssi1_rdy_tx */
-			OMAP3_CORE1_IOPAD(0x2182, PIN_INPUT | WAKEUP_EN | MUX_MODE4) /* ssi1_wake_tx (cawake) */
+			OMAP3_CORE1_IOPAD(0x2182, PIN_INPUT | MUX_MODE4)	/* ssi1_wake_tx (cawake) */
 			OMAP3_CORE1_IOPAD(0x2184, PIN_INPUT | MUX_MODE7)             /* ssi1_dat_rx */
 			OMAP3_CORE1_IOPAD(0x2186, PIN_INPUT | MUX_MODE7)             /* ssi1_flag_rx */
 			OMAP3_CORE1_IOPAD(0x2188, PIN_OUTPUT | MUX_MODE4)            /* ssi1_rdy_rx */
@@ -120,7 +120,7 @@
 
 	modem_pins1: pinmux_modem_core1_pins {
 		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x207a, PIN_INPUT | WAKEUP_EN | MUX_MODE4) /* gpio_34 (ape_rst_rq) */
+			OMAP3_CORE1_IOPAD(0x207a, PIN_INPUT | MUX_MODE4)	/* gpio_34 (ape_rst_rq) */
 			OMAP3_CORE1_IOPAD(0x2100, PIN_OUTPUT | MUX_MODE4)            /* gpio_88 (cmt_rst_rq) */
 			OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT | MUX_MODE4)            /* gpio_93 (cmt_apeslpx) */
 		>;
diff --git a/arch/arm/boot/dts/omap3-zoom3.dts b/arch/arm/boot/dts/omap3-zoom3.dts
index acb5f3c..75d4dfb 100644
--- a/arch/arm/boot/dts/omap3-zoom3.dts
+++ b/arch/arm/boot/dts/omap3-zoom3.dts
@@ -98,7 +98,7 @@
 		pinctrl-single,pins = <
                         OMAP3_CORE1_IOPAD(0x2174, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_cts.uart2_cts */
                         OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT | MUX_MODE0)		/* uart2_rts.uart2_rts */
-                        OMAP3_CORE1_IOPAD(0x217a, WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart2_rx.uart2_rx */
+                        OMAP3_CORE1_IOPAD(0x217a, PIN_INPUT | MUX_MODE0)		/* uart2_rx.uart2_rx */
                         OMAP3_CORE1_IOPAD(0x2178, PIN_OUTPUT | MUX_MODE0)		/* uart2_tx.uart2_tx */
 		>;
 	};
@@ -107,7 +107,7 @@
 		pinctrl-single,pins = <
                         OMAP3_CORE1_IOPAD(0x219a, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* uart3_cts_rctx.uart3_cts_rctx */
                         OMAP3_CORE1_IOPAD(0x219c, PIN_OUTPUT | MUX_MODE0)		/* uart3_rts_sd.uart3_rts_sd */
-                        OMAP3_CORE1_IOPAD(0x219e, WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart3_rx_irrx.uart3_rx_irrx */
+                        OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | MUX_MODE0)		/* uart3_rx_irrx.uart3_rx_irrx */
                         OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
 		>;
 	};
@@ -125,7 +125,7 @@
 		pinctrl-single,pins = <
 			OMAP3630_CORE2_IOPAD(0x25d8, PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_clk.sdmmc3_clk */
 			OMAP3630_CORE2_IOPAD(0x25e4, PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d4.sdmmc3_dat0 */
-			OMAP3630_CORE2_IOPAD(0x25e6, WAKEUP_EN | PIN_INPUT_PULLUP | MUX_MODE2) /* etk_d5.sdmmc3_dat1 */
+			OMAP3630_CORE2_IOPAD(0x25e6, PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d5.sdmmc3_dat1 */
 			OMAP3630_CORE2_IOPAD(0x25e8, PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d6.sdmmc3_dat2 */
 			OMAP3630_CORE2_IOPAD(0x25e2, PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d3.sdmmc3_dat3 */
 		>;
diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index 23b1d7c..4bc22d2 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -332,7 +332,7 @@
 
 	wlcore_irq_pin: pinmux_wlcore_irq_pin {
 		pinctrl-single,pins = <
-			OMAP5_IOPAD(0x40, WAKEUP_EN | PIN_INPUT_PULLUP | MUX_MODE6)	/* llia_wakereqin.gpio1_wk14 */
+			OMAP5_IOPAD(0x40, PIN_INPUT_PULLUP | MUX_MODE6)	/* llia_wakereqin.gpio1_wk14 */
 		>;
 	};
 };
-- 
2.8.1

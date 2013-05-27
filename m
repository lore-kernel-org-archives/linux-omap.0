From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v3 5/5] ARM: dts: OMAP2+: use pinctrl constants
Date: Mon, 27 May 2013 16:52:34 +0200
Message-ID: <1369666354-29152-6-git-send-email-florian.vaussard@epfl.ch>
References: <1369666354-29152-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:40798 "HELO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932721Ab3E0Oxk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 May 2013 10:53:40 -0400
In-Reply-To: <1369666354-29152-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Using constants for pinctrl allows a better readability, and remove
redundancy with comments.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap2.dtsi              |    1 +
 arch/arm/boot/dts/omap3-beagle.dts        |   24 ++++----
 arch/arm/boot/dts/omap3-igep.dtsi         |   32 +++++-----
 arch/arm/boot/dts/omap3.dtsi              |    1 +
 arch/arm/boot/dts/omap4-panda-a4.dts      |    6 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi |   50 ++++++++--------
 arch/arm/boot/dts/omap4-panda-es.dts      |    6 +-
 arch/arm/boot/dts/omap4-sdp-es23plus.dts  |    6 +-
 arch/arm/boot/dts/omap4-sdp.dts           |   94 ++++++++++++++--------------
 arch/arm/boot/dts/omap4.dtsi              |    1 +
 arch/arm/boot/dts/omap5-evm.dts           |   88 +++++++++++++-------------
 arch/arm/boot/dts/omap5.dtsi              |    1 +
 12 files changed, 157 insertions(+), 153 deletions(-)

diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index f39b237..b3cc896 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -9,6 +9,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/omap.h>
 
 #include "skeleton.dtsi"
 
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 434288f..6d47c4b 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -81,18 +81,18 @@
 
 	hsusbb2_pins: pinmux_hsusbb2_pins {
 		pinctrl-single,pins = <
-			0x5c0 0x3  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_clk OUTPUT */
-			0x5c2 0x3  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_stp OUTPUT */
-			0x5c4 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dir INPUT | PULLDOWN */
-			0x5c6 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_nxt INPUT | PULLDOWN */
-			0x5c8 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat0 INPUT | PULLDOWN */
-			0x5cA 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat1 INPUT | PULLDOWN */
-			0x1a4 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat2 INPUT | PULLDOWN */
-			0x1a6 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat3 INPUT | PULLDOWN */
-			0x1a8 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat4 INPUT | PULLDOWN */
-			0x1aa 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat5 INPUT | PULLDOWN */
-			0x1ac 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat6 INPUT | PULLDOWN */
-			0x1ae 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat7 INPUT | PULLDOWN */
+			0x5c0 (PIN_OUTPUT | MUX_MODE3)		/* usbb2_ulpitll_clk.usbb1_ulpiphy_clk */
+			0x5c2 (PIN_OUTPUT | MUX_MODE3)		/* usbb2_ulpitll_clk.usbb1_ulpiphy_stp */
+			0x5c4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* usbb2_ulpitll_clk.usbb1_ulpiphy_dir */
+			0x5c6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* usbb2_ulpitll_clk.usbb1_ulpiphy_nxt */
+			0x5c8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* usbb2_ulpitll_clk.usbb1_ulpiphy_dat0 */
+			0x5cA (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* usbb2_ulpitll_clk.usbb1_ulpiphy_dat1 */
+			0x1a4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* usbb2_ulpitll_clk.usbb1_ulpiphy_dat2 */
+			0x1a6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* usbb2_ulpitll_clk.usbb1_ulpiphy_dat3 */
+			0x1a8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* usbb2_ulpitll_clk.usbb1_ulpiphy_dat4 */
+			0x1aa (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* usbb2_ulpitll_clk.usbb1_ulpiphy_dat5 */
+			0x1ac (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* usbb2_ulpitll_clk.usbb1_ulpiphy_dat6 */
+			0x1ae (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* usbb2_ulpitll_clk.usbb1_ulpiphy_dat7 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index 54588b0..7b62b80 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -29,37 +29,37 @@
 &omap3_pmx_core {
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-			0x152 0x100	/* uart1_rx.uart1_rx INPUT | MODE0 */
-			0x14c 0		/* uart1_tx.uart1_tx OUTPUT | MODE0 */
+			0x152 (PIN_INPUT | MUX_MODE0)		/* uart1_rx.uart1_rx */
+			0x14c (PIN_OUTPUT |MUX_MODE0)		/* uart1_tx.uart1_tx */
 		>;
 	};
 
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
-			0x14a 0x100	/* uart2_rx.uart2_rx INPUT | MODE0 */
-			0x148 0		/* uart2_tx.uart2_tx OUTPUT | MODE0 */
+			0x14a (PIN_INPUT | MUX_MODE0)		/* uart2_rx.uart2_rx */
+			0x148 (PIN_OUTPUT | MUX_MODE0)		/* uart2_tx.uart2_tx */
 		>;
 	};
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-			0x16e 0x100	/* uart3_rx.uart3_rx INPUT | MODE0 */
-			0x170 0		/* uart3_tx.uart3_tx OUTPUT | MODE0 */
+			0x16e (PIN_INPUT | MUX_MODE0)		/* uart3_rx.uart3_rx */
+			0x170 (PIN_OUTPUT | MUX_MODE0)		/* uart3_tx.uart3_tx */
 		>;
 	};
 
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			0x114 0x0118    /* sdmmc1_clk.sdmmc1_clk INPUT PULLUP | MODE 0 */
-			0x116 0x0118    /* sdmmc1_cmd.sdmmc1_cmd INPUT PULLUP | MODE 0 */
-			0x118 0x0118 	/* sdmmc1_dat0.sdmmc1_dat0 INPUT PULLUP | MODE 0 */
-			0x11a 0x0118	/* sdmmc1_dat1.sdmmc1_dat1 INPUT PULLUP | MODE 0 */
-			0x11c 0x0118	/* sdmmc1_dat2.sdmmc1_dat2 INPUT PULLUP | MODE 0 */
-			0x11e 0x0118	/* sdmmc1_dat3.sdmmc1_dat3 INPUT PULLUP | MODE 0 */
-			0x120 0x0100	/* sdmmc1_dat4.sdmmc1_dat4 INPUT | MODE 0 */
-			0x122 0x0100	/* sdmmc1_dat5.sdmmc1_dat5 INPUT | MODE 0 */
-			0x124 0x0100	/* sdmmc1_dat6.sdmmc1_dat6 INPUT | MODE 0 */
-			0x126 0x0100	/* sdmmc1_dat7.sdmmc1_dat7 INPUT | MODE 0 */
+			0x114 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
+			0x116 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd.sdmmc1_cmd */
+			0x118 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat0.sdmmc1_dat0 */
+			0x11a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat1.sdmmc1_dat1 */
+			0x11c (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat2.sdmmc1_dat2 */
+			0x11e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3.sdmmc1_dat3 */
+			0x120 (PIN_INPUT | MUX_MODE0)		/* sdmmc1_dat4.sdmmc1_dat4 */
+			0x122 (PIN_INPUT | MUX_MODE0)		/* sdmmc1_dat5.sdmmc1_dat5 */
+			0x124 (PIN_INPUT | MUX_MODE0)		/* sdmmc1_dat6.sdmmc1_dat6 */
+			0x126 (PIN_INPUT | MUX_MODE0)		/* sdmmc1_dat7.sdmmc1_dat7 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index aede64d..813370d 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -9,6 +9,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/omap.h>
 
 #include "skeleton.dtsi"
 
diff --git a/arch/arm/boot/dts/omap4-panda-a4.dts b/arch/arm/boot/dts/omap4-panda-a4.dts
index f18fb5c..133f1b7 100644
--- a/arch/arm/boot/dts/omap4-panda-a4.dts
+++ b/arch/arm/boot/dts/omap4-panda-a4.dts
@@ -13,8 +13,8 @@
 /* Pandaboard Rev A4+ have external pullups on SCL & SDA */
 &dss_hdmi_pins {
 	pinctrl-single,pins = <
-		0x5a 0x118	/* hdmi_cec.hdmi_cec INPUT PULLUP | MODE 0 */
-		0x5c 0x100	/* hdmi_scl.hdmi_scl INPUT | MODE 0 */
-		0x5e 0x100	/* hdmi_sda.hdmi_sda INPUT | MODE 0 */
+		0x5a (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
+		0x5c (PIN_INPUT | MUX_MODE0)		/* hdmi_scl.hdmi_scl */
+		0x5e (PIN_INPUT | MUX_MODE0)		/* hdmi_sda.hdmi_sda */
 		>;
 };
diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 16b03fd..548329e 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -68,71 +68,71 @@
 
 	twl6040_pins: pinmux_twl6040_pins {
 		pinctrl-single,pins = <
-			0xe0 0x3	/* hdq_sio.gpio_127 OUTPUT | MODE3 */
-			0x160 0x100	/* sys_nirq2.sys_nirq2 INPUT | MODE0 */
+			0xe0 (PIN_OUTPUT | MUX_MODE3)	/* hdq_sio.gpio_127 */
+			0x160 (PIN_INPUT | MUX_MODE0)	/* sys_nirq2.sys_nirq2 */
 		>;
 	};
 
 	mcpdm_pins: pinmux_mcpdm_pins {
 		pinctrl-single,pins = <
-			0xc6 0x108	/* abe_pdm_ul_data.abe_pdm_ul_data INPUT PULLDOWN | MODE0 */
-			0xc8 0x108	/* abe_pdm_dl_data.abe_pdm_dl_data INPUT PULLDOWN | MODE0 */
-			0xca 0x118	/* abe_pdm_frame.abe_pdm_frame INPUT PULLUP | MODE0 */
-			0xcc 0x108	/* abe_pdm_lb_clk.abe_pdm_lb_clk INPUT PULLDOWN | MODE0 */
-			0xce 0x108	/* abe_clks.abe_clks INPUT PULLDOWN | MODE0 */
+			0xc6 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_ul_data.abe_pdm_ul_data */
+			0xc8 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_dl_data.abe_pdm_dl_data */
+			0xca (PIN_INPUT_PULLUP   | MUX_MODE0)	/* abe_pdm_frame.abe_pdm_frame */
+			0xcc (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_lb_clk.abe_pdm_lb_clk */
+			0xce (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_clks.abe_clks */
 		>;
 	};
 
 	mcbsp1_pins: pinmux_mcbsp1_pins {
 		pinctrl-single,pins = <
-			0xbe 0x100	/* abe_mcbsp1_clkx.abe_mcbsp1_clkx INPUT | MODE0 */
-			0xc0 0x108	/* abe_mcbsp1_dr.abe_mcbsp1_dr INPUT PULLDOWN | MODE0 */
-			0xc2 0x8		/* abe_mcbsp1_dx.abe_mcbsp1_dx OUTPUT PULLDOWN | MODE0 */
-			0xc4 0x100	/* abe_mcbsp1_fsx.abe_mcbsp1_fsx INPUT | MODE0 */
+			0xbe (PIN_INPUT | MUX_MODE0)		/* abe_mcbsp1_clkx.abe_mcbsp1_clkx */
+			0xc0 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_mcbsp1_dr.abe_mcbsp1_dr */
+			0xc2 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* abe_mcbsp1_dx.abe_mcbsp1_dx */
+			0xc4 (PIN_INPUT | MUX_MODE0)		/* abe_mcbsp1_fsx.abe_mcbsp1_fsx */
 		>;
 	};
 
 	dss_hdmi_pins: pinmux_dss_hdmi_pins {
 		pinctrl-single,pins = <
-			0x5a 0x118	/* hdmi_cec.hdmi_cec INPUT PULLUP | MODE 0 */
-			0x5c 0x118	/* hdmi_scl.hdmi_scl INPUT PULLUP | MODE 0 */
-			0x5e 0x118	/* hdmi_sda.hdmi_sda INPUT PULLUP | MODE 0 */
+			0x5a (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
+			0x5c (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_scl.hdmi_scl */
+			0x5e (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_sda.hdmi_sda */
 		>;
 	};
 
 	tpd12s015_pins: pinmux_tpd12s015_pins {
 		pinctrl-single,pins = <
-			0x22 0x3	/* gpmc_a17.gpio_41 OUTPUT | MODE3 */
-			0x48 0x3	/* gpmc_nbe1.gpio_60 OUTPUT | MODE3 */
-			0x58 0x10b	/* hdmi_hpd.gpio_63 INPUT PULLDOWN | MODE3 */
+			0x22 (PIN_OUTPUT | MUX_MODE3)		/* gpmc_a17.gpio_41 */
+			0x48 (PIN_OUTPUT | MUX_MODE3)		/* gpmc_nbe1.gpio_60 */
+			0x58 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* hdmi_hpd.gpio_63 */
 		>;
 	};
 
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
-			0xe2 0x118        /* i2c1_scl PULLUP | INPUTENABLE | MODE0 */
-			0xe4 0x118        /* i2c1_sda PULLUP | INPUTENABLE | MODE0 */
+			0xe2 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
+			0xe4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
 		>;
 	};
 
 	i2c2_pins: pinmux_i2c2_pins {
 		pinctrl-single,pins = <
-			0xe6 0x118        /* i2c2_scl PULLUP | INPUTENABLE | MODE0 */
-			0xe8 0x118        /* i2c2_sda PULLUP | INPUTENABLE | MODE0 */
+			0xe6 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c2_scl */
+			0xe8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c2_sda */
 		>;
 	};
 
 	i2c3_pins: pinmux_i2c3_pins {
 		pinctrl-single,pins = <
-			0xea 0x118        /* i2c3_scl PULLUP | INPUTENABLE | MODE0 */
-			0xec 0x118     /* i2c3_sda PULLUP | INPUTENABLE | MODE0 */
+			0xea (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_scl */
+			0xec (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_sda */
 		>;
 	};
 
 	i2c4_pins: pinmux_i2c4_pins {
 		pinctrl-single,pins = <
-			0xee 0x118        /* i2c4_scl PULLUP | INPUTENABLE | MODE0 */
-			0xf0 0x118     /* i2c4_sda PULLUP | INPUTENABLE | MODE0 */
+			0xee (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_scl */
+			0xf0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_sda */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap4-panda-es.dts b/arch/arm/boot/dts/omap4-panda-es.dts
index c6f012e..5cfdf19 100644
--- a/arch/arm/boot/dts/omap4-panda-es.dts
+++ b/arch/arm/boot/dts/omap4-panda-es.dts
@@ -29,8 +29,8 @@
 /* PandaboardES has external pullups on SCL & SDA */
 &dss_hdmi_pins {
 	pinctrl-single,pins = <
-		0x5a 0x118	/* hdmi_cec.hdmi_cec INPUT PULLUP | MODE 0 */
-		0x5c 0x100	/* hdmi_scl.hdmi_scl INPUT | MODE 0 */
-		0x5e 0x100	/* hdmi_sda.hdmi_sda INPUT | MODE 0 */
+		0x5a (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
+		0x5c (PIN_INPUT | MUX_MODE0)		/* hdmi_scl.hdmi_scl */
+		0x5e (PIN_INPUT | MUX_MODE0)		/* hdmi_sda.hdmi_sda */
 		>;
 };
diff --git a/arch/arm/boot/dts/omap4-sdp-es23plus.dts b/arch/arm/boot/dts/omap4-sdp-es23plus.dts
index 4f26355..aad5dda 100644
--- a/arch/arm/boot/dts/omap4-sdp-es23plus.dts
+++ b/arch/arm/boot/dts/omap4-sdp-es23plus.dts
@@ -10,8 +10,8 @@
 /* SDP boards with 4430 ES2.3+ or 4460 have external pullups on SCL & SDA */
 &dss_hdmi_pins {
 	pinctrl-single,pins = <
-		0x5a 0x118	/* hdmi_cec.hdmi_cec INPUT PULLUP | MODE 0 */
-		0x5c 0x100	/* hdmi_scl.hdmi_scl INPUT | MODE 0 */
-		0x5e 0x100	/* hdmi_sda.hdmi_sda INPUT | MODE 0 */
+		0x5a (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
+		0x5c (PIN_INPUT | MUX_MODE0)		/* hdmi_scl.hdmi_scl */
+		0x5e (PIN_INPUT | MUX_MODE0)		/* hdmi_sda.hdmi_sda */
 		>;
 };
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 509e27c..a10a91b 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -156,123 +156,123 @@
 
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
-			0xd8 0x118	/* uart2_cts.uart2_cts INPUT_PULLUP | MODE0 */
-			0xda 0		/* uart2_rts.uart2_rts OUTPUT | MODE0 */
-			0xdc 0x118	/* uart2_rx.uart2_rx INPUT_PULLUP | MODE0 */
-			0xde 0		/* uart2_tx.uart2_tx OUTPUT | MODE0 */
+			0xd8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_cts.uart2_cts */
+			0xda (PIN_OUTPUT | MUX_MODE0)		/* uart2_rts.uart2_rts */
+			0xdc (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_rx.uart2_rx */
+			0xde (PIN_OUTPUT | MUX_MODE0)		/* uart2_tx.uart2_tx */
 		>;
 	};
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-			0x100 0x118	/* uart3_cts_rctx.uart3_cts_rctx INPUT_PULLUP | MODE0 */
-			0x102 0		/* uart3_rts_sd.uart3_rts_sd OUTPUT | MODE0 */
-			0x104 0x100	/* uart3_rx_irrx.uart3_rx_irrx INPUT | MODE0 */
-			0x106 0		/* uart3_tx_irtx.uart3_tx_irtx OUTPUT | MODE0 */
+			0x100 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart3_cts_rctx.uart3_cts_rctx */
+			0x102 (PIN_OUTPUT | MUX_MODE0)		/* uart3_rts_sd.uart3_rts_sd */
+			0x104 (PIN_INPUT | MUX_MODE0)		/* uart3_rx_irrx.uart3_rx_irrx */
+			0x106 (PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
 		>;
 	};
 
 	uart4_pins: pinmux_uart4_pins {
 		pinctrl-single,pins = <
-			0x11c 0x100	/* uart4_rx.uart4_rx INPUT | MODE0 */
-			0x11e 0		/* uart4_tx.uart4_tx OUTPUT | MODE0 */
+			0x11c (PIN_INPUT | MUX_MODE0)		/* uart4_rx.uart4_rx */
+			0x11e (PIN_OUTPUT | MUX_MODE0)		/* uart4_tx.uart4_tx */
 		>;
 	};
 
 	twl6040_pins: pinmux_twl6040_pins {
 		pinctrl-single,pins = <
-			0xe0 0x3	/* hdq_sio.gpio_127 OUTPUT | MODE3 */
-			0x160 0x100	/* sys_nirq2.sys_nirq2 INPUT | MODE0 */
+			0xe0 (PIN_OUTPUT | MUX_MODE3)		/* hdq_sio.gpio_127 */
+			0x160 (PIN_INPUT | MUX_MODE0)		/* sys_nirq2.sys_nirq2 */
 		>;
 	};
 
 	mcpdm_pins: pinmux_mcpdm_pins {
 		pinctrl-single,pins = <
-			0xc6 0x108	/* abe_pdm_ul_data.abe_pdm_ul_data INPUT PULLDOWN | MODE0 */
-			0xc8 0x108	/* abe_pdm_dl_data.abe_pdm_dl_data INPUT PULLDOWN | MODE0 */
-			0xca 0x118	/* abe_pdm_frame.abe_pdm_frame INPUT PULLUP | MODE0 */
-			0xcc 0x108	/* abe_pdm_lb_clk.abe_pdm_lb_clk INPUT PULLDOWN | MODE0 */
-			0xce 0x108	/* abe_clks.abe_clks INPUT PULLDOWN | MODE0 */
+			0xc6 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_ul_data.abe_pdm_ul_data */
+			0xc8 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_dl_data.abe_pdm_dl_data */
+			0xca (PIN_INPUT_PULLUP | MUX_MODE0)	/* abe_pdm_frame.abe_pdm_frame */
+			0xcc (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_lb_clk.abe_pdm_lb_clk */
+			0xce (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_clks.abe_clks */
 		>;
 	};
 
 	dmic_pins: pinmux_dmic_pins {
 		pinctrl-single,pins = <
-			0xd0 0		/* abe_dmic_clk1.abe_dmic_clk1 OUTPUT | MODE0 */
-			0xd2 0x100	/* abe_dmic_din1.abe_dmic_din1 INPUT | MODE0 */
-			0xd4 0x100	/* abe_dmic_din2.abe_dmic_din2 INPUT | MODE0 */
-			0xd6 0x100	/* abe_dmic_din3.abe_dmic_din3 INPUT | MODE0 */
+			0xd0 (PIN_OUTPUT | MUX_MODE0)		/* abe_dmic_clk1.abe_dmic_clk1 */
+			0xd2 (PIN_INPUT | MUX_MODE0)		/* abe_dmic_din1.abe_dmic_din1 */
+			0xd4 (PIN_INPUT | MUX_MODE0)		/* abe_dmic_din2.abe_dmic_din2 */
+			0xd6 (PIN_INPUT | MUX_MODE0)		/* abe_dmic_din3.abe_dmic_din3 */
 		>;
 	};
 
 	mcbsp1_pins: pinmux_mcbsp1_pins {
 		pinctrl-single,pins = <
-			0xbe 0x100	/* abe_mcbsp1_clkx.abe_mcbsp1_clkx INPUT | MODE0 */
-			0xc0 0x108	/* abe_mcbsp1_dr.abe_mcbsp1_dr INPUT PULLDOWN | MODE0 */
-			0xc2 0x8	/* abe_mcbsp1_dx.abe_mcbsp1_dx OUTPUT PULLDOWN | MODE0 */
-			0xc4 0x100	/* abe_mcbsp1_fsx.abe_mcbsp1_fsx INPUT | MODE0 */
+			0xbe (PIN_INPUT | MUX_MODE0)		/* abe_mcbsp1_clkx.abe_mcbsp1_clkx */
+			0xc0 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_mcbsp1_dr.abe_mcbsp1_dr */
+			0xc2 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* abe_mcbsp1_dx.abe_mcbsp1_dx */
+			0xc4 (PIN_INPUT | MUX_MODE0)		/* abe_mcbsp1_fsx.abe_mcbsp1_fsx */
 		>;
 	};
 
 	mcbsp2_pins: pinmux_mcbsp2_pins {
 		pinctrl-single,pins = <
-			0xb6 0x100	/* abe_mcbsp2_clkx.abe_mcbsp2_clkx INPUT | MODE0 */
-			0xb8 0x108	/* abe_mcbsp2_dr.abe_mcbsp2_dr INPUT PULLDOWN | MODE0 */
-			0xba 0x8	/* abe_mcbsp2_dx.abe_mcbsp2_dx OUTPUT PULLDOWN | MODE0 */
-			0xbc 0x100	/* abe_mcbsp2_fsx.abe_mcbsp2_fsx INPUT | MODE0 */
+			0xb6 (PIN_INPUT | MUX_MODE0)		/* abe_mcbsp2_clkx.abe_mcbsp2_clkx */
+			0xb8 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_mcbsp2_dr.abe_mcbsp2_dr */
+			0xba (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* abe_mcbsp2_dx.abe_mcbsp2_dx */
+			0xbc (PIN_INPUT | MUX_MODE0)		/* abe_mcbsp2_fsx.abe_mcbsp2_fsx */
 		>;
 	};
 
 	mcspi1_pins: pinmux_mcspi1_pins {
 		pinctrl-single,pins = <
-			0xf2 0x100	/*  mcspi1_clk.mcspi1_clk INPUT | MODE0 */
-			0xf4 0x100	/*  mcspi1_somi.mcspi1_somi INPUT | MODE0 */
-			0xf6 0x100	/*  mcspi1_simo.mcspi1_simo INPUT | MODE0 */
-			0xf8 0x100	/*  mcspi1_cs0.mcspi1_cs0 INPUT | MODE0*/
+			0xf2 (PIN_INPUT | MUX_MODE0)		/*  mcspi1_clk.mcspi1_clk */
+			0xf4 (PIN_INPUT | MUX_MODE0)		/*  mcspi1_somi.mcspi1_somi */
+			0xf6 (PIN_INPUT | MUX_MODE0)		/*  mcspi1_simo.mcspi1_simo */
+			0xf8 (PIN_INPUT | MUX_MODE0)		/*  mcspi1_cs0.mcspi1_cs0 */
 		>;
 	};
 
 	dss_hdmi_pins: pinmux_dss_hdmi_pins {
 		pinctrl-single,pins = <
-			0x5a 0x118	/* hdmi_cec.hdmi_cec INPUT PULLUP | MODE 0 */
-			0x5c 0x118	/* hdmi_scl.hdmi_scl INPUT PULLUP | MODE 0 */
-			0x5e 0x118	/* hdmi_sda.hdmi_sda INPUT PULLUP | MODE 0 */
+			0x5a (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
+			0x5c (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_scl.hdmi_scl */
+			0x5e (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_sda.hdmi_sda */
 		>;
 	};
 
 	tpd12s015_pins: pinmux_tpd12s015_pins {
 		pinctrl-single,pins = <
-			0x22 0x3	/* gpmc_a17.gpio_41 OUTPUT | MODE3 */
-			0x48 0x3	/* gpmc_nbe1.gpio_60 OUTPUT | MODE3 */
-			0x58 0x10b	/* hdmi_hpd.gpio_63 INPUT PULLDOWN | MODE3 */
+			0x22 (PIN_OUTPUT | MUX_MODE3)		/* gpmc_a17.gpio_41 */
+			0x48 (PIN_OUTPUT | MUX_MODE3)		/* gpmc_nbe1.gpio_60 */
+			0x58 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* hdmi_hpd.gpio_63 */
 		>;
 	};
 
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
-			0xe2 0x118        /* i2c1_scl PULLUP | INPUTENABLE | MODE0 */
-			0xe4 0x118       /* i2c1_sda PULLUP | INPUTENABLE | MODE0 */
+			0xe2 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
+			0xe4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
 		>;
 	};
 
 	i2c2_pins: pinmux_i2c2_pins {
 		pinctrl-single,pins = <
-                        0xe6 0x118        /* i2c2_scl PULLUP | INPUTENABLE | MODE0 */
-                        0xe8 0x118        /* i2c2_sda PULLUP | INPUTENABLE | MODE0 */
+			0xe6 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c2_scl */
+			0xe8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c2_sda */
 		>;
 	};
 
 	i2c3_pins: pinmux_i2c3_pins {
 		pinctrl-single,pins = <
-			0xea 0x118        /* i2c3_scl PULLUP | INPUTENABLE | MODE0 */
-			0xec 0x118     /* i2c3_sda PULLUP | INPUTENABLE | MODE0 */
+			0xea (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_scl */
+			0xec (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_sda */
 		>;
 	};
 
 	i2c4_pins: pinmux_i2c4_pins {
 		pinctrl-single,pins = <
-			0xee 0x118        /* i2c4_scl PULLUP | INPUTENABLE | MODE0 */
-			0xf0 0x118     /* i2c4_sda PULLUP | INPUTENABLE | MODE0 */
+			0xee (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_scl */
+			0xf0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_sda */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index d4304a2..ebf3108 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -16,6 +16,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pinctrl/omap.h>
 
 #include "skeleton.dtsi"
 
diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
index f5f55d1..22e9ee8 100644
--- a/arch/arm/boot/dts/omap5-evm.dts
+++ b/arch/arm/boot/dts/omap5-evm.dts
@@ -40,106 +40,106 @@
 
 	twl6040_pins: pinmux_twl6040_pins {
 		pinctrl-single,pins = <
-			0x18a 0x6	/* perslimbus2_clock.gpio5_145 OUTPUT | MODE6 */
+			0x18a (PIN_OUTPUT | MUX_MODE6)	/* perslimbus2_clock.gpio5_145 */
 		>;
 	};
 
 	mcpdm_pins: pinmux_mcpdm_pins {
 		pinctrl-single,pins = <
-			0x142 0x108	/* abe_clks.abe_clks INPUT PULLDOWN | MODE0 */
-			0x15c 0x108	/* abemcpdm_ul_data.abemcpdm_ul_data INPUT PULLDOWN | MODE0 */
-			0x15e 0x108	/* abemcpdm_dl_data.abemcpdm_dl_data INPUT PULLDOWN | MODE0 */
-			0x160 0x118	/* abemcpdm_frame.abemcpdm_frame INPUT PULLUP | MODE0 */
-			0x162 0x108	/* abemcpdm_lb_clk.abemcpdm_lb_clk INPUT PULLDOWN | MODE0 */
+			0x142 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_clks.abe_clks */
+			0x15c (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abemcpdm_ul_data.abemcpdm_ul_data */
+			0x15e (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abemcpdm_dl_data.abemcpdm_dl_data */
+			0x160 (PIN_INPUT_PULLUP | MUX_MODE0)	/* abemcpdm_frame.abemcpdm_frame */
+			0x162 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abemcpdm_lb_clk.abemcpdm_lb_clk */
 		>;
 	};
 
 	dmic_pins: pinmux_dmic_pins {
 		pinctrl-single,pins = <
-			0x144 0x100	/* abedmic_din1.abedmic_din1 INPUT | MODE0 */
-			0x146 0x100	/* abedmic_din2.abedmic_din2 INPUT | MODE0 */
-			0x148 0x100	/* abedmic_din3.abedmic_din3 INPUT | MODE0 */
-			0x14a 0		/* abedmic_clk1.abedmic_clk1 OUTPUT | MODE0 */
+			0x144 (PIN_INPUT | MUX_MODE0)		/* abedmic_din1.abedmic_din1 */
+			0x146 (PIN_INPUT | MUX_MODE0)		/* abedmic_din2.abedmic_din2 */
+			0x148 (PIN_INPUT | MUX_MODE0)		/* abedmic_din3.abedmic_din3 */
+			0x14a (PIN_OUTPUT | MUX_MODE0)		/* abedmic_clk1.abedmic_clk1 */
 		>;
 	};
 
 	mcbsp1_pins: pinmux_mcbsp1_pins {
 		pinctrl-single,pins = <
-			0x14c 0x101	/* abedmic_clk2.abemcbsp1_fsx INPUT | MODE1 */
-			0x14e 0x9	/* abedmic_clk3.abemcbsp1_dx OUTPUT PULLDOWN | MODE1 */
-			0x150 0x101	/* abeslimbus1_clock.abemcbsp1_clkx INPUT | MODE0 */
-			0x152 0x109	/* abeslimbus1_data.abemcbsp1_dr INPUT PULLDOWN | MODE1 */
+			0x14c (PIN_INPUT | MUX_MODE1)		/* abedmic_clk2.abemcbsp1_fsx */
+			0x14e (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* abedmic_clk3.abemcbsp1_dx */
+			0x150 (PIN_INPUT | MUX_MODE1)		/* abeslimbus1_clock.abemcbsp1_clkx */
+			0x152 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* abeslimbus1_data.abemcbsp1_dr */
 		>;
 	};
 
 	mcbsp2_pins: pinmux_mcbsp2_pins {
 		pinctrl-single,pins = <
-			0x154 0x108	/* abemcbsp2_dr.abemcbsp2_dr INPUT PULLDOWN | MODE0 */
-			0x156 0x8	/* abemcbsp2_dx.abemcbsp2_dx OUTPUT PULLDOWN | MODE0 */
-			0x158 0x100	/* abemcbsp2_fsx.abemcbsp2_fsx INPUT | MODE0 */
-			0x15a 0x100	/* abemcbsp2_clkx.abemcbsp2_clkx INPUT | MODE0 */
+			0x154 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abemcbsp2_dr.abemcbsp2_dr */
+			0x156 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* abemcbsp2_dx.abemcbsp2_dx */
+			0x158 (PIN_INPUT | MUX_MODE0)		/* abemcbsp2_fsx.abemcbsp2_fsx */
+			0x15a (PIN_INPUT | MUX_MODE0)		/* abemcbsp2_clkx.abemcbsp2_clkx */
 		>;
 	};
 
-        i2c1_pins: pinmux_i2c1_pins {
-                pinctrl-single,pins = <
-                        0x1b2 0x118        /* i2c1_scl PULLUP | INPUTENABLE | MODE0 */
-                        0x1b4 0x118        /* i2c1_sda PULLUP | INPUTENABLE | MODE0 */
-                >;
-        };
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			0x1b2 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
+			0x1b4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
+		>;
+	};
 
 	i2c2_pins: pinmux_i2c2_pins {
 		pinctrl-single,pins = <
-			0x178 0x100        /* i2c2_scl INPUTENABLE | MODE0 */
-			0x17a 0x100        /* i2c2_sda INPUTENABLE | MODE0 */
+			0x178 (PIN_INPUT | MUX_MODE0)		/* i2c2_scl */
+			0x17a (PIN_INPUT | MUX_MODE0)		/* i2c2_sda */
 		>;
 	};
 
 	i2c3_pins: pinmux_i2c3_pins {
 		pinctrl-single,pins = <
-			0x13a 0x100        /* i2c3_scl INPUTENABLE | MODE0 */
-			0x13c 0x100     /* i2c3_sda INPUTENABLE | MODE0 */
+			0x13a (PIN_INPUT | MUX_MODE0)		/* i2c3_scl */
+			0x13c (PIN_INPUT | MUX_MODE0)		/* i2c3_sda */
 		>;
 	};
 
 	i2c4_pins: pinmux_i2c4_pins {
 		pinctrl-single,pins = <
-			0xb8 0x100        /* i2c4_scl INPUTENABLE | MODE0 */
-			0xba 0x100     /* i2c4_sda INPUTENABLE | MODE0 */
+			0xb8 (PIN_INPUT | MUX_MODE0)		/* i2c4_scl */
+			0xba (PIN_INPUT | MUX_MODE0)		/* i2c4_sda */
 		>;
 	};
 
 	i2c5_pins: pinmux_i2c5_pins {
 		pinctrl-single,pins = <
-			0x184 0x100        /* i2c5_scl INPUTENABLE | MODE0 */
-			0x186 0x100     /* i2c5_sda INPUTENABLE | MODE0 */
+			0x184 (PIN_INPUT | MUX_MODE0)		/* i2c5_scl */
+			0x186 (PIN_INPUT | MUX_MODE0)		/* i2c5_sda */
 		>;
 	};
 
 	mcspi2_pins: pinmux_mcspi2_pins {
 		pinctrl-single,pins = <
-			0xbc 0x100	/*  MCSPI2_CLK INPUTENABLE | MODE0 */
-			0xbe 0x100	/*  MCSPI2_SIMO INPUTENABLE | MODE0 */
-			0xc0 0x118	/*  MCSPI2_SOMI PULLUP | INPUTENABLE | MODE0*/
-			0xc2 0x0	/*  MCSPI2_CS MODE0*/
+			0xbc (PIN_INPUT | MUX_MODE0)		/*  mcspi2_clk */
+			0xbe (PIN_INPUT | MUX_MODE0)		/*  mcspi2_simo */
+			0xc0 (PIN_INPUT_PULLUP | MUX_MODE0)	/*  mcspi2_somi */
+			0xc2 (PIN_OUTPUT | MUX_MODE0)		/*  mcspi2_cs */
 		>;
 	};
 
 	mcspi3_pins: pinmux_mcspi3_pins {
 		pinctrl-single,pins = <
-			0x78 0x101	/*  MCSPI2_SOMI INPUTENABLE | MODE1 */
-			0x7a 0x101	/*  MCSPI2_CS INPUTENABLE | MODE1 */
-			0x7c 0x101	/*  MCSPI2_SIMO INPUTENABLE | MODE1 */
-			0x7e 0x101	/*  MCSPI2_CLK INPUTENABLE | MODE1 */
+			0x78 (PIN_INPUT | MUX_MODE1)		/*  mcspi2_somi */
+			0x7a (PIN_INPUT | MUX_MODE1)		/*  mcspi2_cs */
+			0x7c (PIN_INPUT | MUX_MODE1)		/*  mcspi2_simo */
+			0x7e (PIN_INPUT | MUX_MODE1)		/*  mcspi2_clk */
 		>;
 	};
 
 	mcspi4_pins: pinmux_mcspi4_pins {
 		pinctrl-single,pins = <
-			0x164 0x101	/*  MCSPI2_CLK INPUTENABLE | MODE1 */
-			0x168 0x101	/*  MCSPI2_SIMO INPUTENABLE | MODE1 */
-			0x16a 0x101	/*  MCSPI2_SOMI INPUTENABLE | MODE1 */
-			0x16c 0x101	/*  MCSPI2_CS INPUTENABLE | MODE1 */
+			0x164 (PIN_INPUT | MUX_MODE1)		/*  mcspi2_clk */
+			0x168 (PIN_INPUT | MUX_MODE1)		/*  mcspi2_simo */
+			0x16a (PIN_INPUT | MUX_MODE1)		/*  mcspi2_somi */
+			0x16c (PIN_INPUT | MUX_MODE1)		/*  mcspi2_cs */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 061cf70..825ce300 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -17,6 +17,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pinctrl/omap.h>
 
 #include "skeleton.dtsi"
 
-- 
1.7.5.4


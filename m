From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [RESEND PATCH 10/11] ARM: OMAP4: USB: Add pin mux configuration for panda board
Date: Wed, 31 Oct 2012 19:56:51 +0530
Message-ID: <1351693612-23314-11-git-send-email-keshava_mgowda@ti.com>
References: <1351693612-23314-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1351693612-23314-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The port1 of omap4 panda board is used in ULPI PHY mode.
The pin mux of usbhs (usbb1) port 1 is configured accordingly.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap4-panda.dts |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index dad0df6..ea374cf 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -65,6 +65,7 @@
 			&twl6040_pins
 			&mcpdm_pins
 			&mcbsp1_pins
+			&usbb1_pins   /* port 0 of omap usb host port pin mux configuration */
 	>;
 
 	twl6040_pins: pinmux_twl6040_pins {
@@ -92,6 +93,23 @@
 			0xc4 0x100	/* abe_mcbsp1_fsx.abe_mcbsp1_fsx INPUT | MODE0 */
 		>;
 	};
+
+	usbb1_pins: pinmux_usbb1_pins {
+		pinctrl-single,pins = <
+			0x82 0x10C  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_clk INPUT | PULLDOWN */
+			0x84 0x4  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_stp OUTPUT */
+			0x86 0x104  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dir INPUT | PULLDOWN */
+			0x88 0x104  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_nxt INPUT | PULLDOWN */
+			0x8a 0x104  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat0 INPUT | PULLDOWN */
+			0x8c 0x104  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat1 INPUT | PULLDOWN */
+			0x8e 0x104  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat2 INPUT | PULLDOWN */
+			0x90 0x104  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat3 INPUT | PULLDOWN */
+			0x92 0x104  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat4 INPUT | PULLDOWN */
+			0x94 0x104  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat5 INPUT | PULLDOWN */
+			0x96 0x104  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat6 INPUT | PULLDOWN */
+			0x98 0x104  /* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat7 INPUT | PULLDOWN */
+		>;
+	};
 };
 
 &i2c1 {
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

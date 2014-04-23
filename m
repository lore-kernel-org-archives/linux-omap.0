From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] ARM: dts: Fix bad OTG muxing for cm-t boards
Date: Wed, 23 Apr 2014 12:03:21 -0700
Message-ID: <1398279803-5655-2-git-send-email-tony@atomide.com>
References: <1398279803-5655-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20624 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932516AbaDWTD1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 15:03:27 -0400
In-Reply-To: <1398279803-5655-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>

Looks like the OTG pins are off by 2 and we get this:

pinctrl-single 48002030.pinmux: pin 480021a0.0 already requested by 49020000.serial; cannot claim for 480ab000.usb_otg_hs
pinctrl-single 48002030.pinmux: pin-184 (480ab000.usb_otg_hs) status -22
pinctrl-single 48002030.pinmux: could not request pin 184 (480021a0.0) from group pinmux_hsusb0_pins  on device pinctrl-single
musb-omap2430 480ab000.usb_otg_hs: Error applying setting, reverse things back

That's probably because the TRM lists the values as
32-bit registers so every second needs 2 added to the
address. The OTG pin start range must start from
0x21a2, not 0x21a0.

Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
index d000558..75e0a1f 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
@@ -35,18 +35,18 @@
 
  	hsusb0_pins: pinmux_hsusb0_pins {
 		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)		/* hsusb0_clk.hsusb0_clk */
-			OMAP3_CORE1_IOPAD(0x21a2, PIN_OUTPUT | MUX_MODE0)		/* hsusb0_stp.hsusb0_stp */
-			OMAP3_CORE1_IOPAD(0x21a4, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_dir.hsusb0_dir */
-			OMAP3_CORE1_IOPAD(0x21a6, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_nxt.hsusb0_nxt */
-			OMAP3_CORE1_IOPAD(0x21a8, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data0.hsusb2_data0 */
-			OMAP3_CORE1_IOPAD(0x21aa, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data1.hsusb0_data1 */
-			OMAP3_CORE1_IOPAD(0x21ac, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data2.hsusb0_data2 */
-			OMAP3_CORE1_IOPAD(0x21ae, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data7.hsusb0_data3 */
-			OMAP3_CORE1_IOPAD(0x21b0, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data7.hsusb0_data4 */
-			OMAP3_CORE1_IOPAD(0x21b2, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data7.hsusb0_data5 */
-			OMAP3_CORE1_IOPAD(0x21b4, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data7.hsusb0_data6 */
-			OMAP3_CORE1_IOPAD(0x21b6, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data7.hsusb0_data7 */
+			OMAP3_CORE1_IOPAD(0x21a2, PIN_OUTPUT | MUX_MODE0)		/* hsusb0_clk.hsusb0_clk */
+			OMAP3_CORE1_IOPAD(0x21a4, PIN_OUTPUT | MUX_MODE0)		/* hsusb0_stp.hsusb0_stp */
+			OMAP3_CORE1_IOPAD(0x21a6, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_dir.hsusb0_dir */
+			OMAP3_CORE1_IOPAD(0x21a8, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_nxt.hsusb0_nxt */
+			OMAP3_CORE1_IOPAD(0x21aa, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data0.hsusb2_data0 */
+			OMAP3_CORE1_IOPAD(0x21ac, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data1.hsusb0_data1 */
+			OMAP3_CORE1_IOPAD(0x21ae, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data2.hsusb0_data2 */
+			OMAP3_CORE1_IOPAD(0x21b0, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data7.hsusb0_data3 */
+			OMAP3_CORE1_IOPAD(0x21b2, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data7.hsusb0_data4 */
+			OMAP3_CORE1_IOPAD(0x21b4, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data7.hsusb0_data5 */
+			OMAP3_CORE1_IOPAD(0x21b6, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data7.hsusb0_data6 */
+			OMAP3_CORE1_IOPAD(0x21b8, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data7.hsusb0_data7 */
 		>;
 	};
 };
-- 
1.8.1.1


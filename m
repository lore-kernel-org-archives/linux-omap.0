From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 9/9] ARM/dts: omap5-evm: pinmux configuration for audio
Date: Thu,  4 Oct 2012 14:57:28 +0300
Message-ID: <1349351848-12972-10-git-send-email-peter.ujfalusi@ti.com>
References: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:32835 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755588Ab2JDL4h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 07:56:37 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so333451obb.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Oct 2012 04:56:36 -0700 (PDT)
In-Reply-To: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

u-boot stopped configuring 'non essential' pins recently. The kernel needs
to configure the mux for audio needs.
Since the pinmux for these IPs are static let pinctrl to handle the mux
configuration for.
Configuring the mux for: twl6040 (audpwron), McPDM, DMIC, McBSP1 and McBSP2.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap5-evm.dts | 54 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
index 825e607..c663eba 100644
--- a/arch/arm/boot/dts/omap5-evm.dts
+++ b/arch/arm/boot/dts/omap5-evm.dts
@@ -27,6 +27,60 @@
 
 };
 
+&omap5_pmx_core {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+			&twl6040_pins
+			&mcpdm_pins
+			&dmic_pins
+			&mcbsp1_pins
+			&mcbsp2_pins
+	>;
+
+	twl6040_pins: pinmux_twl6040_pins {
+		pinctrl-single,pins = <
+			0x18a 0x6	/* perslimbus2_clock.gpio5_145 OUTPUT | MODE6 */
+		>;
+	};
+
+	mcpdm_pins: pinmux_mcpdm_pins {
+		pinctrl-single,pins = <
+			0x142 0x108	/* abe_clks.abe_clks INPUT PULLDOWN | MODE0 */
+			0x15c 0x108	/* abemcpdm_ul_data.abemcpdm_ul_data INPUT PULLDOWN | MODE0 */
+			0x15e 0x108	/* abemcpdm_dl_data.abemcpdm_dl_data INPUT PULLDOWN | MODE0 */
+			0x160 0x118	/* abemcpdm_frame.abemcpdm_frame INPUT PULLUP | MODE0 */
+			0x162 0x108	/* abemcpdm_lb_clk.abemcpdm_lb_clk INPUT PULLDOWN | MODE0 */
+		>;
+	};
+
+	dmic_pins: pinmux_dmic_pins {
+		pinctrl-single,pins = <
+			0x144 0x100	/* abedmic_din1.abedmic_din1 INPUT | MODE0 */
+			0x146 0x100	/* abedmic_din2.abedmic_din2 INPUT | MODE0 */
+			0x148 0x100	/* abedmic_din3.abedmic_din3 INPUT | MODE0 */
+			0x14a 0		/* abedmic_clk1.abedmic_clk1 OUTPUT | MODE0 */
+		>;
+	};
+
+	mcbsp1_pins: pinmux_mcbsp1_pins {
+		pinctrl-single,pins = <
+			0x14c 0x101	/* abedmic_clk2.abemcbsp1_fsx INPUT | MODE1 */
+			0x14e 0x9	/* abedmic_clk3.abemcbsp1_dx OUTPUT PULLDOWN | MODE1 */
+			0x150 0x101	/* abeslimbus1_clock.abemcbsp1_clkx INPUT | MODE0 */
+			0x152 0x109	/* abeslimbus1_data.abemcbsp1_dr INPUT PULLDOWN | MODE1 */
+		>;
+	};
+
+	mcbsp2_pins: pinmux_mcbsp2_pins {
+		pinctrl-single,pins = <
+			0x154 0x108	/* abemcbsp2_dr.abemcbsp2_dr INPUT PULLDOWN | MODE0 */
+			0x156 0x8	/* abemcbsp2_dx.abemcbsp2_dx OUTPUT PULLDOWN | MODE0 */
+			0x158 0x100	/* abemcbsp2_fsx.abemcbsp2_fsx INPUT | MODE0 */
+			0x15a 0x100	/* abemcbsp2_clkx.abemcbsp2_clkx INPUT | MODE0 */
+		>;
+	};
+};
+
 &mmc1 {
 	vmmc-supply = <&vmmcsd_fixed>;
 	bus-width = <4>;
-- 
1.7.12


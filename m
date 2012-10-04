From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 6/9] ARM/dts: omap4-sdp: pinmux configuration for audio
Date: Thu,  4 Oct 2012 14:57:25 +0300
Message-ID: <1349351848-12972-7-git-send-email-peter.ujfalusi@ti.com>
References: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:35613 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755560Ab2JDL4a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 07:56:30 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so339707oag.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Oct 2012 04:56:29 -0700 (PDT)
In-Reply-To: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

u-boot stopped configuring 'non essential' pins recently. The kernel needs
to configure the mux for audio needs.
Since the pinmux for these IPs are static let pinctrl to handle the mux
configuration for.
Configuring the mux for: twl6040 (audpwron, irq), McPDM, DMIC, McBSP1 and
McBSP2.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts | 53 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index cf09875..5b7e04f 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -117,6 +117,15 @@
 };
 
 &omap4_pmx_core {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+			&twl6040_pins
+			&mcpdm_pins
+			&dmic_pins
+			&mcbsp1_pins
+			&mcbsp2_pins
+	>;
+
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
 			0xd8 0x118	/* uart2_cts.uart2_cts INPUT_PULLUP | MODE0 */
@@ -141,6 +150,50 @@
 			0x11e 0		/* uart4_tx.uart4_tx OUTPUT | MODE0 */
 		>;
 	};
+
+	twl6040_pins: pinmux_twl6040_pins {
+		pinctrl-single,pins = <
+			0xe0 0x3	/* hdq_sio.gpio_127 OUTPUT | MODE3 */
+			0x160 0x100	/* sys_nirq2.sys_nirq2 INPUT | MODE0 */
+		>;
+	};
+
+	mcpdm_pins: pinmux_mcpdm_pins {
+		pinctrl-single,pins = <
+			0xc6 0x108	/* abe_pdm_ul_data.abe_pdm_ul_data INPUT PULLDOWN | MODE0 */
+			0xc8 0x108	/* abe_pdm_dl_data.abe_pdm_dl_data INPUT PULLDOWN | MODE0 */
+			0xca 0x118	/* abe_pdm_frame.abe_pdm_frame INPUT PULLUP | MODE0 */
+			0xcc 0x108	/* abe_pdm_lb_clk.abe_pdm_lb_clk INPUT PULLDOWN | MODE0 */
+			0xce 0x108	/* abe_clks.abe_clks INPUT PULLDOWN | MODE0 */
+		>;
+	};
+
+	dmic_pins: pinmux_dmic_pins {
+		pinctrl-single,pins = <
+			0xd0 0		/* abe_dmic_clk1.abe_dmic_clk1 OUTPUT | MODE0 */
+			0xd2 0x100	/* abe_dmic_din1.abe_dmic_din1 INPUT | MODE0 */
+			0xd4 0x100	/* abe_dmic_din2.abe_dmic_din2 INPUT | MODE0 */
+			0xd6 0x100	/* abe_dmic_din3.abe_dmic_din3 INPUT | MODE0 */
+		>;
+	};
+
+	mcbsp1_pins: pinmux_mcbsp1_pins {
+		pinctrl-single,pins = <
+			0xbe 0x100	/* abe_mcbsp1_clkx.abe_mcbsp1_clkx INPUT | MODE0 */
+			0xc0 0x108	/* abe_mcbsp1_dr.abe_mcbsp1_dr INPUT PULLDOWN | MODE0 */
+			0xc2 0x8	/* abe_mcbsp1_dx.abe_mcbsp1_dx OUTPUT PULLDOWN | MODE0 */
+			0xc4 0x100	/* abe_mcbsp1_fsx.abe_mcbsp1_fsx INPUT | MODE0 */
+		>;
+	};
+
+	mcbsp2_pins: pinmux_mcbsp2_pins {
+		pinctrl-single,pins = <
+			0xb6 0x100	/* abe_mcbsp2_clkx.abe_mcbsp2_clkx INPUT | MODE0 */
+			0xb8 0x108	/* abe_mcbsp2_dr.abe_mcbsp2_dr INPUT PULLDOWN | MODE0 */
+			0xba 0x8	/* abe_mcbsp2_dx.abe_mcbsp2_dx OUTPUT PULLDOWN | MODE0 */
+			0xbc 0x100	/* abe_mcbsp2_fsx.abe_mcbsp2_fsx INPUT | MODE0 */
+		>;
+	};
 };
 
 &i2c1 {
-- 
1.7.12


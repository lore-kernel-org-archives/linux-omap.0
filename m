From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 7/9] ARM/dts: omap4-panda: pinmux configuration for audio
Date: Thu,  4 Oct 2012 14:57:26 +0300
Message-ID: <1349351848-12972-8-git-send-email-peter.ujfalusi@ti.com>
References: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:59970 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755560Ab2JDL4d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 07:56:33 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so333387obb.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Oct 2012 04:56:32 -0700 (PDT)
In-Reply-To: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

u-boot stopped configuring 'non essential' pins recently. The kernel needs
to configure the mux for audio needs.
Since the pinmux for these IPs are static let pinctrl to handle the mux
configuration for.
Configuring the mux for: twl6040 (audpwron, irq), McPDM and McBSP1.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 771cefd..e8f927c 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -59,6 +59,41 @@
 	};
 };
 
+&omap4_pmx_core {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+			&twl6040_pins
+			&mcpdm_pins
+			&mcbsp1_pins
+	>;
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
+	mcbsp1_pins: pinmux_mcbsp1_pins {
+		pinctrl-single,pins = <
+			0xbe 0x100	/* abe_mcbsp1_clkx.abe_mcbsp1_clkx INPUT | MODE0 */
+			0xc0 0x108	/* abe_mcbsp1_dr.abe_mcbsp1_dr INPUT PULLDOWN | MODE0 */
+			0xc2 0x8		/* abe_mcbsp1_dx.abe_mcbsp1_dx OUTPUT PULLDOWN | MODE0 */
+			0xc4 0x100	/* abe_mcbsp1_fsx.abe_mcbsp1_fsx INPUT | MODE0 */
+		>;
+	};
+};
+
 &i2c1 {
 	clock-frequency = <400000>;
 
-- 
1.7.12


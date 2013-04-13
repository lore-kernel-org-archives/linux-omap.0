From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Configure and fix the McSPI pins for 4430sdp
Date: Fri, 12 Apr 2013 17:26:43 -0700
Message-ID: <20130413002643.GH10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10511 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab3DMA0q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Apr 2013 20:26:46 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

The bootloader configures the pins, but has pull bits
set without pull enable bits. While this is harmless,
and won't do anything, it seems to cause confusion at
least for me every time looking at the pin configuration.
Fix it for DT based boot.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -223,6 +223,15 @@
 		>;
 	};
 
+	mcspi1_pins: pinmux_mcspi1_pins {
+		pinctrl-single,pins = <
+			0xf2 0x100	/*  mcspi1_clk.mcspi1_clk INPUT | MODE0 */
+			0xf4 0x100	/*  mcspi1_somi.mcspi1_somi INPUT | MODE0 */
+			0xf6 0x100	/*  mcspi1_simo.mcspi1_simo INPUT | MODE0 */
+			0xf8 0x100	/*  mcspi1_cs0.mcspi1_cs0 INPUT | MODE0*/
+		>;
+	};
+
 	dss_hdmi_pins: pinmux_dss_hdmi_pins {
 		pinctrl-single,pins = <
 			0x5a 0x118	/* hdmi_cec.hdmi_cec INPUT PULLUP | MODE 0 */
@@ -358,6 +367,9 @@
 };
 
 &mcspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcspi1_pins>;
+
 	eth@0 {
 		compatible = "ks8851";
 		spi-max-frequency = <24000000>;

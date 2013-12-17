From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCHv2 17/27] ARM: omap3-tobi.dts: add lcd (TEST)
Date: Tue, 17 Dec 2013 18:17:28 +0100
Message-ID: <52B08728.8050105@epfl.ch>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com> <1387205794-32246-18-git-send-email-tomi.valkeinen@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:35116 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753453Ab3LQRRc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Dec 2013 12:17:32 -0500
In-Reply-To: <1387205794-32246-18-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

Hello

On 12/16/2013 03:56 PM, Tomi Valkeinen wrote:
> This is a test for Overo with Palo43 expansion, _not_ Tobi. Palo43
> doesn't have a dts, but seems to work ok with omap3-tobi.dts, so I used
> it as a test.
> 
> Not to be merged.
> 

FYI, I got the DVI (HDMI connector) on the Overo/Tobi to work with the patch
below (not to be merged, and probably corrupted by our mail server), until a
framebuffer console. So for me:

Tested-by: Florian Vaussard <florian.vaussard@epfl.ch>

Regards,
Florian

8< --------------------------------
>From 29237c38d35b833efe304b1a58463127555c4748 Mon Sep 17 00:00:00 2001
From: Florian Vaussard <florian.vaussard@epfl.ch>
Date: Tue, 17 Dec 2013 17:47:04 +0100
Subject: [PATCH] ARM: omap3-tobi.dts: add dvi output

Add DVI output to Overo/Tobi board.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo.dtsi | 33 +++++++++++++++++++++++
 arch/arm/boot/dts/omap3-tobi.dts   | 54
++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-overo.dtsi
b/arch/arm/boot/dts/omap3-overo.dtsi
index a461d2f..90b08f6 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -89,6 +89,39 @@
                        0x170 (PIN_OUTPUT | MUX_MODE0) /*
uart3_tx_irtx.uart3_tx_irtx */
                >;
        };
+
+       dss_dpi_pins: pinmux_dss_dpi_pins {
+               pinctrl-single,pins = <
+                       0x0a4 (PIN_OUTPUT | MUX_MODE0)   /*
dss_pclk.dss_pclk */
+                       0x0a6 (PIN_OUTPUT | MUX_MODE0)   /*
dss_hsync.dss_hsync */
+                       0x0a8 (PIN_OUTPUT | MUX_MODE0)   /*
dss_vsync.dss_vsync */
+                       0x0aa (PIN_OUTPUT | MUX_MODE0)   /*
dss_acbias.dss_acbias */
+                       0x0ac (PIN_OUTPUT | MUX_MODE0)   /*
dss_data0.dss_data0 */
+                       0x0ae (PIN_OUTPUT | MUX_MODE0)   /*
dss_data1.dss_data1 */
+                       0x0b0 (PIN_OUTPUT | MUX_MODE0)   /*
dss_data2.dss_data2 */
+                       0x0b2 (PIN_OUTPUT | MUX_MODE0)   /*
dss_data3.dss_data3 */
+                       0x0b4 (PIN_OUTPUT | MUX_MODE0)   /*
dss_data4.dss_data4 */
+                       0x0b6 (PIN_OUTPUT | MUX_MODE0)   /*
dss_data5.dss_data5 */
+                       0x0b8 (PIN_OUTPUT | MUX_MODE0)   /*
dss_data6.dss_data6 */
+                       0x0ba (PIN_OUTPUT | MUX_MODE0)   /*
dss_data7.dss_data7 */
+                       0x0bc (PIN_OUTPUT | MUX_MODE0)   /*
dss_data8.dss_data8 */
+                       0x0be (PIN_OUTPUT | MUX_MODE0)   /*
dss_data9.dss_data9 */
+                       0x0c0 (PIN_OUTPUT | MUX_MODE0)   /*
dss_data10.dss_data10 */
+                       0x0c2 (PIN_OUTPUT | MUX_MODE0)   /*
dss_data11.dss_data11 */
+                       0x0c4 (PIN_OUTPUT | MUX_MODE0)   /*
dss_data12.dss_data12 */
+                       0x0c6 (PIN_OUTPUT | MUX_MODE0)   /*
dss_data13.dss_data13 */
+                       0x0c8 (PIN_OUTPUT | MUX_MODE0)   /*
dss_data14.dss_data14 */
+                       0x0ca (PIN_OUTPUT | MUX_MODE0)   /*
dss_data15.dss_data15 */
+                       0x0cc (PIN_OUTPUT | MUX_MODE0)   /*
dss_data16.dss_data16 */
+                       0x0ce (PIN_OUTPUT | MUX_MODE0)   /*
dss_data17.dss_data17 */
+                       0x0d0 (PIN_OUTPUT | MUX_MODE0)   /*
dss_data18.dss_data18 */
+                       0x0d2 (PIN_OUTPUT | MUX_MODE0)   /*
dss_data19.dss_data19 */
+                       0x0d4 (PIN_OUTPUT | MUX_MODE0)   /*
dss_data20.dss_data20 */
+                       0x0d6 (PIN_OUTPUT | MUX_MODE0)   /*
dss_data21.dss_data21 */
+                       0x0d8 (PIN_OUTPUT | MUX_MODE0)   /*
dss_data22.dss_data22 */
+                       0x0da (PIN_OUTPUT | MUX_MODE0)   /*
dss_data23.dss_data23 */
+               >;
+       };
 };

 &uart3 {
diff --git a/arch/arm/boot/dts/omap3-tobi.dts
b/arch/arm/boot/dts/omap3-tobi.dts
index 7e4ad2a..bfb1a1d 100644
--- a/arch/arm/boot/dts/omap3-tobi.dts
+++ b/arch/arm/boot/dts/omap3-tobi.dts
@@ -81,3 +81,57 @@
 &mmc3 {
        status = "disabled";
 };
+
+&dss {
+       pinctrl-names = "default";
+       pinctrl-0 = <&dss_dpi_pins>;
+
+       vdds_dsi-supply = <&vpll2>;
+
+       dpi_out: endpoint {
+               remote-endpoint = <&tfp410_in>;
+               data-lines = <24>;
+       };
+};
+
+/ {
+       aliases {
+               display0 = &dvi0;
+       };
+
+       tfp410: encoder@0 {
+               compatible = "ti,tfp410";
+
+               ports {
+                       #address-cells = <1>;
+                       #size-cells = <0>;
+
+                       port@0 {
+                               reg = <0>;
+
+                               tfp410_in: endpoint@0 {
+                                       remote-endpoint = <&dpi_out>;
+                               };
+                       };
+
+                       port@1 {
+                               reg = <1>;
+
+                               tfp410_out: endpoint@0 {
+                                       remote-endpoint =
<&dvi_connector_in>;
+                               };
+                       };
+               };
+       };
+
+       dvi0: connector@0 {
+               compatible = "dvi-connector";
+               label = "dvi";
+
+               i2c-bus = <&i2c3>;
+
+               dvi_connector_in: endpoint {
+                       remote-endpoint = <&tfp410_out>;
+               };
+       };
+};
-- 
1.8.1.2



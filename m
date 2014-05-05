From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 2/7] phy: omap-usb2: Add clock names to Documentation binding
Date: Mon, 5 May 2014 12:54:41 +0300
Message-ID: <1399283686-6127-3-git-send-email-rogerq@ti.com>
References: <1399283686-6127-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57430 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756010AbaEEJzA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 May 2014 05:55:00 -0400
In-Reply-To: <1399283686-6127-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kishon@ti.com, tony@atomide.com, balbi@ti.com, bcousson@baylibre.com
Cc: george.cherian@ti.com, sergei.shtylyov@cogentembedded.com, nm@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Add "wkupclk" and "refclk" information to DT binding information.

Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/phy/ti-phy.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
index 788fb0f..9ce458f 100644
--- a/Documentation/devicetree/bindings/phy/ti-phy.txt
+++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
@@ -32,6 +32,11 @@ Required properties:
  - reg : Address and length of the register set for the device.
  - #phy-cells: determine the number of cells that should be given in the
    phandle while referencing this phy.
+ - clocks: a list of phandles and clock-specifier pairs, one for each entry in
+   clock-names.
+ - clock-names: should include:
+   * "wkupclk" - wakeup clock.
+   * "refclk" - reference clock (optional).
 
 Optional properties:
  - ctrl-module : phandle of the control module used by PHY driver to power on
@@ -44,6 +49,8 @@ usb2phy@4a0ad080 {
 	reg = <0x4a0ad080 0x58>;
 	ctrl-module = <&omap_control_usb>;
 	#phy-cells = <0>;
+	clocks = <&usb_phy_cm_clk32k>, <&usb_otg_ss_refclk960m>;
+	clock-names = "wkupclk", "refclk";
 };
 
 TI PIPE3 PHY
-- 
1.8.3.2


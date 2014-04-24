From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 23/23] Doc/DT: Add OMAP5 DSS DT bindings
Date: Thu, 24 Apr 2014 13:17:19 +0300
Message-ID: <1398334639-14172-24-git-send-email-tomi.valkeinen@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58162 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755100AbaDXKTo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2014 06:19:44 -0400
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree@vger.kernel.org

Add DT binding documentation for OMAP5 Display Subsystem.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org
---
 .../devicetree/bindings/video/ti,omap5-dss.txt     | 96 ++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/ti,omap5-dss.txt

diff --git a/Documentation/devicetree/bindings/video/ti,omap5-dss.txt b/Documentation/devicetree/bindings/video/ti,omap5-dss.txt
new file mode 100644
index 000000000000..38ffc8fcd816
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/ti,omap5-dss.txt
@@ -0,0 +1,96 @@
+Texas Instruments OMAP5 Display Subsystem
+=========================================
+
+See Documentation/devicetree/bindings/video/ti,omap-dss.txt for generic
+description about OMAP Display Subsystem bindings.
+
+DSS Core
+--------
+
+Required properties:
+- compatible: "ti,omap5-dss"
+- reg: address and length of the register space
+- ti,hwmods: "dss_core"
+- clocks: handle to fclk
+- clock-names: "fck"
+
+Required nodes:
+- DISPC
+
+Optional nodes:
+- DSS Submodules: RFBI, DSI, HDMI
+- Video port for DPI output
+
+DPI Endpoint required properties:
+- data-lines: number of lines used
+
+
+DISPC
+-----
+
+Required properties:
+- compatible: "ti,omap5-dispc"
+- reg: address and length of the register space
+- ti,hwmods: "dss_dispc"
+- interrupts: the DISPC interrupt
+- clocks: handle to fclk
+- clock-names: "fck"
+
+
+RFBI
+----
+
+Required properties:
+- compatible: "ti,omap5-rfbi"
+- reg: address and length of the register space
+- ti,hwmods: "dss_rfbi"
+- clocks: handles to fclk and iclk
+- clock-names: "fck", "ick"
+
+Optional nodes:
+- Video port for RFBI output
+- RFBI controlled peripherals
+
+
+DSI
+---
+
+Required properties:
+- compatible: "ti,omap5-dsi"
+- reg: addresses and lengths of the register spaces for 'proto', 'phy' and 'pll'
+- reg-names: "proto", "phy", "pll"
+- interrupts: the DSI interrupt line
+- ti,hwmods: "dss_dsi1" or "dss_dsi2"
+- vdd-supply: power supply for DSI
+- clocks: handles to fclk and pll clock
+- clock-names: "fck", "sys_clk"
+
+Optional nodes:
+- Video port for DSI output
+- DSI controlled peripherals
+
+DSI Endpoint required properties:
+- lanes: list of pin numbers for the DSI lanes: CLK+, CLK-, DATA0+, DATA0-,
+  DATA1+, DATA1-, ...
+
+
+HDMI
+----
+
+Required properties:
+- compatible: "ti,omap5-hdmi"
+- reg: addresses and lengths of the register spaces for 'wp', 'pll', 'phy',
+       'core'
+- reg-names: "wp", "pll", "phy", "core"
+- interrupts: the HDMI interrupt line
+- ti,hwmods: "dss_hdmi"
+- vdda-supply: vdda power supply
+- clocks: handles to fclk and pll clock
+- clock-names: "fck", "sys_clk"
+
+Optional nodes:
+- Video port for HDMI output
+
+HDMI Endpoint optional properties:
+- lanes: list of 8 pin numbers for the HDMI lanes: CLK+, CLK-, D0+, D0-,
+  D1+, D1-, D2+, D2-. (default: 0,1,2,3,4,5,6,7)
-- 
1.9.1


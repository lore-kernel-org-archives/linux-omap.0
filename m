From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/14] Doc/DT: Add DT binding doc for DRA7xx DSS
Date: Tue, 27 Jan 2015 12:50:35 +0200
Message-ID: <1422355842-11234-8-git-send-email-tomi.valkeinen@ti.com>
References: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35771 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757736AbbA0KvF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Jan 2015 05:51:05 -0500
In-Reply-To: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree@vger.kernel.org

Add device tree binding documentation for DRA7xx display subsystem.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org
---
 .../devicetree/bindings/video/ti,dra7-dss.txt      | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/ti,dra7-dss.txt

diff --git a/Documentation/devicetree/bindings/video/ti,dra7-dss.txt b/Documentation/devicetree/bindings/video/ti,dra7-dss.txt
new file mode 100644
index 000000000000..f33a05137b0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/ti,dra7-dss.txt
@@ -0,0 +1,69 @@
+Texas Instruments DRA7x Display Subsystem
+=========================================
+
+See Documentation/devicetree/bindings/video/ti,omap-dss.txt for generic
+description about OMAP Display Subsystem bindings.
+
+DSS Core
+--------
+
+Required properties:
+- compatible: "ti,dra7-dss"
+- reg: address and length of the register spaces for 'dss'
+- ti,hwmods: "dss_core"
+- clocks: handle to fclk
+- clock-names: "fck"
+- syscon: phandle to control module core syscon node
+
+Optional properties:
+
+Some DRA7xx SoCs have one dedicated video PLL, some have two. These properties
+can be used to describe the video PLLs:
+
+- reg: address and length of the register spaces for 'pll1_clkctrl',
+  'pll1', 'pll2_clkctrl', 'pll2'
+- clocks: handle to video1 pll clock and video2 pll clock
+- clock-names: "video1_clk" and "video2_clk"
+
+Required nodes:
+- DISPC
+
+Optional nodes:
+- DSS Submodules: HDMI
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
+- compatible: "ti,dra7-dispc"
+- reg: address and length of the register space
+- ti,hwmods: "dss_dispc"
+- interrupts: the DISPC interrupt
+- clocks: handle to fclk
+- clock-names: "fck"
+
+HDMI
+----
+
+Required properties:
+- compatible: "ti,dra7-hdmi"
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
2.2.2


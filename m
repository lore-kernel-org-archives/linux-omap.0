From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 4/9] mfd: omap-usb-tll: Update DT clock binding information
Date: Thu, 9 Jan 2014 17:38:18 +0530
Message-ID: <1389269303-30465-5-git-send-email-rogerq@ti.com>
References: <1389269303-30465-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1389269303-30465-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: balbi@ti.com, arnd@arndb.de, sre@debian.org, mark.rutland@arm.com, m.paolino@virtualopensystems.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

The omap-usb-tll driver needs one clock for each TLL channel.
Add this information to the DT binding document.

CC: Lee Jones <lee.jones@linaro.org>
CC: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/mfd/omap-usb-tll.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt b/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
index 62fe697..c58d704 100644
--- a/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
+++ b/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
@@ -7,6 +7,16 @@ Required properties:
 - interrupts : should contain the TLL module's interrupt
 - ti,hwmod : must contain "usb_tll_hs"
 
+Optional properties:
+
+- clocks: a list of phandles and clock-specifier pairs, one for each entry in
+  clock-names.
+
+- clock-names: should include:
+  * "usb_tll_hs_usb_ch0_clk" - USB TLL channel 0 clock
+  * "usb_tll_hs_usb_ch1_clk" - USB TLL channel 1 clock
+  * "usb_tll_hs_usb_ch2_clk" - USB TLL channel 2 clock
+
 Example:
 
 	usbhstll: usbhstll@4a062000 {
-- 
1.8.3.2

From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 05/10] ARM: dts: am4372: Add control module syscon node
Date: Tue, 4 Nov 2014 12:48:49 +0200
Message-ID: <1415098134-26405-6-git-send-email-rogerq@ti.com>
References: <1415098134-26405-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1415098134-26405-1-git-send-email-rogerq@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, wsa@the-dreams.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Use syscon regmap to expose the Control module register space.
This register space is shared between many users e.g. DCAN, USB, display, etc.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 46660ff..899c57c 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -57,6 +57,11 @@
 		cache-level = <2>;
 	};
 
+	am43xx_control_module: control_module@4a002000 {
+		compatible = "syscon";
+		reg = <0x44e10000 0x7f4>;
+	};
+
 	am43xx_pinmux: pinmux@44e10800 {
 		compatible = "ti,am437-padconf", "pinctrl-single";
 		reg = <0x44e10800 0x31c>;
-- 
1.8.3.2


From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 11/12] ARM: dts: am33xx: Add control module syscon node
Date: Tue, 9 Sep 2014 17:55:33 +0300
Message-ID: <1410274534-22826-12-git-send-email-rogerq@ti.com>
References: <1410274534-22826-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1410274534-22826-1-git-send-email-rogerq@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Use syscon regmap to expose the Control module register space.
This register space is shared between many users e.g. DCAN, USB, display, etc.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 3a0a161..492c043 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -83,6 +83,11 @@
 		};
 	};
 
+	am33xx_control_module: control_module@4a002000 {
+		compatible = "syscon";
+		reg = <0x44e10000 0x7fc>;
+	};
+
 	am33xx_pinmux: pinmux@44e10800 {
 		compatible = "pinctrl-single";
 		reg = <0x44e10800 0x0238>;
-- 
1.8.3.2


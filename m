From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 12/12] ARM: dts: omap3: Fix gpmc memory resource size
Date: Fri, 10 Jul 2015 15:23:39 +0300
Message-ID: <1436531019-18088-13-git-send-email-rogerq@ti.com>
References: <1436531019-18088-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436531019-18088-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, dwmw2@infradead.org, computersforpeace@gmail.com, bcousson@baylibre.com
Cc: ezequiel@vanguardiasur.com.ar, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The last register address is offset at 0x2d0 but is a
4 bit register. So total GPMC register resource size
is 0x2d4

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 69a40cf..f9623f7 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -714,7 +714,7 @@
 		gpmc: gpmc@6e000000 {
 			compatible = "ti,omap3430-gpmc";
 			ti,hwmods = "gpmc";
-			reg = <0x6e000000 0x02d0>;
+			reg = <0x6e000000 0x02d4>;
 			interrupts = <20>;
 			gpmc,num-cs = <8>;
 			gpmc,num-waitpins = <4>;
-- 
2.1.4

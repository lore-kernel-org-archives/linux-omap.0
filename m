From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 14/22] ARM: dts: OMAP2+: Fix NAND device nodes.
Date: Fri, 7 Aug 2015 12:12:24 +0300
Message-ID: <1438938752-31010-15-git-send-email-rogerq@ti.com>
References: <1438938752-31010-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438938752-31010-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: dwmw2@infradead.org, computersforpeace@gmail.com, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Add compatible id, GPMC register resource and interrupt
resource to NAND controller nodes.

TODO: For now only dra7-evm and omap3-beagle are fixed.
Once series is reviewed I'll update this patch to
fix all omap boards.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts     | 4 +++-
 arch/arm/boot/dts/omap3-beagle.dts | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 096f68b..ce11b0f 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -569,9 +569,11 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_flash_x16>;
-	ranges = <0 0 0 0x01000000>;	/* minimum GPMC partition = 16MB */
+	ranges = <0 0 0x08000000 0x01000000>;	/* minimum GPMC partition = 16MB */
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>;		/* device IO registers */
+		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <16>;
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index a547411..34cf55e 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -384,7 +384,8 @@
 
 	/* Chip select 0 */
 	nand@0,0 {
-		reg = <0 0 4>;		/* NAND I/O window, 4 bytes */
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>;		/* CS0, offset 0, IO size 4 */
 		interrupts = <20>;
 		ti,nand-ecc-opt = "ham1";
 		nand-bus-width = <16>;
-- 
2.1.4

From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/4] ARM: dts: am437x-cm-t43: Correct tps65218 irq type
Date: Fri, 20 Apr 2018 14:38:20 +0300
Message-ID: <20180420113822.17577-3-peter.ujfalusi@ti.com>
References: <20180420113822.17577-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180420113822.17577-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

According to the documentation the interrupt line is active low.

The patch will silence the warning from gic_irq_domain_translate():
"Make it clear that broken DTs are... broken"

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am437x-cm-t43.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
index 3b9a94c274a7..54f67f98046c 100644
--- a/arch/arm/boot/dts/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -203,7 +203,7 @@
 	tps65218: tps65218@24 {
 		compatible = "ti,tps65218";
 		reg = <0x24>;
-		interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* NMIn */
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_LOW>; /* NMIn */
 		interrupt-parent = <&gic>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

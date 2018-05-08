From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/4] Revert "ARM: dts: am437x-sk-evm: Correct tps65218 irq type"
Date: Tue, 8 May 2018 16:20:53 +0300
Message-ID: <20180508132053.5471-5-peter.ujfalusi@ti.com>
References: <20180508132053.5471-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180508132053.5471-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

This reverts commit 561f9bcf268422ebe78a1739d86a255fd481c71c.

While the correct IRQ level fixed the WARN_ON(), but prevented the probe
of tps65218 as GIC_SPI does not support LEVEL_LOW (?)

Use LEVEL_HIGH as it looks to be the accurate one since the INTn of TPS is
connected to NMIn of the SoC.

Fixes: 561f9bcf2684 ("ARM: dts: am437x-sk-evm: Correct tps65218 irq type")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index ca5c9070476c..4118802b7fea 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -429,7 +429,7 @@
 	tps@24 {
 		compatible = "ti,tps65218";
 		reg = <0x24>;
-		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

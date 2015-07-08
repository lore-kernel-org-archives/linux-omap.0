From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 3/6] ARM: dts: AM4372: Add PRCM IRQ entry
Date: Wed, 8 Jul 2015 11:12:25 +0530
Message-ID: <1436334148-9309-4-git-send-email-j-keerthy@ti.com>
References: <1436334148-9309-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436334148-9309-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, galak@codeaurora.org, pawel.moll@arm.com, paul@pwsan.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Add PRCM IRQ entry.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index c80a3e2..637133b 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -86,6 +86,7 @@
 			prcm: prcm@1f0000 {
 				compatible = "ti,am4-prcm";
 				reg = <0x1f0000 0x11000>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 
 				prcm_clocks: clocks {
 					#address-cells = <1>;
-- 
1.9.1

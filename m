From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 28/28] ARM: dts: AM43xx: Add node for RNG
Date: Wed, 1 Jun 2016 12:06:46 +0300
Message-ID: <1464772006-11254-9-git-send-email-t-kristo@ti.com>
References: <1464771389-10640-1-git-send-email-t-kristo@ti.com>
 <1464772006-11254-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <1464772006-11254-1-git-send-email-t-kristo@ti.com>
Sender: linux-crypto-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, lokeshvutla@ti.com
List-Id: linux-omap@vger.kernel.org

From: Lokesh Vutla <lokeshvutla@ti.com>

Adding DT node for hardware random number generator.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 12fcde4..a44ee94 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -843,6 +843,13 @@
 			dma-names = "tx", "rx";
 		};
 
+		rng: rng@48310000 {
+			compatible = "ti,omap4-rng";
+			ti,hwmods = "rng";
+			reg = <0x48310000 0x2000>;
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		mcasp0: mcasp@48038000 {
 			compatible = "ti,am33xx-mcasp-audio";
 			ti,hwmods = "mcasp0";
-- 
1.9.1

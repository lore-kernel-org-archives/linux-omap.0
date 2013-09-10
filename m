From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 2/3] ARM: dts: add AM33XX SPI DMA support
Date: Tue, 10 Sep 2013 14:24:38 -0500
Message-ID: <1378841079-15796-3-git-send-email-joelf@ti.com>
References: <1378841079-15796-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1378841079-15796-1-git-send-email-joelf@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>, Devicetree Discuss <devicetree@vger.kernel.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux SPI Devel List <spi-devel-general@lists.sourceforge.net>
List-Id: linux-omap@vger.kernel.org

From: Matt Porter <mporter@ti.com>

Adds DMA resources to the AM33XX SPI nodes.

Signed-off-by: Matt Porter <mporter@ti.com>
Signed-off-by: Joel A Fernandes <joelagnel@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 19a1c1d..9ce85e5 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -335,6 +335,11 @@
 			interrupts = <65>;
 			ti,spi-num-cs = <2>;
 			ti,hwmods = "spi0";
+			dmas = <&edma 16
+				&edma 17
+				&edma 18
+				&edma 19>;
+			dma-names = "tx0", "rx0", "tx1", "rx1";
 			status = "disabled";
 		};
 
@@ -346,6 +351,11 @@
 			interrupts = <125>;
 			ti,spi-num-cs = <2>;
 			ti,hwmods = "spi1";
+			dmas = <&edma 42
+				&edma 43
+				&edma 44
+				&edma 45>;
+			dma-names = "tx0", "rx0", "tx1", "rx1";
 			status = "disabled";
 		};
 
-- 
1.8.1.2


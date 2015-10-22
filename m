From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/4] arm: dts: add dm816x missing spi DT dma handles
Date: Thu, 22 Oct 2015 11:19:17 +0200
Message-ID: <5628AA15.6020908@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, fisaksen@baylibre.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add the missing SPI controller DMA handler in the dm816x DT
node, only properties for the two channels on four were present.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/dm816x.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index a7a34e4..eee636d 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -280,8 +280,11 @@
 			ti,spi-num-cs = <4>;
 			ti,hwmods = "mcspi1";
 			dmas = <&edma 16 &edma 17
-				&edma 18 &edma 19>;
-			dma-names = "tx0", "rx0", "tx1", "rx1";
+				&edma 18 &edma 19
+				&edma 20 &edma 21
+				&edma 22 &edma 23>;
+			dma-names = "tx0", "rx0", "tx1", "rx1",
+				    "tx2", "rx2", "tx3", "rx3";
 		};

 		mmc1: mmc@48060000 {
-- 
1.9.1

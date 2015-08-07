From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 21/22] ARM: dts: dra7x-evm: Provide NAND ready pin
Date: Fri, 7 Aug 2015 12:12:31 +0300
Message-ID: <1438938752-31010-22-git-send-email-rogerq@ti.com>
References: <1438938752-31010-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438938752-31010-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: dwmw2@infradead.org, computersforpeace@gmail.com, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On these boards NAND ready pin status is avilable over
GPMC_WAIT0 pin.

Read speed increases from 13768 KiB/ to 17246 KiB/s.
Write speed was unchanged at 7123 KiB/s.
Measured using mtd_speedtest.ko.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts  | 1 +
 arch/arm/boot/dts/dra72-evm.dts | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 3fb1ced..b717fd0 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -575,6 +575,7 @@
 		reg = <0 0 4>;		/* device IO registers */
 		interrupt-parent = <&crossbar_mpu>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+		ready-gpio = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 pin */
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <16>;
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index fc0677a..c1a3397 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -387,6 +387,7 @@
 		 */
 		reg = <0 0 4>;		/* device IO registers */
 		interrupt-parent = <&crossbar_mpu>;
+		ready-gpio = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 pin */
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <16>;
-- 
2.1.4

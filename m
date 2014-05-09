From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v4 6/6] ARM: dts: am335x-evm: fix reg and range property of GPMC NAND node
Date: Sat, 10 May 2014 02:16:52 +0530
Message-ID: <1399668412-10818-4-git-send-email-pekon@ti.com>
References: <1399668412-10818-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42427 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757709AbaEIUrg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 16:47:36 -0400
In-Reply-To: <1399668412-10818-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com
Cc: linux-omap <linux-omap@vger.kernel.org>, Pekon Gupta <pekon@ti.com>

1) NAND device memory is not directly accessible to CPU, its indirectly accessed
   via registers. So the 'reg' property for GPMC NAND nodes should be limited to
   address range of internal GPMC registers only.
2) Also, minimum granularity of address space under a GPMC chip-select is 16MB
   so 'range' property for GPMC NAND node should specify 16MB as its memory-size
3) On AM437x, address map of external memory accessible via GPMC starts from 0x0

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 33f7c57..bae7575 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -437,9 +437,9 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&nandflash_pins_s0>;
-	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
+	ranges = <0 0 0 0x1000000>;	/* CS0: NAND */
 	nand@0,0 {
-		reg = <0 0 0>; /* CS0, offset 0 */
+		reg = <0 0 0x380>; /* CS0, offset=0, reg-map size=0x380 */
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
-- 
1.8.5.1.163.gd7aced9


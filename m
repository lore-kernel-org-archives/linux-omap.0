From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v4 5/6] ARM: dts: am43x-epos-evm: fix reg and range property of GPMC NAND node
Date: Sat, 10 May 2014 02:16:51 +0530
Message-ID: <1399668412-10818-3-git-send-email-pekon@ti.com>
References: <1399668412-10818-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46282 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757696AbaEIUre (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 16:47:34 -0400
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
 arch/arm/boot/dts/am43x-epos-evm.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index fd29930..63a6a59 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -287,9 +287,9 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_flash_x8>;
-	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
+	ranges = <0 0 0 0x1000000>;	/* CS0: NAND */
 	nand@0,0 {
-		reg = <0 0 0>; /* CS0, offset 0 */
+		reg = <0 0 0x380>; /* CS0, offset=0, re-map size=0x380 */
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
-- 
1.8.5.1.163.gd7aced9


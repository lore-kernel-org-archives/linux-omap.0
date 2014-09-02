From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/6] ARM: dts: am437x-gp-evm: Use BCH16 ECC scheme instead of BCH8
Date: Tue, 2 Sep 2014 16:57:03 +0300
Message-ID: <1409666227-20622-3-git-send-email-rogerq@ti.com>
References: <1409666227-20622-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49574 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753200AbaIBN5X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Sep 2014 09:57:23 -0400
In-Reply-To: <1409666227-20622-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: pekon@pek-sem.com, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

am437x-gp-evm uses a NAND chip with page size 4096 bytes
and spare area of 225 bytes per page.

For such a setup it is preferrable to use BCH16 ECC scheme over
BCH8. This also makes it compatible with ROM code ECC scheme so
we can boot with NAND after flashing from kernel.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 646a6ea..402249e 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -424,7 +424,7 @@
 	ranges = <0 0 0 0x01000000>;	/* minimum GPMC partition = 16MB */
 	nand@0,0 {
 		reg = <0 0 4>;		/* device IO registers */
-		ti,nand-ecc-opt = "bch8";
+		ti,nand-ecc-opt = "bch16";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
 		gpmc,device-width = <1>;
-- 
1.8.3.2


From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] ARM: dts: am335x-evm: Fix 5th NAND partition's name
Date: Tue, 21 Oct 2014 14:25:45 +0300
Message-ID: <1413890745-3855-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50863 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755251AbaJUL0X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Oct 2014 07:26:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: javier.martinez@collabora.co.uk, pekon@pek-sem.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>, Sekhar Nori <nsekhar@ti.com>

The 5th NAND partition should be named "NAND.u-boot-spl-os"
instead of "NAND.u-boot-spl". This is to be consistent with other
TI boards as well as u-boot.

Fixes: 91994facdd2d ("ARM: dts: am335x-evm: NAND: update MTD partition table")

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index e2156a5..c4b968f 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -489,7 +489,7 @@
 			reg = <0x00060000 0x00020000>;
 		};
 		partition@4 {
-			label = "NAND.u-boot-spl";
+			label = "NAND.u-boot-spl-os";
 			reg = <0x00080000 0x00040000>;
 		};
 		partition@5 {
-- 
1.8.3.2


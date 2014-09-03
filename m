From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/2] ARM: dts: dra7-evm: Fix 8th NAND partition's name
Date: Wed, 3 Sep 2014 14:17:32 +0300
Message-ID: <1409743052-632-3-git-send-email-rogerq@ti.com>
References: <1409743052-632-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47065 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755981AbaICLSV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Sep 2014 07:18:21 -0400
In-Reply-To: <1409743052-632-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: nm@ti.com, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Pekon Gupta <pekon@pek-sem.com>, Sekhar Nori <nsekhar@ti.com>

The 8th NAND partition should be named "NAND.u-boot-env.backup1"
instead of "NAND.u-boot-env". This is to be consistent with other
TI boards as well as u-boot.

CC: Pekon Gupta <pekon@pek-sem.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 42f5bc9..990ee6a 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -483,7 +483,7 @@
 			reg = <0x001c0000 0x00020000>;
 		};
 		partition@7 {
-			label = "NAND.u-boot-env";
+			label = "NAND.u-boot-env.backup1";
 			reg = <0x001e0000 0x00020000>;
 		};
 		partition@8 {
-- 
1.8.3.2


From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v4 4/6] ARM: dts: am43xx: fix starting offset of NAND.filesystem MTD partition
Date: Sat, 10 May 2014 02:16:50 +0530
Message-ID: <1399668412-10818-2-git-send-email-pekon@ti.com>
References: <1399668412-10818-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46279 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757700AbaEIUrd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 16:47:33 -0400
In-Reply-To: <1399668412-10818-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com
Cc: linux-omap <linux-omap@vger.kernel.org>, Pekon Gupta <pekon@ti.com>

MTD NAND partition for file-system should start at offset=0xA00000

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index cf8bdf1..fd29930 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -360,7 +360,7 @@
 		};
 		partition@9 {
 			label = "NAND.file-system";
-			reg = <0x00800000 0x1F600000>;
+			reg = <0x00A00000 0x1F600000>;
 		};
 	};
 };
-- 
1.8.5.1.163.gd7aced9


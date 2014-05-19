From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v7 4/4] ARM: dts: am43xx: fix starting offset of NAND.filesystem MTD partition
Date: Mon, 19 May 2014 14:45:48 +0530
Message-ID: <1400490948-11571-5-git-send-email-pekon@ti.com>
References: <1400490948-11571-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58165 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753827AbaESJQJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 May 2014 05:16:09 -0400
In-Reply-To: <1400490948-11571-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, Javier Martinez Canillas <javier@dowhile0.org>, Roger Quadros <rogerq@ti.com>, Pekon Gupta <pekon@ti.com>

MTD NAND partition for file-system should start at offset=0xA00000

Signed-off-by: Pekon Gupta <pekon@ti.com>
Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 2a0fbbb..ad362c5 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -366,7 +366,7 @@
 		};
 		partition@9 {
 			label = "NAND.file-system";
-			reg = <0x00800000 0x1F600000>;
+			reg = <0x00a00000 0x1f600000>;
 		};
 	};
 };
-- 
1.8.5.1.163.gd7aced9


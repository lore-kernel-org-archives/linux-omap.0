From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v6 4/4] ARM: dts: am43xx: fix starting offset of NAND.filesystem MTD partition
Date: Fri, 16 May 2014 16:33:50 +0530
Message-ID: <1400238230-26357-5-git-send-email-pekon@ti.com>
References: <1400238230-26357-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42276 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757086AbaEPLET (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 May 2014 07:04:19 -0400
In-Reply-To: <1400238230-26357-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, Roger Quadros <rogerq@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Pekon Gupta <pekon@ti.com>

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


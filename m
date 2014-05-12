From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v5 4/4] ARM: dts: am43xx: fix starting offset of NAND.filesystem MTD partition
Date: Mon, 12 May 2014 17:19:13 +0530
Message-ID: <1399895353-3663-5-git-send-email-pekon@ti.com>
References: <1399895353-3663-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51550 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754529AbaELLtm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 May 2014 07:49:42 -0400
In-Reply-To: <1399895353-3663-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, bcousson@baylibre.com, Pekon Gupta <pekon@ti.com>

MTD NAND partition for file-system should start at offset=0xA00000

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index cf8bdf1..9f6a176 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -360,7 +360,7 @@
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


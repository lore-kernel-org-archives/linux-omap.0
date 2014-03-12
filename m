From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v2 2/2] ARM: dts: am43xx: fix starting offset of NAND.filesystem MTD partition
Date: Wed, 12 Mar 2014 15:15:47 +0530
Message-ID: <1394617547-25240-3-git-send-email-pekon@ti.com>
References: <1394617547-25240-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52405 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753129AbaCLJqE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Mar 2014 05:46:04 -0400
In-Reply-To: <1394617547-25240-1-git-send-email-pekon@ti.com>
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
index 167dbc8..d09e6fb 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -341,7 +341,7 @@
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


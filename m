From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 2/9] omap4: dts: Add node for DES3DES module
Date: Wed, 25 Sep 2013 17:01:02 -0500
Message-ID: <1380146469-29496-3-git-send-email-joelf@ti.com>
References: <1380146469-29496-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52079 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754937Ab3IYWCW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Sep 2013 18:02:22 -0400
In-Reply-To: <1380146469-29496-1-git-send-email-joelf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@secretlab.ca>, Jason Kridner <jkridner@beagleboard.org>, Koen Kooi <koen@beagleboard.org>
Cc: Devicetree Discuss <devicetree@vger.kernel.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Joel Fernandes <joelf@ti.com>

OMAP4 has an DES3DES  module that uses the omap-des crypto driver.
Add DT entries for the same.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 4267a74..0e72401 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -673,5 +673,15 @@
 			dmas = <&sdma 111>, <&sdma 110>;
 			dma-names = "tx", "rx";
 		};
+
+		des: des@480A5000 {
+			compatible = "ti,omap4-des";
+			ti,hwmods = "des";
+			reg = <0x480a5000 0xa0>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 82 0x4>;
+			dmas = <&sdma 117>, <&sdma 116>;
+			dma-names = "tx", "rx";
+		};
 	};
 };
-- 
1.8.1.2


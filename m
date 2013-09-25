From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 1/9] omap4: dts: Add node for AES
Date: Wed, 25 Sep 2013 17:01:01 -0500
Message-ID: <1380146469-29496-2-git-send-email-joelf@ti.com>
References: <1380146469-29496-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50250 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752857Ab3IYWCR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Sep 2013 18:02:17 -0400
In-Reply-To: <1380146469-29496-1-git-send-email-joelf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@secretlab.ca>, Jason Kridner <jkridner@beagleboard.org>, Koen Kooi <koen@beagleboard.org>
Cc: Devicetree Discuss <devicetree@vger.kernel.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Joel Fernandes <joelf@ti.com>

OMAP4 has an AES module that uses the omap-aes crypto driver.
Add DT entries for the same.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 45708e1..4267a74 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -663,5 +663,15 @@
 			ram-bits = <12>;
 			ti,has-mailbox;
 		};
+
+		aes: aes@4B501000 {
+			compatible = "ti,omap4-aes";
+			ti,hwmods = "aes";
+			reg = <0x4B501000 0xa0>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 85 0x4>;
+			dmas = <&sdma 111>, <&sdma 110>;
+			dma-names = "tx", "rx";
+		};
 	};
 };
-- 
1.8.1.2


From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v4 1/5] ARM: dts: dra7-evm: Remove the wrong and undocumented compatible
Date: Tue, 29 Apr 2014 16:35:09 +0530
Message-ID: <1398769513-8736-2-git-send-email-rnayak@ti.com>
References: <1398769513-8736-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49071 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964805AbaD2LHX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Apr 2014 07:07:23 -0400
In-Reply-To: <1398769513-8736-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, bcousson@baylibre.com, nm@ti.com, arnd@arndb.de, s-anna@ti.com, Rajendra Nayak <rnayak@ti.com>

"ti,dra752" is neither documented nor correct, since the device is actually a
dra742 device as rightly documented in dt bindings.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: devicetree@vger.kernel.org
---
 arch/arm/boot/dts/dra7-evm.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 5babba0..7807429 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -11,7 +11,7 @@
 
 / {
 	model = "TI DRA7";
-	compatible = "ti,dra7-evm", "ti,dra752", "ti,dra7";
+	compatible = "ti,dra7-evm", "ti,dra7";
 
 	memory {
 		device_type = "memory";
-- 
1.7.9.5


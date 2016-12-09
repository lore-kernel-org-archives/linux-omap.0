From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH 1/4] ARM: dts: am335x: Fix the interrupt name of TPS65217
Date: Fri,  9 Dec 2016 15:28:30 +0900
Message-ID: <20161209062833.5768-2-woogyom.kim@gmail.com>
References: <20161209062833.5768-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161209062833.5768-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-omap@vger.kernel.org

Use 'interrupt-names' for getting the charger interrupt number.

Fixes: 1934e89a769b ("ARM: dts: am335x: Add the charger interrupt")
Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index dc561d5..14b6269 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -320,7 +320,7 @@
 
 	charger {
 		interrupts = <TPS65217_IRQ_AC>, <TPS65217_IRQ_USB>;
-		interrupts-names = "AC", "USB";
+		interrupt-names = "AC", "USB";
 		status = "okay";
 	};
 
-- 
2.9.3

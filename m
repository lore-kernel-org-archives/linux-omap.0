From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH 4/4] dt-bindings: input: Specify the interrupt number of TPS65217 power button
Date: Fri,  9 Dec 2016 15:28:33 +0900
Message-ID: <20161209062833.5768-5-woogyom.kim@gmail.com>
References: <20161209062833.5768-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161209062833.5768-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-omap@vger.kernel.org

Specify the power button interrupt number which is from the datasheet.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt b/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
index 3e5b979..8682ab6 100644
--- a/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
+++ b/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
@@ -8,8 +8,9 @@ This driver provides a simple power button event via an Interrupt.
 Required properties:
 - compatible: should be "ti,tps65217-pwrbutton" or "ti,tps65218-pwrbutton"
 
-Required properties for TPS65218:
+Required properties:
 - interrupts: should be one of the following
+   - <2>: For controllers compatible with tps65217
    - <3 IRQ_TYPE_EDGE_BOTH>: For controllers compatible with tps65218
 
 Examples:
@@ -17,6 +18,7 @@ Examples:
 &tps {
 	tps65217-pwrbutton {
 		compatible = "ti,tps65217-pwrbutton";
+		interrupts = <2>;
 	};
 };
 
-- 
2.9.3

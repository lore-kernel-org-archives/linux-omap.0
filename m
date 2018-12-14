From: Andreas Klinger <ak@it-klinger.de>
Subject: [PATCH] gpio-omap.txt: add reg and interrupts properties
Date: Fri, 14 Dec 2018 20:48:25 +0100
Message-ID: <20181214194822.lvavgczxq4cy7v64@arbad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Document properties reg and interrupts for OMAP GPIO controller bindings

Also add unit address in node name of the example

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 Documentation/devicetree/bindings/gpio/gpio-omap.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-omap.txt b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
index 8d950522e7fa..e57b2cb28f6c 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-omap.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
@@ -5,6 +5,8 @@ Required properties:
   - "ti,omap2-gpio" for OMAP2 controllers
   - "ti,omap3-gpio" for OMAP3 controllers
   - "ti,omap4-gpio" for OMAP4 controllers
+- reg : Physical base address of the controller and length of memory mapped
+  region.
 - gpio-controller : Marks the device node as a GPIO controller.
 - #gpio-cells : Should be two.
   - first cell is the pin number
@@ -18,6 +20,8 @@ Required properties:
       2 = high-to-low edge triggered.
       4 = active high level-sensitive.
       8 = active low level-sensitive.
+- interrupts : The interrupt the controller is rising as output when an
+  interrupt occures
 
 OMAP specific properties:
 - ti,hwmods:		Name of the hwmod associated to the GPIO:
@@ -29,11 +33,13 @@ OMAP specific properties:
 
 Example:
 
-gpio4: gpio4 {
+gpio0: gpio@44e07000 {
     compatible = "ti,omap4-gpio";
-    ti,hwmods = "gpio4";
+    reg = <0x44e07000 0x1000>;
+    ti,hwmods = "gpio1";
     gpio-controller;
     #gpio-cells = <2>;
     interrupt-controller;
     #interrupt-cells = <2>;
+    interrupts = <96>;
 };
-- 
2.11.0


-- 

From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 3/3] gpio-twl4030: updates the bindings for new dt properties
Date: Mon,  3 Sep 2012 15:54:51 +0200
Message-ID: <1346680491-4211-4-git-send-email-florian.vaussard@epfl.ch>
References: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.218]:40834 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756455Ab2ICNzQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Sep 2012 09:55:16 -0400
In-Reply-To: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Benoit Cousson <b-cousson@ti.com>, Rob Herring <rob.herring@calxeda.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Add the new properties to the documentation of bindings.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 .../devicetree/bindings/gpio/gpio-twl4030.txt      |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-twl4030.txt b/Documentation/devicetree/bindings/gpio/gpio-twl4030.txt
index 16695d9..690a32e 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-twl4030.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-twl4030.txt
@@ -11,6 +11,11 @@ Required properties:
 - interrupt-controller: Mark the device node as an interrupt controller
   The first cell is the GPIO number.
   The second cell is not used.
+- ti,use-leds : Enables LEDA and LEDB outputs if set to "true"
+- ti,debounce : if n-th bit is set, debounces GPIO-n
+- ti,mmc-cd : if n-th bit is set, GPIO-n controls VMMC(n+1)
+- ti,pullups : if n-th bit is set, set a pullup on GPIO-n
+- ti,pulldowns : if n-th bit is set, set a pulldown on GPIO-n
 
 Example:
 
@@ -20,4 +25,5 @@ twl_gpio: gpio {
     gpio-controller;
     #interrupt-cells = <2>;
     interrupt-controller;
+    ti,use-leds = "true";
 };
-- 
1.7.5.4


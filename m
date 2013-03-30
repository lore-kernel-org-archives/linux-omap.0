From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [RFC][BUG] arm/dts: OMAP3: set #interrupt-cells to two
Date: Sat, 30 Mar 2013 09:21:28 +0100
Message-ID: <1364631689.3767.7.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:52782 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017Ab3C3IVe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Mar 2013 04:21:34 -0400
Received: by mail-ee0-f47.google.com with SMTP id t10so459721eei.20
        for <linux-omap@vger.kernel.org>; Sat, 30 Mar 2013 01:21:33 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Daniel Mack <daniel@zonque.org>, "Hans J. Koch" <hjk@hansjkoch.de>

This patch sets gpio #interrupt-cells from a falsely acquired '1' to '2'
referring to Documentation/devicetree/bindings/gpio/gpio-omap.txt:

      The first cell is the GPIO number.
      The second cell is used to specify flags:
        bits[3:0] trigger type and level flags:
          1 = low-to-high edge triggered.
          2 = high-to-low edge triggered.
          4 = active high level-sensitive.
          8 = active low level-sensitive.

But using this trigger cell in a board specific devicetree leads to a
non-starting kernel. This is due to not yet enabled gpio-clocks while
kernel/irq/irqdomain.c tries to set this trigger-flag (from the second
interrupt-cell) to gpio-irq-controller.

 Any ideas?
---
 arch/arm/boot/dts/omap3.dtsi |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 1997b41..e8e6b8f 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -99,7 +99,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio2: gpio@49050000 {
@@ -108,7 +108,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio3: gpio@49052000 {
@@ -117,7 +117,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio4: gpio@49054000 {
@@ -126,7 +126,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio5: gpio@49056000 {
@@ -135,7 +135,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio6: gpio@49058000 {
@@ -144,7 +144,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		uart1: serial@4806a000 {
-- 
1.7.10.4




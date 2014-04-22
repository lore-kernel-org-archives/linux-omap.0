From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/3] ARM: dts: OMAP2: Fix interrupts for OMAP2420 mailbox
Date: Tue, 22 Apr 2014 17:23:36 -0500
Message-ID: <1398205417-1575-3-git-send-email-s-anna@ti.com>
References: <1398205417-1575-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52822 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754770AbaDVWYP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Apr 2014 18:24:15 -0400
In-Reply-To: <1398205417-1575-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

The mailbox module is capable of generating two interrupts
to MPU in OMAP2420, compared to one in OMAP2430. The second
interrupt is to handle interrupts from the additional IVA
processor present only on OMAP2420.

Move the current common mailbox DT node into the SoC
specific files to allow the above differentiation. Also,
added back the interrupt-names on OMAP2420, that were
previously defined in hwmod data.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap2.dtsi    | 7 -------
 arch/arm/boot/dts/omap2420.dtsi | 8 ++++++++
 arch/arm/boot/dts/omap2430.dtsi | 7 +++++++
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index 22f35ea..8f8c07d 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -71,13 +71,6 @@
 			interrupts = <58>;
 		};
 
-		mailbox: mailbox@48094000 {
-			compatible = "ti,omap2-mailbox";
-			ti,hwmods = "mailbox";
-			reg = <0x48094000 0x200>;
-			interrupts = <26>;
-		};
-
 		intc: interrupt-controller@1 {
 			compatible = "ti,omap2-intc";
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index 85b1fb0..2d99798 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -125,6 +125,14 @@
 			dma-names = "tx", "rx";
 		};
 
+		mailbox: mailbox@48094000 {
+			compatible = "ti,omap2-mailbox";
+			reg = <0x48094000 0x200>;
+			interrupts = <26>, <34>;
+			interrupt-names = "dsp", "iva";
+			ti,hwmods = "mailbox";
+		};
+
 		timer1: timer@48028000 {
 			compatible = "ti,omap2420-timer";
 			reg = <0x48028000 0x400>;
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index d09697d..42d2c61 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -216,6 +216,13 @@
 			dma-names = "tx", "rx";
 		};
 
+		mailbox: mailbox@48094000 {
+			compatible = "ti,omap2-mailbox";
+			reg = <0x48094000 0x200>;
+			interrupts = <26>;
+			ti,hwmods = "mailbox";
+		};
+
 		timer1: timer@49018000 {
 			compatible = "ti,omap2420-timer";
 			reg = <0x49018000 0x400>;
-- 
1.9.2


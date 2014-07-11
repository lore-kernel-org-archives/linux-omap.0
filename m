From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv2 01/10] ARM: dts: OMAP2+: Add mailbox fifo and user information
Date: Fri, 11 Jul 2014 16:44:34 -0500
Message-ID: <1405115083-52977-2-git-send-email-s-anna@ti.com>
References: <1405115083-52977-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34955 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751771AbaGKVpU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Jul 2014 17:45:20 -0400
In-Reply-To: <1405115083-52977-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Dave Gerlach <d-gerlach@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Suman Anna <s-anna@ti.com>

The number of mailbox fifos and users (IP interrupts) are added
to the Mailbox DT nodes on OMAP2420, OMAP2430, OMAP3, and OMAP5
family of SoCs through the DT properties "ti,mbox-num-fifos" and
"ti,mbox-num-users" properties. This data represents the same data
that used to be represented in hwmod attribute data through the
.num_fifos and .num_users fields previously.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap2420.dtsi | 2 ++
 arch/arm/boot/dts/omap2430.dtsi | 2 ++
 arch/arm/boot/dts/omap3.dtsi    | 2 ++
 arch/arm/boot/dts/omap5.dtsi    | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index e83b046..6d21994 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -157,6 +157,8 @@
 			interrupts = <26>, <34>;
 			interrupt-names = "dsp", "iva";
 			ti,hwmods = "mailbox";
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <6>;
 		};
 
 		timer1: timer@48028000 {
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index c4e8013..aa6a354 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -247,6 +247,8 @@
 			reg = <0x48094000 0x200>;
 			interrupts = <26>;
 			ti,hwmods = "mailbox";
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <6>;
 		};
 
 		timer1: timer@49018000 {
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index b2891a9..575a49b 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -332,6 +332,8 @@
 			ti,hwmods = "mailbox";
 			reg = <0x48094000 0x200>;
 			interrupts = <26>;
+			ti,mbox-num-users = <2>;
+			ti,mbox-num-fifos = <2>;
 		};
 
 		mcspi1: spi@48098000 {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 3bfda16..0e8336e 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -641,6 +641,8 @@
 			reg = <0x4a0f4000 0x200>;
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox";
+			ti,mbox-num-users = <3>;
+			ti,mbox-num-fifos = <8>;
 		};
 
 		timer1: timer@4ae18000 {
-- 
2.0.0


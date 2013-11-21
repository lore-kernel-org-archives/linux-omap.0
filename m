From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] ARM: OMAP2+: Fix more missing data for omap3.dtsi file
Date: Thu, 21 Nov 2013 10:51:04 -0800
Message-ID: <1385059866-10646-2-git-send-email-tony@atomide.com>
References: <1385059866-10646-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:21429 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754342Ab3KUSvK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Nov 2013 13:51:10 -0500
In-Reply-To: <1385059866-10646-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

After dropping the duplicate data in hwmod that now should come from
the .dts files, I noticed few more entries missing. Let's add these
as otherwise devices relying on these won't work.

Looks like the side tone entries are bundled into the mcbsp1 to 3,
so that may needs some special handling in the hwmod code as it's
currently trying to look up mcbsp2_sidetone and mcbsp3_sidetone
entries.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3.dtsi | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index f3a0c26..daabf99 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -82,6 +82,13 @@
 		ranges;
 		ti,hwmods = "l3_main";
 
+		aes: aes@480c5000 {
+			compatible = "ti,omap3-aes";
+			ti,hwmods = "aes";
+			reg = <0x480c5000 0x50>;
+			interrupts = <0>;
+		};
+
 		counter32k: counter@48320000 {
 			compatible = "ti,omap-counter32k";
 			reg = <0x48320000 0x20>;
@@ -260,6 +267,13 @@
 			ti,hwmods = "i2c3";
 		};
 
+		mailbox: mailbox@48094000 {
+			compatible = "ti,omap3-mailbox";
+			ti,hwmods = "mailbox";
+			reg = <0x48094000 0x200>;
+			interrupts = <26>;
+		};
+
 		mcspi1: spi@48098000 {
 			compatible = "ti,omap2-mcspi";
 			reg = <0x48098000 0x100>;
@@ -357,6 +371,13 @@
 			dma-names = "tx", "rx";
 		};
 
+		mmu_isp: mmu@480bd400 {
+			compatible = "ti,omap3-mmu-isp";
+			ti,hwmods = "mmu_isp";
+			reg = <0x480bd400 0x80>;
+			interrupts = <8>;
+		};
+
 		wdt2: wdt@48314000 {
 			compatible = "ti,omap3-wdt";
 			reg = <0x48314000 0x80>;
@@ -442,6 +463,27 @@
 			dma-names = "tx", "rx";
 		};
 
+		sham: sham@480c3000 {
+			compatible = "ti,omap3-sham";
+			ti,hwmods = "sham";
+			reg = <0x480c3000 0x64>;
+			interrupts = <49>;
+		};
+
+		smartreflex_core: smartreflex@480cb000 {
+			compatible = "ti,omap3-smartreflex-core";
+			ti,hwmods = "smartreflex_core";
+			reg = <0x480cb000 0x400>;
+			interrupts = <19>;
+		};
+
+		smartreflex_mpu_iva: smartreflex@480c9000 {
+			compatible = "ti,omap3-smartreflex-iva";
+			ti,hwmods = "smartreflex_mpu_iva";
+			reg = <0x480c9000 0x400>;
+			interrupts = <18>;
+		};
+
 		timer1: timer@48318000 {
 			compatible = "ti,omap3430-timer";
 			reg = <0x48318000 0x400>;
-- 
1.8.1.1


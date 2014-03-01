From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v2 7/7] ARM: dts: omap3-gta04: Add bma180 accelerometer
Date: Sat,  1 Mar 2014 14:58:54 +0100
Message-ID: <1393682334-26805-8-git-send-email-marek@goldelico.com>
References: <1393682334-26805-1-git-send-email-marek@goldelico.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179]:54878 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbaCAN7q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Mar 2014 08:59:46 -0500
In-Reply-To: <1393682334-26805-1-git-send-email-marek@goldelico.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hns@goldelico.com, NeilBrown <neilb@suse.de>

From: NeilBrown <neilb@suse.de>

Add node for bma180 driver.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 arch/arm/boot/dts/omap3-gta04.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index d556e3a..f8ad125 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -110,6 +110,14 @@
 		interrupts = <17 IRQ_TYPE_EDGE_RISING>;
 	};
 
+	/* accelerometer */
+	bma180@41 {
+		compatible = "bosch,bma180";
+		reg = <0x41>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	/* leds */
 	tca6507@45 {
 		compatible = "ti,tca6507";
-- 
1.8.3.2


From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 08/11] ARM: dts: AM33XX BASE0033: add 32KBit EEPROM support.
Date: Sat, 16 Nov 2013 14:23:41 +0100
Message-ID: <1384608224-9452-9-git-send-email-javier.martinez@collabora.co.uk>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:60376 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab3KPNZD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Nov 2013 08:25:03 -0500
In-Reply-To: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

The IGEP AQUILA EXPANSION has a 32KBit EEPROM for user data storage.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/boot/dts/am335x-base0033.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-base0033.dts b/arch/arm/boot/dts/am335x-base0033.dts
index 2878024..a76ea11 100644
--- a/arch/arm/boot/dts/am335x-base0033.dts
+++ b/arch/arm/boot/dts/am335x-base0033.dts
@@ -87,3 +87,10 @@
 	status = "okay";
 };
 
+&i2c0 {
+	eeprom: eeprom@50 {
+		compatible = "at,24c256";
+		reg = <0x50>;
+	};
+};
+
-- 
1.8.4.2


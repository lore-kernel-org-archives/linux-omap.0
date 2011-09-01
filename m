From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 13/13] arm/dts: omap4-panda: Add EEPROM entry in i2c3
Date: Thu, 1 Sep 2011 19:21:29 +0200
Message-ID: <1314897689-17791-14-git-send-email-b-cousson@ti.com>
References: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52304 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756169Ab1IARWv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Sep 2011 13:22:51 -0400
In-Reply-To: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>

Add a generic i2c EEPROM entry.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 5c1c2a7..0a83e3f 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -61,6 +61,15 @@
 
 &i2c3 {
 	clock-frequency = <100000>;
+
+	/*
+	 * Display monitor features are burnt in their EEPROM as EDID data.
+	 * The EEPROM is connected as I2C slave device.
+	 */
+	eeprom@50 {
+		compatible = "ti,eeprom";
+		reg = <0x50>;
+	};
 };
 
 &i2c4 {
-- 
1.7.0.4


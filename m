From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 1/2] ARM: OMAP2: Add pin multiplexing configuration for OMAP34xx I2C pins
Date: Mon,  9 Jun 2008 17:46:40 +0300
Message-ID: <1213022801-25058-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:22671 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755306AbYFIOqq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jun 2008 10:46:46 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m59EgVBh031179
	for <linux-omap@vger.kernel.org>; Mon, 9 Jun 2008 09:46:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/mux.c       |   18 ++++++++++++++++++
 include/asm-arm/arch-omap/mux.h |    9 +++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 6919d52..5a68fb3 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -226,6 +226,24 @@ static struct pin_config __initdata_or_module omap34xx_pins[] = {
  *		mux-mode | [active-mode | off-mode]
  */
 
+/* 34xx I2C */
+MUX_CFG_34XX("K21_34XX_I2C1_SCL", 0x1ba,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("J21_34XX_I2C1_SDA", 0x1bc,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AF15_34XX_I2C2_SCL", 0x1be,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AE15_34XX_I2C2_SDA", 0x1c0,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AF14_34XX_I2C3_SCL", 0x1c2,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AG14_34XX_I2C3_SDA", 0x1c4,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AD26_34XX_I2C4_SCL", 0xa00,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AE26_34XX_I2C4_SDA", 0xa02,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+
 /* PHY - HSUSB: 12-pin ULPI PHY: Port 1*/
 MUX_CFG_34XX("Y8_3430_USB1HS_PHY_CLK", 0x5da,
 		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_OUTPUT)
diff --git a/include/asm-arm/arch-omap/mux.h b/include/asm-arm/arch-omap/mux.h
index ad39b0b..7a51aa0 100644
--- a/include/asm-arm/arch-omap/mux.h
+++ b/include/asm-arm/arch-omap/mux.h
@@ -644,6 +644,15 @@ enum omap24xx_index {
 };
 
 enum omap34xx_index {
+	/* 34xx I2C */
+	K21_34XX_I2C1_SCL,
+	J21_34XX_I2C1_SDA,
+	AF15_34XX_I2C2_SCL,
+	AE15_34XX_I2C2_SDA,
+	AF14_34XX_I2C3_SCL,
+	AG14_34XX_I2C3_SDA,
+	AD26_34XX_I2C4_SCL,
+	AE26_34XX_I2C4_SDA,
 
 	/* PHY - HSUSB: 12-pin ULPI PHY: Port 1*/
 	Y8_3430_USB1HS_PHY_CLK,
-- 
1.5.5.3


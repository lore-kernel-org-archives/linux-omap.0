From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP: Sort 34xx GPIO pins, add few more pins
Date: Fri, 6 Mar 2009 16:39:49 -0800
Message-ID: <20090307003948.GD32353@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64269 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844AbZCGAjx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2009 19:39:53 -0500
Received: from c-69-181-40-92.hsd1.ca.comcast.net ([69.181.40.92] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1LfkZy-000JnI-Mh
	for linux-omap@vger.kernel.org; Sat, 07 Mar 2009 00:39:51 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Here's the patch I promised few days ago to sort the GPIO pins,
sorry for the delay.

Tony

--vtzGhvizbBRQ85DL
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="mux-sort.patch"

>From 362769b996c7514c4bc92eee815ed7ca9aa1544f Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 5 Mar 2009 17:09:20 -0800
Subject: [PATCH] ARM: OMAP: Sort 34xx GPIO pins, add few more pins

Sort 34xx GPIO pins, add few more pins

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 9ed2e49..026c4fc 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -456,16 +456,24 @@ MUX_CFG_34XX("AC1_3430_USB3FS_PHY_MM3_TXEN_N", 0x18a,
  * (Always specify PIN_INPUT, except for names suffixed by "_OUT".)
  * No internal pullup/pulldown without "_UP" or "_DOWN" suffix.
  */
-MUX_CFG_34XX("AH8_34XX_GPIO29", 0x5fa,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
-MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 MUX_CFG_34XX("AF26_34XX_GPIO0", 0x1e0,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 MUX_CFG_34XX("AF22_34XX_GPIO9", 0xa18,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("AH8_34XX_GPIO29", 0x5fa,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("U8_34XX_GPIO54_OUT", 0x0b4,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("U8_34XX_GPIO54_DOWN", 0x0b4,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLDOWN)
 MUX_CFG_34XX("L8_34XX_GPIO63", 0x0ce,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("G25_34XX_GPIO86_OUT", 0x0fc,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AG4_34XX_GPIO134_OUT", 0x160,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AE4_34XX_GPIO136_OUT", 0x164,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 MUX_CFG_34XX("AF6_34XX_GPIO140_UP", 0x16c,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
 MUX_CFG_34XX("AE6_34XX_GPIO141", 0x16e,
@@ -474,13 +482,10 @@ MUX_CFG_34XX("AF5_34XX_GPIO142", 0x170,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 MUX_CFG_34XX("AE5_34XX_GPIO143", 0x172,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
-MUX_CFG_34XX("AG4_34XX_GPIO134", 0x160,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
-MUX_CFG_34XX("U8_34XX_GPIO54", 0x0b4,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
-MUX_CFG_34XX("AE4_34XX_GPIO136", 0x164,
+MUX_CFG_34XX("H19_34XX_GPIO164_OUT", 0x19c,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
-
+MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 };
 
 #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/include/mach/mux.h
index 8d73a9a..f7e298a 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -788,18 +788,21 @@ enum omap34xx_index {
 	 *  - "_DOWN" suffix (GPIO3_DOWN) with internal pulldown
 	 *  - "_OUT" suffix (GPIO3_OUT) for output-only pins (unlike 24xx)
 	 */
-	AH8_34XX_GPIO29,
-	J25_34XX_GPIO170,
 	AF26_34XX_GPIO0,
 	AF22_34XX_GPIO9,
+	AH8_34XX_GPIO29,
+	U8_34XX_GPIO54_OUT,
+	U8_34XX_GPIO54_DOWN,
 	L8_34XX_GPIO63,
+	G25_34XX_GPIO86_OUT,
+	AG4_34XX_GPIO134_OUT,
+	AE4_34XX_GPIO136_OUT,
 	AF6_34XX_GPIO140_UP,
 	AE6_34XX_GPIO141,
 	AF5_34XX_GPIO142,
 	AE5_34XX_GPIO143,
-	AG4_34XX_GPIO134,
-	U8_34XX_GPIO54,
-	AE4_34XX_GPIO136,
+	H19_34XX_GPIO164_OUT,
+	J25_34XX_GPIO170,
 };
 
 struct omap_mux_cfg {

--vtzGhvizbBRQ85DL--

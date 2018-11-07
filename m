From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 1/3] ARM: OMAP1: ams-delta: Drop board specific global GPIO numbers
Date: Wed,  7 Nov 2018 21:17:44 +0100
Message-ID: <20181107201746.14705-2-jmkrzyszt@gmail.com>
References: <20181107201746.14705-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107201746.14705-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

As all users of the board specific GPIO pins have been converted from
legacy integer-based to descriptor-based interface, there is no longer
a need to maintain statically assigned GPIO pin numbers.  Drop support
for that.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c |  3 ---
 arch/arm/mach-omap1/board-ams-delta.h | 16 ----------------
 2 files changed, 19 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 19e0c071d675..a6986a83a916 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -167,7 +167,6 @@ static struct omap_usb_config ams_delta_usb_config __initdata = {
 	.pins[0]	= 2,
 };
 
-#define LATCH1_GPIO_BASE	232
 #define LATCH1_NGPIO		8
 
 static struct resource latch1_resources[] = {
@@ -183,7 +182,6 @@ static struct resource latch1_resources[] = {
 
 static struct bgpio_pdata latch1_pdata = {
 	.label	= LATCH1_LABEL,
-	.base	= LATCH1_GPIO_BASE,
 	.ngpio	= LATCH1_NGPIO,
 };
 
@@ -219,7 +217,6 @@ static struct resource latch2_resources[] = {
 
 static struct bgpio_pdata latch2_pdata = {
 	.label	= LATCH2_LABEL,
-	.base	= AMS_DELTA_LATCH2_GPIO_BASE,
 	.ngpio	= AMS_DELTA_LATCH2_NGPIO,
 };
 
diff --git a/arch/arm/mach-omap1/board-ams-delta.h b/arch/arm/mach-omap1/board-ams-delta.h
index a74a306d7e77..06e4c64a47f8 100644
--- a/arch/arm/mach-omap1/board-ams-delta.h
+++ b/arch/arm/mach-omap1/board-ams-delta.h
@@ -41,22 +41,6 @@
 #define AMS_DELTA_GPIO_PIN_CONFIG	11
 #define AMS_DELTA_GPIO_PIN_NAND_RB	12
 
-#define AMS_DELTA_GPIO_PIN_LCD_VBLEN		240
-#define AMS_DELTA_GPIO_PIN_LCD_NDISP		241
-#define AMS_DELTA_GPIO_PIN_NAND_NCE		242
-#define AMS_DELTA_GPIO_PIN_NAND_NRE		243
-#define AMS_DELTA_GPIO_PIN_NAND_NWP		244
-#define AMS_DELTA_GPIO_PIN_NAND_NWE		245
-#define AMS_DELTA_GPIO_PIN_NAND_ALE		246
-#define AMS_DELTA_GPIO_PIN_NAND_CLE		247
-#define AMS_DELTA_GPIO_PIN_KEYBRD_PWR		248
-#define AMS_DELTA_GPIO_PIN_KEYBRD_DATAOUT	249
-#define AMS_DELTA_GPIO_PIN_SCARD_RSTIN		250
-#define AMS_DELTA_GPIO_PIN_SCARD_CMDVCC		251
-#define AMS_DELTA_GPIO_PIN_MODEM_NRESET		252
-#define AMS_DELTA_GPIO_PIN_MODEM_CODEC		253
-
-#define AMS_DELTA_LATCH2_GPIO_BASE	AMS_DELTA_GPIO_PIN_LCD_VBLEN
 #define AMS_DELTA_LATCH2_NGPIO		16
 
 #endif /* CONFIG_MACH_AMS_DELTA */
-- 
2.16.4

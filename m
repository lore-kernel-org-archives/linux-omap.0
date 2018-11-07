From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 3/3] ARM: OMAP1: ams-delta: Move AMS_DELTA_LATCH2_NGPIO to the board file
Date: Wed,  7 Nov 2018 21:17:46 +0100
Message-ID: <20181107201746.14705-4-jmkrzyszt@gmail.com>
References: <20181107201746.14705-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107201746.14705-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

That symbol is not used outside the board file, there is no need to
keep it in the board header.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 6 ++++--
 arch/arm/mach-omap1/board-ams-delta.h | 2 --
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index a6986a83a916..1947bc63074e 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -204,11 +204,13 @@ static struct platform_device latch1_gpio_device = {
 #define LATCH1_PIN_DOCKIT1		6
 #define LATCH1_PIN_DOCKIT2		7
 
+#define LATCH2_NGPIO			16
+
 static struct resource latch2_resources[] = {
 	[0] = {
 		.name	= "dat",
 		.start	= LATCH2_PHYS,
-		.end	= LATCH2_PHYS + (AMS_DELTA_LATCH2_NGPIO - 1) / 8,
+		.end	= LATCH2_PHYS + (LATCH2_NGPIO - 1) / 8,
 		.flags	= IORESOURCE_MEM,
 	},
 };
@@ -217,7 +219,7 @@ static struct resource latch2_resources[] = {
 
 static struct bgpio_pdata latch2_pdata = {
 	.label	= LATCH2_LABEL,
-	.ngpio	= AMS_DELTA_LATCH2_NGPIO,
+	.ngpio	= LATCH2_NGPIO,
 };
 
 static struct platform_device latch2_gpio_device = {
diff --git a/arch/arm/mach-omap1/board-ams-delta.h b/arch/arm/mach-omap1/board-ams-delta.h
index 2c3aff824cf0..b5c4a373b905 100644
--- a/arch/arm/mach-omap1/board-ams-delta.h
+++ b/arch/arm/mach-omap1/board-ams-delta.h
@@ -37,8 +37,6 @@
 #define AMS_DELTA_GPIO_PIN_CONFIG	11
 #define AMS_DELTA_GPIO_PIN_NAND_RB	12
 
-#define AMS_DELTA_LATCH2_NGPIO		16
-
 #endif /* CONFIG_MACH_AMS_DELTA */
 
 #endif /* __ASM_ARCH_OMAP_AMS_DELTA_H */
-- 
2.16.4

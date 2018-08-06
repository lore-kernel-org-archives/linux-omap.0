From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH v2 06/12] ARM: OMAP1: ams-delta: drop obsolete NAND resources
Date: Tue,  7 Aug 2018 00:29:12 +0200
Message-ID: <20180806222918.12644-7-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806222918.12644-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Amstrad Delta NAND device now uses GPIO API for data I/O so there is no
need to assign memory I/O resource to the device any longer.  Drop it.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 16f7bbe47607..08e732bc1cd2 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -321,20 +321,9 @@ struct modem_private_data {
 
 static struct modem_private_data modem_priv;
 
-static struct resource ams_delta_nand_resources[] = {
-	[0] = {
-		.start	= OMAP1_MPUIO_BASE,
-		.end	= OMAP1_MPUIO_BASE +
-				OMAP_MPUIO_IO_CNTL + sizeof(u32) - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
 static struct platform_device ams_delta_nand_device = {
 	.name	= "ams-delta-nand",
 	.id	= -1,
-	.num_resources	= ARRAY_SIZE(ams_delta_nand_resources),
-	.resource	= ams_delta_nand_resources,
 };
 
 #define OMAP_GPIO_LABEL		"gpio-0-15"
-- 
2.16.4

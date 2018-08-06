From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH v2 03/12] ARM: OMAP1: ams-delta: Provide GPIO lookup table for NAND data port
Date: Tue,  7 Aug 2018 00:29:09 +0200
Message-ID: <20180806222918.12644-4-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806222918.12644-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Data port used by Amstrad Delta NAND driver is actually an OMAP MPUIO
device, already under control of gpio-omap driver.  The NAND driver
gets access to the port by ioremapping it and performs read/write
operations.  That is done without any proteciton from other users
legally manipulating the port pins over GPIO API.

The plan is to convert the driver to access the port over GPIO consumer
API.  Before that is implemented, the driver can already obtain
exclusive access to the port by requesting an array of its GPIO
descriptors.

Add respective entries to the NAND GPIO lookup table.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index eedacdfe9725..16f7bbe47607 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -337,7 +337,8 @@ static struct platform_device ams_delta_nand_device = {
 	.resource	= ams_delta_nand_resources,
 };
 
-#define OMAP_GPIO_LABEL	"gpio-0-15"
+#define OMAP_GPIO_LABEL		"gpio-0-15"
+#define OMAP_MPUIO_LABEL	"mpuio"
 
 static struct gpiod_lookup_table ams_delta_nand_gpio_table = {
 	.table = {
@@ -349,6 +350,14 @@ static struct gpiod_lookup_table ams_delta_nand_gpio_table = {
 		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_NWE, "nwe", 0),
 		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_ALE, "ale", 0),
 		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_CLE, "cle", 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 0, "data", 0, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 1, "data", 1, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 2, "data", 2, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 3, "data", 3, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 4, "data", 4, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 5, "data", 5, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 6, "data", 6, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 7, "data", 7, 0),
 		{ },
 	},
 };
-- 
2.16.4

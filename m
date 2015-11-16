From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 17/27] cris: nand: use the mtd instance embedded in struct
 nand_chip
Date: Mon, 16 Nov 2015 14:37:50 +0100
Message-ID: <1447681080-31232-18-git-send-email-boris.brezillon@free-electrons.com>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org
Cc: Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Stefan Agner <stefan@agner.ch>, linux-sunxi@googlegroups.com, Robert Jarzmik <robert.jarzmik@free.fr>, Alexander Clouter <alex@digriz.org.uk>, devel@driverdev.osuosl.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-samsung-soc@vger.kernel.org, Maxim Levitsky <maximlevitsky@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Marek Vasut <marek.vasut@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Josh Wu <josh.wu@atmel.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Wan ZongShun <mcuos.com@gmail.com>, Steven Miao <realmz6@gmail.com>, adi-buildroot-devel@li
List-Id: linux-omap@vger.kernel.org

struct nand_chip now embeds an mtd device. Patch all drivers to make use
of this mtd instance instead of using the instance embedded in their
private struct or dynamically allocated.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Most of those changes were generate with this coccinelle script:
http://code.bulix.org/5vxuih-89429
---
 arch/cris/arch-v32/drivers/mach-a3/nandflash.c | 3 +--
 arch/cris/arch-v32/drivers/mach-fs/nandflash.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/cris/arch-v32/drivers/mach-a3/nandflash.c b/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
index db953cf..ad78b97 100644
--- a/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
+++ b/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
@@ -36,7 +36,6 @@
 #define CE_BIT 12
 
 struct mtd_info_wrapper {
-	struct mtd_info info;
 	struct nand_chip chip;
 };
 
@@ -148,7 +147,7 @@ struct mtd_info *__init crisv32_nand_flash_probe(void)
 
 	/* Get pointer to private data */
 	this = &wrapper->chip;
-	crisv32_mtd = &wrapper->info;
+	crisv32_mtd = nand_to_mtd(&wrapper->chip);
 
 	/* Link the private data with the MTD structure */
 	crisv32_mtd->priv = this;
diff --git a/arch/cris/arch-v32/drivers/mach-fs/nandflash.c b/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
index 22a6467..00a277b 100644
--- a/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
+++ b/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
@@ -31,7 +31,6 @@
 #define BY_BIT 7
 
 struct mtd_info_wrapper {
-	struct mtd_info info;
 	struct nand_chip chip;
 };
 
@@ -129,7 +128,7 @@ struct mtd_info *__init crisv32_nand_flash_probe(void)
 
 	/* Get pointer to private data */
 	this = &wrapper->chip;
-	crisv32_mtd = &wrapper->info;
+	crisv32_mtd = nand_to_mtd(&wrapper->chip);
 
 	pa_oe.oe |= 1 << CE_BIT;
 	pa_oe.oe |= 1 << ALE_BIT;
-- 
2.1.4

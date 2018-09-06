From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 15/19] mtd: rawnand: Inline onfi_get_async_timing_mode()
Date: Fri,  7 Sep 2018 00:38:47 +0200
Message-ID: <20180906223851.6964-16-boris.brezillon@bootlin.com>
References: <20180906223851.6964-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180906223851.6964-1-boris.brezillon@bootlin.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>, Richard Weinberger <richard@nod.at>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org
Cc: Andrew Lunn <andrew@lunn.ch>, Rich Felker <dalias@libc.org>, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Alexander Clouter <alex@digriz.org.uk>, devel@driverdev.osuosl.org, Alexander Shiyan <shc_work@mail.ru>, Jonathan Corbet <corbet@lwn.net>, Gregory CLEMENT <gregory.clement@bootlin.com>, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Marek Vasut <marek.vasut@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Haojian Zhuang <haojian.zhuang@gmail.com>, Krzysztof Halasa <khalasa@piap.pl>, linux-omap@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Ryan Mallon <rmallon@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

onfi_get_async_timing_mode() is only used in one place inside
nand_base.c. Let's inline the code and kill the helper.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 5 +++--
 include/linux/mtd/rawnand.h      | 9 ---------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 2f8bbc3bca7a..136ccdc61a06 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1310,8 +1310,9 @@ static int nand_init_data_interface(struct nand_chip *chip)
 	 * if the NAND does not support ONFI, fallback to the default ONFI
 	 * timing mode.
 	 */
-	modes = onfi_get_async_timing_mode(chip);
-	if (modes == ONFI_TIMING_MODE_UNKNOWN) {
+	if (chip->parameters.onfi) {
+		modes = chip->parameters.onfi->async_timing_mode;
+	} else {
 		if (!chip->onfi_timing_mode_default)
 			return 0;
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 04e11a314e9c..7f0e3dc222ed 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1540,15 +1540,6 @@ int nand_isbad_bbt(struct nand_chip *chip, loff_t offs, int allowbbt);
 int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
 		    int allowbbt);
 
-/* return the supported asynchronous timing mode. */
-static inline int onfi_get_async_timing_mode(struct nand_chip *chip)
-{
-	if (!chip->parameters.onfi)
-		return ONFI_TIMING_MODE_UNKNOWN;
-
-	return chip->parameters.onfi->async_timing_mode;
-}
-
 int onfi_fill_data_interface(struct nand_chip *chip,
 			     enum nand_data_interface_type type,
 			     int timing_mode);
-- 
2.14.1

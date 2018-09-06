From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 13/19] mtd: rawnand: Get rid of a few unused definitions
Date: Fri,  7 Sep 2018 00:38:45 +0200
Message-ID: <20180906223851.6964-14-boris.brezillon@bootlin.com>
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

Those definitions are not used, let's remove them.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/nand_timings.c | 14 --------------
 include/linux/mtd/rawnand.h         |  8 --------
 2 files changed, 22 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_timings.c b/drivers/mtd/nand/raw/nand_timings.c
index ebc7b5f76f77..cb4f0007b65c 100644
--- a/drivers/mtd/nand/raw/nand_timings.c
+++ b/drivers/mtd/nand/raw/nand_timings.c
@@ -270,20 +270,6 @@ static const struct nand_data_interface onfi_sdr_timings[] = {
 	},
 };
 
-/**
- * onfi_async_timing_mode_to_sdr_timings - [NAND Interface] Retrieve NAND
- * timings according to the given ONFI timing mode
- * @mode: ONFI timing mode
- */
-const struct nand_sdr_timings *onfi_async_timing_mode_to_sdr_timings(int mode)
-{
-	if (mode < 0 || mode >= ARRAY_SIZE(onfi_sdr_timings))
-		return ERR_PTR(-EINVAL);
-
-	return &onfi_sdr_timings[mode].timings.sdr;
-}
-EXPORT_SYMBOL(onfi_async_timing_mode_to_sdr_timings);
-
 /**
  * onfi_fill_data_interface - [NAND Interface] Initialize a data interface from
  * given ONFI mode
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 608279104aae..8aa8b57ca4b1 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -119,10 +119,6 @@ enum nand_ecc_algo {
 #define NAND_ECC_GENERIC_ERASED_CHECK	BIT(0)
 #define NAND_ECC_MAXIMIZE		BIT(1)
 
-/* Bit mask for flags passed to do_nand_read_ecc */
-#define NAND_GET_DEVICE		0x80
-
-
 /*
  * Option constants for bizarre disfunctionality and real
  * features.
@@ -163,9 +159,7 @@ enum nand_ecc_algo {
 #define NAND_SAMSUNG_LP_OPTIONS NAND_CACHEPRG
 
 /* Macros to identify the above */
-#define NAND_HAS_CACHEPROG(chip) ((chip->options & NAND_CACHEPRG))
 #define NAND_HAS_SUBPAGE_READ(chip) ((chip->options & NAND_SUBPAGE_READ))
-#define NAND_HAS_SUBPAGE_WRITE(chip) !((chip)->options & NAND_NO_SUBPAGE_WRITE)
 
 /* Non chip related options */
 /* This option skips the bbt scan during initialization. */
@@ -1649,8 +1643,6 @@ static inline int nand_opcode_8bits(unsigned int command)
 	return 0;
 }
 
-/* get timing characteristics from ONFI timing mode. */
-const struct nand_sdr_timings *onfi_async_timing_mode_to_sdr_timings(int mode);
 
 int nand_check_erased_ecc_chunk(void *data, int datalen,
 				void *ecc, int ecclen,
-- 
2.14.1

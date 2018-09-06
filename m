From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 10/19] mtd: rawnand: Move function prototypes after struct
 declarations
Date: Fri,  7 Sep 2018 00:38:42 +0200
Message-ID: <20180906223851.6964-11-boris.brezillon@bootlin.com>
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

Move nand_scan[_with_ids]() and nand_wait_ready() at the end of the
file where all function prototype lies. This will also allow us to get
rid of the nand_flash_dev forward declaration.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 include/linux/mtd/rawnand.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 992d78d29674..15183b73fed2 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -27,18 +27,6 @@
 struct nand_chip;
 struct nand_flash_dev;
 
-/* Scan and identify a NAND device */
-int nand_scan_with_ids(struct nand_chip *chip, unsigned int max_chips,
-		       struct nand_flash_dev *ids);
-
-static inline int nand_scan(struct nand_chip *chip, unsigned int max_chips)
-{
-	return nand_scan_with_ids(chip, max_chips, NULL);
-}
-
-/* Internal helper for board drivers which need to override command function */
-void nand_wait_ready(struct nand_chip *chip);
-
 /* The maximum number of NAND chips in an array */
 #define NAND_MAX_CHIPS		8
 
@@ -1739,6 +1727,18 @@ int nand_read_data_op(struct nand_chip *chip, void *buf, unsigned int len,
 int nand_write_data_op(struct nand_chip *chip, const void *buf,
 		       unsigned int len, bool force_8bit);
 
+/* Scan and identify a NAND device */
+int nand_scan_with_ids(struct nand_chip *chip, unsigned int max_chips,
+		       struct nand_flash_dev *ids);
+
+static inline int nand_scan(struct nand_chip *chip, unsigned int max_chips)
+{
+	return nand_scan_with_ids(chip, max_chips, NULL);
+}
+
+/* Internal helper for board drivers which need to override command function */
+void nand_wait_ready(struct nand_chip *chip);
+
 /*
  * Free resources held by the NAND device, must be called on error after a
  * sucessful nand_scan().
-- 
2.14.1

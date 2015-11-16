From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 22/27] mtd: nand: simplify nand_dt_init() usage
Date: Mon, 16 Nov 2015 14:37:55 +0100
Message-ID: <1447681080-31232-23-git-send-email-boris.brezillon@free-electrons.com>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Alexander Clouter <alex@digriz.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marek.vasut@gmail.com>, Steven Miao <realmz6@gmail.com>, adi-b
List-Id: linux-omap@vger.kernel.org

nand_dt_init() function requires 3 arguments where it actually needs one
(dn and mtd can both be retrieved from chip). Drop these parameters.

Testing for dn != NULL inside nand_dt_init() also helps simplifying the
caller code.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/nand_base.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 71cc029..2f75eb1 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -3937,11 +3937,17 @@ ident_done:
 	return type;
 }
 
-static int nand_dt_init(struct mtd_info *mtd, struct nand_chip *chip,
-			struct device_node *dn)
+static int nand_dt_init(struct nand_chip *chip)
 {
+	struct device_node *dn = nand_get_flash_node(chip);
 	int ecc_mode, ecc_strength, ecc_step;
 
+	if (!dn)
+		return 0;
+
+	/* MTD can automatically handle DT partitions, etc. */
+	mtd_set_of_node(nand_to_mtd(chip), dn);
+
 	if (of_get_nand_bus_width(dn) == 16)
 		chip->options |= NAND_BUSWIDTH_16;
 
@@ -3989,14 +3995,9 @@ int nand_scan_ident(struct mtd_info *mtd, int maxchips,
 	struct nand_flash_dev *type;
 	int ret;
 
-	if (nand_get_flash_node(chip)) {
-		/* MTD can automatically handle DT partitions, etc. */
-		mtd_set_of_node(mtd, nand_get_flash_node(chip));
-
-		ret = nand_dt_init(mtd, chip, nand_get_flash_node(chip));
-		if (ret)
-			return ret;
-	}
+	ret = nand_dt_init(chip);
+	if (ret)
+		return ret;
 
 	/* Set the default functions */
 	nand_set_defaults(chip, chip->options & NAND_BUSWIDTH_16);
-- 
2.1.4

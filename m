From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 13/27] mtd: nand: add nand_to_mtd() helper
Date: Mon, 16 Nov 2015 14:37:46 +0100
Message-ID: <1447681080-31232-14-git-send-email-boris.brezillon@free-electrons.com>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Alexander Clouter <alex@digriz.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marek.vasut@gmail.com>, Steven Miao <realmz6@gmail.com>, adi-b
List-Id: linux-omap@vger.kernel.org

Add a new helper to retrieve the MTD device attached to a NAND chip.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/mtd/nand.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index c4e39ff..8ec071e 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -737,6 +737,11 @@ static inline struct nand_chip *mtd_to_nand(struct mtd_info *mtd)
 	return mtd->priv;
 }
 
+static inline struct mtd_info *nand_to_mtd(struct nand_chip *chip)
+{
+	return &chip->mtd;
+}
+
 /*
  * NAND Flash Manufacturer ID Codes
  */
-- 
2.1.4

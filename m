From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 22/25] mtd: nand: add helpers to access ->priv
Date: Tue,  1 Dec 2015 12:03:19 +0100
Message-ID: <1448967802-25796-23-git-send-email-boris.brezillon@free-electrons.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Alexander Clouter <alex@digriz.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marek.vasut@gmail.com>, Steven Miao <realmz6@gmail.com>, adi-b
List-Id: linux-omap@vger.kernel.org

Add two helpers to access the field reserved for private controller data.
This makes it clearer what this field is reserved for and ease future
refactoring.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/mtd/nand.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index f12efe1..4afa263 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -739,6 +739,16 @@ static inline struct mtd_info *nand_to_mtd(struct nand_chip *chip)
 	return &chip->mtd;
 }
 
+static inline void *nand_get_controller_data(struct nand_chip *chip)
+{
+	return chip->priv;
+}
+
+static inline void nand_set_controller_data(struct nand_chip *chip, void *priv)
+{
+	chip->priv = priv;
+}
+
 /*
  * NAND Flash Manufacturer ID Codes
  */
-- 
2.1.4

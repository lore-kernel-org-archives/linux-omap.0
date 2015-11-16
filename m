From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 18/27] mtd: nand: update mtd_to_nand()
Date: Mon, 16 Nov 2015 14:37:51 +0100
Message-ID: <1447681080-31232-19-git-send-email-boris.brezillon@free-electrons.com>
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

Now that all drivers are using the mtd instance embedded in the nand_chip
struct we can safely update the mtd_to_nand_chip() implementation to use
the container_of macro instead of returning the content of mtd->priv.
This will allow us to remove mtd->priv = chip assignments done in all
NAND controller drivers.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/mtd/nand.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 8ec071e..873646d 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -734,7 +734,7 @@ static inline struct device_node *nand_get_flash_node(struct nand_chip *chip)
 
 static inline struct nand_chip *mtd_to_nand(struct mtd_info *mtd)
 {
-	return mtd->priv;
+	return container_of(mtd, struct nand_chip, mtd);
 }
 
 static inline struct mtd_info *nand_to_mtd(struct nand_chip *chip)
-- 
2.1.4

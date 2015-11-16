From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 03/27] mtd: nand: update examples in the documentation to use
 mtd_to_nand()
Date: Mon, 16 Nov 2015 14:37:36 +0100
Message-ID: <1447681080-31232-4-git-send-email-boris.brezillon@free-electrons.com>
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

mtd_to_nand() has been introduced to hide accesses to mtd->priv.
All NAND controller drivers should use it instead of directly accessing
the ->priv field.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 Documentation/DocBook/mtdnand.tmpl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/DocBook/mtdnand.tmpl b/Documentation/DocBook/mtdnand.tmpl
index 7da8f04..403a7ab 100644
--- a/Documentation/DocBook/mtdnand.tmpl
+++ b/Documentation/DocBook/mtdnand.tmpl
@@ -235,7 +235,7 @@ static void board_hwcontrol(struct mtd_info *mtd, int cmd)
 		<programlisting>
 static void board_hwcontrol(struct mtd_info *mtd, int cmd)
 {
-	struct nand_chip *this = (struct nand_chip *) mtd->priv;
+	struct nand_chip *this = mtd_to_nand(mtd);
 	switch(cmd){
 		case NAND_CTL_SETCLE: this->IO_ADDR_W |= CLE_ADRR_BIT;  break;
 		case NAND_CTL_CLRCLE: this->IO_ADDR_W &amp;= ~CLE_ADRR_BIT; break;
@@ -399,7 +399,7 @@ static void board_select_chip (struct mtd_info *mtd, int chip)
 		<programlisting>
 static void board_select_chip (struct mtd_info *mtd, int chip)
 {
-	struct nand_chip *this = (struct nand_chip *) mtd->priv;
+	struct nand_chip *this = mtd_to_nand(mtd);
 	
 	/* Deselect all chips */
 	this->IO_ADDR_R &amp;= ~BOARD_NAND_ADDR_MASK;
-- 
2.1.4

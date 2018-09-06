From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 01/19] mtd: rawnand: Leave chip->IO_ADDR_{R,
 W} to NULL when unused
Date: Fri,  7 Sep 2018 00:38:33 +0200
Message-ID: <20180906223851.6964-2-boris.brezillon@bootlin.com>
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

There's no point in poisoning the ->IO_ADDR_{R,W}, a NULL pointer
is just as good to detect unexpected ->IO_ADDR_{R,W} usage.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 3 ---
 drivers/mtd/nand/raw/socrates_nand.c     | 4 ----
 2 files changed, 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index fee40a3ce5d2..851db4a7d3e4 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2270,9 +2270,6 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 	mtd->owner = THIS_MODULE;
 	mtd->dev.parent = &pdev->dev;
 
-	chip->IO_ADDR_R = (void __iomem *)0xdeadbeef;
-	chip->IO_ADDR_W = (void __iomem *)0xdeadbeef;
-
 	chip->cmd_ctrl = brcmnand_cmd_ctrl;
 	chip->cmdfunc = brcmnand_cmdfunc;
 	chip->waitfunc = brcmnand_waitfunc;
diff --git a/drivers/mtd/nand/raw/socrates_nand.c b/drivers/mtd/nand/raw/socrates_nand.c
index 64ea9a014054..aa42b4ea4d23 100644
--- a/drivers/mtd/nand/raw/socrates_nand.c
+++ b/drivers/mtd/nand/raw/socrates_nand.c
@@ -152,10 +152,6 @@ static int socrates_nand_probe(struct platform_device *ofdev)
 	mtd->name = "socrates_nand";
 	mtd->dev.parent = &ofdev->dev;
 
-	/*should never be accessed directly */
-	nand_chip->IO_ADDR_R = (void *)0xdeadbeef;
-	nand_chip->IO_ADDR_W = (void *)0xdeadbeef;
-
 	nand_chip->cmd_ctrl = socrates_nand_cmd_ctrl;
 	nand_chip->read_byte = socrates_nand_read_byte;
 	nand_chip->write_buf = socrates_nand_write_buf;
-- 
2.14.1

From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 07/27] mips: nand: make use of mtd_to_nand() where appropriate
Date: Mon, 16 Nov 2015 14:37:40 +0100
Message-ID: <1447681080-31232-8-git-send-email-boris.brezillon@free-electrons.com>
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

mtd_to_nand() was recently introduced to avoid direct accesses to the
mtd->priv field. Update all MIPS specific implementations to use this
helper.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/mips/alchemy/devboards/db1200.c | 2 +-
 arch/mips/alchemy/devboards/db1300.c | 2 +-
 arch/mips/alchemy/devboards/db1550.c | 2 +-
 arch/mips/pnx833x/common/platform.c  | 2 +-
 arch/mips/rb532/devices.c            | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index 8c13675..992442a 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -200,7 +200,7 @@ static struct i2c_board_info db1200_i2c_devs[] __initdata = {
 static void au1200_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
 				 unsigned int ctrl)
 {
-	struct nand_chip *this = mtd->priv;
+	struct nand_chip *this = mtd_to_nand(mtd);
 	unsigned long ioaddr = (unsigned long)this->IO_ADDR_W;
 
 	ioaddr &= 0xffffff00;
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index b580770..d3c087f 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -150,7 +150,7 @@ static void __init db1300_gpio_config(void)
 static void au1300_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
 				 unsigned int ctrl)
 {
-	struct nand_chip *this = mtd->priv;
+	struct nand_chip *this = mtd_to_nand(mtd);
 	unsigned long ioaddr = (unsigned long)this->IO_ADDR_W;
 
 	ioaddr &= 0xffffff00;
diff --git a/arch/mips/alchemy/devboards/db1550.c b/arch/mips/alchemy/devboards/db1550.c
index 5740bcf..b518f02 100644
--- a/arch/mips/alchemy/devboards/db1550.c
+++ b/arch/mips/alchemy/devboards/db1550.c
@@ -128,7 +128,7 @@ static struct i2c_board_info db1550_i2c_devs[] __initdata = {
 static void au1550_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
 				 unsigned int ctrl)
 {
-	struct nand_chip *this = mtd->priv;
+	struct nand_chip *this = mtd_to_nand(mtd);
 	unsigned long ioaddr = (unsigned long)this->IO_ADDR_W;
 
 	ioaddr &= 0xffffff00;
diff --git a/arch/mips/pnx833x/common/platform.c b/arch/mips/pnx833x/common/platform.c
index b4b774b..3cd3577 100644
--- a/arch/mips/pnx833x/common/platform.c
+++ b/arch/mips/pnx833x/common/platform.c
@@ -180,7 +180,7 @@ static struct platform_device pnx833x_sata_device = {
 static void
 pnx833x_flash_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
-	struct nand_chip *this = mtd->priv;
+	struct nand_chip *this = mtd_to_nand(mtd);
 	unsigned long nandaddr = (unsigned long)this->IO_ADDR_W;
 
 	if (cmd == NAND_CMD_NONE)
diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index 9bd7a2d..0966adc 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -148,7 +148,7 @@ static int rb532_dev_ready(struct mtd_info *mtd)
 
 static void rb532_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
-	struct nand_chip *chip = mtd->priv;
+	struct nand_chip *chip = mtd_to_nand(mtd);
 	unsigned char orbits, nandbits;
 
 	if (ctrl & NAND_CTRL_CHANGE) {
-- 
2.1.4

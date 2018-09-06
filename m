From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 02/19] mtd: rawnand: Create a legacy struct and move
 ->IO_ADDR_{R, W} there
Date: Fri,  7 Sep 2018 00:38:34 +0200
Message-ID: <20180906223851.6964-3-boris.brezillon@bootlin.com>
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

We regularly have new NAND controller drivers that are making use of
fields/hooks that we want to get rid of but can't because of all the
legacy drivers that we might break if we do.

So, instead of removing those fields/hooks, let's move them to a
sub-struct which is clearly documented as deprecated.

We start with the ->IO_ADDR_{R,W] fields.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 Documentation/driver-api/mtdnand.rst | 24 ++++++++++++------------
 arch/arm/mach-ep93xx/snappercl15.c   |  5 +++--
 arch/arm/mach-ep93xx/ts72xx.c        |  6 +++---
 arch/arm/mach-imx/mach-qong.c        |  4 ++--
 arch/arm/mach-ixp4xx/ixdp425-setup.c |  2 +-
 arch/arm/mach-omap1/board-nand.c     |  2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c |  6 +++---
 arch/arm/mach-pxa/balloon3.c         |  2 +-
 arch/arm/mach-pxa/em-x270.c          |  6 +++---
 arch/arm/mach-pxa/palmtx.c           |  2 +-
 arch/mips/alchemy/devboards/db1200.c |  6 +++---
 arch/mips/alchemy/devboards/db1300.c |  6 +++---
 arch/mips/alchemy/devboards/db1550.c |  6 +++---
 arch/mips/pnx833x/common/platform.c  |  2 +-
 arch/mips/rb532/devices.c            |  2 +-
 arch/sh/boards/mach-migor/setup.c    |  6 +++---
 drivers/mtd/nand/raw/ams-delta.c     |  8 ++++----
 drivers/mtd/nand/raw/au1550nd.c      | 26 +++++++++++++-------------
 drivers/mtd/nand/raw/cmx270_nand.c   | 16 ++++++++--------
 drivers/mtd/nand/raw/cs553x_nand.c   | 30 +++++++++++++++---------------
 drivers/mtd/nand/raw/davinci_nand.c  | 24 ++++++++++++------------
 drivers/mtd/nand/raw/fsl_upm.c       | 16 ++++++++--------
 drivers/mtd/nand/raw/gpio.c          | 10 +++++-----
 drivers/mtd/nand/raw/jz4740_nand.c   |  8 ++++----
 drivers/mtd/nand/raw/jz4780_nand.c   |  4 ++--
 drivers/mtd/nand/raw/lpc32xx_mlc.c   |  4 ++--
 drivers/mtd/nand/raw/lpc32xx_slc.c   |  4 ++--
 drivers/mtd/nand/raw/nand_base.c     | 12 ++++++------
 drivers/mtd/nand/raw/ndfc.c          |  4 ++--
 drivers/mtd/nand/raw/omap2.c         | 30 +++++++++++++++---------------
 drivers/mtd/nand/raw/orion_nand.c    |  6 +++---
 drivers/mtd/nand/raw/pasemi_nand.c   | 22 +++++++++++-----------
 drivers/mtd/nand/raw/plat_nand.c     |  4 ++--
 drivers/mtd/nand/raw/s3c2410.c       | 12 ++++++------
 drivers/mtd/nand/raw/sharpsl.c       |  6 +++---
 drivers/mtd/nand/raw/tmio_nand.c     |  6 +++---
 include/linux/mtd/rawnand.h          | 26 ++++++++++++++++++++------
 37 files changed, 190 insertions(+), 175 deletions(-)

diff --git a/Documentation/driver-api/mtdnand.rst b/Documentation/driver-api/mtdnand.rst
index 5470a3d6bd9e..1d2403f1d8c5 100644
--- a/Documentation/driver-api/mtdnand.rst
+++ b/Documentation/driver-api/mtdnand.rst
@@ -180,10 +180,10 @@ by a chip select decoder.
     {
         struct nand_chip *this = mtd_to_nand(mtd);
         switch(cmd){
-            case NAND_CTL_SETCLE: this->IO_ADDR_W |= CLE_ADRR_BIT;  break;
-            case NAND_CTL_CLRCLE: this->IO_ADDR_W &= ~CLE_ADRR_BIT; break;
-            case NAND_CTL_SETALE: this->IO_ADDR_W |= ALE_ADRR_BIT;  break;
-            case NAND_CTL_CLRALE: this->IO_ADDR_W &= ~ALE_ADRR_BIT; break;
+            case NAND_CTL_SETCLE: this->legacy.IO_ADDR_W |= CLE_ADRR_BIT;  break;
+            case NAND_CTL_CLRCLE: this->legacy.IO_ADDR_W &= ~CLE_ADRR_BIT; break;
+            case NAND_CTL_SETALE: this->legacy.IO_ADDR_W |= ALE_ADRR_BIT;  break;
+            case NAND_CTL_CLRALE: this->legacy.IO_ADDR_W &= ~ALE_ADRR_BIT; break;
         }
     }
 
@@ -235,8 +235,8 @@ necessary information about the device.
         }
 
         /* Set address of NAND IO lines */
-        this->IO_ADDR_R = baseaddr;
-        this->IO_ADDR_W = baseaddr;
+        this->legacy.IO_ADDR_R = baseaddr;
+        this->legacy.IO_ADDR_W = baseaddr;
         /* Reference hardware control function */
         this->hwcontrol = board_hwcontrol;
         /* Set command delay time, see datasheet for correct value */
@@ -336,17 +336,17 @@ connected to an address decoder.
         struct nand_chip *this = mtd_to_nand(mtd);
 
         /* Deselect all chips */
-        this->IO_ADDR_R &= ~BOARD_NAND_ADDR_MASK;
-        this->IO_ADDR_W &= ~BOARD_NAND_ADDR_MASK;
+        this->legacy.IO_ADDR_R &= ~BOARD_NAND_ADDR_MASK;
+        this->legacy.IO_ADDR_W &= ~BOARD_NAND_ADDR_MASK;
         switch (chip) {
         case 0:
-            this->IO_ADDR_R |= BOARD_NAND_ADDR_CHIP0;
-            this->IO_ADDR_W |= BOARD_NAND_ADDR_CHIP0;
+            this->legacy.IO_ADDR_R |= BOARD_NAND_ADDR_CHIP0;
+            this->legacy.IO_ADDR_W |= BOARD_NAND_ADDR_CHIP0;
             break;
         ....
         case n:
-            this->IO_ADDR_R |= BOARD_NAND_ADDR_CHIPn;
-            this->IO_ADDR_W |= BOARD_NAND_ADDR_CHIPn;
+            this->legacy.IO_ADDR_R |= BOARD_NAND_ADDR_CHIPn;
+            this->legacy.IO_ADDR_W |= BOARD_NAND_ADDR_CHIPn;
             break;
         }
     }
diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index aa03ea79c5f5..1dad83a0bc5b 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -43,7 +43,7 @@
 #define SNAPPERCL15_NAND_CEN	(1 << 11) /* Chip enable (active low) */
 #define SNAPPERCL15_NAND_RDY	(1 << 14) /* Device ready */
 
-#define NAND_CTRL_ADDR(chip) 	(chip->IO_ADDR_W + 0x40)
+#define NAND_CTRL_ADDR(chip) 	(chip->legacy.IO_ADDR_W + 0x40)
 
 static void snappercl15_nand_cmd_ctrl(struct nand_chip *chip, int cmd,
 				      unsigned int ctrl)
@@ -69,7 +69,8 @@ static void snappercl15_nand_cmd_ctrl(struct nand_chip *chip, int cmd,
 	}
 
 	if (cmd != NAND_CMD_NONE)
-		__raw_writew((cmd & 0xff) | nand_state, chip->IO_ADDR_W);
+		__raw_writew((cmd & 0xff) | nand_state,
+			     chip->legacy.IO_ADDR_W);
 }
 
 static int snappercl15_nand_dev_ready(struct nand_chip *chip)
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 26259dd9e951..188bf02595c5 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -80,7 +80,7 @@ static void ts72xx_nand_hwcontrol(struct nand_chip *chip,
 				  int cmd, unsigned int ctrl)
 {
 	if (ctrl & NAND_CTRL_CHANGE) {
-		void __iomem *addr = chip->IO_ADDR_R;
+		void __iomem *addr = chip->legacy.IO_ADDR_R;
 		unsigned char bits;
 
 		addr += (1 << TS72XX_NAND_CONTROL_ADDR_LINE);
@@ -94,12 +94,12 @@ static void ts72xx_nand_hwcontrol(struct nand_chip *chip,
 	}
 
 	if (cmd != NAND_CMD_NONE)
-		__raw_writeb(cmd, chip->IO_ADDR_W);
+		__raw_writeb(cmd, chip->legacy.IO_ADDR_W);
 }
 
 static int ts72xx_nand_device_ready(struct nand_chip *chip)
 {
-	void __iomem *addr = chip->IO_ADDR_R;
+	void __iomem *addr = chip->legacy.IO_ADDR_R;
 
 	addr += (1 << TS72XX_NAND_BUSY_ADDR_LINE);
 
diff --git a/arch/arm/mach-imx/mach-qong.c b/arch/arm/mach-imx/mach-qong.c
index ff015f603ac9..48972944bb95 100644
--- a/arch/arm/mach-imx/mach-qong.c
+++ b/arch/arm/mach-imx/mach-qong.c
@@ -136,9 +136,9 @@ static void qong_nand_cmd_ctrl(struct nand_chip *nand_chip, int cmd,
 		return;
 
 	if (ctrl & NAND_CLE)
-		writeb(cmd, nand_chip->IO_ADDR_W + (1 << 24));
+		writeb(cmd, nand_chip->legacy.IO_ADDR_W + (1 << 24));
 	else
-		writeb(cmd, nand_chip->IO_ADDR_W + (1 << 23));
+		writeb(cmd, nand_chip->legacy.IO_ADDR_W + (1 << 23));
 }
 
 /*
diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index 7c39edc121ba..797e7edc7124 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -92,7 +92,7 @@ ixdp425_flash_nand_cmd_ctrl(struct nand_chip *this, int cmd, unsigned int ctrl)
 	}
 
 	if (cmd != NAND_CMD_NONE)
-		writeb(cmd, this->IO_ADDR_W + offset);
+		writeb(cmd, this->legacy.IO_ADDR_W + offset);
 }
 
 static struct platform_nand_data ixdp425_flash_nand_data = {
diff --git a/arch/arm/mach-omap1/board-nand.c b/arch/arm/mach-omap1/board-nand.c
index 59d56a30bc63..20923eb2d9b6 100644
--- a/arch/arm/mach-omap1/board-nand.c
+++ b/arch/arm/mach-omap1/board-nand.c
@@ -31,6 +31,6 @@ void omap1_nand_cmd_ctl(struct nand_chip *this, int cmd, unsigned int ctrl)
 	if (ctrl & NAND_ALE)
 		mask |= 0x04;
 
-	writeb(cmd, this->IO_ADDR_W + mask);
+	writeb(cmd, this->legacy.IO_ADDR_W + mask);
 }
 
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index 48d85ddf7c31..aac2c6eb35e2 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -145,7 +145,7 @@ static void ts78xx_ts_nand_cmd_ctrl(struct nand_chip *this, int cmd,
 	}
 
 	if (cmd != NAND_CMD_NONE)
-		writeb(cmd, this->IO_ADDR_W);
+		writeb(cmd, this->legacy.IO_ADDR_W);
 }
 
 static int ts78xx_ts_nand_dev_ready(struct nand_chip *chip)
@@ -156,7 +156,7 @@ static int ts78xx_ts_nand_dev_ready(struct nand_chip *chip)
 static void ts78xx_ts_nand_write_buf(struct nand_chip *chip,
 				     const uint8_t *buf, int len)
 {
-	void __iomem *io_base = chip->IO_ADDR_W;
+	void __iomem *io_base = chip->legacy.IO_ADDR_W;
 	unsigned long off = ((unsigned long)buf & 3);
 	int sz;
 
@@ -182,7 +182,7 @@ static void ts78xx_ts_nand_write_buf(struct nand_chip *chip,
 static void ts78xx_ts_nand_read_buf(struct nand_chip *chip,
 				    uint8_t *buf, int len)
 {
-	void __iomem *io_base = chip->IO_ADDR_R;
+	void __iomem *io_base = chip->legacy.IO_ADDR_R;
 	unsigned long off = ((unsigned long)buf & 3);
 	int sz;
 
diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 71fda90b9599..256e60c38a6d 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -597,7 +597,7 @@ static void balloon3_nand_cmd_ctl(struct nand_chip *this, int cmd,
 	}
 
 	if (cmd != NAND_CMD_NONE)
-		writeb(cmd, this->IO_ADDR_W);
+		writeb(cmd, this->legacy.IO_ADDR_W);
 }
 
 static void balloon3_nand_select_chip(struct nand_chip *this, int chip)
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index ba1ec9992830..3acb945a2628 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -288,7 +288,7 @@ static void nand_cs_off(void)
 static void em_x270_nand_cmd_ctl(struct nand_chip *this, int dat,
 				 unsigned int ctrl)
 {
-	unsigned long nandaddr = (unsigned long)this->IO_ADDR_W;
+	unsigned long nandaddr = (unsigned long)this->legacy.IO_ADDR_W;
 
 	dsb();
 
@@ -308,9 +308,9 @@ static void em_x270_nand_cmd_ctl(struct nand_chip *this, int dat,
 	}
 
 	dsb();
-	this->IO_ADDR_W = (void __iomem *)nandaddr;
+	this->legacy.IO_ADDR_W = (void __iomem *)nandaddr;
 	if (dat != NAND_CMD_NONE)
-		writel(dat, this->IO_ADDR_W);
+		writel(dat, this->legacy.IO_ADDR_W);
 
 	dsb();
 }
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index ed9661e70b83..36ea32c1bbcc 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -250,7 +250,7 @@ static inline void palmtx_keys_init(void) {}
 static void palmtx_nand_cmd_ctl(struct nand_chip *this, int cmd,
 				unsigned int ctrl)
 {
-	char __iomem *nandaddr = this->IO_ADDR_W;
+	char __iomem *nandaddr = this->legacy.IO_ADDR_W;
 
 	if (cmd == NAND_CMD_NONE)
 		return;
diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index f043615c1a99..97dc74f7f41a 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -200,7 +200,7 @@ static struct i2c_board_info db1200_i2c_devs[] __initdata = {
 static void au1200_nand_cmd_ctrl(struct nand_chip *this, int cmd,
 				 unsigned int ctrl)
 {
-	unsigned long ioaddr = (unsigned long)this->IO_ADDR_W;
+	unsigned long ioaddr = (unsigned long)this->legacy.IO_ADDR_W;
 
 	ioaddr &= 0xffffff00;
 
@@ -212,9 +212,9 @@ static void au1200_nand_cmd_ctrl(struct nand_chip *this, int cmd,
 		/* assume we want to r/w real data  by default */
 		ioaddr += MEM_STNAND_DATA;
 	}
-	this->IO_ADDR_R = this->IO_ADDR_W = (void __iomem *)ioaddr;
+	this->legacy.IO_ADDR_R = this->legacy.IO_ADDR_W = (void __iomem *)ioaddr;
 	if (cmd != NAND_CMD_NONE) {
-		__raw_writeb(cmd, this->IO_ADDR_W);
+		__raw_writeb(cmd, this->legacy.IO_ADDR_W);
 		wmb();
 	}
 }
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index 1201fa655e78..b813dc1c1682 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -152,7 +152,7 @@ static void __init db1300_gpio_config(void)
 static void au1300_nand_cmd_ctrl(struct nand_chip *this, int cmd,
 				 unsigned int ctrl)
 {
-	unsigned long ioaddr = (unsigned long)this->IO_ADDR_W;
+	unsigned long ioaddr = (unsigned long)this->legacy.IO_ADDR_W;
 
 	ioaddr &= 0xffffff00;
 
@@ -164,9 +164,9 @@ static void au1300_nand_cmd_ctrl(struct nand_chip *this, int cmd,
 		/* assume we want to r/w real data  by default */
 		ioaddr += MEM_STNAND_DATA;
 	}
-	this->IO_ADDR_R = this->IO_ADDR_W = (void __iomem *)ioaddr;
+	this->legacy.IO_ADDR_R = this->legacy.IO_ADDR_W = (void __iomem *)ioaddr;
 	if (cmd != NAND_CMD_NONE) {
-		__raw_writeb(cmd, this->IO_ADDR_W);
+		__raw_writeb(cmd, this->legacy.IO_ADDR_W);
 		wmb();
 	}
 }
diff --git a/arch/mips/alchemy/devboards/db1550.c b/arch/mips/alchemy/devboards/db1550.c
index cae39cde5de6..65f6b7184fbe 100644
--- a/arch/mips/alchemy/devboards/db1550.c
+++ b/arch/mips/alchemy/devboards/db1550.c
@@ -129,7 +129,7 @@ static struct i2c_board_info db1550_i2c_devs[] __initdata = {
 static void au1550_nand_cmd_ctrl(struct nand_chip *this, int cmd,
 				 unsigned int ctrl)
 {
-	unsigned long ioaddr = (unsigned long)this->IO_ADDR_W;
+	unsigned long ioaddr = (unsigned long)this->legacy.IO_ADDR_W;
 
 	ioaddr &= 0xffffff00;
 
@@ -141,9 +141,9 @@ static void au1550_nand_cmd_ctrl(struct nand_chip *this, int cmd,
 		/* assume we want to r/w real data  by default */
 		ioaddr += MEM_STNAND_DATA;
 	}
-	this->IO_ADDR_R = this->IO_ADDR_W = (void __iomem *)ioaddr;
+	this->legacy.IO_ADDR_R = this->legacy.IO_ADDR_W = (void __iomem *)ioaddr;
 	if (cmd != NAND_CMD_NONE) {
-		__raw_writeb(cmd, this->IO_ADDR_W);
+		__raw_writeb(cmd, this->legacy.IO_ADDR_W);
 		wmb();
 	}
 }
diff --git a/arch/mips/pnx833x/common/platform.c b/arch/mips/pnx833x/common/platform.c
index ca8a2889431e..33d0f070b33d 100644
--- a/arch/mips/pnx833x/common/platform.c
+++ b/arch/mips/pnx833x/common/platform.c
@@ -180,7 +180,7 @@ static struct platform_device pnx833x_sata_device = {
 static void
 pnx833x_flash_nand_cmd_ctrl(struct nand_chip *this, int cmd, unsigned int ctrl)
 {
-	unsigned long nandaddr = (unsigned long)this->IO_ADDR_W;
+	unsigned long nandaddr = (unsigned long)this->legacy.IO_ADDR_W;
 
 	if (cmd == NAND_CMD_NONE)
 		return;
diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index 9173949892ed..02a9e042fb44 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -160,7 +160,7 @@ static void rb532_cmd_ctrl(struct nand_chip *chip, int cmd, unsigned int ctrl)
 		set_latch_u5(orbits, nandbits);
 	}
 	if (cmd != NAND_CMD_NONE)
-		writeb(cmd, chip->IO_ADDR_W);
+		writeb(cmd, chip->legacy.IO_ADDR_W);
 }
 
 static struct resource nand_slot0_res[] = {
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 833f3e49027b..ebcc4d5a67ce 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -172,11 +172,11 @@ static void migor_nand_flash_cmd_ctl(struct nand_chip *chip, int cmd,
 		return;
 
 	if (ctrl & NAND_CLE)
-		writeb(cmd, chip->IO_ADDR_W + 0x00400000);
+		writeb(cmd, chip->legacy.IO_ADDR_W + 0x00400000);
 	else if (ctrl & NAND_ALE)
-		writeb(cmd, chip->IO_ADDR_W + 0x00800000);
+		writeb(cmd, chip->legacy.IO_ADDR_W + 0x00800000);
 	else
-		writeb(cmd, chip->IO_ADDR_W);
+		writeb(cmd, chip->legacy.IO_ADDR_W);
 }
 
 static int migor_nand_flash_ready(struct nand_chip *chip)
diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 48413203dbc2..5bc8b29faf6d 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -68,7 +68,7 @@ static void ams_delta_write_byte(struct nand_chip *this, u_char byte)
 	void __iomem *io_base = (void __iomem *)nand_get_controller_data(this);
 
 	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
-	writew(byte, this->IO_ADDR_W);
+	writew(byte, this->legacy.IO_ADDR_W);
 	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NWE, 0);
 	ndelay(40);
 	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NWE, 1);
@@ -82,7 +82,7 @@ static u_char ams_delta_read_byte(struct nand_chip *this)
 	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NRE, 0);
 	ndelay(40);
 	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
-	res = readw(this->IO_ADDR_R);
+	res = readw(this->legacy.IO_ADDR_R);
 	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NRE, 1);
 
 	return res;
@@ -208,8 +208,8 @@ static int ams_delta_init(struct platform_device *pdev)
 	nand_set_controller_data(this, (void *)io_base);
 
 	/* Set address of NAND IO lines */
-	this->IO_ADDR_R = io_base + OMAP_MPUIO_INPUT_LATCH;
-	this->IO_ADDR_W = io_base + OMAP_MPUIO_OUTPUT;
+	this->legacy.IO_ADDR_R = io_base + OMAP_MPUIO_INPUT_LATCH;
+	this->legacy.IO_ADDR_W = io_base + OMAP_MPUIO_OUTPUT;
 	this->read_byte = ams_delta_read_byte;
 	this->write_buf = ams_delta_write_buf;
 	this->read_buf = ams_delta_read_buf;
diff --git a/drivers/mtd/nand/raw/au1550nd.c b/drivers/mtd/nand/raw/au1550nd.c
index d0ec8606e769..b7bb2b2af4ef 100644
--- a/drivers/mtd/nand/raw/au1550nd.c
+++ b/drivers/mtd/nand/raw/au1550nd.c
@@ -35,7 +35,7 @@ struct au1550nd_ctx {
  */
 static u_char au_read_byte(struct nand_chip *this)
 {
-	u_char ret = readb(this->IO_ADDR_R);
+	u_char ret = readb(this->legacy.IO_ADDR_R);
 	wmb(); /* drain writebuffer */
 	return ret;
 }
@@ -49,7 +49,7 @@ static u_char au_read_byte(struct nand_chip *this)
  */
 static void au_write_byte(struct nand_chip *this, u_char byte)
 {
-	writeb(byte, this->IO_ADDR_W);
+	writeb(byte, this->legacy.IO_ADDR_W);
 	wmb(); /* drain writebuffer */
 }
 
@@ -61,7 +61,7 @@ static void au_write_byte(struct nand_chip *this, u_char byte)
  */
 static u_char au_read_byte16(struct nand_chip *this)
 {
-	u_char ret = (u_char) cpu_to_le16(readw(this->IO_ADDR_R));
+	u_char ret = (u_char) cpu_to_le16(readw(this->legacy.IO_ADDR_R));
 	wmb(); /* drain writebuffer */
 	return ret;
 }
@@ -75,7 +75,7 @@ static u_char au_read_byte16(struct nand_chip *this)
  */
 static void au_write_byte16(struct nand_chip *this, u_char byte)
 {
-	writew(le16_to_cpu((u16) byte), this->IO_ADDR_W);
+	writew(le16_to_cpu((u16) byte), this->legacy.IO_ADDR_W);
 	wmb(); /* drain writebuffer */
 }
 
@@ -92,7 +92,7 @@ static void au_write_buf(struct nand_chip *this, const u_char *buf, int len)
 	int i;
 
 	for (i = 0; i < len; i++) {
-		writeb(buf[i], this->IO_ADDR_W);
+		writeb(buf[i], this->legacy.IO_ADDR_W);
 		wmb(); /* drain writebuffer */
 	}
 }
@@ -110,7 +110,7 @@ static void au_read_buf(struct nand_chip *this, u_char *buf, int len)
 	int i;
 
 	for (i = 0; i < len; i++) {
-		buf[i] = readb(this->IO_ADDR_R);
+		buf[i] = readb(this->legacy.IO_ADDR_R);
 		wmb(); /* drain writebuffer */
 	}
 }
@@ -130,7 +130,7 @@ static void au_write_buf16(struct nand_chip *this, const u_char *buf, int len)
 	len >>= 1;
 
 	for (i = 0; i < len; i++) {
-		writew(p[i], this->IO_ADDR_W);
+		writew(p[i], this->legacy.IO_ADDR_W);
 		wmb(); /* drain writebuffer */
 	}
 
@@ -152,7 +152,7 @@ static void au_read_buf16(struct mtd_info *mtd, u_char *buf, int len)
 	len >>= 1;
 
 	for (i = 0; i < len; i++) {
-		p[i] = readw(this->IO_ADDR_R);
+		p[i] = readw(this->legacy.IO_ADDR_R);
 		wmb(); /* drain writebuffer */
 	}
 }
@@ -179,19 +179,19 @@ static void au1550_hwcontrol(struct mtd_info *mtd, int cmd)
 	switch (cmd) {
 
 	case NAND_CTL_SETCLE:
-		this->IO_ADDR_W = ctx->base + MEM_STNAND_CMD;
+		this->legacy.IO_ADDR_W = ctx->base + MEM_STNAND_CMD;
 		break;
 
 	case NAND_CTL_CLRCLE:
-		this->IO_ADDR_W = ctx->base + MEM_STNAND_DATA;
+		this->legacy.IO_ADDR_W = ctx->base + MEM_STNAND_DATA;
 		break;
 
 	case NAND_CTL_SETALE:
-		this->IO_ADDR_W = ctx->base + MEM_STNAND_ADDR;
+		this->legacy.IO_ADDR_W = ctx->base + MEM_STNAND_ADDR;
 		break;
 
 	case NAND_CTL_CLRALE:
-		this->IO_ADDR_W = ctx->base + MEM_STNAND_DATA;
+		this->legacy.IO_ADDR_W = ctx->base + MEM_STNAND_DATA;
 		/* FIXME: Nobody knows why this is necessary,
 		 * but it works only that way */
 		udelay(1);
@@ -208,7 +208,7 @@ static void au1550_hwcontrol(struct mtd_info *mtd, int cmd)
 		break;
 	}
 
-	this->IO_ADDR_R = this->IO_ADDR_W;
+	this->legacy.IO_ADDR_R = this->legacy.IO_ADDR_W;
 
 	wmb(); /* Drain the writebuffer */
 }
diff --git a/drivers/mtd/nand/raw/cmx270_nand.c b/drivers/mtd/nand/raw/cmx270_nand.c
index e8458036419b..b4ed69815bed 100644
--- a/drivers/mtd/nand/raw/cmx270_nand.c
+++ b/drivers/mtd/nand/raw/cmx270_nand.c
@@ -51,7 +51,7 @@ static const struct mtd_partition partition_info[] = {
 
 static u_char cmx270_read_byte(struct nand_chip *this)
 {
-	return (readl(this->IO_ADDR_R) >> 16);
+	return (readl(this->legacy.IO_ADDR_R) >> 16);
 }
 
 static void cmx270_write_buf(struct nand_chip *this, const u_char *buf,
@@ -60,7 +60,7 @@ static void cmx270_write_buf(struct nand_chip *this, const u_char *buf,
 	int i;
 
 	for (i=0; i<len; i++)
-		writel((*buf++ << 16), this->IO_ADDR_W);
+		writel((*buf++ << 16), this->legacy.IO_ADDR_W);
 }
 
 static void cmx270_read_buf(struct nand_chip *this, u_char *buf, int len)
@@ -68,7 +68,7 @@ static void cmx270_read_buf(struct nand_chip *this, u_char *buf, int len)
 	int i;
 
 	for (i=0; i<len; i++)
-		*buf++ = readl(this->IO_ADDR_R) >> 16;
+		*buf++ = readl(this->legacy.IO_ADDR_R) >> 16;
 }
 
 static inline void nand_cs_on(void)
@@ -89,7 +89,7 @@ static void nand_cs_off(void)
 static void cmx270_hwcontrol(struct nand_chip *this, int dat,
 			     unsigned int ctrl)
 {
-	unsigned int nandaddr = (unsigned int)this->IO_ADDR_W;
+	unsigned int nandaddr = (unsigned int)this->legacy.IO_ADDR_W;
 
 	dsb();
 
@@ -109,9 +109,9 @@ static void cmx270_hwcontrol(struct nand_chip *this, int dat,
 	}
 
 	dsb();
-	this->IO_ADDR_W = (void __iomem*)nandaddr;
+	this->legacy.IO_ADDR_W = (void __iomem*)nandaddr;
 	if (dat != NAND_CMD_NONE)
-		writel((dat << 16), this->IO_ADDR_W);
+		writel((dat << 16), this->legacy.IO_ADDR_W);
 
 	dsb();
 }
@@ -173,8 +173,8 @@ static int __init cmx270_init(void)
 	cmx270_nand_mtd->owner = THIS_MODULE;
 
 	/* insert callbacks */
-	this->IO_ADDR_R = cmx270_nand_io;
-	this->IO_ADDR_W = cmx270_nand_io;
+	this->legacy.IO_ADDR_R = cmx270_nand_io;
+	this->legacy.IO_ADDR_W = cmx270_nand_io;
 	this->cmd_ctrl = cmx270_hwcontrol;
 	this->dev_ready = cmx270_device_ready;
 
diff --git a/drivers/mtd/nand/raw/cs553x_nand.c b/drivers/mtd/nand/raw/cs553x_nand.c
index c1628c03282a..b03fb36e9e69 100644
--- a/drivers/mtd/nand/raw/cs553x_nand.c
+++ b/drivers/mtd/nand/raw/cs553x_nand.c
@@ -96,43 +96,43 @@
 static void cs553x_read_buf(struct nand_chip *this, u_char *buf, int len)
 {
 	while (unlikely(len > 0x800)) {
-		memcpy_fromio(buf, this->IO_ADDR_R, 0x800);
+		memcpy_fromio(buf, this->legacy.IO_ADDR_R, 0x800);
 		buf += 0x800;
 		len -= 0x800;
 	}
-	memcpy_fromio(buf, this->IO_ADDR_R, len);
+	memcpy_fromio(buf, this->legacy.IO_ADDR_R, len);
 }
 
 static void cs553x_write_buf(struct nand_chip *this, const u_char *buf, int len)
 {
 	while (unlikely(len > 0x800)) {
-		memcpy_toio(this->IO_ADDR_R, buf, 0x800);
+		memcpy_toio(this->legacy.IO_ADDR_R, buf, 0x800);
 		buf += 0x800;
 		len -= 0x800;
 	}
-	memcpy_toio(this->IO_ADDR_R, buf, len);
+	memcpy_toio(this->legacy.IO_ADDR_R, buf, len);
 }
 
 static unsigned char cs553x_read_byte(struct nand_chip *this)
 {
-	return readb(this->IO_ADDR_R);
+	return readb(this->legacy.IO_ADDR_R);
 }
 
 static void cs553x_write_byte(struct nand_chip *this, u_char byte)
 {
 	int i = 100000;
 
-	while (i && readb(this->IO_ADDR_R + MM_NAND_STS) & CS_NAND_CTLR_BUSY) {
+	while (i && readb(this->legacy.IO_ADDR_R + MM_NAND_STS) & CS_NAND_CTLR_BUSY) {
 		udelay(1);
 		i--;
 	}
-	writeb(byte, this->IO_ADDR_W + 0x801);
+	writeb(byte, this->legacy.IO_ADDR_W + 0x801);
 }
 
 static void cs553x_hwcontrol(struct nand_chip *this, int cmd,
 			     unsigned int ctrl)
 {
-	void __iomem *mmio_base = this->IO_ADDR_R;
+	void __iomem *mmio_base = this->legacy.IO_ADDR_R;
 	if (ctrl & NAND_CTRL_CHANGE) {
 		unsigned char ctl = (ctrl & ~NAND_CTRL_CHANGE ) ^ 0x01;
 		writeb(ctl, mmio_base + MM_NAND_CTL);
@@ -143,7 +143,7 @@ static void cs553x_hwcontrol(struct nand_chip *this, int cmd,
 
 static int cs553x_device_ready(struct nand_chip *this)
 {
-	void __iomem *mmio_base = this->IO_ADDR_R;
+	void __iomem *mmio_base = this->legacy.IO_ADDR_R;
 	unsigned char foo = readb(mmio_base + MM_NAND_STS);
 
 	return (foo & CS_NAND_STS_FLASH_RDY) && !(foo & CS_NAND_CTLR_BUSY);
@@ -151,7 +151,7 @@ static int cs553x_device_ready(struct nand_chip *this)
 
 static void cs_enable_hwecc(struct nand_chip *this, int mode)
 {
-	void __iomem *mmio_base = this->IO_ADDR_R;
+	void __iomem *mmio_base = this->legacy.IO_ADDR_R;
 
 	writeb(0x07, mmio_base + MM_NAND_ECC_CTL);
 }
@@ -160,7 +160,7 @@ static int cs_calculate_ecc(struct nand_chip *this, const u_char *dat,
 			    u_char *ecc_code)
 {
 	uint32_t ecc;
-	void __iomem *mmio_base = this->IO_ADDR_R;
+	void __iomem *mmio_base = this->legacy.IO_ADDR_R;
 
 	ecc = readl(mmio_base + MM_NAND_STS);
 
@@ -199,8 +199,8 @@ static int __init cs553x_init_one(int cs, int mmio, unsigned long adr)
 	new_mtd->owner = THIS_MODULE;
 
 	/* map physical address */
-	this->IO_ADDR_R = this->IO_ADDR_W = ioremap(adr, 4096);
-	if (!this->IO_ADDR_R) {
+	this->legacy.IO_ADDR_R = this->legacy.IO_ADDR_W = ioremap(adr, 4096);
+	if (!this->legacy.IO_ADDR_R) {
 		pr_warn("ioremap cs553x NAND @0x%08lx failed\n", adr);
 		err = -EIO;
 		goto out_mtd;
@@ -242,7 +242,7 @@ static int __init cs553x_init_one(int cs, int mmio, unsigned long adr)
 out_free:
 	kfree(new_mtd->name);
 out_ior:
-	iounmap(this->IO_ADDR_R);
+	iounmap(this->legacy.IO_ADDR_R);
 out_mtd:
 	kfree(this);
 out:
@@ -324,7 +324,7 @@ static void __exit cs553x_cleanup(void)
 			continue;
 
 		this = mtd_to_nand(mtd);
-		mmio_base = this->IO_ADDR_R;
+		mmio_base = this->legacy.IO_ADDR_R;
 
 		/* Release resources, unregister device */
 		nand_release(this);
diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 4b261c73b240..1204b5120176 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -110,11 +110,11 @@ static void nand_davinci_hwcontrol(struct nand_chip *nand, int cmd,
 		else if ((ctrl & NAND_CTRL_ALE) == NAND_CTRL_ALE)
 			addr += info->mask_ale;
 
-		nand->IO_ADDR_W = addr;
+		nand->legacy.IO_ADDR_W = addr;
 	}
 
 	if (cmd != NAND_CMD_NONE)
-		iowrite8(cmd, nand->IO_ADDR_W);
+		iowrite8(cmd, nand->legacy.IO_ADDR_W);
 }
 
 static void nand_davinci_select_chip(struct nand_chip *nand, int chip)
@@ -127,8 +127,8 @@ static void nand_davinci_select_chip(struct nand_chip *nand, int chip)
 	if (chip > 0)
 		info->current_cs += info->mask_chipsel;
 
-	info->chip.IO_ADDR_W = info->current_cs;
-	info->chip.IO_ADDR_R = info->chip.IO_ADDR_W;
+	info->chip.legacy.IO_ADDR_W = info->current_cs;
+	info->chip.legacy.IO_ADDR_R = info->chip.legacy.IO_ADDR_W;
 }
 
 /*----------------------------------------------------------------------*/
@@ -438,22 +438,22 @@ static void nand_davinci_read_buf(struct nand_chip *chip, uint8_t *buf,
 				  int len)
 {
 	if ((0x03 & ((uintptr_t)buf)) == 0 && (0x03 & len) == 0)
-		ioread32_rep(chip->IO_ADDR_R, buf, len >> 2);
+		ioread32_rep(chip->legacy.IO_ADDR_R, buf, len >> 2);
 	else if ((0x01 & ((uintptr_t)buf)) == 0 && (0x01 & len) == 0)
-		ioread16_rep(chip->IO_ADDR_R, buf, len >> 1);
+		ioread16_rep(chip->legacy.IO_ADDR_R, buf, len >> 1);
 	else
-		ioread8_rep(chip->IO_ADDR_R, buf, len);
+		ioread8_rep(chip->legacy.IO_ADDR_R, buf, len);
 }
 
 static void nand_davinci_write_buf(struct nand_chip *chip, const uint8_t *buf,
 				   int len)
 {
 	if ((0x03 & ((uintptr_t)buf)) == 0 && (0x03 & len) == 0)
-		iowrite32_rep(chip->IO_ADDR_R, buf, len >> 2);
+		iowrite32_rep(chip->legacy.IO_ADDR_R, buf, len >> 2);
 	else if ((0x01 & ((uintptr_t)buf)) == 0 && (0x01 & len) == 0)
-		iowrite16_rep(chip->IO_ADDR_R, buf, len >> 1);
+		iowrite16_rep(chip->legacy.IO_ADDR_R, buf, len >> 1);
 	else
-		iowrite8_rep(chip->IO_ADDR_R, buf, len);
+		iowrite8_rep(chip->legacy.IO_ADDR_R, buf, len);
 }
 
 /*
@@ -759,8 +759,8 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	mtd->dev.parent		= &pdev->dev;
 	nand_set_flash_node(&info->chip, pdev->dev.of_node);
 
-	info->chip.IO_ADDR_R	= vaddr;
-	info->chip.IO_ADDR_W	= vaddr;
+	info->chip.legacy.IO_ADDR_R	= vaddr;
+	info->chip.legacy.IO_ADDR_W	= vaddr;
 	info->chip.chip_delay	= 0;
 	info->chip.select_chip	= nand_davinci_select_chip;
 
diff --git a/drivers/mtd/nand/raw/fsl_upm.c b/drivers/mtd/nand/raw/fsl_upm.c
index 48c5215f9a0e..f59fd57fc529 100644
--- a/drivers/mtd/nand/raw/fsl_upm.c
+++ b/drivers/mtd/nand/raw/fsl_upm.c
@@ -101,7 +101,7 @@ static void fun_cmd_ctrl(struct nand_chip *chip, int cmd, unsigned int ctrl)
 
 	mar = (cmd << (32 - fun->upm.width)) |
 		fun->mchip_offsets[fun->mchip_number];
-	fsl_upm_run_pattern(&fun->upm, chip->IO_ADDR_R, mar);
+	fsl_upm_run_pattern(&fun->upm, chip->legacy.IO_ADDR_R, mar);
 
 	if (fun->wait_flags & FSL_UPM_WAIT_RUN_PATTERN)
 		fun_wait_rnb(fun);
@@ -115,8 +115,8 @@ static void fun_select_chip(struct nand_chip *chip, int mchip_nr)
 		chip->cmd_ctrl(chip, NAND_CMD_NONE, 0 | NAND_CTRL_CHANGE);
 	} else if (mchip_nr >= 0 && mchip_nr < NAND_MAX_CHIPS) {
 		fun->mchip_number = mchip_nr;
-		chip->IO_ADDR_R = fun->io_base + fun->mchip_offsets[mchip_nr];
-		chip->IO_ADDR_W = chip->IO_ADDR_R;
+		chip->legacy.IO_ADDR_R = fun->io_base + fun->mchip_offsets[mchip_nr];
+		chip->legacy.IO_ADDR_W = chip->legacy.IO_ADDR_R;
 	} else {
 		BUG();
 	}
@@ -126,7 +126,7 @@ static uint8_t fun_read_byte(struct nand_chip *chip)
 {
 	struct fsl_upm_nand *fun = to_fsl_upm_nand(nand_to_mtd(chip));
 
-	return in_8(fun->chip.IO_ADDR_R);
+	return in_8(fun->chip.legacy.IO_ADDR_R);
 }
 
 static void fun_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
@@ -135,7 +135,7 @@ static void fun_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 	int i;
 
 	for (i = 0; i < len; i++)
-		buf[i] = in_8(fun->chip.IO_ADDR_R);
+		buf[i] = in_8(fun->chip.legacy.IO_ADDR_R);
 }
 
 static void fun_write_buf(struct nand_chip *chip, const uint8_t *buf, int len)
@@ -144,7 +144,7 @@ static void fun_write_buf(struct nand_chip *chip, const uint8_t *buf, int len)
 	int i;
 
 	for (i = 0; i < len; i++) {
-		out_8(fun->chip.IO_ADDR_W, buf[i]);
+		out_8(fun->chip.legacy.IO_ADDR_W, buf[i]);
 		if (fun->wait_flags & FSL_UPM_WAIT_WRITE_BYTE)
 			fun_wait_rnb(fun);
 	}
@@ -160,8 +160,8 @@ static int fun_chip_init(struct fsl_upm_nand *fun,
 	int ret;
 	struct device_node *flash_np;
 
-	fun->chip.IO_ADDR_R = fun->io_base;
-	fun->chip.IO_ADDR_W = fun->io_base;
+	fun->chip.legacy.IO_ADDR_R = fun->io_base;
+	fun->chip.legacy.IO_ADDR_W = fun->io_base;
 	fun->chip.cmd_ctrl = fun_cmd_ctrl;
 	fun->chip.chip_delay = fun->chip_delay;
 	fun->chip.read_byte = fun_read_byte;
diff --git a/drivers/mtd/nand/raw/gpio.c b/drivers/mtd/nand/raw/gpio.c
index 273437c1ae6c..bb43fad65362 100644
--- a/drivers/mtd/nand/raw/gpio.c
+++ b/drivers/mtd/nand/raw/gpio.c
@@ -90,7 +90,7 @@ static void gpio_nand_cmd_ctrl(struct nand_chip *chip, int cmd,
 	if (cmd == NAND_CMD_NONE)
 		return;
 
-	writeb(cmd, gpiomtd->nand_chip.IO_ADDR_W);
+	writeb(cmd, gpiomtd->nand_chip.legacy.IO_ADDR_W);
 	gpio_nand_dosync(gpiomtd);
 }
 
@@ -225,9 +225,9 @@ static int gpio_nand_probe(struct platform_device *pdev)
 	chip = &gpiomtd->nand_chip;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	chip->IO_ADDR_R = devm_ioremap_resource(dev, res);
-	if (IS_ERR(chip->IO_ADDR_R))
-		return PTR_ERR(chip->IO_ADDR_R);
+	chip->legacy.IO_ADDR_R = devm_ioremap_resource(dev, res);
+	if (IS_ERR(chip->legacy.IO_ADDR_R))
+		return PTR_ERR(chip->legacy.IO_ADDR_R);
 
 	res = gpio_nand_get_io_sync(pdev);
 	if (res) {
@@ -274,7 +274,7 @@ static int gpio_nand_probe(struct platform_device *pdev)
 		chip->dev_ready = gpio_nand_devready;
 
 	nand_set_flash_node(chip, pdev->dev.of_node);
-	chip->IO_ADDR_W		= chip->IO_ADDR_R;
+	chip->legacy.IO_ADDR_W	= chip->legacy.IO_ADDR_R;
 	chip->ecc.mode		= NAND_ECC_SOFT;
 	chip->ecc.algo		= NAND_ECC_HAMMING;
 	chip->options		= gpiomtd->plat.options;
diff --git a/drivers/mtd/nand/raw/jz4740_nand.c b/drivers/mtd/nand/raw/jz4740_nand.c
index 946a71cf816d..449180de92e2 100644
--- a/drivers/mtd/nand/raw/jz4740_nand.c
+++ b/drivers/mtd/nand/raw/jz4740_nand.c
@@ -91,8 +91,8 @@ static void jz_nand_select_chip(struct nand_chip *chip, int chipnr)
 		banknr = -1;
 	} else {
 		banknr = nand->banks[chipnr] - 1;
-		chip->IO_ADDR_R = nand->bank_base[banknr];
-		chip->IO_ADDR_W = nand->bank_base[banknr];
+		chip->legacy.IO_ADDR_R = nand->bank_base[banknr];
+		chip->legacy.IO_ADDR_W = nand->bank_base[banknr];
 	}
 	writel(ctrl, nand->base + JZ_REG_NAND_CTRL);
 
@@ -114,7 +114,7 @@ static void jz_nand_cmd_ctrl(struct nand_chip *chip, int dat,
 			bank_base += JZ_NAND_MEM_ADDR_OFFSET;
 		else if (ctrl & NAND_CLE)
 			bank_base += JZ_NAND_MEM_CMD_OFFSET;
-		chip->IO_ADDR_W = bank_base;
+		chip->legacy.IO_ADDR_W = bank_base;
 
 		reg = readl(nand->base + JZ_REG_NAND_CTRL);
 		if (ctrl & NAND_NCE)
@@ -124,7 +124,7 @@ static void jz_nand_cmd_ctrl(struct nand_chip *chip, int dat,
 		writel(reg, nand->base + JZ_REG_NAND_CTRL);
 	}
 	if (dat != NAND_CMD_NONE)
-		writeb(dat, chip->IO_ADDR_W);
+		writeb(dat, chip->legacy.IO_ADDR_W);
 }
 
 static int jz_nand_dev_ready(struct nand_chip *chip)
diff --git a/drivers/mtd/nand/raw/jz4780_nand.c b/drivers/mtd/nand/raw/jz4780_nand.c
index d54b2774f7f9..89909a17242d 100644
--- a/drivers/mtd/nand/raw/jz4780_nand.c
+++ b/drivers/mtd/nand/raw/jz4780_nand.c
@@ -275,8 +275,8 @@ static int jz4780_nand_init_chip(struct platform_device *pdev,
 		return -ENOMEM;
 	mtd->dev.parent = dev;
 
-	chip->IO_ADDR_R = cs->base + OFFSET_DATA;
-	chip->IO_ADDR_W = cs->base + OFFSET_DATA;
+	chip->legacy.IO_ADDR_R = cs->base + OFFSET_DATA;
+	chip->legacy.IO_ADDR_W = cs->base + OFFSET_DATA;
 	chip->chip_delay = RB_DELAY_US;
 	chip->options = NAND_NO_SUBPAGE_WRITE;
 	chip->select_chip = jz4780_nand_select_chip;
diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index ae31f6ccbeb3..cc1c6e6c59e1 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -742,8 +742,8 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	nand_chip->cmd_ctrl = lpc32xx_nand_cmd_ctrl;
 	nand_chip->dev_ready = lpc32xx_nand_device_ready;
 	nand_chip->chip_delay = 25; /* us */
-	nand_chip->IO_ADDR_R = MLC_DATA(host->io_base);
-	nand_chip->IO_ADDR_W = MLC_DATA(host->io_base);
+	nand_chip->legacy.IO_ADDR_R = MLC_DATA(host->io_base);
+	nand_chip->legacy.IO_ADDR_W = MLC_DATA(host->io_base);
 
 	/* Init NAND controller */
 	lpc32xx_nand_setup(host);
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 26d27a81f814..8a6f109c43af 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -878,8 +878,8 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 		goto enable_wp;
 
 	/* Set NAND IO addresses and command/ready functions */
-	chip->IO_ADDR_R = SLC_DATA(host->io_base);
-	chip->IO_ADDR_W = SLC_DATA(host->io_base);
+	chip->legacy.IO_ADDR_R = SLC_DATA(host->io_base);
+	chip->legacy.IO_ADDR_W = SLC_DATA(host->io_base);
 	chip->cmd_ctrl = lpc32xx_nand_cmd_ctrl;
 	chip->dev_ready = lpc32xx_nand_device_ready;
 	chip->chip_delay = 20; /* 20us command delay time */
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index e63dfad8235b..1edaa9fdbce9 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -260,7 +260,7 @@ static void nand_release_device(struct mtd_info *mtd)
  */
 static uint8_t nand_read_byte(struct nand_chip *chip)
 {
-	return readb(chip->IO_ADDR_R);
+	return readb(chip->legacy.IO_ADDR_R);
 }
 
 /**
@@ -272,7 +272,7 @@ static uint8_t nand_read_byte(struct nand_chip *chip)
  */
 static uint8_t nand_read_byte16(struct nand_chip *chip)
 {
-	return (uint8_t) cpu_to_le16(readw(chip->IO_ADDR_R));
+	return (uint8_t) cpu_to_le16(readw(chip->legacy.IO_ADDR_R));
 }
 
 /**
@@ -348,7 +348,7 @@ static void nand_write_byte16(struct nand_chip *chip, uint8_t byte)
  */
 static void nand_write_buf(struct nand_chip *chip, const uint8_t *buf, int len)
 {
-	iowrite8_rep(chip->IO_ADDR_W, buf, len);
+	iowrite8_rep(chip->legacy.IO_ADDR_W, buf, len);
 }
 
 /**
@@ -361,7 +361,7 @@ static void nand_write_buf(struct nand_chip *chip, const uint8_t *buf, int len)
  */
 static void nand_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 {
-	ioread8_rep(chip->IO_ADDR_R, buf, len);
+	ioread8_rep(chip->legacy.IO_ADDR_R, buf, len);
 }
 
 /**
@@ -377,7 +377,7 @@ static void nand_write_buf16(struct nand_chip *chip, const uint8_t *buf,
 {
 	u16 *p = (u16 *) buf;
 
-	iowrite16_rep(chip->IO_ADDR_W, p, len >> 1);
+	iowrite16_rep(chip->legacy.IO_ADDR_W, p, len >> 1);
 }
 
 /**
@@ -392,7 +392,7 @@ static void nand_read_buf16(struct nand_chip *chip, uint8_t *buf, int len)
 {
 	u16 *p = (u16 *) buf;
 
-	ioread16_rep(chip->IO_ADDR_R, p, len >> 1);
+	ioread16_rep(chip->legacy.IO_ADDR_R, p, len >> 1);
 }
 
 /**
diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
index b96070a3afff..adc4060c65ad 100644
--- a/drivers/mtd/nand/raw/ndfc.c
+++ b/drivers/mtd/nand/raw/ndfc.c
@@ -142,8 +142,8 @@ static int ndfc_chip_init(struct ndfc_controller *ndfc,
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
 
-	chip->IO_ADDR_R = ndfc->ndfcbase + NDFC_DATA;
-	chip->IO_ADDR_W = ndfc->ndfcbase + NDFC_DATA;
+	chip->legacy.IO_ADDR_R = ndfc->ndfcbase + NDFC_DATA;
+	chip->legacy.IO_ADDR_W = ndfc->ndfcbase + NDFC_DATA;
 	chip->cmd_ctrl = ndfc_hwcontrol;
 	chip->dev_ready = ndfc_ready;
 	chip->select_chip = ndfc_select_chip;
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index 6f0fec3596cc..627048886c95 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -275,7 +275,7 @@ static void omap_read_buf8(struct mtd_info *mtd, u_char *buf, int len)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
 
-	ioread8_rep(nand->IO_ADDR_R, buf, len);
+	ioread8_rep(nand->legacy.IO_ADDR_R, buf, len);
 }
 
 /**
@@ -291,7 +291,7 @@ static void omap_write_buf8(struct mtd_info *mtd, const u_char *buf, int len)
 	bool status;
 
 	while (len--) {
-		iowrite8(*p++, info->nand.IO_ADDR_W);
+		iowrite8(*p++, info->nand.legacy.IO_ADDR_W);
 		/* wait until buffer is available for write */
 		do {
 			status = info->ops->nand_writebuffer_empty();
@@ -309,7 +309,7 @@ static void omap_read_buf16(struct mtd_info *mtd, u_char *buf, int len)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
 
-	ioread16_rep(nand->IO_ADDR_R, buf, len / 2);
+	ioread16_rep(nand->legacy.IO_ADDR_R, buf, len / 2);
 }
 
 /**
@@ -327,7 +327,7 @@ static void omap_write_buf16(struct mtd_info *mtd, const u_char * buf, int len)
 	len >>= 1;
 
 	while (len--) {
-		iowrite16(*p++, info->nand.IO_ADDR_W);
+		iowrite16(*p++, info->nand.legacy.IO_ADDR_W);
 		/* wait until buffer is available for write */
 		do {
 			status = info->ops->nand_writebuffer_empty();
@@ -373,7 +373,7 @@ static void omap_read_buf_pref(struct nand_chip *chip, u_char *buf, int len)
 			r_count = readl(info->reg.gpmc_prefetch_status);
 			r_count = PREFETCH_STATUS_FIFO_CNT(r_count);
 			r_count = r_count >> 2;
-			ioread32_rep(info->nand.IO_ADDR_R, p, r_count);
+			ioread32_rep(info->nand.legacy.IO_ADDR_R, p, r_count);
 			p += r_count;
 			len -= r_count << 2;
 		} while (len);
@@ -401,7 +401,7 @@ static void omap_write_buf_pref(struct nand_chip *chip, const u_char *buf,
 
 	/* take care of subpage writes */
 	if (len % 2 != 0) {
-		writeb(*buf, info->nand.IO_ADDR_W);
+		writeb(*buf, info->nand.legacy.IO_ADDR_W);
 		p = (u16 *)(buf + 1);
 		len--;
 	}
@@ -421,7 +421,7 @@ static void omap_write_buf_pref(struct nand_chip *chip, const u_char *buf,
 			w_count = PREFETCH_STATUS_FIFO_CNT(w_count);
 			w_count = w_count >> 1;
 			for (i = 0; (i < w_count) && len; i++, len -= 2)
-				iowrite16(*p++, info->nand.IO_ADDR_W);
+				iowrite16(*p++, info->nand.legacy.IO_ADDR_W);
 		}
 		/* wait for data to flushed-out before reset the prefetch */
 		tim = 0;
@@ -585,14 +585,14 @@ static irqreturn_t omap_nand_irq(int this_irq, void *dev)
 			bytes = info->buf_len;
 		else if (!info->buf_len)
 			bytes = 0;
-		iowrite32_rep(info->nand.IO_ADDR_W,
-						(u32 *)info->buf, bytes >> 2);
+		iowrite32_rep(info->nand.legacy.IO_ADDR_W, (u32 *)info->buf,
+			      bytes >> 2);
 		info->buf = info->buf + bytes;
 		info->buf_len -= bytes;
 
 	} else {
-		ioread32_rep(info->nand.IO_ADDR_R,
-						(u32 *)info->buf, bytes >> 2);
+		ioread32_rep(info->nand.legacy.IO_ADDR_R, (u32 *)info->buf,
+			     bytes >> 2);
 		info->buf = info->buf + bytes;
 
 		if (this_irq == info->gpmc_irq_count)
@@ -2221,15 +2221,15 @@ static int omap_nand_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	nand_chip->IO_ADDR_R = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(nand_chip->IO_ADDR_R))
-		return PTR_ERR(nand_chip->IO_ADDR_R);
+	nand_chip->legacy.IO_ADDR_R = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(nand_chip->legacy.IO_ADDR_R))
+		return PTR_ERR(nand_chip->legacy.IO_ADDR_R);
 
 	info->phys_base = res->start;
 
 	nand_chip->controller = &omap_gpmc_controller;
 
-	nand_chip->IO_ADDR_W = nand_chip->IO_ADDR_R;
+	nand_chip->legacy.IO_ADDR_W = nand_chip->legacy.IO_ADDR_R;
 	nand_chip->cmd_ctrl  = omap_hwcontrol;
 
 	info->ready_gpiod = devm_gpiod_get_optional(&pdev->dev, "rb",
diff --git a/drivers/mtd/nand/raw/orion_nand.c b/drivers/mtd/nand/raw/orion_nand.c
index 92d8f249ee97..d73e3c7a3f3a 100644
--- a/drivers/mtd/nand/raw/orion_nand.c
+++ b/drivers/mtd/nand/raw/orion_nand.c
@@ -45,12 +45,12 @@ static void orion_nand_cmd_ctrl(struct nand_chip *nc, int cmd,
 	if (nc->options & NAND_BUSWIDTH_16)
 		offs <<= 1;
 
-	writeb(cmd, nc->IO_ADDR_W + offs);
+	writeb(cmd, nc->legacy.IO_ADDR_W + offs);
 }
 
 static void orion_nand_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 {
-	void __iomem *io_base = chip->IO_ADDR_R;
+	void __iomem *io_base = chip->legacy.IO_ADDR_R;
 #if defined(__LINUX_ARM_ARCH__) && __LINUX_ARM_ARCH__ >= 5
 	uint64_t *buf64;
 #endif
@@ -136,7 +136,7 @@ static int __init orion_nand_probe(struct platform_device *pdev)
 
 	nand_set_controller_data(nc, board);
 	nand_set_flash_node(nc, pdev->dev.of_node);
-	nc->IO_ADDR_R = nc->IO_ADDR_W = io_base;
+	nc->legacy.IO_ADDR_R = nc->legacy.IO_ADDR_W = io_base;
 	nc->cmd_ctrl = orion_nand_cmd_ctrl;
 	nc->read_buf = orion_nand_read_buf;
 	nc->ecc.mode = NAND_ECC_SOFT;
diff --git a/drivers/mtd/nand/raw/pasemi_nand.c b/drivers/mtd/nand/raw/pasemi_nand.c
index a1e3bf7a276b..1b367bf9ef53 100644
--- a/drivers/mtd/nand/raw/pasemi_nand.c
+++ b/drivers/mtd/nand/raw/pasemi_nand.c
@@ -46,22 +46,22 @@ static const char driver_name[] = "pasemi-nand";
 static void pasemi_read_buf(struct nand_chip *chip, u_char *buf, int len)
 {
 	while (len > 0x800) {
-		memcpy_fromio(buf, chip->IO_ADDR_R, 0x800);
+		memcpy_fromio(buf, chip->legacy.IO_ADDR_R, 0x800);
 		buf += 0x800;
 		len -= 0x800;
 	}
-	memcpy_fromio(buf, chip->IO_ADDR_R, len);
+	memcpy_fromio(buf, chip->legacy.IO_ADDR_R, len);
 }
 
 static void pasemi_write_buf(struct nand_chip *chip, const u_char *buf,
 			     int len)
 {
 	while (len > 0x800) {
-		memcpy_toio(chip->IO_ADDR_R, buf, 0x800);
+		memcpy_toio(chip->legacy.IO_ADDR_R, buf, 0x800);
 		buf += 0x800;
 		len -= 0x800;
 	}
-	memcpy_toio(chip->IO_ADDR_R, buf, len);
+	memcpy_toio(chip->legacy.IO_ADDR_R, buf, len);
 }
 
 static void pasemi_hwcontrol(struct nand_chip *chip, int cmd,
@@ -71,9 +71,9 @@ static void pasemi_hwcontrol(struct nand_chip *chip, int cmd,
 		return;
 
 	if (ctrl & NAND_CLE)
-		out_8(chip->IO_ADDR_W + (1 << CLE_PIN_CTL), cmd);
+		out_8(chip->legacy.IO_ADDR_W + (1 << CLE_PIN_CTL), cmd);
 	else
-		out_8(chip->IO_ADDR_W + (1 << ALE_PIN_CTL), cmd);
+		out_8(chip->legacy.IO_ADDR_W + (1 << ALE_PIN_CTL), cmd);
 
 	/* Push out posted writes */
 	eieio();
@@ -117,10 +117,10 @@ static int pasemi_nand_probe(struct platform_device *ofdev)
 	/* Link the private data with the MTD structure */
 	pasemi_nand_mtd->dev.parent = dev;
 
-	chip->IO_ADDR_R = of_iomap(np, 0);
-	chip->IO_ADDR_W = chip->IO_ADDR_R;
+	chip->legacy.IO_ADDR_R = of_iomap(np, 0);
+	chip->legacy.IO_ADDR_W = chip->legacy.IO_ADDR_R;
 
-	if (!chip->IO_ADDR_R) {
+	if (!chip->legacy.IO_ADDR_R) {
 		err = -EIO;
 		goto out_mtd;
 	}
@@ -169,7 +169,7 @@ static int pasemi_nand_probe(struct platform_device *ofdev)
  out_lpc:
 	release_region(lpcctl, 4);
  out_ior:
-	iounmap(chip->IO_ADDR_R);
+	iounmap(chip->legacy.IO_ADDR_R);
  out_mtd:
 	kfree(chip);
  out:
@@ -190,7 +190,7 @@ static int pasemi_nand_remove(struct platform_device *ofdev)
 
 	release_region(lpcctl, 4);
 
-	iounmap(chip->IO_ADDR_R);
+	iounmap(chip->legacy.IO_ADDR_R);
 
 	/* Free the MTD device structure */
 	kfree(chip);
diff --git a/drivers/mtd/nand/raw/plat_nand.c b/drivers/mtd/nand/raw/plat_nand.c
index d65e4084dea4..c06347531d26 100644
--- a/drivers/mtd/nand/raw/plat_nand.c
+++ b/drivers/mtd/nand/raw/plat_nand.c
@@ -60,8 +60,8 @@ static int plat_nand_probe(struct platform_device *pdev)
 	mtd = nand_to_mtd(&data->chip);
 	mtd->dev.parent = &pdev->dev;
 
-	data->chip.IO_ADDR_R = data->io_base;
-	data->chip.IO_ADDR_W = data->io_base;
+	data->chip.legacy.IO_ADDR_R = data->io_base;
+	data->chip.legacy.IO_ADDR_W = data->io_base;
 	data->chip.cmd_ctrl = pdata->ctrl.cmd_ctrl;
 	data->chip.dev_ready = pdata->ctrl.dev_ready;
 	data->chip.select_chip = pdata->ctrl.select_chip;
diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index 1f70eb35320b..473abf10eeec 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -681,7 +681,7 @@ static int s3c2440_nand_calculate_ecc(struct nand_chip *chip,
 
 static void s3c2410_nand_read_buf(struct nand_chip *this, u_char *buf, int len)
 {
-	readsb(this->IO_ADDR_R, buf, len);
+	readsb(this->legacy.IO_ADDR_R, buf, len);
 }
 
 static void s3c2440_nand_read_buf(struct nand_chip *this, u_char *buf, int len)
@@ -703,7 +703,7 @@ static void s3c2440_nand_read_buf(struct nand_chip *this, u_char *buf, int len)
 static void s3c2410_nand_write_buf(struct nand_chip *this, const u_char *buf,
 				   int len)
 {
-	writesb(this->IO_ADDR_W, buf, len);
+	writesb(this->legacy.IO_ADDR_W, buf, len);
 }
 
 static void s3c2440_nand_write_buf(struct nand_chip *this, const u_char *buf,
@@ -881,7 +881,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 
 	switch (info->cpu_type) {
 	case TYPE_S3C2410:
-		chip->IO_ADDR_W = regs + S3C2410_NFDATA;
+		chip->legacy.IO_ADDR_W = regs + S3C2410_NFDATA;
 		info->sel_reg   = regs + S3C2410_NFCONF;
 		info->sel_bit	= S3C2410_NFCONF_nFCE;
 		chip->cmd_ctrl  = s3c2410_nand_hwcontrol;
@@ -889,7 +889,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 		break;
 
 	case TYPE_S3C2440:
-		chip->IO_ADDR_W = regs + S3C2440_NFDATA;
+		chip->legacy.IO_ADDR_W = regs + S3C2440_NFDATA;
 		info->sel_reg   = regs + S3C2440_NFCONT;
 		info->sel_bit	= S3C2440_NFCONT_nFCE;
 		chip->cmd_ctrl  = s3c2440_nand_hwcontrol;
@@ -899,7 +899,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 		break;
 
 	case TYPE_S3C2412:
-		chip->IO_ADDR_W = regs + S3C2440_NFDATA;
+		chip->legacy.IO_ADDR_W = regs + S3C2440_NFDATA;
 		info->sel_reg   = regs + S3C2440_NFCONT;
 		info->sel_bit	= S3C2412_NFCONT_nFCE0;
 		chip->cmd_ctrl  = s3c2440_nand_hwcontrol;
@@ -911,7 +911,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 		break;
 	}
 
-	chip->IO_ADDR_R = chip->IO_ADDR_W;
+	chip->legacy.IO_ADDR_R = chip->legacy.IO_ADDR_W;
 
 	nmtd->info	   = info;
 	nmtd->set	   = set;
diff --git a/drivers/mtd/nand/raw/sharpsl.c b/drivers/mtd/nand/raw/sharpsl.c
index 31abbe33798e..d9cdd11fbd3a 100644
--- a/drivers/mtd/nand/raw/sharpsl.c
+++ b/drivers/mtd/nand/raw/sharpsl.c
@@ -75,7 +75,7 @@ static void sharpsl_nand_hwcontrol(struct nand_chip *chip, int cmd,
 	}
 
 	if (cmd != NAND_CMD_NONE)
-		writeb(cmd, chip->IO_ADDR_W);
+		writeb(cmd, chip->legacy.IO_ADDR_W);
 }
 
 static int sharpsl_nand_dev_ready(struct nand_chip *chip)
@@ -153,8 +153,8 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	writeb(readb(sharpsl->io + FLASHCTL) | FLWP, sharpsl->io + FLASHCTL);
 
 	/* Set address of NAND IO lines */
-	this->IO_ADDR_R = sharpsl->io + FLASHIO;
-	this->IO_ADDR_W = sharpsl->io + FLASHIO;
+	this->legacy.IO_ADDR_R = sharpsl->io + FLASHIO;
+	this->legacy.IO_ADDR_W = sharpsl->io + FLASHIO;
 	/* Set address of hardware control function */
 	this->cmd_ctrl = sharpsl_nand_hwcontrol;
 	this->dev_ready = sharpsl_nand_dev_ready;
diff --git a/drivers/mtd/nand/raw/tmio_nand.c b/drivers/mtd/nand/raw/tmio_nand.c
index f44621672779..0b23587bf47c 100644
--- a/drivers/mtd/nand/raw/tmio_nand.c
+++ b/drivers/mtd/nand/raw/tmio_nand.c
@@ -155,7 +155,7 @@ static void tmio_nand_hwcontrol(struct nand_chip *chip, int cmd,
 	}
 
 	if (cmd != NAND_CMD_NONE)
-		tmio_iowrite8(cmd, chip->IO_ADDR_W);
+		tmio_iowrite8(cmd, chip->legacy.IO_ADDR_W);
 }
 
 static int tmio_nand_dev_ready(struct nand_chip *chip)
@@ -399,8 +399,8 @@ static int tmio_probe(struct platform_device *dev)
 		return retval;
 
 	/* Set address of NAND IO lines */
-	nand_chip->IO_ADDR_R = tmio->fcr;
-	nand_chip->IO_ADDR_W = tmio->fcr;
+	nand_chip->legacy.IO_ADDR_R = tmio->fcr;
+	nand_chip->legacy.IO_ADDR_W = tmio->fcr;
 
 	/* Set address of hardware control function */
 	nand_chip->cmd_ctrl = tmio_nand_hwcontrol;
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index e3a96ee7e531..6b1dc8fef89d 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1172,13 +1172,27 @@ int nand_op_parser_exec_op(struct nand_chip *chip,
 			   const struct nand_op_parser *parser,
 			   const struct nand_operation *op, bool check_only);
 
+/**
+ * struct nand_legacy - NAND chip legacy fields/hooks
+ * @IO_ADDR_R: address to read the 8 I/O lines of the flash device
+ * @IO_ADDR_W: address to write the 8 I/O lines of the flash device
+ *
+ * If you look at this structure you're already wrong. These fields/hooks are
+ * all deprecated.
+ */
+struct nand_legacy {
+	void __iomem *IO_ADDR_R;
+	void __iomem *IO_ADDR_W;
+};
+
 /**
  * struct nand_chip - NAND Private Flash Chip Data
  * @mtd:		MTD device registered to the MTD framework
- * @IO_ADDR_R:		[BOARDSPECIFIC] address to read the 8 I/O lines of the
- *			flash device
- * @IO_ADDR_W:		[BOARDSPECIFIC] address to write the 8 I/O lines of the
- *			flash device.
+ * @legacy:		All legacy fields/hooks. If you develop a new driver,
+ *			don't even try to use any of these fields/hooks, and if
+ *			you're modifying an existing driver that is using those
+ *			fields/hooks, you should consider reworking the driver
+ *			avoid using them.
  * @read_byte:		[REPLACEABLE] read one byte from the chip
  * @write_byte:		[REPLACEABLE] write a single byte to the chip on the
  *			low 8 I/O lines
@@ -1280,8 +1294,8 @@ int nand_op_parser_exec_op(struct nand_chip *chip,
 
 struct nand_chip {
 	struct mtd_info mtd;
-	void __iomem *IO_ADDR_R;
-	void __iomem *IO_ADDR_W;
+
+	struct nand_legacy legacy;
 
 	uint8_t (*read_byte)(struct nand_chip *chip);
 	void (*write_byte)(struct nand_chip *chip, uint8_t byte);
-- 
2.14.1

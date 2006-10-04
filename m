From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: Pending September patches
Date: Wed, 4 Oct 2006 20:22:51 +0200
Message-ID: <20061004182251.GA3845@orphique>
References: <4523B6F8.3020800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <4523B6F8.3020800@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 04, 2006 at 03:28:24PM +0200, Dirk Behme wrote:
> Hi,
> 
> my list of pending OMAP patches for September 2006:
> 
> 1. [PATCH] MTD patch, including the latest modifications an
> offical upgrades for MTD
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-September/007889.html
> 
> Note: Is this still necessary or does 2.6.18 contain it
> automatically?

2.6.18 is quite well synced with MTD tree. What is missing is out driver
modification... Please consider.

[PATCH] Make omap-nand-flash driver work after MTD update

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

diff --git a/drivers/mtd/nand/omap-nand-flash.c b/drivers/mtd/nand/omap-nand-flash.c
index 35a3408..a231e18 100644
--- a/drivers/mtd/nand/omap-nand-flash.c
+++ b/drivers/mtd/nand/omap-nand-flash.c
@@ -11,6 +11,7 @@
 
 #include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -44,21 +45,25 @@ struct omap_nand_info {
 /*
  *	hardware specific access to control-lines
  *	NOTE:  boards may use different bits for these!!
+ *
+ *	ctrl:
+ *	NAND_NCE: bit 0 - don't care
+ *	NAND_CLE: bit 1 -> bit 1  (0x0002)
+ *	NAND_ALE: bit 2 -> bit 2  (0x0004)
  */
-#define	MASK_CLE	0x02
-#define	MASK_ALE	0x04
-static void omap_nand_hwcontrol(struct mtd_info *mtd, int cmd)
+
+static void omap_nand_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
-	struct nand_chip *this = mtd->priv;
-	unsigned long IO_ADDR_W = (unsigned long) this->IO_ADDR_W;
-
-	switch (cmd) {
-		case NAND_CTL_SETCLE: IO_ADDR_W |= MASK_CLE; break;
-		case NAND_CTL_CLRCLE: IO_ADDR_W &= ~MASK_CLE; break;
-		case NAND_CTL_SETALE: IO_ADDR_W |= MASK_ALE; break;
-		case NAND_CTL_CLRALE: IO_ADDR_W &= ~MASK_ALE; break;
-	}
-	this->IO_ADDR_W = (void __iomem *) IO_ADDR_W;
+	struct nand_chip *chip = mtd->priv;
+	unsigned long mask;
+
+	if (cmd == NAND_CMD_NONE)
+		return;
+
+	mask = (ctrl & NAND_CLE) ? 0x02 : 0;
+	if (ctrl & NAND_ALE)
+		mask |= 0x04;
+	writeb(cmd, (unsigned long)chip->IO_ADDR_W | mask);
 }
 
 static int omap_nand_dev_ready(struct mtd_info *mtd)
@@ -76,12 +81,10 @@ static int __devinit omap_nand_probe(str
 	unsigned long			size = res->end - res->start + 1;
 	int				err;
 
-	info = kmalloc(sizeof(struct omap_nand_info), GFP_KERNEL);
+	info = kzalloc(sizeof(struct omap_nand_info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
-	memset(info, 0, sizeof(struct omap_nand_info));
-
 	if (!request_mem_region(res->start, size, pdev->dev.driver->name)) {
 		err = -EBUSY;
 		goto out_free_info;
@@ -93,8 +96,8 @@ static int __devinit omap_nand_probe(str
 		goto out_release_mem_region;
 	}
 	info->nand.IO_ADDR_W = info->nand.IO_ADDR_R;
-	info->nand.hwcontrol = omap_nand_hwcontrol;
-	info->nand.eccmode = NAND_ECC_SOFT;
+	info->nand.cmd_ctrl = omap_nand_hwcontrol;
+	info->nand.ecc.mode = NAND_ECC_SOFT;
 	info->nand.options = pdata->options;
 	if (pdata->dev_ready)
 		info->nand.dev_ready = omap_nand_dev_ready;

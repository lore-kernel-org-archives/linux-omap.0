From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Subject: Re: [PATCH] Move N800 specific OneNand setup to N800 platform file,
	was: Basic N800 support
Date: Fri, 9 Mar 2007 21:29:02 +0200
Message-ID: <20070309192902.GA12786@angel.research.nokia.com>
References: <13020905.97851169452503947.JavaMail.weblogic@ep_ml23>
	<20070122171254.GD7382@atomide.com>
	<20070206213648.GH9311@atomide.com>
	<000101c74a77$39e94120$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070301134533.GA15801@angel.research.nokia.com>
	<00a901c75c64$01b1e830$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070302164855.GA313@angel.research.nokia.com>
	<45EA99D0.8010103@googlemail.com>
	<20070307115754.GH21093@atomide.com>
	<004201c7611f$bae52b90$c7a3580a@swcenter.sec.samsung.co.kr>
Reply-To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <004201c7611f$bae52b90$c7a3580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kyungmin

Thank you for your comments and irq handler fix. 

> If this patch is applied, we have to add all platform files to add
> onenand_readw, onenand_writew.

We could pass the needed methods to the setup. This would also allow 
to add more fields if new omap2 devices with more complex setups are
needed.

> Umm, there's omap tree dependency. omap2_block_sleep() & omap2_allow_sleep().
> ...
> Just remove it or define dummy macro?

The log message in our internal tree says the sleep prevention was added
to maximise speed when reading from bufferram. 

I vote for dummy macro, which can then presumably be overdriven by a custom 
definion from some device specific header.

Regards
Jarkko Lavinen

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-Fix-request_irq-compile-error-and-pass-readw-and-writew-methods-to-platform-setup.txt"

>From a6200a8f8f029193cce157a3efe90809104c353f Mon Sep 17 00:00:00 2001
From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Date: Fri, 9 Mar 2007 20:56:39 +0200
Subject: [PATCH] Fix request_irq compile error and pass readw, and writew methods to platform setup.
Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
---
 arch/arm/mach-omap2/board-n800-flash.c |   27 +++++++++++----------------
 drivers/mtd/onenand/omap2.c            |    6 +++++-
 include/asm-arm/arch-omap/onenand.h    |    8 +++++++-
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800-flash.c b/arch/arm/mach-omap2/board-n800-flash.c
index 4005cfb..08678dc 100644
--- a/arch/arm/mach-omap2/board-n800-flash.c
+++ b/arch/arm/mach-omap2/board-n800-flash.c
@@ -21,7 +21,7 @@
 
 static struct mtd_partition n800_partitions[8];
 
-static int n800_onenand_setup(void __iomem *);
+static int n800_onenand_setup(struct omap_onenand_setup_data *sdata);
 
 static struct omap_onenand_platform_data n800_onenand_data = {
 	.cs = 0,
@@ -39,17 +39,7 @@ static struct platform_device n800_onenand_device = {
 	},
 };
 
-static unsigned short omap2_onenand_readw(void __iomem *addr)
-{
-	return readw(addr);
-}
-
-static void omap2_onenand_writew(unsigned short value, void __iomem *addr)
-{
-	writew(value, addr);
-}
-
-static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base)
+static int omap2_onenand_set_sync_mode(int cs, struct omap_onenand_setup_data *sdata)
 {
 	const int min_gpmc_clk_period = 18;
 	struct gpmc_timings t;
@@ -65,12 +55,12 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base)
 		latency = 4;
 
 	/* Configure OneNAND for sync read */
-	reg = omap2_onenand_readw(onenand_base + ONENAND_REG_SYS_CFG1);
+	reg = (sdata->readw)(sdata->iobase + ONENAND_REG_SYS_CFG1);
 	reg &= ~((0x7 << ONENAND_SYS_CFG1_BRL_SHIFT) | (0x7 << 9));
 	reg |=	(latency << ONENAND_SYS_CFG1_BRL_SHIFT) |
 		ONENAND_SYS_CFG1_SYNC_READ |
 		ONENAND_SYS_CFG1_BL_16;
-	omap2_onenand_writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
+	(sdata->writew)(reg, sdata->iobase + ONENAND_REG_SYS_CFG1);
 
 	/* FIXME: Get timings from platform data */
 	/* Set syncronous read timings */
@@ -114,13 +104,18 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base)
 	return gpmc_cs_set_timings(cs, &t);
 }
 
-static int n800_onenand_setup(void __iomem *onenand_base)
+static int n800_onenand_setup(struct omap_onenand_setup_data *sdata)
 {
 	struct omap_onenand_platform_data *datap = &n800_onenand_data;
 	struct device *dev = &n800_onenand_device.dev;
 
+	if (sdata == NULL) {
+		dev_err(dev, "setup data is a NULL pointer\n");
+		return -EINVAL;
+	}
+
 	/* Set sync timings in GPMC */
-	if (omap2_onenand_set_sync_mode(datap->cs, onenand_base) < 0) {
+	if (omap2_onenand_set_sync_mode(datap->cs, sdata) < 0) {
 		dev_err(dev, "Unable to set synchronous mode\n");
 		return -EINVAL;
 	}
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 96fcb5f..fb1c15c 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -337,7 +337,11 @@ static int __devinit omap2_onenand_probe(struct platform_device *pdev)
 	}
 
 	if (pdata->onenand_setup != NULL) {
-		r = pdata->onenand_setup(info->onenand.base);
+		struct omap_onenand_setup_data data;
+		data.iobase = info->onenand.base;
+		data.readw  = omap2_onenand_readw;
+		data.writew = omap2_onenand_writew;
+		r = pdata->onenand_setup(&data);
 		if (r < 0) {
 			dev_err(&pdev->dev, "Onenand platform setup failed: %d\n", r);
 			goto err_iounmap;                       
diff --git a/include/asm-arm/arch-omap/onenand.h b/include/asm-arm/arch-omap/onenand.h
index 3e8ab2f..a7670af 100644
--- a/include/asm-arm/arch-omap/onenand.h
+++ b/include/asm-arm/arch-omap/onenand.h
@@ -11,10 +11,16 @@
 
 #include <linux/mtd/partitions.h>
 
+struct omap_onenand_setup_data {
+	void __iomem            *iobase;
+	unsigned short          (*readw)(void __iomem *);
+	void                    (*writew)(unsigned short, void __iomem *);
+};
+
 struct omap_onenand_platform_data {
 	int			cs;
 	int			gpio_irq;
 	struct mtd_partition	*parts;
 	int			nr_parts;
-	int                     (*onenand_setup)(void __iomem *);
+	int                     (*onenand_setup)(struct omap_onenand_setup_data *);
 };
-- 
1.4.4.4


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--lrZ03NoBR/3+SXJZ--

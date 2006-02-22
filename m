From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] OMAP2 MCSPI Use resources
Date: Wed, 22 Feb 2006 05:50:04 -0800 (PST)
Message-ID: <20060222135004.56372.qmail@web32913.mail.mud.yahoo.com>
References: <20060222123642.4032.qmail@web32907.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-935711719-1140616204=:55834"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060222123642.4032.qmail@web32907.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--0-935711719-1140616204=:55834
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

--- Komal Shah <komal_shah802003@yahoo.com> wrote:

> Juha,
> 
> Attached patch uses the resources instead of passing base address
> from
> pdata, also removed MASTER_CDATA macro and uses
> spi_get_master_drvdata
> api instead. 
> 
> I am able to build the tree, but not able to test it as I don't have
> TSC2101 protocol driver ready. So, if you can test it with your
> protocol drivers then let me know.
> 

Also let me know why you are exporting omap2_mcspi_driver and instead
of class_device_put we can use spi_master_put and spi_master_get
instead of class_device_get. If you confirm this third patch will
in-corporate review comments from you :)

---

Attached the updated patch with clocks support.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-935711719-1140616204=:55834
Content-Type: text/x-patch; name="mcspi02.patch"
Content-Description: 4062830852-mcspi02.patch
Content-Disposition: inline; filename="mcspi02.patch"

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index def9e53..7028a04 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -115,6 +115,82 @@ static inline void omap_init_sti(void)
 static inline void omap_init_sti(void) {}
 #endif
 
+#if 	defined(CONFIG_SPI_OMAP24XX) || defined(CONFIG_SPI_OMAP24XX_MODULE)
+
+#include <asm/arch/mcspi.h>
+
+#define OMAP2_MCSPI_BASE1		IO_ADDRESS(0x48098000)
+#define OMAP2_MCSPI_INT1		65
+
+#define OMAP2_MCSPI_BASE2		IO_ADDRESS(0x4809A000)
+#define OMAP2_MCSPI_INT2		66
+
+static struct omap2_mcspi_platform_config omap2_mcspi1_config = {
+	.num_cs         = 4,
+};    
+
+static struct resource omap_mcspi_resources1[] = {
+	{
+		.start		= OMAP2_MCSPI_BASE1,
+		.end		= OMAP2_MCSPI_BASE1 + 0x3f,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP2_MCSPI_INT1,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device omap_mcspi_device1 = {
+	.name		= "omap2_mcspi",
+	.id		= 1,
+	.dev = {
+		.release	= omap_nop_release,
+		.platform_data  = &omap2_mcspi1_config,
+	},
+	.num_resources	= ARRAY_SIZE(omap_mcspi_resources1),
+	.resource	= omap_mcspi_resources1,
+};
+
+static struct omap2_mcspi_platform_config omap2_mcspi2_config = {
+	.num_cs         = 2,
+};    
+
+static struct resource omap_mcspi_resources2[] = {
+	{
+		.start		= OMAP2_MCSPI_BASE2,
+		.end		= OMAP2_MCSPI_BASE2 + 0x3f,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP2_MCSPI_INT2,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device omap_mcspi_device2 = {
+	.name		= "omap2_mcspi",
+	.id		= 2,
+	.dev = {
+		.release	= omap_nop_release,
+		.platform_data  = &omap2_mcspi2_config,
+	},
+	.num_resources	= ARRAY_SIZE(omap_mcspi_resources2),
+	.resource	= omap_mcspi_resources2,
+};
+
+static void omap_init_mcspi(void)
+{
+	(void) platform_device_register(&omap_mcspi_device1);
+	(void) platform_device_register(&omap_mcspi_device2);
+}
+
+#else
+
+static void omap_init_mcspi(void) {}
+
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 static int __init omap2_init_devices(void)
@@ -123,6 +199,7 @@ static int __init omap2_init_devices(voi
 	 * in alphabetical order so they're easier to sort through.
 	 */
 	omap_init_i2c();
+	omap_init_mcspi();
 	omap_init_sti();
 
 	return 0;
diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 5042fc8..08f3422 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -28,6 +28,8 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/clk.h>
 
 #include <linux/spi/spi.h>
 
@@ -84,6 +86,9 @@ struct omap2_mcspi {
 	spinlock_t		lock;
 	struct list_head	msg_queue;
 	struct spi_master	*master;
+	unsigned long		base;
+	struct	clk		*iclk;		/* Interface clock */
+	struct	clk		*fclk;		/* Functional clock */
 };
 
 struct omap2_mcspi_cs {
@@ -98,38 +103,36 @@ struct omap2_mcspi_cs {
 } while(0)
 
 
-#define MASTER_PDATA(master) (struct omap2_mcspi_platform_config *)((master)->cdev.dev->platform_data)
-
-static inline void mcspi_write_reg(const struct spi_master *master,
+static inline void mcspi_write_reg(const struct spi_device *spi,
 				   int idx, u32 val)
 {
-	struct omap2_mcspi_platform_config *pdata = MASTER_PDATA(master);
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(spi->master);
 
-	__raw_writel(val, pdata->base + idx);
+	__raw_writel(val, mcspi->base + idx);
 }
 
-static inline u32 mcspi_read_reg(const struct spi_master *master,
+static inline u32 mcspi_read_reg(const struct spi_device *spi,
 				 int idx)
 {
-	struct omap2_mcspi_platform_config *pdata = MASTER_PDATA(master);
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(spi->master);
 
-	return __raw_readl(pdata->base + idx);
+	return __raw_readl(mcspi->base + idx);
 }
 
 static inline void mcspi_write_cs_reg(const struct spi_device *spi,
 				      int idx, u32 val)
 {
-	struct omap2_mcspi_platform_config *pdata = MASTER_PDATA(spi->master);
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(spi->master);
 
-	__raw_writel(val, pdata->base + spi->chip_select * 0x14 + idx);
+	__raw_writel(val, mcspi->base + spi->chip_select * 0x14 + idx);
 }
 
 static inline u32 mcspi_read_cs_reg(const struct spi_device *spi,
 				    int idx)
 {
-	struct omap2_mcspi_platform_config *pdata = MASTER_PDATA(spi->master);
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(spi->master);
 
-	return __raw_readl(pdata->base + spi->chip_select * 0x14 + idx);
+	return __raw_readl(mcspi->base + spi->chip_select * 0x14 + idx);
 }
 
 static void omap2_mcspi_set_enable(const struct spi_device *spi, int enable)
@@ -155,11 +158,11 @@ static void omap2_mcspi_set_master_mode(
 	u32 l;
 
 	/* Need reset when switching from slave mode */
-	l = mcspi_read_reg(spi->master, OMAP2_MCSPI_MODULCTRL);
+	l = mcspi_read_reg(spi, OMAP2_MCSPI_MODULCTRL);
 	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_STEST, 0);
 	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_MS, 0);
 	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_SINGLE, single_channel);
-	mcspi_write_reg(spi->master, OMAP2_MCSPI_MODULCTRL, l);
+	mcspi_write_reg(spi, OMAP2_MCSPI_MODULCTRL, l);
 }
 
 static void omap2_mcspi_txrx(struct spi_device *spi, struct spi_transfer *xfer)
@@ -167,6 +170,7 @@ static void omap2_mcspi_txrx(struct spi_
 	unsigned int		count, c;
 	u32                     l;
 	unsigned long		base, tx_reg, rx_reg, chstat_reg;
+	struct omap2_mcspi	*mcspi;
 
 	count = xfer->len;
 	c = count;
@@ -183,7 +187,8 @@ static void omap2_mcspi_txrx(struct spi_
 
 	/* We store the pre-calculated register addresses on stack to speed
 	 * up the transfer loop. */
-	base = (MASTER_PDATA(spi->master))->base + spi->chip_select * 0x14;
+	mcspi = spi_master_get_devdata(spi->master);
+	base = mcspi->base + spi->chip_select * 0x14;
 	tx_reg		= base + OMAP2_MCSPI_TX0;
 	rx_reg		= base + OMAP2_MCSPI_RX0;
 	chstat_reg	= base + OMAP2_MCSPI_CHSTAT0;
@@ -412,8 +417,45 @@ static int __devinit omap2_mcspi_reset(s
 #endif
 }
 
+static int omap2_mcspi_get_clocks(struct omap2_mcspi *mcspi, int bus)
+{
+	mcspi->iclk = clk_get(NULL,
+	     		bus == 1 ? "mcspi1_ick" : "mcspi2_ick");
+	if (IS_ERR(mcspi->iclk)) {
+		return -ENODEV;
+	}
+	
+	mcspi->fclk = clk_get(NULL,
+		     	bus == 1 ? "mcspi1_fck" : "mcspi2_fck");
+	if (IS_ERR(mcspi->fclk)) {
+		clk_put(mcspi->fclk);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void omap2_mcspi_put_clocks(struct omap2_mcspi *mcspi)
+{
+	clk_put(mcspi->fclk);
+	clk_put(mcspi->iclk);
+}
+
+static void omap2_mcspi_enable_clocks(struct omap2_mcspi *mcspi)
+{
+	clk_enable(mcspi->iclk);
+	clk_enable(mcspi->fclk);
+}
+
+static void omap2_mcspi_disable_clocks(struct omap2_mcspi *mcspi)
+{
+	clk_disable(mcspi->iclk);
+	clk_disable(mcspi->fclk);
+}
+
 static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
 {
+	struct resource			*mem;
 	struct spi_master		*master;
 	struct omap2_mcspi_platform_config *pdata = pdev->dev.platform_data;
 	struct omap2_mcspi		*mcspi;
@@ -436,16 +478,41 @@ static int __devinit omap2_mcspi_probe(s
 	master->cleanup = omap2_mcspi_cleanup;
 	master->num_chipselect = pdata->num_cs;
 
+	/* Setup register addresses */
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(&pdev->dev, "can not find platform io memory\n");
+		status = -ENODEV;
+		goto err0;
+	}
+	
+	status = (int) request_mem_region(mem->start,
+					 (mem->end - mem->start) + 1,
+					 pdev->name);
+	if (!status) {
+		dev_err(&pdev->dev, "SPI region already claimed\n");
+		status = -EBUSY;
+		goto err0;
+	}
+
 	if (class_device_get(&master->cdev) == NULL) {
 		dev_err(&pdev->dev, "no master->cdev");
 		status = -ENOMEM;
-		goto err0;
+		goto err1;
 	}
 
-	dev_set_drvdata(&pdev->dev, master);
+	platform_set_drvdata(pdev, master);
 
-	mcspi = class_get_devdata(&master->cdev);
+	mcspi = spi_master_get_devdata(master);
 	mcspi->master = master;
+	mcspi->base = mem->start;
+
+	if ((status = omap2_mcspi_get_clocks(mcspi, pdev->id)) != 0) {
+		dev_err(&pdev->dev, "Can't get spi%d clocks\n", pdev->id);
+		goto err2;
+	}
+
+	omap2_mcspi_enable_clocks(mcspi);
 
 	tasklet_init(&mcspi->tasklet, omap2_mcspi_work, (unsigned long) mcspi);
 
@@ -453,26 +520,38 @@ static int __devinit omap2_mcspi_probe(s
 	INIT_LIST_HEAD(&mcspi->msg_queue);
 
 	if (omap2_mcspi_reset(master) < 0)
-                goto err1;
+		goto err3;
 
 	status = spi_register_master(master);
 	if (status < 0)
-		goto err1;
+		goto err3;
 
 	return status;
 
- err1:
+ err3:
+	omap2_mcspi_disable_clocks(mcspi);
+	omap2_mcspi_put_clocks(mcspi);
+ err2:
 	class_device_put(&master->cdev);
+ err1:
+	release_mem_region(mem->start, (mem->end - mem->start) + 1);
  err0:
 	return status;
 }
 
 static int __devexit omap2_mcspi_remove(struct platform_device *pdev)
 {
+	struct resource 		*mem;
 	struct spi_master		*master;
-
-	master = dev_get_drvdata(&pdev->dev);
-
+	struct omap2_mcspi 		*mcspi;
+       	
+	master = platform_get_drvdata(pdev);
+	mcspi = spi_master_get_devdata(master);
+	
+	omap2_mcspi_disable_clocks(mcspi);
+	omap2_mcspi_put_clocks(mcspi);
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(mem->start, (mem->end - mem->start) + 1);
 	spi_unregister_master(master);
 
 	return 0;
@@ -488,10 +567,11 @@ struct platform_driver omap2_mcspi_drive
 };
 EXPORT_SYMBOL_GPL(omap2_mcspi_driver);
 
+static char __initdata banner[] = KERN_INFO "OMAP24xx McSPI driver initializing\n";
 
 static int __init omap2_mcspi_init(void)
 {
-	printk(KERN_INFO "OMAP24xx McSPI driver initializing\n");
+	printk(banner);
 	return platform_driver_register(&omap2_mcspi_driver);
 }
 subsys_initcall(omap2_mcspi_init);

--0-935711719-1140616204=:55834
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-935711719-1140616204=:55834--

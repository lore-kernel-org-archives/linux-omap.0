From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 205/493] gpio: remove use of __devinit
Date: Mon, 19 Nov 2012 13:22:34 -0500
Message-ID: <1353349642-3677-205-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41904 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651Ab2KSSnF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Nov 2012 13:43:05 -0500
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Peter Tyser <ptyser@xes-inc.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, device-drivers-devel@blackfin.uclinux.org, patches@opensource.wolfsonmicro.com, linux-omap@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Grant Likely <grant.likely@secretlab.ca> 
Cc: Linus Walleij <linus.walleij@linaro.org> 
Cc: Peter Tyser <ptyser@xes-inc.com> 
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com> 
Cc: Kevin Hilman <khilman@ti.com> 
Cc: device-drivers-devel@blackfin.uclinux.org 
Cc: patches@opensource.wolfsonmicro.com 
Cc: linux-omap@vger.kernel.org 
---
 drivers/gpio/gpio-74x164.c     | 2 +-
 drivers/gpio/gpio-ab8500.c     | 2 +-
 drivers/gpio/gpio-adnp.c       | 2 +-
 drivers/gpio/gpio-adp5520.c    | 2 +-
 drivers/gpio/gpio-adp5588.c    | 2 +-
 drivers/gpio/gpio-arizona.c    | 2 +-
 drivers/gpio/gpio-cs5535.c     | 2 +-
 drivers/gpio/gpio-da9052.c     | 2 +-
 drivers/gpio/gpio-da9055.c     | 2 +-
 drivers/gpio/gpio-em.c         | 2 +-
 drivers/gpio/gpio-ep93xx.c     | 2 +-
 drivers/gpio/gpio-generic.c    | 2 +-
 drivers/gpio/gpio-ich.c        | 6 +++---
 drivers/gpio/gpio-janz-ttl.c   | 6 +++---
 drivers/gpio/gpio-langwell.c   | 4 ++--
 drivers/gpio/gpio-lpc32xx.c    | 2 +-
 drivers/gpio/gpio-max7300.c    | 2 +-
 drivers/gpio/gpio-max7301.c    | 2 +-
 drivers/gpio/gpio-max730x.c    | 2 +-
 drivers/gpio/gpio-max732x.c    | 4 ++--
 drivers/gpio/gpio-mc33880.c    | 2 +-
 drivers/gpio/gpio-mcp23s08.c   | 2 +-
 drivers/gpio/gpio-ml-ioh.c     | 4 ++--
 drivers/gpio/gpio-mpc5200.c    | 4 ++--
 drivers/gpio/gpio-msic.c       | 2 +-
 drivers/gpio/gpio-msm-v2.c     | 2 +-
 drivers/gpio/gpio-mvebu.c      | 2 +-
 drivers/gpio/gpio-mxc.c        | 4 ++--
 drivers/gpio/gpio-mxs.c        | 2 +-
 drivers/gpio/gpio-omap.c       | 6 +++---
 drivers/gpio/gpio-pca953x.c    | 6 +++---
 drivers/gpio/gpio-pch.c        | 4 ++--
 drivers/gpio/gpio-pxa.c        | 6 +++---
 drivers/gpio/gpio-rc5t583.c    | 2 +-
 drivers/gpio/gpio-rdc321x.c    | 2 +-
 drivers/gpio/gpio-sch.c        | 2 +-
 drivers/gpio/gpio-sodaville.c  | 4 ++--
 drivers/gpio/gpio-sta2x11.c    | 4 ++--
 drivers/gpio/gpio-stmpe.c      | 4 ++--
 drivers/gpio/gpio-stp-xway.c   | 2 +-
 drivers/gpio/gpio-sx150x.c     | 2 +-
 drivers/gpio/gpio-tc3589x.c    | 2 +-
 drivers/gpio/gpio-tegra.c      | 2 +-
 drivers/gpio/gpio-timberdale.c | 2 +-
 drivers/gpio/gpio-tps6586x.c   | 2 +-
 drivers/gpio/gpio-tps65910.c   | 2 +-
 drivers/gpio/gpio-tps65912.c   | 2 +-
 drivers/gpio/gpio-twl4030.c    | 6 +++---
 drivers/gpio/gpio-twl6040.c    | 2 +-
 drivers/gpio/gpio-vr41xx.c     | 2 +-
 drivers/gpio/gpio-vt8500.c     | 2 +-
 drivers/gpio/gpio-vx855.c      | 2 +-
 drivers/gpio/gpio-wm831x.c     | 2 +-
 drivers/gpio/gpio-wm8350.c     | 2 +-
 drivers/gpio/gpio-wm8994.c     | 2 +-
 drivers/gpio/gpio-xilinx.c     | 2 +-
 56 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index ee1cb30..2e6df41 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -105,7 +105,7 @@ static int gen_74x164_direction_output(struct gpio_chip *gc,
 	return 0;
 }
 
-static int __devinit gen_74x164_probe(struct spi_device *spi)
+static int gen_74x164_probe(struct spi_device *spi)
 {
 	struct gen_74x164_chip *chip;
 	struct gen_74x164_chip_platform_data *pdata;
diff --git a/drivers/gpio/gpio-ab8500.c b/drivers/gpio/gpio-ab8500.c
index 48c3bab..0a636de 100644
--- a/drivers/gpio/gpio-ab8500.c
+++ b/drivers/gpio/gpio-ab8500.c
@@ -402,7 +402,7 @@ static void ab8500_gpio_irq_remove(struct ab8500_gpio *ab8500_gpio)
 	}
 }
 
-static int __devinit ab8500_gpio_probe(struct platform_device *pdev)
+static int ab8500_gpio_probe(struct platform_device *pdev)
 {
 	struct ab8500_platform_data *ab8500_pdata =
 				dev_get_platdata(pdev->dev.parent);
diff --git a/drivers/gpio/gpio-adnp.c b/drivers/gpio/gpio-adnp.c
index 9796b9c..9f23684 100644
--- a/drivers/gpio/gpio-adnp.c
+++ b/drivers/gpio/gpio-adnp.c
@@ -516,7 +516,7 @@ static void adnp_irq_teardown(struct adnp *adnp)
 	irq_domain_remove(adnp->domain);
 }
 
-static __devinit int adnp_i2c_probe(struct i2c_client *client,
+static int adnp_i2c_probe(struct i2c_client *client,
 				    const struct i2c_device_id *id)
 {
 	struct device_node *np = client->dev.of_node;
diff --git a/drivers/gpio/gpio-adp5520.c b/drivers/gpio/gpio-adp5520.c
index fc01e6d..b9fac75 100644
--- a/drivers/gpio/gpio-adp5520.c
+++ b/drivers/gpio/gpio-adp5520.c
@@ -87,7 +87,7 @@ static int adp5520_gpio_direction_output(struct gpio_chip *chip,
 	return ret;
 }
 
-static int __devinit adp5520_gpio_probe(struct platform_device *pdev)
+static int adp5520_gpio_probe(struct platform_device *pdev)
 {
 	struct adp5520_gpio_platform_data *pdata = pdev->dev.platform_data;
 	struct adp5520_gpio *dev;
diff --git a/drivers/gpio/gpio-adp5588.c b/drivers/gpio/gpio-adp5588.c
index f762269..27001ec 100644
--- a/drivers/gpio/gpio-adp5588.c
+++ b/drivers/gpio/gpio-adp5588.c
@@ -346,7 +346,7 @@ static void adp5588_irq_teardown(struct adp5588_gpio *dev)
 }
 #endif /* CONFIG_GPIO_ADP5588_IRQ */
 
-static int __devinit adp5588_gpio_probe(struct i2c_client *client,
+static int adp5588_gpio_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
 	struct adp5588_gpio_platform_data *pdata = client->dev.platform_data;
diff --git a/drivers/gpio/gpio-arizona.c b/drivers/gpio/gpio-arizona.c
index a406573..0a76fb0 100644
--- a/drivers/gpio/gpio-arizona.c
+++ b/drivers/gpio/gpio-arizona.c
@@ -94,7 +94,7 @@ static struct gpio_chip template_chip = {
 	.can_sleep		= 1,
 };
 
-static int __devinit arizona_gpio_probe(struct platform_device *pdev)
+static int arizona_gpio_probe(struct platform_device *pdev)
 {
 	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
 	struct arizona_pdata *pdata = arizona->dev->platform_data;
diff --git a/drivers/gpio/gpio-cs5535.c b/drivers/gpio/gpio-cs5535.c
index 00f98f9..d4a6d82 100644
--- a/drivers/gpio/gpio-cs5535.c
+++ b/drivers/gpio/gpio-cs5535.c
@@ -300,7 +300,7 @@ static struct cs5535_gpio_chip cs5535_gpio_chip = {
 	},
 };
 
-static int __devinit cs5535_gpio_probe(struct platform_device *pdev)
+static int cs5535_gpio_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	int err = -EIO;
diff --git a/drivers/gpio/gpio-da9052.c b/drivers/gpio/gpio-da9052.c
index 9f5824d..5d2bc81 100644
--- a/drivers/gpio/gpio-da9052.c
+++ b/drivers/gpio/gpio-da9052.c
@@ -201,7 +201,7 @@ static struct gpio_chip reference_gp __devinitdata = {
 	.base = -1,
 };
 
-static int __devinit da9052_gpio_probe(struct platform_device *pdev)
+static int da9052_gpio_probe(struct platform_device *pdev)
 {
 	struct da9052_gpio *gpio;
 	struct da9052_pdata *pdata;
diff --git a/drivers/gpio/gpio-da9055.c b/drivers/gpio/gpio-da9055.c
index 0c99899..17ed323 100644
--- a/drivers/gpio/gpio-da9055.c
+++ b/drivers/gpio/gpio-da9055.c
@@ -139,7 +139,7 @@ static struct gpio_chip reference_gp __devinitdata = {
 	.base = -1,
 };
 
-static int __devinit da9055_gpio_probe(struct platform_device *pdev)
+static int da9055_gpio_probe(struct platform_device *pdev)
 {
 	struct da9055_gpio *gpio;
 	struct da9055_pdata *pdata;
diff --git a/drivers/gpio/gpio-em.c b/drivers/gpio/gpio-em.c
index 8095d93..1e9157b 100644
--- a/drivers/gpio/gpio-em.c
+++ b/drivers/gpio/gpio-em.c
@@ -233,7 +233,7 @@ static struct irq_domain_ops em_gio_irq_domain_ops = {
 	.map	= em_gio_irq_domain_map,
 };
 
-static int __devinit em_gio_probe(struct platform_device *pdev)
+static int em_gio_probe(struct platform_device *pdev)
 {
 	struct gpio_em_config *pdata = pdev->dev.platform_data;
 	struct em_gio_priv *p;
diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index 9fe5b8fe..56b98ee 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -340,7 +340,7 @@ static int ep93xx_gpio_add_bank(struct bgpio_chip *bgc, struct device *dev,
 	return gpiochip_add(&bgc->gc);
 }
 
-static int __devinit ep93xx_gpio_probe(struct platform_device *pdev)
+static int ep93xx_gpio_probe(struct platform_device *pdev)
 {
 	struct ep93xx_gpio *ep93xx_gpio;
 	struct resource *res;
diff --git a/drivers/gpio/gpio-generic.c b/drivers/gpio/gpio-generic.c
index 983f0f2..be37596 100644
--- a/drivers/gpio/gpio-generic.c
+++ b/drivers/gpio/gpio-generic.c
@@ -444,7 +444,7 @@ static void __iomem *bgpio_map(struct platform_device *pdev,
 	return ret;
 }
 
-static int __devinit bgpio_pdev_probe(struct platform_device *pdev)
+static int bgpio_pdev_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *r;
diff --git a/drivers/gpio/gpio-ich.c b/drivers/gpio/gpio-ich.c
index c230263..3ff9ff6 100644
--- a/drivers/gpio/gpio-ich.c
+++ b/drivers/gpio/gpio-ich.c
@@ -238,7 +238,7 @@ static void ichx_gpio_set(struct gpio_chip *chip, unsigned nr, int val)
 	ichx_write_bit(GPIO_LVL, nr, val, 0);
 }
 
-static void __devinit ichx_gpiolib_setup(struct gpio_chip *chip)
+static void ichx_gpiolib_setup(struct gpio_chip *chip)
 {
 	chip->owner = THIS_MODULE;
 	chip->label = DRV_NAME;
@@ -313,7 +313,7 @@ static struct ichx_desc intel5_desc = {
 	.ngpio = 76,
 };
 
-static int __devinit ichx_gpio_request_regions(struct resource *res_base,
+static int ichx_gpio_request_regions(struct resource *res_base,
 						const char *name, u8 use_gpio)
 {
 	int i;
@@ -353,7 +353,7 @@ static void ichx_gpio_release_regions(struct resource *res_base, u8 use_gpio)
 	}
 }
 
-static int __devinit ichx_gpio_probe(struct platform_device *pdev)
+static int ichx_gpio_probe(struct platform_device *pdev)
 {
 	struct resource *res_base, *res_pm;
 	int err;
diff --git a/drivers/gpio/gpio-janz-ttl.c b/drivers/gpio/gpio-janz-ttl.c
index 365dd04..cd28270 100644
--- a/drivers/gpio/gpio-janz-ttl.c
+++ b/drivers/gpio/gpio-janz-ttl.c
@@ -108,13 +108,13 @@ static void ttl_set_value(struct gpio_chip *gpio, unsigned offset, int value)
 	spin_unlock(&mod->lock);
 }
 
-static void __devinit ttl_write_reg(struct ttl_module *mod, u8 reg, u16 val)
+static void ttl_write_reg(struct ttl_module *mod, u8 reg, u16 val)
 {
 	iowrite16be(reg, &mod->regs->control);
 	iowrite16be(val, &mod->regs->control);
 }
 
-static void __devinit ttl_setup_device(struct ttl_module *mod)
+static void ttl_setup_device(struct ttl_module *mod)
 {
 	/* reset the device to a known state */
 	iowrite16be(0x0000, &mod->regs->control);
@@ -140,7 +140,7 @@ static void __devinit ttl_setup_device(struct ttl_module *mod)
 	ttl_write_reg(mod, MASTER_CONF_CTL, CONF_PAE | CONF_PBE | CONF_PCE);
 }
 
-static int __devinit ttl_probe(struct platform_device *pdev)
+static int ttl_probe(struct platform_device *pdev)
 {
 	struct janz_platform_data *pdata;
 	struct device *dev = &pdev->dev;
diff --git a/drivers/gpio/gpio-langwell.c b/drivers/gpio/gpio-langwell.c
index b815896..a3bf90d 100644
--- a/drivers/gpio/gpio-langwell.c
+++ b/drivers/gpio/gpio-langwell.c
@@ -332,7 +332,7 @@ static const struct dev_pm_ops lnw_gpio_pm_ops = {
 	.runtime_idle = lnw_gpio_runtime_idle,
 };
 
-static int __devinit lnw_gpio_probe(struct pci_dev *pdev,
+static int lnw_gpio_probe(struct pci_dev *pdev,
 			const struct pci_device_id *id)
 {
 	void *base;
@@ -435,7 +435,7 @@ static struct pci_driver lnw_gpio_driver = {
 };
 
 
-static int __devinit wp_gpio_probe(struct platform_device *pdev)
+static int wp_gpio_probe(struct platform_device *pdev)
 {
 	struct lnw_gpio *lnw;
 	struct gpio_chip *gc;
diff --git a/drivers/gpio/gpio-lpc32xx.c b/drivers/gpio/gpio-lpc32xx.c
index 3644e0d..9f676f4 100644
--- a/drivers/gpio/gpio-lpc32xx.c
+++ b/drivers/gpio/gpio-lpc32xx.c
@@ -542,7 +542,7 @@ static int lpc32xx_of_xlate(struct gpio_chip *gc,
 	return gpiospec->args[1];
 }
 
-static int __devinit lpc32xx_gpio_probe(struct platform_device *pdev)
+static int lpc32xx_gpio_probe(struct platform_device *pdev)
 {
 	int i;
 
diff --git a/drivers/gpio/gpio-max7300.c b/drivers/gpio/gpio-max7300.c
index 869235f..5c92414 100644
--- a/drivers/gpio/gpio-max7300.c
+++ b/drivers/gpio/gpio-max7300.c
@@ -31,7 +31,7 @@ static int max7300_i2c_read(struct device *dev, unsigned int reg)
 	return i2c_smbus_read_byte_data(client, reg);
 }
 
-static int __devinit max7300_probe(struct i2c_client *client,
+static int max7300_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct max7301 *ts;
diff --git a/drivers/gpio/gpio-max7301.c b/drivers/gpio/gpio-max7301.c
index 31bf49d..cf5d5b3 100644
--- a/drivers/gpio/gpio-max7301.c
+++ b/drivers/gpio/gpio-max7301.c
@@ -50,7 +50,7 @@ static int max7301_spi_read(struct device *dev, unsigned int reg)
 	return word & 0xff;
 }
 
-static int __devinit max7301_probe(struct spi_device *spi)
+static int max7301_probe(struct spi_device *spi)
 {
 	struct max7301 *ts;
 	int ret;
diff --git a/drivers/gpio/gpio-max730x.c b/drivers/gpio/gpio-max730x.c
index 05e2dac..91b4f45 100644
--- a/drivers/gpio/gpio-max730x.c
+++ b/drivers/gpio/gpio-max730x.c
@@ -160,7 +160,7 @@ static void max7301_set(struct gpio_chip *chip, unsigned offset, int value)
 	mutex_unlock(&ts->lock);
 }
 
-int __devinit __max730x_probe(struct max7301 *ts)
+int __max730x_probe(struct max7301 *ts)
 {
 	struct device *dev = ts->dev;
 	struct max7301_platform_data *pdata;
diff --git a/drivers/gpio/gpio-max732x.c b/drivers/gpio/gpio-max732x.c
index 67ef5ea..5edd2cb3 100644
--- a/drivers/gpio/gpio-max732x.c
+++ b/drivers/gpio/gpio-max732x.c
@@ -526,7 +526,7 @@ static void max732x_irq_teardown(struct max732x_chip *chip)
 }
 #endif
 
-static int __devinit max732x_setup_gpio(struct max732x_chip *chip,
+static int max732x_setup_gpio(struct max732x_chip *chip,
 					const struct i2c_device_id *id,
 					unsigned gpio_start)
 {
@@ -574,7 +574,7 @@ static int __devinit max732x_setup_gpio(struct max732x_chip *chip,
 	return port;
 }
 
-static int __devinit max732x_probe(struct i2c_client *client,
+static int max732x_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
 	struct max732x_platform_data *pdata;
diff --git a/drivers/gpio/gpio-mc33880.c b/drivers/gpio/gpio-mc33880.c
index c6572e1..79fc430 100644
--- a/drivers/gpio/gpio-mc33880.c
+++ b/drivers/gpio/gpio-mc33880.c
@@ -80,7 +80,7 @@ static void mc33880_set(struct gpio_chip *chip, unsigned offset, int value)
 	mutex_unlock(&mc->lock);
 }
 
-static int __devinit mc33880_probe(struct spi_device *spi)
+static int mc33880_probe(struct spi_device *spi)
 {
 	struct mc33880 *mc;
 	struct mc33880_platform_data *pdata;
diff --git a/drivers/gpio/gpio-mcp23s08.c b/drivers/gpio/gpio-mcp23s08.c
index 1160f1a..9ec14ba 100644
--- a/drivers/gpio/gpio-mcp23s08.c
+++ b/drivers/gpio/gpio-mcp23s08.c
@@ -475,7 +475,7 @@ fail:
 
 #if IS_ENABLED(CONFIG_I2C)
 
-static int __devinit mcp230xx_probe(struct i2c_client *client,
+static int mcp230xx_probe(struct i2c_client *client,
 				    const struct i2c_device_id *id)
 {
 	struct mcp23s08_platform_data *pdata;
diff --git a/drivers/gpio/gpio-ml-ioh.c b/drivers/gpio/gpio-ml-ioh.c
index c824b5d..934b9bc 100644
--- a/drivers/gpio/gpio-ml-ioh.c
+++ b/drivers/gpio/gpio-ml-ioh.c
@@ -385,7 +385,7 @@ static irqreturn_t ioh_gpio_handler(int irq, void *dev_id)
 	return ret;
 }
 
-static __devinit void ioh_gpio_alloc_generic_chip(struct ioh_gpio *chip,
+static void ioh_gpio_alloc_generic_chip(struct ioh_gpio *chip,
 				unsigned int irq_start, unsigned int num)
 {
 	struct irq_chip_generic *gc;
@@ -406,7 +406,7 @@ static __devinit void ioh_gpio_alloc_generic_chip(struct ioh_gpio *chip,
 			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
 }
 
-static int __devinit ioh_gpio_probe(struct pci_dev *pdev,
+static int ioh_gpio_probe(struct pci_dev *pdev,
 				    const struct pci_device_id *id)
 {
 	int ret;
diff --git a/drivers/gpio/gpio-mpc5200.c b/drivers/gpio/gpio-mpc5200.c
index 2c7cef3..42647f2 100644
--- a/drivers/gpio/gpio-mpc5200.c
+++ b/drivers/gpio/gpio-mpc5200.c
@@ -148,7 +148,7 @@ mpc52xx_wkup_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	return 0;
 }
 
-static int __devinit mpc52xx_wkup_gpiochip_probe(struct platform_device *ofdev)
+static int mpc52xx_wkup_gpiochip_probe(struct platform_device *ofdev)
 {
 	struct mpc52xx_gpiochip *chip;
 	struct mpc52xx_gpio_wkup __iomem *regs;
@@ -308,7 +308,7 @@ mpc52xx_simple_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	return 0;
 }
 
-static int __devinit mpc52xx_simple_gpiochip_probe(struct platform_device *ofdev)
+static int mpc52xx_simple_gpiochip_probe(struct platform_device *ofdev)
 {
 	struct mpc52xx_gpiochip *chip;
 	struct gpio_chip *gc;
diff --git a/drivers/gpio/gpio-msic.c b/drivers/gpio/gpio-msic.c
index b389862..27ea7b9 100644
--- a/drivers/gpio/gpio-msic.c
+++ b/drivers/gpio/gpio-msic.c
@@ -256,7 +256,7 @@ static void msic_gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 	chip->irq_eoi(data);
 }
 
-static int __devinit platform_msic_gpio_probe(struct platform_device *pdev)
+static int platform_msic_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct intel_msic_gpio_pdata *pdata = dev->platform_data;
diff --git a/drivers/gpio/gpio-msm-v2.c b/drivers/gpio/gpio-msm-v2.c
index 26f5122..5451bec 100644
--- a/drivers/gpio/gpio-msm-v2.c
+++ b/drivers/gpio/gpio-msm-v2.c
@@ -352,7 +352,7 @@ static struct irq_chip msm_gpio_irq_chip = {
 	.irq_set_wake	= msm_gpio_irq_set_wake,
 };
 
-static int __devinit msm_gpio_probe(struct platform_device *dev)
+static int msm_gpio_probe(struct platform_device *dev)
 {
 	int i, irq, ret;
 
diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index a515b92..28b1bdd 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -501,7 +501,7 @@ static struct of_device_id mvebu_gpio_of_match[] __devinitdata = {
 };
 MODULE_DEVICE_TABLE(of, mvebu_gpio_of_match);
 
-static int __devinit mvebu_gpio_probe(struct platform_device *pdev)
+static int mvebu_gpio_probe(struct platform_device *pdev)
 {
 	struct mvebu_gpio_chip *mvchip;
 	const struct of_device_id *match;
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 80f44bb..7877335 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -356,7 +356,7 @@ static void __init mxc_gpio_init_gc(struct mxc_gpio_port *port, int irq_base)
 			       IRQ_NOREQUEST, 0);
 }
 
-static void __devinit mxc_gpio_get_hw(struct platform_device *pdev)
+static void mxc_gpio_get_hw(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id =
 			of_match_device(mxc_gpio_dt_ids, &pdev->dev);
@@ -395,7 +395,7 @@ static int mxc_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
 	return irq_find_mapping(port->domain, offset);
 }
 
-static int __devinit mxc_gpio_probe(struct platform_device *pdev)
+static int mxc_gpio_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct mxc_gpio_port *port;
diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 796fb13..fa2a63c 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -214,7 +214,7 @@ static const struct of_device_id mxs_gpio_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mxs_gpio_dt_ids);
 
-static int __devinit mxs_gpio_probe(struct platform_device *pdev)
+static int mxs_gpio_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id =
 			of_match_device(mxs_gpio_dt_ids, &pdev->dev);
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index d71e5bd..f1fbedb2 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1012,7 +1012,7 @@ static void omap_gpio_mod_init(struct gpio_bank *bank)
 		dev_err(bank->dev, "Could not get gpio dbck\n");
 }
 
-static __devinit void
+static void
 omap_mpuio_alloc_gc(struct gpio_bank *bank, unsigned int irq_start,
 		    unsigned int num)
 {
@@ -1041,7 +1041,7 @@ omap_mpuio_alloc_gc(struct gpio_bank *bank, unsigned int irq_start,
 			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
 }
 
-static void __devinit omap_gpio_chip_init(struct gpio_bank *bank)
+static void omap_gpio_chip_init(struct gpio_bank *bank)
 {
 	int j;
 	static int gpio;
@@ -1089,7 +1089,7 @@ static void __devinit omap_gpio_chip_init(struct gpio_bank *bank)
 
 static const struct of_device_id omap_gpio_match[];
 
-static int __devinit omap_gpio_probe(struct platform_device *pdev)
+static int omap_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 9c693ae..fff7c2b 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -602,7 +602,7 @@ pca953x_get_alt_pdata(struct i2c_client *client, int *gpio_base, u32 *invert)
 }
 #endif
 
-static int __devinit device_pca953x_init(struct pca953x_chip *chip, u32 invert)
+static int device_pca953x_init(struct pca953x_chip *chip, u32 invert)
 {
 	int ret;
 
@@ -621,7 +621,7 @@ out:
 	return ret;
 }
 
-static int __devinit device_pca957x_init(struct pca953x_chip *chip, u32 invert)
+static int device_pca957x_init(struct pca953x_chip *chip, u32 invert)
 {
 	int ret;
 	u32 val = 0;
@@ -652,7 +652,7 @@ out:
 	return ret;
 }
 
-static int __devinit pca953x_probe(struct i2c_client *client,
+static int pca953x_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
 	struct pca953x_platform_data *pdata;
diff --git a/drivers/gpio/gpio-pch.c b/drivers/gpio/gpio-pch.c
index b21cc3f..0cb1a40 100644
--- a/drivers/gpio/gpio-pch.c
+++ b/drivers/gpio/gpio-pch.c
@@ -326,7 +326,7 @@ static irqreturn_t pch_gpio_handler(int irq, void *dev_id)
 	return ret;
 }
 
-static __devinit void pch_gpio_alloc_generic_chip(struct pch_gpio *chip,
+static void pch_gpio_alloc_generic_chip(struct pch_gpio *chip,
 				unsigned int irq_start, unsigned int num)
 {
 	struct irq_chip_generic *gc;
@@ -346,7 +346,7 @@ static __devinit void pch_gpio_alloc_generic_chip(struct pch_gpio *chip,
 			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
 }
 
-static int __devinit pch_gpio_probe(struct pci_dev *pdev,
+static int pch_gpio_probe(struct pci_dev *pdev,
 				    const struct pci_device_id *id)
 {
 	s32 ret;
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 98d52cb..3e35243 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -250,7 +250,7 @@ static int pxa_gpio_of_xlate(struct gpio_chip *gc,
 }
 #endif
 
-static int __devinit pxa_init_gpio_chip(int gpio_end,
+static int pxa_init_gpio_chip(int gpio_end,
 					int (*set_wake)(unsigned int, unsigned int))
 {
 	int i, gpio, nbanks = gpio_to_bank(gpio_end) + 1;
@@ -490,7 +490,7 @@ const struct irq_domain_ops pxa_irq_domain_ops = {
 	.xlate	= irq_domain_xlate_twocell,
 };
 
-static int __devinit pxa_gpio_probe_dt(struct platform_device *pdev)
+static int pxa_gpio_probe_dt(struct platform_device *pdev)
 {
 	int ret, nr_banks, nr_gpios;
 	struct device_node *prev, *next, *np = pdev->dev.of_node;
@@ -537,7 +537,7 @@ err:
 #define pxa_gpio_probe_dt(pdev)		(-1)
 #endif
 
-static int __devinit pxa_gpio_probe(struct platform_device *pdev)
+static int pxa_gpio_probe(struct platform_device *pdev)
 {
 	struct pxa_gpio_chip *c;
 	struct resource *res;
diff --git a/drivers/gpio/gpio-rc5t583.c b/drivers/gpio/gpio-rc5t583.c
index 2931514..59ee5de 100644
--- a/drivers/gpio/gpio-rc5t583.c
+++ b/drivers/gpio/gpio-rc5t583.c
@@ -111,7 +111,7 @@ static void rc5t583_gpio_free(struct gpio_chip *gc, unsigned offset)
 	rc5t583_set_bits(parent, RC5T583_GPIO_PGSEL, BIT(offset));
 }
 
-static int __devinit rc5t583_gpio_probe(struct platform_device *pdev)
+static int rc5t583_gpio_probe(struct platform_device *pdev)
 {
 	struct rc5t583 *rc5t583 = dev_get_drvdata(pdev->dev.parent);
 	struct rc5t583_platform_data *pdata = dev_get_platdata(rc5t583->dev);
diff --git a/drivers/gpio/gpio-rdc321x.c b/drivers/gpio/gpio-rdc321x.c
index 17b971b..dd3b49f 100644
--- a/drivers/gpio/gpio-rdc321x.c
+++ b/drivers/gpio/gpio-rdc321x.c
@@ -128,7 +128,7 @@ static int rdc_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 /*
  * Cache the initial value of both GPIO data registers
  */
-static int __devinit rdc321x_gpio_probe(struct platform_device *pdev)
+static int rdc321x_gpio_probe(struct platform_device *pdev)
 {
 	int err;
 	struct resource *r;
diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
index ed54425..4498855 100644
--- a/drivers/gpio/gpio-sch.c
+++ b/drivers/gpio/gpio-sch.c
@@ -185,7 +185,7 @@ static struct gpio_chip sch_gpio_resume = {
 	.set			= sch_gpio_resume_set,
 };
 
-static int __devinit sch_gpio_probe(struct platform_device *pdev)
+static int sch_gpio_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	int err, id;
diff --git a/drivers/gpio/gpio-sodaville.c b/drivers/gpio/gpio-sodaville.c
index e25f731..88f374a 100644
--- a/drivers/gpio/gpio-sodaville.c
+++ b/drivers/gpio/gpio-sodaville.c
@@ -129,7 +129,7 @@ static struct irq_domain_ops irq_domain_sdv_ops = {
 	.xlate = sdv_xlate,
 };
 
-static __devinit int sdv_register_irqsupport(struct sdv_gpio_chip_data *sd,
+static int sdv_register_irqsupport(struct sdv_gpio_chip_data *sd,
 		struct pci_dev *pdev)
 {
 	struct irq_chip_type *ct;
@@ -186,7 +186,7 @@ out_free_desc:
 	return ret;
 }
 
-static int __devinit sdv_gpio_probe(struct pci_dev *pdev,
+static int sdv_gpio_probe(struct pci_dev *pdev,
 					const struct pci_device_id *pci_id)
 {
 	struct sdv_gpio_chip_data *sd;
diff --git a/drivers/gpio/gpio-sta2x11.c b/drivers/gpio/gpio-sta2x11.c
index 6064fb3..5585425 100644
--- a/drivers/gpio/gpio-sta2x11.c
+++ b/drivers/gpio/gpio-sta2x11.c
@@ -320,7 +320,7 @@ static irqreturn_t gsta_gpio_handler(int irq, void *dev_id)
 	return ret;
 }
 
-static __devinit void gsta_alloc_irq_chip(struct gsta_gpio *chip)
+static void gsta_alloc_irq_chip(struct gsta_gpio *chip)
 {
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
@@ -353,7 +353,7 @@ static __devinit void gsta_alloc_irq_chip(struct gsta_gpio *chip)
 }
 
 /* The platform device used here is instantiated by the MFD device */
-static int __devinit gsta_probe(struct platform_device *dev)
+static int gsta_probe(struct platform_device *dev)
 {
 	int i, err;
 	struct pci_dev *pdev;
diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
index 821392d..72cf618 100644
--- a/drivers/gpio/gpio-stmpe.c
+++ b/drivers/gpio/gpio-stmpe.c
@@ -267,7 +267,7 @@ static irqreturn_t stmpe_gpio_irq(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static int __devinit stmpe_gpio_irq_init(struct stmpe_gpio *stmpe_gpio)
+static int stmpe_gpio_irq_init(struct stmpe_gpio *stmpe_gpio)
 {
 	int base = stmpe_gpio->irq_base;
 	int irq;
@@ -301,7 +301,7 @@ static void stmpe_gpio_irq_remove(struct stmpe_gpio *stmpe_gpio)
 	}
 }
 
-static int __devinit stmpe_gpio_probe(struct platform_device *pdev)
+static int stmpe_gpio_probe(struct platform_device *pdev)
 {
 	struct stmpe *stmpe = dev_get_drvdata(pdev->dev.parent);
 	struct stmpe_gpio_platform_data *pdata;
diff --git a/drivers/gpio/gpio-stp-xway.c b/drivers/gpio/gpio-stp-xway.c
index 8bead0b..85841ee7 100644
--- a/drivers/gpio/gpio-stp-xway.c
+++ b/drivers/gpio/gpio-stp-xway.c
@@ -197,7 +197,7 @@ static int xway_stp_hw_init(struct xway_stp *chip)
 	return 0;
 }
 
-static int __devinit xway_stp_probe(struct platform_device *pdev)
+static int xway_stp_probe(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	const __be32 *shadow, *groups, *dsl, *phy;
diff --git a/drivers/gpio/gpio-sx150x.c b/drivers/gpio/gpio-sx150x.c
index 0e1472d..9c93308 100644
--- a/drivers/gpio/gpio-sx150x.c
+++ b/drivers/gpio/gpio-sx150x.c
@@ -575,7 +575,7 @@ static void sx150x_remove_irq_chip(struct sx150x_chip *chip)
 	}
 }
 
-static int __devinit sx150x_probe(struct i2c_client *client,
+static int sx150x_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
 	static const u32 i2c_funcs = I2C_FUNC_SMBUS_BYTE_DATA |
diff --git a/drivers/gpio/gpio-tc3589x.c b/drivers/gpio/gpio-tc3589x.c
index 54ad34a..b4a136b 100644
--- a/drivers/gpio/gpio-tc3589x.c
+++ b/drivers/gpio/gpio-tc3589x.c
@@ -309,7 +309,7 @@ static int tc3589x_gpio_irq_init(struct tc3589x_gpio *tc3589x_gpio,
 	return 0;
 }
 
-static int __devinit tc3589x_gpio_probe(struct platform_device *pdev)
+static int tc3589x_gpio_probe(struct platform_device *pdev)
 {
 	struct tc3589x *tc3589x = dev_get_drvdata(pdev->dev.parent);
 	struct tc3589x_gpio_platform_data *pdata;
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index cfd9b72..9b9dc0d 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -381,7 +381,7 @@ static struct of_device_id tegra_gpio_of_match[] __devinitdata = {
  */
 static struct lock_class_key gpio_lock_class;
 
-static int __devinit tegra_gpio_probe(struct platform_device *pdev)
+static int tegra_gpio_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct tegra_gpio_soc_config *config;
diff --git a/drivers/gpio/gpio-timberdale.c b/drivers/gpio/gpio-timberdale.c
index 1a3e2b9..728d6e7 100644
--- a/drivers/gpio/gpio-timberdale.c
+++ b/drivers/gpio/gpio-timberdale.c
@@ -222,7 +222,7 @@ static struct irq_chip timbgpio_irqchip = {
 	.irq_set_type	= timbgpio_irq_type,
 };
 
-static int __devinit timbgpio_probe(struct platform_device *pdev)
+static int timbgpio_probe(struct platform_device *pdev)
 {
 	int err, i;
 	struct gpio_chip *gc;
diff --git a/drivers/gpio/gpio-tps6586x.c b/drivers/gpio/gpio-tps6586x.c
index 33ea93f..2025512 100644
--- a/drivers/gpio/gpio-tps6586x.c
+++ b/drivers/gpio/gpio-tps6586x.c
@@ -88,7 +88,7 @@ static int tps6586x_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
 				TPS6586X_INT_PLDO_0 + offset);
 }
 
-static int __devinit tps6586x_gpio_probe(struct platform_device *pdev)
+static int tps6586x_gpio_probe(struct platform_device *pdev)
 {
 	struct tps6586x_platform_data *pdata;
 	struct tps6586x_gpio *tps6586x_gpio;
diff --git a/drivers/gpio/gpio-tps65910.c b/drivers/gpio/gpio-tps65910.c
index cf4e327..635352c 100644
--- a/drivers/gpio/gpio-tps65910.c
+++ b/drivers/gpio/gpio-tps65910.c
@@ -113,7 +113,7 @@ static struct tps65910_board *tps65910_parse_dt_for_gpio(struct device *dev,
 }
 #endif
 
-static int __devinit tps65910_gpio_probe(struct platform_device *pdev)
+static int tps65910_gpio_probe(struct platform_device *pdev)
 {
 	struct tps65910 *tps65910 = dev_get_drvdata(pdev->dev.parent);
 	struct tps65910_board *pdata = dev_get_platdata(tps65910->dev);
diff --git a/drivers/gpio/gpio-tps65912.c b/drivers/gpio/gpio-tps65912.c
index 55c1d35..c0623b8 100644
--- a/drivers/gpio/gpio-tps65912.c
+++ b/drivers/gpio/gpio-tps65912.c
@@ -84,7 +84,7 @@ static struct gpio_chip template_chip = {
 	.base			= -1,
 };
 
-static int __devinit tps65912_gpio_probe(struct platform_device *pdev)
+static int tps65912_gpio_probe(struct platform_device *pdev)
 {
 	struct tps65912 *tps65912 = dev_get_drvdata(pdev->dev.parent);
 	struct tps65912_board *pdata = tps65912->dev->platform_data;
diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index c5f8ca2..648e560 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -352,7 +352,7 @@ static struct gpio_chip twl_gpiochip = {
 
 /*----------------------------------------------------------------------*/
 
-static int __devinit gpio_twl4030_pulls(u32 ups, u32 downs)
+static int gpio_twl4030_pulls(u32 ups, u32 downs)
 {
 	u8		message[6];
 	unsigned	i, gpio_bit;
@@ -377,7 +377,7 @@ static int __devinit gpio_twl4030_pulls(u32 ups, u32 downs)
 				REG_GPIOPUPDCTR1, 5);
 }
 
-static int __devinit gpio_twl4030_debounce(u32 debounce, u8 mmc_cd)
+static int gpio_twl4030_debounce(u32 debounce, u8 mmc_cd)
 {
 	u8		message[4];
 
@@ -419,7 +419,7 @@ static struct twl4030_gpio_platform_data *of_gpio_twl4030(struct device *dev)
 	return omap_twl_info;
 }
 
-static int __devinit gpio_twl4030_probe(struct platform_device *pdev)
+static int gpio_twl4030_probe(struct platform_device *pdev)
 {
 	struct twl4030_gpio_platform_data *pdata = pdev->dev.platform_data;
 	struct device_node *node = pdev->dev.of_node;
diff --git a/drivers/gpio/gpio-twl6040.c b/drivers/gpio/gpio-twl6040.c
index dd58e8b..2962b84 100644
--- a/drivers/gpio/gpio-twl6040.c
+++ b/drivers/gpio/gpio-twl6040.c
@@ -82,7 +82,7 @@ static struct gpio_chip twl6040gpo_chip = {
 
 /*----------------------------------------------------------------------*/
 
-static int __devinit gpo_twl6040_probe(struct platform_device *pdev)
+static int gpo_twl6040_probe(struct platform_device *pdev)
 {
 	struct twl6040_gpo_data *pdata = pdev->dev.platform_data;
 	struct device *twl6040_core_dev = pdev->dev.parent;
diff --git a/drivers/gpio/gpio-vr41xx.c b/drivers/gpio/gpio-vr41xx.c
index 54d6e9a..c13920b 100644
--- a/drivers/gpio/gpio-vr41xx.c
+++ b/drivers/gpio/gpio-vr41xx.c
@@ -490,7 +490,7 @@ static struct gpio_chip vr41xx_gpio_chip = {
 	.to_irq			= vr41xx_gpio_to_irq,
 };
 
-static int __devinit giu_probe(struct platform_device *pdev)
+static int giu_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	unsigned int trigger, i, pin;
diff --git a/drivers/gpio/gpio-vt8500.c b/drivers/gpio/gpio-vt8500.c
index 9ed2a2b..b53320a 100644
--- a/drivers/gpio/gpio-vt8500.c
+++ b/drivers/gpio/gpio-vt8500.c
@@ -271,7 +271,7 @@ static struct of_device_id vt8500_gpio_dt_ids[] = {
 	{ /* Sentinel */ },
 };
 
-static int __devinit vt8500_gpio_probe(struct platform_device *pdev)
+static int vt8500_gpio_probe(struct platform_device *pdev)
 {
 	void __iomem *gpio_base;
 	struct device_node *np;
diff --git a/drivers/gpio/gpio-vx855.c b/drivers/gpio/gpio-vx855.c
index 43fcc42..90dd23b 100644
--- a/drivers/gpio/gpio-vx855.c
+++ b/drivers/gpio/gpio-vx855.c
@@ -219,7 +219,7 @@ static void vx855gpio_gpio_setup(struct vx855_gpio *vg)
 }
 
 /* This platform device is ordinarily registered by the vx855 mfd driver */
-static __devinit int vx855gpio_probe(struct platform_device *pdev)
+static int vx855gpio_probe(struct platform_device *pdev)
 {
 	struct resource *res_gpi;
 	struct resource *res_gpo;
diff --git a/drivers/gpio/gpio-wm831x.c b/drivers/gpio/gpio-wm831x.c
index 273d541..8182145 100644
--- a/drivers/gpio/gpio-wm831x.c
+++ b/drivers/gpio/gpio-wm831x.c
@@ -243,7 +243,7 @@ static struct gpio_chip template_chip = {
 	.can_sleep		= 1,
 };
 
-static int __devinit wm831x_gpio_probe(struct platform_device *pdev)
+static int wm831x_gpio_probe(struct platform_device *pdev)
 {
 	struct wm831x *wm831x = dev_get_drvdata(pdev->dev.parent);
 	struct wm831x_pdata *pdata = wm831x->dev->platform_data;
diff --git a/drivers/gpio/gpio-wm8350.c b/drivers/gpio/gpio-wm8350.c
index 348a7d9..2b99fc3 100644
--- a/drivers/gpio/gpio-wm8350.c
+++ b/drivers/gpio/gpio-wm8350.c
@@ -109,7 +109,7 @@ static struct gpio_chip template_chip = {
 	.can_sleep		= 1,
 };
 
-static int __devinit wm8350_gpio_probe(struct platform_device *pdev)
+static int wm8350_gpio_probe(struct platform_device *pdev)
 {
 	struct wm8350 *wm8350 = dev_get_drvdata(pdev->dev.parent);
 	struct wm8350_platform_data *pdata = wm8350->dev->platform_data;
diff --git a/drivers/gpio/gpio-wm8994.c b/drivers/gpio/gpio-wm8994.c
index 59f0944..fc39178 100644
--- a/drivers/gpio/gpio-wm8994.c
+++ b/drivers/gpio/gpio-wm8994.c
@@ -245,7 +245,7 @@ static struct gpio_chip template_chip = {
 	.can_sleep		= 1,
 };
 
-static int __devinit wm8994_gpio_probe(struct platform_device *pdev)
+static int wm8994_gpio_probe(struct platform_device *pdev)
 {
 	struct wm8994 *wm8994 = dev_get_drvdata(pdev->dev.parent);
 	struct wm8994_pdata *pdata = wm8994->dev->platform_data;
diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index 79b0fe8..5a35138 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -159,7 +159,7 @@ static void xgpio_save_regs(struct of_mm_gpio_chip *mm_gc)
  * driver data structure. It returns 0, if the driver is bound to the GPIO
  * device, or a negative value if there is an error.
  */
-static int __devinit xgpio_of_probe(struct device_node *np)
+static int xgpio_of_probe(struct device_node *np)
 {
 	struct xgpio_instance *chip;
 	int status = 0;
-- 
1.8.0


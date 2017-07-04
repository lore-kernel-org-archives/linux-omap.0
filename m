From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] gpio: drop unnecessary includes from
 include/linux/gpio/driver.h
Date: Tue,  4 Jul 2017 12:53:34 +0900
Message-ID: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-gpio@vger.kernel.org
Cc: Thor Thayer <thor.thayer@linux.intel.com>, Tien Hock Loh <thloh@altera.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Thierry Reding <thierry.reding@gmail.com>, Alban Bedel <albeu@free.fr>, Florian Fainelli <f.fainelli@gmail.com>, Alexander Shiyan <shc_work@mail.ru>, Kevin Hilman <khilman@kernel.org>, Michal Simek <michal.simek@xilinx.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-acpi@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Joel Stanley <joel@jms.id.au>, Grygorii Strashko <grygorii.strashko@ti.com>, Ray Jui <rjui@broadcom.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-arm-kernel@lists.inf
List-Id: linux-omap@vger.kernel.org

Some of include directives in include/linux/gpio/driver.h are
unneeded because the header does not need to know the content of
struct device, irq_chip, etc.  Just declare they are structures.

On the other hand, <linux/irqhandler.h> and <linux/spinlock_types.h>
turned out to be necessary for irq_flow_handler_t and spinlock_t,
respectively.

Each driver should include what it needs without relying on what is
implicitly included from <linux/gpio/driver.h>.  This will cut down
unnecessary header parsing.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/gpio/gpio-104-dio-48e.c  |  1 +
 drivers/gpio/gpio-104-idi-48.c   |  1 +
 drivers/gpio/gpio-104-idio-16.c  |  1 +
 drivers/gpio/gpio-altera-a10sr.c |  2 ++
 drivers/gpio/gpio-altera.c       |  3 +++
 drivers/gpio/gpio-aspeed.c       |  5 +++++
 drivers/gpio/gpio-ath79.c        |  2 ++
 drivers/gpio/gpio-bcm-kona.c     |  1 +
 drivers/gpio/gpio-clps711x.c     |  1 +
 drivers/gpio/gpio-crystalcove.c  |  2 ++
 drivers/gpio/gpio-dln2.c         |  1 +
 drivers/gpio/gpio-dwapb.c        |  1 +
 drivers/gpio/gpio-etraxfs.c      |  1 +
 drivers/gpio/gpio-f7188x.c       |  1 +
 drivers/gpio/gpio-ftgpio010.c    |  3 +++
 drivers/gpio/gpio-ingenic.c      |  1 +
 drivers/gpio/gpio-intel-mid.c    |  2 ++
 drivers/gpio/gpio-lp873x.c       |  1 +
 drivers/gpio/gpio-lynxpoint.c    |  2 ++
 drivers/gpio/gpio-max732x.c      |  1 +
 drivers/gpio/gpio-max77620.c     |  1 +
 drivers/gpio/gpio-menz127.c      |  1 +
 drivers/gpio/gpio-merrifield.c   |  4 ++++
 drivers/gpio/gpio-omap.c         |  3 +++
 drivers/gpio/gpio-pca953x.c      |  1 +
 drivers/gpio/gpio-pci-idio-16.c  |  2 ++
 drivers/gpio/gpio-pisosr.c       |  1 +
 drivers/gpio/gpio-pl061.c        |  1 +
 drivers/gpio/gpio-rcar.c         |  1 +
 drivers/gpio/gpio-stmpe.c        |  2 ++
 drivers/gpio/gpio-tc3589x.c      |  3 +++
 drivers/gpio/gpio-tegra.c        |  1 +
 drivers/gpio/gpio-tps65218.c     |  1 +
 drivers/gpio/gpio-vf610.c        |  3 +++
 drivers/gpio/gpio-vx855.c        |  1 +
 drivers/gpio/gpio-wcove.c        |  2 ++
 drivers/gpio/gpio-wm831x.c       |  1 +
 drivers/gpio/gpio-wm8994.c       |  1 +
 drivers/gpio/gpio-ws16c48.c      |  1 +
 drivers/gpio/gpio-xgene-sb.c     |  2 ++
 drivers/gpio/gpio-xlp.c          |  1 +
 drivers/gpio/gpio-zx.c           |  1 +
 drivers/gpio/gpio-zynq.c         |  3 +++
 drivers/gpio/gpiolib-acpi.c      |  1 +
 drivers/gpio/gpiolib.c           |  2 ++
 include/linux/gpio/driver.h      | 11 ++++++-----
 46 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index 598e209efa2d..bdc52be7902a 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -22,6 +22,7 @@
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/irqdesc.h>
+#include <linux/irqdomain.h>
 #include <linux/isa.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index 51f046e29ff7..7bbb0e8573d1 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -22,6 +22,7 @@
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/irqdesc.h>
+#include <linux/irqdomain.h>
 #include <linux/isa.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/gpio/gpio-104-idio-16.c b/drivers/gpio/gpio-104-idio-16.c
index ec2ce34ff473..7e3fc0bf3398 100644
--- a/drivers/gpio/gpio-104-idio-16.c
+++ b/drivers/gpio/gpio-104-idio-16.c
@@ -22,6 +22,7 @@
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/irqdesc.h>
+#include <linux/irqdomain.h>
 #include <linux/isa.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/gpio/gpio-altera-a10sr.c b/drivers/gpio/gpio-altera-a10sr.c
index 16a8951b2bed..4cdca9332043 100644
--- a/drivers/gpio/gpio-altera-a10sr.c
+++ b/drivers/gpio/gpio-altera-a10sr.c
@@ -21,6 +21,8 @@
 #include <linux/gpio/driver.h>
 #include <linux/mfd/altera-a10sr.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 
 /**
  * struct altr_a10sr_gpio - Altera Max5 GPIO device private data structure
diff --git a/drivers/gpio/gpio-altera.c b/drivers/gpio/gpio-altera.c
index 17485dc20384..40b26274acaf 100644
--- a/drivers/gpio/gpio-altera.c
+++ b/drivers/gpio/gpio-altera.c
@@ -17,6 +17,9 @@
  */
 
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/of_gpio.h>
 #include <linux/platform_device.h>
diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 4ca436e66bdb..a9d575e215da 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -15,9 +15,14 @@
 #include <linux/hashtable.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
diff --git a/drivers/gpio/gpio-ath79.c b/drivers/gpio/gpio-ath79.c
index f33d4a5fe671..1249ab0f8f4f 100644
--- a/drivers/gpio/gpio-ath79.c
+++ b/drivers/gpio/gpio-ath79.c
@@ -17,6 +17,8 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
 
 #define AR71XX_GPIO_REG_OE		0x00
 #define AR71XX_GPIO_REG_IN		0x04
diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index dfcf56ee3c61..937d646d184b 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/irqdomain.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/pinctrl/pinconf-generic.h>
 
 #define BCM_GPIO_PASSWD				0x00a5a501
 #define GPIO_PER_BANK				32
diff --git a/drivers/gpio/gpio-clps711x.c b/drivers/gpio/gpio-clps711x.c
index 52fd63f02134..1f499b5e7f91 100644
--- a/drivers/gpio/gpio-clps711x.c
+++ b/drivers/gpio/gpio-clps711x.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/gpio/driver.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 
 static int clps711x_gpio_probe(struct platform_device *pdev)
diff --git a/drivers/gpio/gpio-crystalcove.c b/drivers/gpio/gpio-crystalcove.c
index e60156ec0c18..0f66ae796d4a 100644
--- a/drivers/gpio/gpio-crystalcove.c
+++ b/drivers/gpio/gpio-crystalcove.c
@@ -16,6 +16,8 @@
  */
 
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
diff --git a/drivers/gpio/gpio-dln2.c b/drivers/gpio/gpio-dln2.c
index aecb847166f5..d524f3390196 100644
--- a/drivers/gpio/gpio-dln2.c
+++ b/drivers/gpio/gpio-dln2.c
@@ -17,6 +17,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/gpio.h>
 #include <linux/gpio/driver.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/dln2.h>
 
diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index c07ada9c7af6..350454b9359e 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -23,6 +23,7 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/spinlock.h>
diff --git a/drivers/gpio/gpio-etraxfs.c b/drivers/gpio/gpio-etraxfs.c
index 14c6aac26780..ef518aacbeac 100644
--- a/drivers/gpio/gpio-etraxfs.c
+++ b/drivers/gpio/gpio-etraxfs.c
@@ -4,6 +4,7 @@
 #include <linux/of_gpio.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/platform_device.h>
 
 #define ETRAX_FS_rw_pa_dout	0
diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
index 13350c9d7f5e..08604a76d543 100644
--- a/drivers/gpio/gpio-f7188x.c
+++ b/drivers/gpio/gpio-f7188x.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/gpio/driver.h>
 #include <linux/bitops.h>
+#include <linux/pinctrl/pinconf-generic.h>
 
 #define DRVNAME "gpio-f7188x"
 
diff --git a/drivers/gpio/gpio-ftgpio010.c b/drivers/gpio/gpio-ftgpio010.c
index e9386f8b67f5..699a3709e357 100644
--- a/drivers/gpio/gpio-ftgpio010.c
+++ b/drivers/gpio/gpio-ftgpio010.c
@@ -12,6 +12,9 @@
 #include <linux/gpio/driver.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
 #include <linux/platform_device.h>
 #include <linux/of_gpio.h>
 #include <linux/bitops.h>
diff --git a/drivers/gpio/gpio-ingenic.c b/drivers/gpio/gpio-ingenic.c
index 254780730b95..7ec8de5ee926 100644
--- a/drivers/gpio/gpio-ingenic.c
+++ b/drivers/gpio/gpio-ingenic.c
@@ -9,6 +9,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
diff --git a/drivers/gpio/gpio-intel-mid.c b/drivers/gpio/gpio-intel-mid.c
index b76ecee82c3f..af6b7d27ee41 100644
--- a/drivers/gpio/gpio-intel-mid.c
+++ b/drivers/gpio/gpio-intel-mid.c
@@ -23,6 +23,8 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/gpio/driver.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/gpio/gpio-lp873x.c b/drivers/gpio/gpio-lp873x.c
index df0ad2cef0d2..1cd5e7e08ad9 100644
--- a/drivers/gpio/gpio-lp873x.c
+++ b/drivers/gpio/gpio-lp873x.c
@@ -16,6 +16,7 @@
 
 #include <linux/gpio.h>
 #include <linux/module.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/gpio/gpio-lynxpoint.c b/drivers/gpio/gpio-lynxpoint.c
index fbd393b46ce0..9adbbac2ba5b 100644
--- a/drivers/gpio/gpio-lynxpoint.c
+++ b/drivers/gpio/gpio-lynxpoint.c
@@ -25,6 +25,8 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
diff --git a/drivers/gpio/gpio-max732x.c b/drivers/gpio/gpio-max732x.c
index 7f4d26ce5f23..c277278af532 100644
--- a/drivers/gpio/gpio-max732x.c
+++ b/drivers/gpio/gpio-max732x.c
@@ -20,6 +20,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
+#include <linux/irq.h>
 #include <linux/platform_data/max732x.h>
 #include <linux/of.h>
 
diff --git a/drivers/gpio/gpio-max77620.c b/drivers/gpio/gpio-max77620.c
index 743459d9477d..35dd0f133028 100644
--- a/drivers/gpio/gpio-max77620.c
+++ b/drivers/gpio/gpio-max77620.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/mfd/max77620.h>
 #include <linux/module.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/gpio/gpio-menz127.c b/drivers/gpio/gpio-menz127.c
index e1037582e34d..f265a841f787 100644
--- a/drivers/gpio/gpio-menz127.c
+++ b/drivers/gpio/gpio-menz127.c
@@ -15,6 +15,7 @@
 #include <linux/mcb.h>
 #include <linux/bitops.h>
 #include <linux/gpio/driver.h>
+#include <linux/pinctrl/pinconf-generic.h>
 
 #define MEN_Z127_CTRL	0x00
 #define MEN_Z127_PSR	0x04
diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
index ec8560298805..2d84fcbe060f 100644
--- a/drivers/gpio/gpio-merrifield.c
+++ b/drivers/gpio/gpio-merrifield.c
@@ -14,8 +14,12 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/consumer.h>
 
 #define GCCR		0x000	/* controller configuration */
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index f8c550de6c72..7ef062e14777 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -19,6 +19,8 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm.h>
@@ -26,6 +28,7 @@
 #include <linux/of_device.h>
 #include <linux/gpio.h>
 #include <linux/bitops.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_data/gpio-omap.h>
 
 #define OFF_MODE	1
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 4c9e21300a26..58a68ba8311f 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -17,6 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/pca953x.h>
diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
index 7de4f6a2cb49..313da56389f4 100644
--- a/drivers/gpio/gpio-pci-idio-16.c
+++ b/drivers/gpio/gpio-pci-idio-16.c
@@ -16,7 +16,9 @@
 #include <linux/errno.h>
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/irqdesc.h>
+#include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
diff --git a/drivers/gpio/gpio-pisosr.c b/drivers/gpio/gpio-pisosr.c
index f5545049c187..4cca0c4dd85a 100644
--- a/drivers/gpio/gpio-pisosr.c
+++ b/drivers/gpio/gpio-pisosr.c
@@ -17,6 +17,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/spi/spi.h>
 
 #define DEFAULT_NGPIO 8
diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index 3d3d6b6645a7..8d502a83babc 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -19,6 +19,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
 #include <linux/bitops.h>
 #include <linux/gpio.h>
 #include <linux/device.h>
diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 4a1536a050bc..9b2b00974163 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -22,6 +22,7 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
index 16cbc5702865..0e6fae84c759 100644
--- a/drivers/gpio/gpio-stmpe.c
+++ b/drivers/gpio/gpio-stmpe.c
@@ -10,6 +10,8 @@
 #include <linux/slab.h>
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/mfd/stmpe.h>
 #include <linux/seq_file.h>
diff --git a/drivers/gpio/gpio-tc3589x.c b/drivers/gpio/gpio-tc3589x.c
index 433b45ef332e..d0ec9902d9c1 100644
--- a/drivers/gpio/gpio-tc3589x.c
+++ b/drivers/gpio/gpio-tc3589x.c
@@ -12,8 +12,11 @@
 #include <linux/gpio/driver.h>
 #include <linux/of.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/mfd/tc3589x.h>
 #include <linux/bitops.h>
+#include <linux/pinctrl/pinconf-generic.h>
 
 /*
  * These registers are modified under the irq bus lock and cached to avoid
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 88529d3c06c9..5e012377be1e 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -29,6 +29,7 @@
 #include <linux/irqdomain.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pm.h>
 
 #define GPIO_BANK(x)		((x) >> 5)
diff --git a/drivers/gpio/gpio-tps65218.c b/drivers/gpio/gpio-tps65218.c
index a379bba57d31..97dca93b0529 100644
--- a/drivers/gpio/gpio-tps65218.c
+++ b/drivers/gpio/gpio-tps65218.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/gpio/driver.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/mfd/tps65218.h>
diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 521fbe338589..844bf591268b 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -23,6 +23,9 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
diff --git a/drivers/gpio/gpio-vx855.c b/drivers/gpio/gpio-vx855.c
index 98a6f1fcc561..96331a43c2c1 100644
--- a/drivers/gpio/gpio-vx855.c
+++ b/drivers/gpio/gpio-vx855.c
@@ -28,6 +28,7 @@
 #include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/device.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/pci.h>
 #include <linux/io.h>
diff --git a/drivers/gpio/gpio-wcove.c b/drivers/gpio/gpio-wcove.c
index 37c103e50ebf..78161e22a859 100644
--- a/drivers/gpio/gpio-wcove.c
+++ b/drivers/gpio/gpio-wcove.c
@@ -18,8 +18,10 @@
 #include <linux/bitops.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/gpio/driver.h>
 #include <linux/mfd/intel_soc_pmic.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
diff --git a/drivers/gpio/gpio-wm831x.c b/drivers/gpio/gpio-wm831x.c
index 938bbe3f831c..b9f2f95a1309 100644
--- a/drivers/gpio/gpio-wm831x.c
+++ b/drivers/gpio/gpio-wm831x.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/gpio.h>
 #include <linux/mfd/core.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/seq_file.h>
 
diff --git a/drivers/gpio/gpio-wm8994.c b/drivers/gpio/gpio-wm8994.c
index 1e35756ac55b..f2708fa3eefb 100644
--- a/drivers/gpio/gpio-wm8994.c
+++ b/drivers/gpio/gpio-wm8994.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/gpio.h>
 #include <linux/mfd/core.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/seq_file.h>
 #include <linux/regmap.h>
diff --git a/drivers/gpio/gpio-ws16c48.c b/drivers/gpio/gpio-ws16c48.c
index 5037974ac063..9eb42b983c75 100644
--- a/drivers/gpio/gpio-ws16c48.c
+++ b/drivers/gpio/gpio-ws16c48.c
@@ -19,6 +19,7 @@
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/irqdesc.h>
+#include <linux/irqdomain.h>
 #include <linux/isa.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
index 033258634b8c..f0929da6c385 100644
--- a/drivers/gpio/gpio-xgene-sb.c
+++ b/drivers/gpio/gpio-xgene-sb.c
@@ -22,6 +22,8 @@
 
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/platform_device.h>
 #include <linux/of_gpio.h>
 #include <linux/gpio/driver.h>
diff --git a/drivers/gpio/gpio-xlp.c b/drivers/gpio/gpio-xlp.c
index d857e1d8e731..646856127aa6 100644
--- a/drivers/gpio/gpio-xlp.c
+++ b/drivers/gpio/gpio-xlp.c
@@ -17,6 +17,7 @@
 #include <linux/of_device.h>
 #include <linux/module.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/interrupt.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/acpi.h>
diff --git a/drivers/gpio/gpio-zx.c b/drivers/gpio/gpio-zx.c
index be3a87da8438..4259ae6ff44c 100644
--- a/drivers/gpio/gpio-zx.c
+++ b/drivers/gpio/gpio-zx.c
@@ -14,6 +14,7 @@
 #include <linux/errno.h>
 #include <linux/gpio/driver.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index df0851464006..e0a83e32caef 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -15,6 +15,9 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index c9b42dd12dfa..2695a8cc3b71 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -18,6 +18,7 @@
 #include <linux/export.h>
 #include <linux/acpi.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/mutex.h>
 #include <linux/pinctrl/pinctrl.h>
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 9568708a550b..b81269c00381 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3,6 +3,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/device.h>
@@ -17,6 +18,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/cdev.h>
 #include <linux/fs.h>
 #include <linux/uaccess.h>
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index af20369ec8e7..07b595e24695 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -1,21 +1,22 @@
 #ifndef __LINUX_GPIO_DRIVER_H
 #define __LINUX_GPIO_DRIVER_H
 
-#include <linux/device.h>
 #include <linux/types.h>
-#include <linux/irq.h>
-#include <linux/irqchip/chained_irq.h>
-#include <linux/irqdomain.h>
+#include <linux/irqhandler.h>
 #include <linux/lockdep.h>
 #include <linux/pinctrl/pinctrl.h>
-#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/spinlock_types.h>
 
 struct gpio_desc;
 struct of_phandle_args;
+struct device;
 struct device_node;
+struct irq_chip;
+struct irq_domain;
 struct seq_file;
 struct gpio_device;
 struct module;
+struct pinctrl_dev;
 
 #ifdef CONFIG_GPIOLIB
 
-- 
2.7.4

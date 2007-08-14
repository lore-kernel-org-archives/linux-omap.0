From: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
Subject: [PATCH 3/4] SPI: tsc2101 support for tsc2xxx core
Date: Tue, 14 Aug 2007 15:12:52 -0400
Message-ID: <20070814191251.27333.75081.stgit@localhost.localdomain>
References: <20070814191229.27333.62004.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20070814191229.27333.62004.stgit@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: david-b@pacbell.net
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

From: Ragner Magalhaes <ragner.magalhaes@indt.org.br>

Add support for tsc2xxx core api

Signed-off-by: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
---

 arch/arm/mach-omap1/board-h2.c |    1 
 drivers/spi/Kconfig            |    5 +-
 drivers/spi/tsc2101.c          |   94 ++++------------------------------------
 drivers/video/omap/lcd_h2.c    |   10 +++-
 include/linux/spi/tsc2101.h    |   10 ++--
 5 files changed, 26 insertions(+), 94 deletions(-)

diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index d2214ad..67b9f01 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -29,6 +29,7 @@
 #include <linux/input.h>
 #include <linux/workqueue.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/tsc2xxx.h>
 #include <linux/spi/tsc2101.h>
 #include <linux/clk.h>
 
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ceab02e..a4b112a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -217,8 +217,9 @@ config SPI_TSC2XXX
 	default n
 
 config SPI_TSC2101
-       depends on SPI_MASTER
-       tristate "TSC2101 chip support"
+	depends on SPI_MASTER
+	tristate "TSC2101 chip support"
+	select SPI_TSC2XXX
        ---help---
          Say Y here if you want support for the TSC2101 chip.
 	 At the moment it provides basic register read / write interface
diff --git a/drivers/spi/tsc2101.c b/drivers/spi/tsc2101.c
index 71702e2..b044b4c 100644
--- a/drivers/spi/tsc2101.c
+++ b/drivers/spi/tsc2101.c
@@ -22,6 +22,7 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/tsc2xxx.h>
 #include <linux/spi/tsc2101.h>
 
 struct tsc2101_device {
@@ -76,99 +77,22 @@ void tsc2101_disable_mclk(struct spi_device *spi)
 }
 EXPORT_SYMBOL(tsc2101_disable_mclk);
 
-int tsc2101_write_sync(struct spi_device *spi, int page, u8 address, u16 data)
+int tsc2101_write_sync(struct spi_device *spi, u32 reg, u16 data)
 {
-	struct tsc2101_device *tsc2101;
-	struct spi_message *m;
-	struct spi_transfer *t;
-	int ret;
-
-	tsc2101 = spi_get_drvdata(spi);
-
-	mutex_lock(&tsc2101->mutex);
-	if (spi->dev.power.power_state.event != PM_EVENT_ON) {
-		mutex_unlock(&tsc2101->mutex);
-		return -ENODEV;
-	}
-
-	m = &tsc2101->message;
-	spi_message_init(m);
-	t = &tsc2101->transfer[0];
-	memset(t, 0, sizeof(tsc2101->transfer));
-
-	/* Address */
-	tsc2101->command = (page << 11) | (address << 5);
-	t->tx_buf = &tsc2101->command;
-	t->len = 2;
-	spi_message_add_tail(t, m);
-
-	/* Data */
-	t++;
-	t->tx_buf = &data;
-	t->len = 2;
-	spi_message_add_tail(t, m);
-
-	ret = spi_sync(spi, m);
-	if (!ret)
-		ret = tsc2101->message.status;
-	mutex_unlock(&tsc2101->mutex);
-
-	return ret;
+	return tsc2xxx_write_sync(spi, reg, data);
 }
 EXPORT_SYMBOL(tsc2101_write_sync);
 
-int tsc2101_reads_sync(struct spi_device *spi,
-		       int page, u8 startaddress, u16 *data, int numregs)
+int tsc2101_reads_sync(struct spi_device *spi, u32 reg, u16 *data,
+		int numregs)
 {
-	struct tsc2101_device *tsc2101;
-	struct spi_message *m;
-	struct spi_transfer *t;
-	int ret;
-
-	tsc2101 = spi_get_drvdata(spi);
-
-	mutex_lock(&tsc2101->mutex);
-	if (spi->dev.power.power_state.event != PM_EVENT_ON) {
-		mutex_unlock(&tsc2101->mutex);
-		return -ENODEV;
-	}
-
-	m = &tsc2101->message;
-	spi_message_init(m);
-	t = &tsc2101->transfer[0];
-	memset(t, 0, sizeof(tsc2101->transfer));
-
-	/* Address */
-	tsc2101->command = 0x8000 | (page << 11) | (startaddress << 5);
-	t->tx_buf = &tsc2101->command;
-	t->len = 2;
-	spi_message_add_tail(t, m);
-
-	/* Data */
-	t++;
-	t->rx_buf = data;
-	t->len = numregs << 1;
-	spi_message_add_tail(t, m);
-
-	ret = spi_sync(spi, m);
-	if (!ret)
-		ret = tsc2101->message.status;
-
-	mutex_unlock(&tsc2101->mutex);
-
-	return ret;
+	return tsc2xxx_read_buf_sync(spi, reg, data, numregs);
 }
 EXPORT_SYMBOL(tsc2101_reads_sync);
 
-int tsc2101_read_sync(struct spi_device *spi, int page, u8 address)
+u16 tsc2101_read_sync(struct spi_device *spi, u32 reg)
 {
-	int err;
-	u16 val;
-
-	err = tsc2101_reads_sync(spi, page, address, &val, 1);
-	if (err)
-		return err;
-	return val;
+	return tsc2xxx_read_sync(spi, reg);
 }
 EXPORT_SYMBOL(tsc2101_read_sync);
 
@@ -244,7 +168,7 @@ static int tsc2101_probe(struct spi_device *spi)
 		goto err;
 	}
 
-	w = tsc2101_read_sync(spi, 1, 0);
+	w = tsc2101_read_sync(spi, TSC2XXX_REG(1, 0));
 	if (!(w & (1 << 14))) {
 		dev_err(&spi->dev, "invalid ADC register value %04x\n", w);
 		goto err;
diff --git a/drivers/video/omap/lcd_h2.c b/drivers/video/omap/lcd_h2.c
index 7d16b57..fa419eb 100644
--- a/drivers/video/omap/lcd_h2.c
+++ b/drivers/video/omap/lcd_h2.c
@@ -21,6 +21,8 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/tsc2xxx.h>
 #include <linux/spi/tsc2101.h>
 
 #include <asm/arch/mux.h>
@@ -48,7 +50,8 @@ static int h2_panel_enable(struct lcd_panel *panel)
 	 * Assert LCD_EN, BKLIGHT_EN pins on LCD panel
 	 * page2, GPIO config reg, GPIO(0,1) to out and asserted
 	 */
-	r = tsc2101_write_sync(h2_panel_dev.tsc2101_dev, 2, 0x23, 0xcc00);
+	r = tsc2101_write_sync(h2_panel_dev.tsc2101_dev,
+					TSC2XXX_REG(2, 0x23), 0xcc00);
 	if (r < 0)
 		dev_err(&h2_panel_dev.lcd_dev->dev,
 			"failed to enable LCD panel\n");
@@ -58,11 +61,14 @@ static int h2_panel_enable(struct lcd_panel *panel)
 
 static void h2_panel_disable(struct lcd_panel *panel)
 {
+	int r;
 	/*
 	 * Deassert LCD_EN and BKLIGHT_EN pins on LCD panel
 	 * page2, GPIO config reg, GPIO(0,1) to out and deasserted
 	 */
-	if (tsc2101_write_sync(h2_panel_dev.tsc2101_dev, 2, 0x23, 0x8800))
+	r = tsc2101_write_sync(h2_panel_dev.tsc2101_dev,
+					TSC2XXX_REG(2, 0x23), 0x8800);
+	if (r < 0)
 		dev_err(&h2_panel_dev.lcd_dev->dev,
 			"failed to disable LCD panel\n");
 }
diff --git a/include/linux/spi/tsc2101.h b/include/linux/spi/tsc2101.h
index 01e6d23..af8815f 100644
--- a/include/linux/spi/tsc2101.h
+++ b/include/linux/spi/tsc2101.h
@@ -30,11 +30,11 @@ struct tsc2101_platform_data {
 	void	(*disable_mclk)(struct spi_device *spi);
 };
 
-extern int tsc2101_read_sync(struct spi_device *spi, int page, u8 address);
-extern int tsc2101_reads_sync(struct spi_device *spi, int page,
-			       u8 startaddress, u16 * data, int numregs);
-extern int tsc2101_write_sync(struct spi_device *spi, int page, u8 address,
-			       u16 data);
+extern u16 tsc2101_read_sync(struct spi_device *spi, u32 reg);
+extern int tsc2101_reads_sync(struct spi_device *spi, u32 reg,
+		u16 *data, int numregs);
+extern int tsc2101_write_sync(struct spi_device *spi, u32 reg,
+		u16 data);
 
 extern int tsc2101_enable_mclk(struct spi_device *spi);
 extern void tsc2101_disable_mclk(struct spi_device *spi);

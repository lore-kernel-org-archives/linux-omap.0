From: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
Subject: [PATCH 2/4] SPI: tsc2301 support for tsc2xxx core
Date: Tue, 14 Aug 2007 15:12:41 -0400
Message-ID: <20070814191241.27333.31173.stgit@localhost.localdomain>
References: <20070814191229.27333.62004.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070814191229.27333.62004.stgit@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: david-b@pacbell.net
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

From: Ragner Magalhaes <ragner.magalhaes@indt.org.br>

Add support for tsc2xxx core api

Signed-off-by: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
---

 drivers/spi/Kconfig         |    1 
 drivers/spi/tsc2301-core.c  |   94 ++++---------------------------------------
 include/linux/spi/tsc2301.h |   50 +++++++++++------------
 3 files changed, 32 insertions(+), 113 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index e612fc7..ceab02e 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -246,6 +246,7 @@ config SPI_TSC210X
 config SPI_TSC2301
 	tristate "TSC2301 driver"
 	depends on SPI_MASTER
+	select SPI_TSC2XXX
 	help
 	  Say Y here if you have a TSC2301 chip connected to an SPI
 	  bus on your board.
diff --git a/drivers/spi/tsc2301-core.c b/drivers/spi/tsc2301-core.c
index 500c3dc..f686287 100644
--- a/drivers/spi/tsc2301-core.c
+++ b/drivers/spi/tsc2301-core.c
@@ -23,62 +23,13 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/tsc2xxx.h>
 #include <linux/spi/tsc2301.h>
 
 #ifdef CONFIG_ARCH_OMAP
 #include <asm/arch/gpio.h>
 #endif
 
-u16 tsc2301_read_reg(struct tsc2301 *tsc, int reg)
-{
-	struct spi_transfer t[2];
-	struct spi_message m;
-	u16 data = 0, cmd;
-
-	cmd = reg;
-	cmd |= 0x8000;
-
-	memset(t, 0, sizeof(t));
-	spi_message_init(&m);
-	m.spi = tsc->spi;
-
-	t[0].tx_buf = &cmd;
-	t[0].rx_buf = NULL;
-	t[0].len = 2;
-	spi_message_add_tail(&t[0], &m);
-
-	t[1].tx_buf = NULL;
-	t[1].rx_buf = &data;
-	t[1].len = 2;
-	spi_message_add_tail(&t[1], &m);
-
-	spi_sync(m.spi, &m);
-
-	return data;
-}
-
-void tsc2301_write_reg(struct tsc2301 *tsc, int reg, u16 val)
-{
-	struct spi_transfer t;
-	struct spi_message m;
-	u16 data[2];
-
-	/* Now we prepare the command for transferring */
-	data[0] = reg;
-	data[1] = val;
-
-	spi_message_init(&m);
-	m.spi = tsc->spi;
-
-	memset(&t, 0, sizeof(t));
-	t.tx_buf = data;
-	t.rx_buf = NULL;
-	t.len = 4;
-	spi_message_add_tail(&t, &m);
-
-	spi_sync(m.spi, &m);
-}
-
 void tsc2301_write_kbc(struct tsc2301 *tsc, int val)
 {
 	u16 w;
@@ -86,7 +37,7 @@ void tsc2301_write_kbc(struct tsc2301 *tsc, int val)
 	w = tsc->config2_shadow;
 	w &= ~(0x03 << 14);
 	w |= (val & 0x03) << 14;
-	tsc2301_write_reg(tsc, TSC2301_REG_CONFIG2, w);
+	tsc2xxx_write_sync(tsc->spi, TSC2301_REG_CONFIG2, w);
 	tsc->config2_shadow = w;
 }
 
@@ -100,39 +51,10 @@ void tsc2301_write_pll(struct tsc2301 *tsc,
 	w |= (pll_n & 0x0f) | ((pll_a & 0x0f) << 4) | ((pll_pdc & 0x0f) << 8);
 	w |= pct_e ? (1 << 12) : 0;
 	w |= pll_o ? (1 << 13) : 0;
-	tsc2301_write_reg(tsc, TSC2301_REG_CONFIG2, w);
+	tsc2xxx_write_sync(tsc->spi, TSC2301_REG_CONFIG2, w);
 	tsc->config2_shadow = w;
 }
 
-void tsc2301_read_buf(struct tsc2301 *tsc, int reg, u16 *rx_buf, int len)
-{
-	struct spi_transfer t[2];
-	struct spi_message m;
-	u16 cmd, i;
-
-	cmd = reg;
-	cmd |= 0x8000;
-
-	spi_message_init(&m);
-	m.spi = tsc->spi;
-
-	memset(t, 0, sizeof(t));
-	t[0].tx_buf = &cmd;
-	t[0].rx_buf = NULL;
-	t[0].len = 2;
-	spi_message_add_tail(&t[0], &m);
-
-	t[1].tx_buf = NULL;
-	t[1].rx_buf = rx_buf;
-	t[1].len = 2 * len;
-	spi_message_add_tail(&t[1], &m);
-
-	spi_sync(m.spi, &m);
-
-	for (i = 0; i < len; i++)
-		printk(KERN_DEBUG "rx_buf[%d]: %04x\n", i, rx_buf[i]);
-}
-
 static int __devinit tsc2301_probe(struct spi_device *spi)
 {
 	struct tsc2301			*tsc;
@@ -179,17 +101,17 @@ static int __devinit tsc2301_probe(struct spi_device *spi)
 	spi_setup(spi);
 
 	/* Soft reset */
-	tsc2301_write_reg(tsc, TSC2301_REG_RESET, 0xbb00);
+	tsc2xxx_write_sync(tsc->spi, TSC2301_REG_RESET, 0xbb00);
 	msleep(1);
 
-	w = tsc2301_read_reg(tsc, TSC2301_REG_ADC);
+	w = tsc2xxx_read_sync(tsc->spi, TSC2301_REG_ADC);
 	if (!(w & (1 << 14))) {
 		dev_err(&spi->dev, "invalid ADC reg value: %04x\n", w);
 		r = -ENODEV;
 		goto err1;
 	}
 
-	w = tsc2301_read_reg(tsc, TSC2301_REG_DAC);
+	w = tsc2xxx_read_sync(tsc->spi, TSC2301_REG_DAC);
 	if (!(w & (1 << 15))) {
 		dev_err(&spi->dev, "invalid DAC reg value: %04x\n", w);
 		r = -ENODEV;
@@ -197,11 +119,11 @@ static int __devinit tsc2301_probe(struct spi_device *spi)
 	}
 
 	/* Stop keypad scanning */
-	tsc2301_write_reg(tsc, TSC2301_REG_KEY, 0x4000);
+	tsc2xxx_write_sync(tsc->spi, TSC2301_REG_KEY, 0x4000);
 
 	/* We have to cache this for read-modify-write, since we can't
 	 * read back BIT15 */
-	w = tsc2301_read_reg(tsc, TSC2301_REG_CONFIG2);
+	w = tsc2xxx_read_sync(tsc->spi, TSC2301_REG_CONFIG2);
 	/* By default BIT15 is set */
 	w |= 1 << 15;
 	tsc->config2_shadow = w;
diff --git a/include/linux/spi/tsc2301.h b/include/linux/spi/tsc2301.h
index 059cc58..186485c 100644
--- a/include/linux/spi/tsc2301.h
+++ b/include/linux/spi/tsc2301.h
@@ -83,33 +83,29 @@ struct tsc2301 {
 
 #define TSC2301_HZ	33000000
 
-#define TSC2301_REG(page, addr)  (((page) << 11) | ((addr) << 5))
-#define TSC2301_REG_TO_PAGE(reg) (((reg) >> 11) & 0x03)
-#define TSC2301_REG_TO_ADDR(reg) (((reg) >> 5)  & 0x1f)
-
-#define TSC2301_REG_X		TSC2301_REG(0, 0)
-#define TSC2301_REG_Y		TSC2301_REG(0, 1)
-#define TSC2301_REG_Z1		TSC2301_REG(0, 2)
-#define TSC2301_REG_Z2		TSC2301_REG(0, 3)
-#define TSC2301_REG_KPDATA	TSC2301_REG(0, 4)
-#define TSC2301_REG_ADC		TSC2301_REG(1, 0)
-#define TSC2301_REG_KEY		TSC2301_REG(1, 1)
-#define TSC2301_REG_DAC		TSC2301_REG(1, 2)
-#define TSC2301_REG_REF		TSC2301_REG(1, 3)
-#define TSC2301_REG_RESET	TSC2301_REG(1, 4)
-#define TSC2301_REG_CONFIG	TSC2301_REG(1, 5)
-#define TSC2301_REG_CONFIG2	TSC2301_REG(1, 6)
-#define TSC2301_REG_KPMASK	TSC2301_REG(1, 16)
-#define TSC2301_REG_AUDCNTL	TSC2301_REG(2, 0)
-#define TSC2301_REG_ADCVOL	TSC2301_REG(2, 1)
-#define TSC2301_REG_DACVOL	TSC2301_REG(2, 2)
-#define TSC2301_REG_BPVOL	TSC2301_REG(2, 3)
-#define TSC2301_REG_KEYCTL	TSC2301_REG(2, 4)
-#define TSC2301_REG_PD_MISC	TSC2301_REG(2, 5)
-#define TSC2301_REG_GPIO	TSC2301_REG(2, 6)
-#define TSC2301_REG_ADCLKCFG	TSC2301_REG(2, 27)
-
-#define TSC2301_REG_PD_MISC_APD		(1 << 15)
+#define TSC2301_REG_X		TSC2XXX_REG(0, 0)
+#define TSC2301_REG_Y		TSC2XXX_REG(0, 1)
+#define TSC2301_REG_Z1		TSC2XXX_REG(0, 2)
+#define TSC2301_REG_Z2		TSC2XXX_REG(0, 3)
+#define TSC2301_REG_KPDATA	TSC2XXX_REG(0, 4)
+#define TSC2301_REG_ADC 	TSC2XXX_REG(1, 0)
+#define TSC2301_REG_KEY 	TSC2XXX_REG(1, 1)
+#define TSC2301_REG_DAC 	TSC2XXX_REG(1, 2)
+#define TSC2301_REG_REF 	TSC2XXX_REG(1, 3)
+#define TSC2301_REG_RESET	TSC2XXX_REG(1, 4)
+#define TSC2301_REG_CONFIG	TSC2XXX_REG(1, 5)
+#define TSC2301_REG_CONFIG2	TSC2XXX_REG(1, 6)
+#define TSC2301_REG_KPMASK	TSC2XXX_REG(1, 16)
+#define TSC2301_REG_AUDCNTL	TSC2XXX_REG(2, 0)
+#define TSC2301_REG_ADCVOL	TSC2XXX_REG(2, 1)
+#define TSC2301_REG_DACVOL	TSC2XXX_REG(2, 2)
+#define TSC2301_REG_BPVOL	TSC2XXX_REG(2, 3)
+#define TSC2301_REG_KEYCTL	TSC2XXX_REG(2, 4)
+#define TSC2301_REG_PD_MISC	TSC2XXX_REG(2, 5)
+#define TSC2301_REG_GPIO	TSC2XXX_REG(2, 6)
+#define TSC2301_REG_ADCLKCFG	TSC2XXX_REG(2, 27)
+
+#define TSC2301_REG_PD_MISC_APD 	(1 << 15)
 #define TSC2301_REG_PD_MISC_AVPD	(1 << 14)
 #define TSC2301_REG_PD_MISC_ABPD	(1 << 13)
 #define TSC2301_REG_PD_MISC_HAPD	(1 << 12)

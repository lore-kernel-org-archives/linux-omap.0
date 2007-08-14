From: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
Subject: [PATCH 1/4] SPI: tsc2xxx core
Date: Tue, 14 Aug 2007 15:12:29 -0400
Message-ID: <20070814191229.27333.62004.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

This is the start to build tsc2xxx core with all sharable routines
between tsc2101, tsc2102, tsc2301 ... and more later tsc2100, tsc2111, etc.

Signed-off-by: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
---

 drivers/spi/Kconfig         |    4 +
 drivers/spi/Makefile        |    1 
 drivers/spi/tsc2xxx.c       |  227 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/tsc2xxx.h |   40 ++++++++
 4 files changed, 272 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4f43b97..e612fc7 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -212,6 +212,10 @@ config SPI_AT25
 	  This driver can also be built as a module.  If so, the module
 	  will be called at25.
 
+config SPI_TSC2XXX
+	tristate
+	default n
+
 config SPI_TSC2101
        depends on SPI_MASTER
        tristate "TSC2101 chip support"
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 78d02bd..05fc03e 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_SPI_XILINX)		+= xilinx_spi.o
 obj-$(CONFIG_SPI_AT25)		+= at25.o
 obj-$(CONFIG_SPI_SPIDEV)	+= spidev.o
 obj-$(CONFIG_SPI_TLE62X0)	+= tle62x0.o
+obj-$(CONFIG_SPI_TSC2XXX)	+= tsc2xxx.o
 obj-$(CONFIG_SPI_TSC2101)	+= tsc2101.o
 obj-$(CONFIG_SPI_TSC2102)	+= tsc2102.o
 obj-$(CONFIG_SPI_TSC210X)	+= tsc210x.o
diff --git a/drivers/spi/tsc2xxx.c b/drivers/spi/tsc2xxx.c
new file mode 100644
index 0000000..14d46d8
--- /dev/null
+++ b/drivers/spi/tsc2xxx.c
@@ -0,0 +1,227 @@
+/*
+ * drivers/spi/tsc2xxx.c
+ *
+ * Copyright (C) 2007, Ragner Magalhaes <ragner.magalhaes@indt.org.br>
+ *
+ * TSC2xxx core.
+ *
+ * Sharable core routines (tsc2101, tsc2102 and tsc2301).
+ *
+ * Licensed under the GPLv2 only.
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/tsc2xxx.h>
+
+u16 tsc2xxx_read_sync(struct spi_device *spi, u32 reg)
+{
+	struct spi_transfer t[2];
+	struct spi_message m;
+	u16 data 	= 0;
+	u16 cmd 	= 0x8000 | reg;
+
+	memset(t, 0, sizeof(t));
+	spi_message_init(&m);
+	m.spi = spi;
+
+	t[0].tx_buf = &cmd;
+	t[0].rx_buf = NULL;
+	t[0].len = 2;
+	spi_message_add_tail(&t[0], &m);
+
+	t[1].tx_buf = NULL;
+	t[1].rx_buf = &data;
+	t[1].len = 2;
+	spi_message_add_tail(&t[1], &m);
+
+	spi_sync(m.spi, &m);
+
+	return data;
+}
+EXPORT_SYMBOL(tsc2xxx_read_sync);
+
+int tsc2xxx_write_sync(struct spi_device *spi, u32 reg, u16 val)
+{
+	struct spi_transfer t[2];
+	struct spi_message m;
+	u16 data 	= val;
+	u16 cmd 	= reg;
+
+	memset(t, 0, sizeof(t));
+	spi_message_init(&m);
+	m.spi = spi;
+
+	t[0].tx_buf = &cmd;
+	t[0].rx_buf = NULL;
+	t[0].len = 2;
+	spi_message_add_tail(&t[0], &m);
+
+	t[1].tx_buf = &data;
+	t[1].rx_buf = NULL;
+	t[1].len = 2;
+	spi_message_add_tail(&t[1], &m);
+
+	spi_sync(m.spi, &m);
+
+	spi_sync(m.spi, &m);
+
+	return (m.status);
+}
+EXPORT_SYMBOL(tsc2xxx_write_sync);
+
+u16 tsc2xxx_read_async(struct spi_device *spi, u32 reg,
+		void (*complete)(void *context))
+{
+	struct spi_transfer t[2];
+	struct spi_message m;
+	u16 data 	= 0;
+	u16 cmd 	= 0x8000 | reg;
+
+	memset(t, 0, sizeof(t));
+	spi_message_init(&m);
+	m.spi = spi;
+
+	m.complete = complete;
+	m.context = spi_get_drvdata(spi);
+
+	t[0].tx_buf = &cmd;
+	t[0].rx_buf = NULL;
+	t[0].len = 2;
+	spi_message_add_tail(&t[0], &m);
+
+	t[1].tx_buf = NULL;
+	t[1].rx_buf = &data;
+	t[1].len = 2;
+	spi_message_add_tail(&t[1], &m);
+
+	spi_async(m.spi, &m);
+
+	return data;
+}
+EXPORT_SYMBOL(tsc2xxx_read_async);
+
+int tsc2xxx_write_async(struct spi_device *spi, u32 reg, u16 val,
+		void (*complete)(void *context))
+{
+	struct spi_transfer t[2];
+	struct spi_message m;
+	u16 data 	= val;
+	u16 cmd 	= reg;
+
+	memset(t, 0, sizeof(t));
+	spi_message_init(&m);
+	m.spi = spi;
+
+	m.complete = complete;
+	m.context = spi_get_drvdata(spi);
+
+	t[0].tx_buf = &cmd;
+	t[0].rx_buf = NULL;
+	t[0].len = 2;
+	spi_message_add_tail(&t[0], &m);
+
+	t[1].tx_buf = &data;
+	t[1].rx_buf = NULL;
+	t[1].len = 2;
+	spi_message_add_tail(&t[1], &m);
+
+	spi_async(m.spi, &m);
+
+	return (m.status);
+}
+EXPORT_SYMBOL(tsc2xxx_write_async);
+
+#ifdef DEBUG
+
+static inline void dump_rx_buf(struct spi_device *spi, u16 *buf, u32 len)
+{
+	struct device *dev = &spi->dev;
+	u32 i;
+	for (i = 0; i < len; i++)
+		dev_dbg(dev, "rx_buf[%d]: %04x\n", i, buf[i]);
+}
+
+#else
+
+static inline void dump_rx_buf(struct spi_device *spi, u16 *buf, u32 len)
+{}
+
+#endif /* DUMP_MSG */
+
+int tsc2xxx_read_buf_sync(struct spi_device *spi, u32 reg, u16 *buf, u32 len)
+{
+	struct spi_transfer t[2];
+	struct spi_message m;
+	u16 cmd 	= 0x8000 | reg;
+
+	memset(t, 0, sizeof(t));
+	spi_message_init(&m);
+	m.spi = spi;
+
+	t[0].tx_buf = &cmd;
+	t[0].rx_buf = NULL;
+	t[0].len = 2;
+	spi_message_add_tail(&t[0], &m);
+
+	t[1].tx_buf = NULL;
+	t[1].rx_buf = buf;
+	t[1].len = 2 * len;
+	spi_message_add_tail(&t[1], &m);
+
+	spi_sync(m.spi, &m);
+
+	dump_rx_buf(spi, buf, len);
+
+	return (m.status);
+}
+EXPORT_SYMBOL(tsc2xxx_read_buf_sync);
+
+int tsc2xxx_read_buf_async(struct spi_device *spi, u32 reg, u16 *buf, u32 len,
+		void (*complete)(void *context))
+{
+	struct spi_transfer t[2];
+	struct spi_message m;
+	u16 cmd 	= 0x8000 | reg;
+
+	memset(t, 0, sizeof(t));
+	spi_message_init(&m);
+	m.spi = spi;
+
+	m.complete = complete;
+	m.context = spi_get_drvdata(spi);
+
+	t[0].tx_buf = &cmd;
+	t[0].rx_buf = NULL;
+	t[0].len = 2;
+	spi_message_add_tail(&t[0], &m);
+
+	t[1].tx_buf = NULL;
+	t[1].rx_buf = buf;
+	t[1].len = 2 * len;
+	spi_message_add_tail(&t[1], &m);
+
+	spi_sync(m.spi, &m);
+
+	dump_rx_buf(spi, buf, len);
+
+	return (m.status);
+}
+EXPORT_SYMBOL(tsc2xxx_read_buf_async);
+
+static int __init tsc2xxx_init(void)
+{
+	return 0;
+}
+
+static void __exit tsc2xxx_exit(void)
+{
+}
+
+module_init(tsc2xxx_init)
+module_exit(tsc2xxx_exit)
+
+MODULE_AUTHOR("Ragner Magalhaes");
+MODULE_DESCRIPTION("TSC2xxx family sharable routines.");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/spi/tsc2xxx.h b/include/linux/spi/tsc2xxx.h
new file mode 100644
index 0000000..ddfc68c
--- /dev/null
+++ b/include/linux/spi/tsc2xxx.h
@@ -0,0 +1,40 @@
+/*
+ * include/linux/spi/tsc2xxx.h
+ *
+ * Copyright (C) 2007, Ragner Magalhaes <ragner.magalhaes@indt.org.br>
+ *
+ * TSC2xxx core.
+ *
+ * Sharable core routines (tsc2101, tsc2102 and tsc2301).
+ *
+ * Licensed under the GPLv2 only.
+ */
+
+#ifndef _LINUX_SPI_TSC2XXX_H
+#define _LINUX_SPI_TSC2XXX_H
+
+struct tsc210x_spi_req {
+	struct spi_device *dev;
+	u16 command;
+	u16 data;
+	struct spi_message message;
+};
+
+#define TSC2XXX_REG(page, addr)  (((page) << 11) | ((addr) << 5))
+#define TSC2XXX_REG_TO_PAGE(reg) (((reg) >> 11) & 0x03)
+#define TSC2XXX_REG_TO_ADDR(reg) (((reg) >> 5)  & 0x1f)
+
+extern u16 tsc2xxx_read_sync(struct spi_device *spi, u32 reg);
+extern int tsc2xxx_write_sync(struct spi_device *spi, u32 reg, u16 val);
+
+extern u16 tsc2xxx_read_async(struct spi_device *spi, u32 reg,
+		void (*complete)(void *context));
+extern int tsc2xxx_write_async(struct spi_device *spi, u32 reg, u16 val,
+		void (*complete)(void *context));
+
+extern int tsc2xxx_read_buf_sync(struct spi_device *spi, u32 reg, u16 *buf,
+		u32 len);
+extern int tsc2xxx_read_buf_async(struct spi_device *spi, u32 reg, u16 *buf,
+		u32 len, void (*complete)(void *context));
+
+#endif /* _LINUX_SPI_TSC2XXX_H */

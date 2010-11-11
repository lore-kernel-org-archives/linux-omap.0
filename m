From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 2/7] OMAP: mux: Add support for control module split in several partitions
Date: Thu, 11 Nov 2010 22:35:16 +0100
Message-ID: <1289511321-18532-3-git-send-email-b-cousson@ti.com>
References: <1289511321-18532-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50090 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360Ab0KKVgG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Nov 2010 16:36:06 -0500
In-Reply-To: <1289511321-18532-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Starting on OMAP4, the pin mux configuration is located in two
different partitions of the control module (CODE_PAD and WKUP_PAD).
The first one is inside the core power domain whereas the second
one is inside the wakeup.
- Add the capability to add any number of partition during board init
time depending of Soc partitioning.
- Add some init flags as well in order to avoid explicit Soc version
check inside the mux core code.
- Add a comment with mux0 mode on top of omap_mux/board/<partition>
if the current mux mode is not the default one.

Thanks to Tony Lindgren <tony@atomide.com> for the following improvements:
- Add omap_mux_get for getting the partition data so platform level
device code can use it.
- Fix the rx51 board code to use the new API.

Thanks to Dan Murphy <dmurphy@ti.com> for testing on OMAP4 and reporting
a couple of bugs.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Tested-by: Murphy Dan <dmurphy@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   12 +-
 arch/arm/mach-omap2/mux.c                    |  310 +++++++++++++++++---------
 arch/arm/mach-omap2/mux.h                    |   71 +++++-
 arch/arm/mach-omap2/mux2420.c                |    7 +-
 arch/arm/mach-omap2/mux2430.c                |    7 +-
 arch/arm/mach-omap2/mux34xx.c                |    7 +-
 6 files changed, 286 insertions(+), 128 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 3fec4d6..3fda20d 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -293,6 +293,8 @@ static struct omap_board_mux rx51_mmc2_off_mux[] = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 
+static struct omap_mux_partition *partition;
+
 /*
  * Current flows to eMMC when eMMC is off and the data lines are pulled up,
  * so pull them down. N.B. we pull 8 lines because we are using 8 lines.
@@ -300,9 +302,9 @@ static struct omap_board_mux rx51_mmc2_off_mux[] = {
 static void rx51_mmc2_remux(struct device *dev, int slot, int power_on)
 {
 	if (power_on)
-		omap_mux_write_array(rx51_mmc2_on_mux);
+		omap_mux_write_array(partition, rx51_mmc2_on_mux);
 	else
-		omap_mux_write_array(rx51_mmc2_off_mux);
+		omap_mux_write_array(partition, rx51_mmc2_off_mux);
 }
 
 static struct omap2_hsmmc_info mmc[] __initdata = {
@@ -922,7 +924,11 @@ void __init rx51_peripherals_init(void)
 	rx51_init_wl1251();
 	spi_register_board_info(rx51_peripherals_spi_board_info,
 				ARRAY_SIZE(rx51_peripherals_spi_board_info));
-	omap2_hsmmc_init(mmc);
+
+	partition = omap_mux_get("core");
+	if (partition)
+		omap2_hsmmc_init(mmc);
+
 	platform_device_register(&rx51_charger_device);
 }
 
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 979e9d1..fa139ff 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -1,9 +1,9 @@
 /*
  * linux/arch/arm/mach-omap2/mux.c
  *
- * OMAP2 and OMAP3 pin multiplexing configurations
+ * OMAP2, OMAP3 and OMAP4 pin multiplexing configurations
  *
- * Copyright (C) 2004 - 2008 Texas Instruments Inc.
+ * Copyright (C) 2004 - 2010 Texas Instruments Inc.
  * Copyright (C) 2003 - 2008 Nokia Corporation
  *
  * Written by Tony Lindgren
@@ -40,60 +40,72 @@
 
 #define OMAP_MUX_BASE_OFFSET		0x30	/* Offset from CTRL_BASE */
 #define OMAP_MUX_BASE_SZ		0x5ca
-#define MUXABLE_GPIO_MODE3		BIT(0)
 
 struct omap_mux_entry {
 	struct omap_mux		mux;
 	struct list_head	node;
 };
 
-static unsigned long mux_phys;
-static void __iomem *mux_base;
-static u8 omap_mux_flags;
+static LIST_HEAD(mux_partitions);
+static DEFINE_MUTEX(muxmode_mutex);
+
+struct omap_mux_partition *omap_mux_get(const char *name)
+{
+	struct omap_mux_partition *partition;
+
+	list_for_each_entry(partition, &mux_partitions, node) {
+		if (!strcmp(name, partition->name))
+			return partition;
+	}
+
+	return NULL;
+}
 
-u16 omap_mux_read(u16 reg)
+u16 omap_mux_read(struct omap_mux_partition *partition, u16 reg)
 {
-	if (cpu_is_omap24xx())
-		return __raw_readb(mux_base + reg);
+	if (partition->flags & OMAP_MUX_REG_8BIT)
+		return __raw_readb(partition->base + reg);
 	else
-		return __raw_readw(mux_base + reg);
+		return __raw_readw(partition->base + reg);
 }
 
-void omap_mux_write(u16 val, u16 reg)
+void omap_mux_write(struct omap_mux_partition *partition, u16 val,
+			   u16 reg)
 {
-	if (cpu_is_omap24xx())
-		__raw_writeb(val, mux_base + reg);
+	if (partition->flags & OMAP_MUX_REG_8BIT)
+		__raw_writeb(val, partition->base + reg);
 	else
-		__raw_writew(val, mux_base + reg);
+		__raw_writew(val, partition->base + reg);
 }
 
-void omap_mux_write_array(struct omap_board_mux *board_mux)
+void omap_mux_write_array(struct omap_mux_partition *partition,
+				 struct omap_board_mux *board_mux)
 {
-	while (board_mux->reg_offset !=  OMAP_MUX_TERMINATOR) {
-		omap_mux_write(board_mux->value, board_mux->reg_offset);
+	while (board_mux->reg_offset != OMAP_MUX_TERMINATOR) {
+		omap_mux_write(partition, board_mux->value,
+			       board_mux->reg_offset);
 		board_mux++;
 	}
 }
 
-static LIST_HEAD(muxmodes);
-static DEFINE_MUTEX(muxmode_mutex);
-
 #ifdef CONFIG_OMAP_MUX
 
 static char *omap_mux_options;
 
-int __init omap_mux_init_gpio(int gpio, int val)
+static int __init _omap_mux_init_gpio(struct omap_mux_partition *partition,
+				      int gpio, int val)
 {
 	struct omap_mux_entry *e;
 	struct omap_mux *gpio_mux = NULL;
 	u16 old_mode;
 	u16 mux_mode;
 	int found = 0;
+	struct list_head *muxmodes = &partition->muxmodes;
 
 	if (!gpio)
 		return -EINVAL;
 
-	list_for_each_entry(e, &muxmodes, node) {
+	list_for_each_entry(e, muxmodes, node) {
 		struct omap_mux *m = &e->mux;
 		if (gpio == m->gpio) {
 			gpio_mux = m;
@@ -112,24 +124,40 @@ int __init omap_mux_init_gpio(int gpio, int val)
 		return -EINVAL;
 	}
 
-	old_mode = omap_mux_read(gpio_mux->reg_offset);
+	old_mode = omap_mux_read(partition, gpio_mux->reg_offset);
 	mux_mode = val & ~(OMAP_MUX_NR_MODES - 1);
-	if (omap_mux_flags & MUXABLE_GPIO_MODE3)
+	if (partition->flags & OMAP_MUX_GPIO_IN_MODE3)
 		mux_mode |= OMAP_MUX_MODE3;
 	else
 		mux_mode |= OMAP_MUX_MODE4;
 	pr_debug("mux: Setting signal %s.gpio%i 0x%04x -> 0x%04x\n",
 		 gpio_mux->muxnames[0], gpio, old_mode, mux_mode);
-	omap_mux_write(mux_mode, gpio_mux->reg_offset);
+	omap_mux_write(partition, mux_mode, gpio_mux->reg_offset);
 
 	return 0;
 }
 
-int __init omap_mux_init_signal(const char *muxname, int val)
+int __init omap_mux_init_gpio(int gpio, int val)
+{
+	struct omap_mux_partition *partition;
+	int ret;
+
+	list_for_each_entry(partition, &mux_partitions, node) {
+		ret = _omap_mux_init_gpio(partition, gpio, val);
+		if (!ret)
+			return ret;
+	}
+
+	return -ENODEV;
+}
+
+static int __init _omap_mux_init_signal(struct omap_mux_partition *partition,
+					const char *muxname, int val)
 {
 	struct omap_mux_entry *e;
 	const char *mode_name;
 	int found = 0, mode0_len = 0;
+	struct list_head *muxmodes = &partition->muxmodes;
 
 	mode_name = strchr(muxname, '.');
 	if (mode_name) {
@@ -139,7 +167,7 @@ int __init omap_mux_init_signal(const char *muxname, int val)
 		mode_name = muxname;
 	}
 
-	list_for_each_entry(e, &muxmodes, node) {
+	list_for_each_entry(e, muxmodes, node) {
 		struct omap_mux *m = &e->mux;
 		char *m0_entry = m->muxnames[0];
 		int i;
@@ -159,12 +187,14 @@ int __init omap_mux_init_signal(const char *muxname, int val)
 				u16 old_mode;
 				u16 mux_mode;
 
-				old_mode = omap_mux_read(m->reg_offset);
+				old_mode = omap_mux_read(partition,
+							 m->reg_offset);
 				mux_mode = val | i;
 				pr_debug("mux: Setting signal "
 					 "%s.%s 0x%04x -> 0x%04x\n",
 					 m0_entry, muxname, old_mode, mux_mode);
-				omap_mux_write(mux_mode, m->reg_offset);
+				omap_mux_write(partition, mux_mode,
+					       m->reg_offset);
 				found++;
 			}
 		}
@@ -184,6 +214,21 @@ int __init omap_mux_init_signal(const char *muxname, int val)
 	return -ENODEV;
 }
 
+int __init omap_mux_init_signal(const char *muxname, int val)
+{
+	struct omap_mux_partition *partition;
+	int ret;
+
+	list_for_each_entry(partition, &mux_partitions, node) {
+		ret = _omap_mux_init_signal(partition, muxname, val);
+		if (!ret)
+			return ret;
+	}
+
+	return -ENODEV;
+
+}
+
 #ifdef CONFIG_DEBUG_FS
 
 #define OMAP_MUX_MAX_NR_FLAGS	10
@@ -248,13 +293,15 @@ static inline void omap_mux_decode(struct seq_file *s, u16 val)
 	} while (i-- > 0);
 }
 
-#define OMAP_MUX_DEFNAME_LEN	16
+#define OMAP_MUX_DEFNAME_LEN	32
 
 static int omap_mux_dbg_board_show(struct seq_file *s, void *unused)
 {
+	struct omap_mux_partition *partition = s->private;
 	struct omap_mux_entry *e;
+	u8 omap_gen = omap_rev() >> 28;
 
-	list_for_each_entry(e, &muxmodes, node) {
+	list_for_each_entry(e, &partition->muxmodes, node) {
 		struct omap_mux *m = &e->mux;
 		char m0_def[OMAP_MUX_DEFNAME_LEN];
 		char *m0_name = m->muxnames[0];
@@ -272,11 +319,16 @@ static int omap_mux_dbg_board_show(struct seq_file *s, void *unused)
 			}
 			m0_def[i] = toupper(m0_name[i]);
 		}
-		val = omap_mux_read(m->reg_offset);
+		val = omap_mux_read(partition, m->reg_offset);
 		mode = val & OMAP_MUX_MODE7;
-
-		seq_printf(s, "OMAP%i_MUX(%s, ",
-					cpu_is_omap34xx() ? 3 : 0, m0_def);
+		if (mode != 0)
+			seq_printf(s, "/* %s */\n", m->muxnames[mode]);
+
+		/*
+		 * XXX: Might be revisited to support differences accross
+		 * same OMAP generation.
+		 */
+		seq_printf(s, "OMAP%d_MUX(%s, ", omap_gen, m0_def);
 		omap_mux_decode(s, val);
 		seq_printf(s, "),\n");
 	}
@@ -286,7 +338,7 @@ static int omap_mux_dbg_board_show(struct seq_file *s, void *unused)
 
 static int omap_mux_dbg_board_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, omap_mux_dbg_board_show, &inode->i_private);
+	return single_open(file, omap_mux_dbg_board_show, inode->i_private);
 }
 
 static const struct file_operations omap_mux_dbg_board_fops = {
@@ -299,16 +351,17 @@ static const struct file_operations omap_mux_dbg_board_fops = {
 static int omap_mux_dbg_signal_show(struct seq_file *s, void *unused)
 {
 	struct omap_mux *m = s->private;
+	struct omap_mux_partition *partition = m->partition;
 	const char *none = "NA";
 	u16 val;
 	int mode;
 
-	val = omap_mux_read(m->reg_offset);
+	val = omap_mux_read(partition, m->reg_offset);
 	mode = val & OMAP_MUX_MODE7;
 
-	seq_printf(s, "name: %s.%s (0x%08lx/0x%03x = 0x%04x), b %s, t %s\n",
+	seq_printf(s, "name: %s.%s (0x%08x/0x%03x = 0x%04x), b %s, t %s\n",
 			m->muxnames[0], m->muxnames[mode],
-			mux_phys + m->reg_offset, m->reg_offset, val,
+			partition->phys + m->reg_offset, m->reg_offset, val,
 			m->balls[0] ? m->balls[0] : none,
 			m->balls[1] ? m->balls[1] : none);
 	seq_printf(s, "mode: ");
@@ -330,8 +383,8 @@ static int omap_mux_dbg_signal_show(struct seq_file *s, void *unused)
 #define OMAP_MUX_MAX_ARG_CHAR  7
 
 static ssize_t omap_mux_dbg_signal_write(struct file *file,
-						const char __user *user_buf,
-						size_t count, loff_t *ppos)
+					 const char __user *user_buf,
+					 size_t count, loff_t *ppos)
 {
 	char buf[OMAP_MUX_MAX_ARG_CHAR];
 	struct seq_file *seqf;
@@ -358,7 +411,7 @@ static ssize_t omap_mux_dbg_signal_write(struct file *file,
 	seqf = file->private_data;
 	m = seqf->private;
 
-	omap_mux_write((u16)val, m->reg_offset);
+	omap_mux_write(m->partition, (u16)val, m->reg_offset);
 	*ppos += count;
 
 	return count;
@@ -379,22 +432,39 @@ static const struct file_operations omap_mux_dbg_signal_fops = {
 
 static struct dentry *mux_dbg_dir;
 
-static void __init omap_mux_dbg_init(void)
+static void __init omap_mux_dbg_create_entry(
+				struct omap_mux_partition *partition,
+				struct dentry *mux_dbg_dir)
 {
 	struct omap_mux_entry *e;
 
+	list_for_each_entry(e, &partition->muxmodes, node) {
+		struct omap_mux *m = &e->mux;
+		m->partition = partition;
+
+		(void)debugfs_create_file(m->muxnames[0], S_IWUGO, mux_dbg_dir,
+					  m, &omap_mux_dbg_signal_fops);
+	}
+}
+
+static void __init omap_mux_dbg_init(void)
+{
+	struct omap_mux_partition *partition;
+	static struct dentry *mux_dbg_board_dir;
+
 	mux_dbg_dir = debugfs_create_dir("omap_mux", NULL);
 	if (!mux_dbg_dir)
 		return;
 
-	(void)debugfs_create_file("board", S_IRUGO, mux_dbg_dir,
-					NULL, &omap_mux_dbg_board_fops);
-
-	list_for_each_entry(e, &muxmodes, node) {
-		struct omap_mux *m = &e->mux;
+	mux_dbg_board_dir = debugfs_create_dir("board", mux_dbg_dir);
+	if (!mux_dbg_board_dir)
+		return;
 
-		(void)debugfs_create_file(m->muxnames[0], S_IWUGO, mux_dbg_dir,
-					m, &omap_mux_dbg_signal_fops);
+	list_for_each_entry(partition, &mux_partitions, node) {
+		omap_mux_dbg_create_entry(partition, mux_dbg_dir);
+		(void)debugfs_create_file(partition->name, S_IRUGO,
+					  mux_dbg_board_dir, partition,
+					  &omap_mux_dbg_board_fops);
 	}
 }
 
@@ -421,23 +491,25 @@ static void __init omap_mux_free_names(struct omap_mux *m)
 /* Free all data except for GPIO pins unless CONFIG_DEBUG_FS is set */
 static int __init omap_mux_late_init(void)
 {
-	struct omap_mux_entry *e, *tmp;
+	struct omap_mux_partition *partition;
 
-	list_for_each_entry_safe(e, tmp, &muxmodes, node) {
-		struct omap_mux *m = &e->mux;
-		u16 mode = omap_mux_read(m->reg_offset);
+	list_for_each_entry(partition, &mux_partitions, node) {
+		struct omap_mux_entry *e, *tmp;
+		list_for_each_entry_safe(e, tmp, &partition->muxmodes, node) {
+			struct omap_mux *m = &e->mux;
+			u16 mode = omap_mux_read(partition, m->reg_offset);
 
-		if (OMAP_MODE_GPIO(mode))
-			continue;
+			if (OMAP_MODE_GPIO(mode))
+				continue;
 
 #ifndef CONFIG_DEBUG_FS
-		mutex_lock(&muxmode_mutex);
-		list_del(&e->node);
-		mutex_unlock(&muxmode_mutex);
-		omap_mux_free_names(m);
-		kfree(m);
+			mutex_lock(&muxmode_mutex);
+			list_del(&e->node);
+			mutex_unlock(&muxmode_mutex);
+			omap_mux_free_names(m);
+			kfree(m);
 #endif
-
+		}
 	}
 
 	omap_mux_dbg_init();
@@ -554,7 +626,7 @@ static void __init omap_mux_set_cmdline_signals(void)
 }
 
 static int __init omap_mux_copy_names(struct omap_mux *src,
-					struct omap_mux *dst)
+				      struct omap_mux *dst)
 {
 	int i;
 
@@ -592,51 +664,63 @@ free:
 
 #endif	/* CONFIG_OMAP_MUX */
 
-static u16 omap_mux_get_by_gpio(int gpio)
+static struct omap_mux *omap_mux_get_by_gpio(
+				struct omap_mux_partition *partition,
+				int gpio)
 {
 	struct omap_mux_entry *e;
-	u16 offset = OMAP_MUX_TERMINATOR;
+	struct omap_mux *ret = NULL;
 
-	list_for_each_entry(e, &muxmodes, node) {
+	list_for_each_entry(e, &partition->muxmodes, node) {
 		struct omap_mux *m = &e->mux;
 		if (m->gpio == gpio) {
-			offset = m->reg_offset;
+			ret = m;
 			break;
 		}
 	}
 
-	return offset;
+	return ret;
 }
 
 /* Needed for dynamic muxing of GPIO pins for off-idle */
 u16 omap_mux_get_gpio(int gpio)
 {
-	u16 offset;
+	struct omap_mux_partition *partition;
+	struct omap_mux *m;
 
-	offset = omap_mux_get_by_gpio(gpio);
-	if (offset == OMAP_MUX_TERMINATOR) {
-		pr_err("mux: Could not get gpio%i\n", gpio);
-		return offset;
+	list_for_each_entry(partition, &mux_partitions, node) {
+		m = omap_mux_get_by_gpio(partition, gpio);
+		if (m)
+			return omap_mux_read(partition, m->reg_offset);
 	}
 
-	return omap_mux_read(offset);
+	if (!m || m->reg_offset == OMAP_MUX_TERMINATOR)
+		pr_err("mux: Could not get gpio%i\n", gpio);
+
+	return OMAP_MUX_TERMINATOR;
 }
 
 /* Needed for dynamic muxing of GPIO pins for off-idle */
 void omap_mux_set_gpio(u16 val, int gpio)
 {
-	u16 offset;
+	struct omap_mux_partition *partition;
+	struct omap_mux *m = NULL;
 
-	offset = omap_mux_get_by_gpio(gpio);
-	if (offset == OMAP_MUX_TERMINATOR) {
-		pr_err("mux: Could not set gpio%i\n", gpio);
-		return;
+	list_for_each_entry(partition, &mux_partitions, node) {
+		m = omap_mux_get_by_gpio(partition, gpio);
+		if (m) {
+			omap_mux_write(partition, val, m->reg_offset);
+			return;
+		}
 	}
 
-	omap_mux_write(val, offset);
+	if (!m || m->reg_offset == OMAP_MUX_TERMINATOR)
+		pr_err("mux: Could not set gpio%i\n", gpio);
 }
 
-static struct omap_mux * __init omap_mux_list_add(struct omap_mux *src)
+static struct omap_mux * __init omap_mux_list_add(
+					struct omap_mux_partition *partition,
+					struct omap_mux *src)
 {
 	struct omap_mux_entry *entry;
 	struct omap_mux *m;
@@ -656,7 +740,7 @@ static struct omap_mux * __init omap_mux_list_add(struct omap_mux *src)
 #endif
 
 	mutex_lock(&muxmode_mutex);
-	list_add_tail(&entry->node, &muxmodes);
+	list_add_tail(&entry->node, &partition->muxmodes);
 	mutex_unlock(&muxmode_mutex);
 
 	return m;
@@ -667,7 +751,8 @@ static struct omap_mux * __init omap_mux_list_add(struct omap_mux *src)
  * the GPIO to mux offset mapping that is needed for dynamic muxing
  * of GPIO pins for off-idle.
  */
-static void __init omap_mux_init_list(struct omap_mux *superset)
+static void __init omap_mux_init_list(struct omap_mux_partition *partition,
+				      struct omap_mux *superset)
 {
 	while (superset->reg_offset !=  OMAP_MUX_TERMINATOR) {
 		struct omap_mux *entry;
@@ -679,13 +764,14 @@ static void __init omap_mux_init_list(struct omap_mux *superset)
 		}
 #else
 		/* Skip pins that are not muxed as GPIO by bootloader */
-		if (!OMAP_MODE_GPIO(omap_mux_read(superset->reg_offset))) {
+		if (!OMAP_MODE_GPIO(omap_mux_read(partition,
+				    superset->reg_offset))) {
 			superset++;
 			continue;
 		}
 #endif
 
-		entry = omap_mux_list_add(superset);
+		entry = omap_mux_list_add(partition, superset);
 		if (!entry) {
 			pr_err("mux: Could not add entry\n");
 			return;
@@ -706,10 +792,11 @@ static void omap_mux_init_package(struct omap_mux *superset,
 		omap_mux_package_init_balls(package_balls, superset);
 }
 
-static void omap_mux_init_signals(struct omap_board_mux *board_mux)
+static void omap_mux_init_signals(struct omap_mux_partition *partition,
+				  struct omap_board_mux *board_mux)
 {
 	omap_mux_set_cmdline_signals();
-	omap_mux_write_array(board_mux);
+	omap_mux_write_array(partition->base, board_mux);
 }
 
 #else
@@ -720,34 +807,49 @@ static void omap_mux_init_package(struct omap_mux *superset,
 {
 }
 
-static void omap_mux_init_signals(struct omap_board_mux *board_mux)
+static void omap_mux_init_signals(struct omap_mux_partition *partition,
+				  struct omap_board_mux *board_mux)
 {
 }
 
 #endif
 
-int __init omap_mux_init(u32 mux_pbase, u32 mux_size,
-				struct omap_mux *superset,
-				struct omap_mux *package_subset,
-				struct omap_board_mux *board_mux,
-				struct omap_ball *package_balls)
-{
-	if (mux_base)
-		return -EBUSY;
+static u32 mux_partitions_cnt;
 
-	mux_phys = mux_pbase;
-	mux_base = ioremap(mux_pbase, mux_size);
-	if (!mux_base) {
-		pr_err("mux: Could not ioremap\n");
+int __init omap_mux_init(const char * name, u32 flags,
+			 u32 mux_pbase, u32 mux_size,
+			 struct omap_mux *superset,
+			 struct omap_mux *package_subset,
+			 struct omap_board_mux *board_mux,
+			 struct omap_ball *package_balls)
+{
+	struct omap_mux_partition *partition;
+
+	partition = kzalloc(sizeof(struct omap_mux_partition), GFP_KERNEL);
+	if (!partition)
+		return -ENOMEM;
+
+	partition->name = name;
+	partition->flags = flags;
+	partition->size = mux_size;
+	partition->phys = mux_pbase;
+	partition->base = ioremap(mux_pbase, mux_size);
+	if (!partition->base) {
+		pr_err("mux: Could not ioremap mux partition at 0x%08x\n",
+			partition->phys);
 		return -ENODEV;
 	}
 
-	if (cpu_is_omap24xx())
-		omap_mux_flags = MUXABLE_GPIO_MODE3;
+	INIT_LIST_HEAD(&partition->muxmodes);
+
+	list_add_tail(&partition->node, &mux_partitions);
+	mux_partitions_cnt++;
+	pr_info("MUX: Add partition: #%d: %s, flags: %x\n",
+		mux_partitions_cnt, partition->name, partition->flags);
 
 	omap_mux_init_package(superset, package_subset, package_balls);
-	omap_mux_init_list(superset);
-	omap_mux_init_signals(board_mux);
+	omap_mux_init_list(partition, superset);
+	omap_mux_init_signals(partition, board_mux);
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 350c04f..46c1aab 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2009 Nokia
- * Copyright (C) 2009 Texas Instruments
+ * Copyright (C) 2009-2010 Texas Instruments
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -56,7 +56,7 @@
 
 #define OMAP_MODE_GPIO(x)	(((x) & OMAP_MUX_MODE7) == OMAP_MUX_MODE4)
 
-/* Flags for omap_mux_init */
+/* Flags for omapX_mux_init */
 #define OMAP_PACKAGE_MASK		0xffff
 #define OMAP_PACKAGE_CBP		6		/* 515-pin 0.40 0.50 */
 #define OMAP_PACKAGE_CUS		5		/* 423-pin 0.65 */
@@ -66,14 +66,47 @@
 #define OMAP_PACKAGE_ZAF		1		/* 2420 447-pin SIP */
 
 
-#define OMAP_MUX_NR_MODES	8			/* Available modes */
-#define OMAP_MUX_NR_SIDES	2			/* Bottom & top */
+#define OMAP_MUX_NR_MODES		8		/* Available modes */
+#define OMAP_MUX_NR_SIDES		2		/* Bottom & top */
+
+/*
+ * omap_mux_init flags definition:
+ *
+ * OMAP_MUX_REG_8BIT: Ensure that access to padconf is done in 8 bits.
+ * The default value is 16 bits.
+ * OMAP_MUX_GPIO_IN_MODE3: The GPIO is selected in mode3.
+ * The default is mode4.
+ */
+#define OMAP_MUX_REG_8BIT		(1 << 0)
+#define OMAP_MUX_GPIO_IN_MODE3		(1 << 1)
+
+/**
+ * struct mux_partition - contain partition related information
+ * @name: name of the current partition
+ * @flags: flags specific to this partition
+ * @phys: physical address
+ * @size: partition size
+ * @base: virtual address after ioremap
+ * @muxmodes: list of nodes that belong to a partition
+ * @node: list node for the partitions linked list
+ */
+struct omap_mux_partition {
+	const char		*name;
+	u32			flags;
+	u32			phys;
+	u32			size;
+	void __iomem		*base;
+	struct list_head	muxmodes;
+	struct list_head	node;
+};
 
 /**
  * struct omap_mux - data for omap mux register offset and it's value
  * @reg_offset:	mux register offset from the mux base
  * @gpio:	GPIO number
  * @muxnames:	available signal modes for a ball
+ * @balls:	available balls on the package
+ * @partition:	mux partition
  */
 struct omap_mux {
 	u16	reg_offset;
@@ -82,6 +115,7 @@ struct omap_mux {
 	char	*muxnames[OMAP_MUX_NR_MODES];
 #ifdef CONFIG_DEBUG_FS
 	char	*balls[OMAP_MUX_NR_SIDES];
+	struct omap_mux_partition *partition;
 #endif
 #endif
 };
@@ -151,28 +185,39 @@ u16 omap_mux_get_gpio(int gpio);
 void omap_mux_set_gpio(u16 val, int gpio);
 
 /**
+ * omap_mux_get() - get a mux partition by name
+ * @name:		Name of the mux partition
+ *
+ */
+struct omap_mux_partition *omap_mux_get(const char *name);
+
+/**
  * omap_mux_read() - read mux register
+ * @partition:		Mux partition
  * @mux_offset:		Offset of the mux register
  *
  */
-u16 omap_mux_read(u16 mux_offset);
+u16 omap_mux_read(struct omap_mux_partition *p, u16 mux_offset);
 
 /**
  * omap_mux_write() - write mux register
+ * @partition:		Mux partition
  * @val:		New mux register value
  * @mux_offset:		Offset of the mux register
  *
  * This should be only needed for dynamic remuxing of non-gpio signals.
  */
-void omap_mux_write(u16 val, u16 mux_offset);
+void omap_mux_write(struct omap_mux_partition *p, u16 val, u16 mux_offset);
 
 /**
  * omap_mux_write_array() - write an array of mux registers
+ * @partition:		Mux partition
  * @board_mux:		Array of mux registers terminated by MAP_MUX_TERMINATOR
  *
  * This should be only needed for dynamic remuxing of non-gpio signals.
  */
-void omap_mux_write_array(struct omap_board_mux *board_mux);
+void omap_mux_write_array(struct omap_mux_partition *p,
+			  struct omap_board_mux *board_mux);
 
 /**
  * omap2420_mux_init() - initialize mux system with board specific set
@@ -198,8 +243,10 @@ int omap3_mux_init(struct omap_board_mux *board_mux, int flags);
 /**
  * omap_mux_init - private mux init function, do not call
  */
-int omap_mux_init(u32 mux_pbase, u32 mux_size,
-				struct omap_mux *superset,
-				struct omap_mux *package_subset,
-				struct omap_board_mux *board_mux,
-				struct omap_ball *package_balls);
+int omap_mux_init(const char *name, u32 flags,
+		  u32 mux_pbase, u32 mux_size,
+		  struct omap_mux *superset,
+		  struct omap_mux *package_subset,
+		  struct omap_board_mux *board_mux,
+		  struct omap_ball *package_balls);
+
diff --git a/arch/arm/mach-omap2/mux2420.c b/arch/arm/mach-omap2/mux2420.c
index 414af54..8231f0a 100644
--- a/arch/arm/mach-omap2/mux2420.c
+++ b/arch/arm/mach-omap2/mux2420.c
@@ -681,8 +681,9 @@ int __init omap2420_mux_init(struct omap_board_mux *board_subset, int flags)
 		pr_warning("mux: No ball data available for omap2420 package\n");
 	}
 
-	return omap_mux_init(OMAP2420_CONTROL_PADCONF_MUX_PBASE,
+	return omap_mux_init("core", OMAP_MUX_REG_8BIT | OMAP_MUX_GPIO_IN_MODE3,
+			     OMAP2420_CONTROL_PADCONF_MUX_PBASE,
 			     OMAP2420_CONTROL_PADCONF_MUX_SIZE,
-				omap2420_muxmodes, NULL, board_subset,
-				package_balls);
+			     omap2420_muxmodes, NULL, board_subset,
+			     package_balls);
 }
diff --git a/arch/arm/mach-omap2/mux2430.c b/arch/arm/mach-omap2/mux2430.c
index 84d2c5a..cb6b404 100644
--- a/arch/arm/mach-omap2/mux2430.c
+++ b/arch/arm/mach-omap2/mux2430.c
@@ -784,8 +784,9 @@ int __init omap2430_mux_init(struct omap_board_mux *board_subset, int flags)
 		pr_warning("mux: No ball data available for omap2420 package\n");
 	}
 
-	return omap_mux_init(OMAP2430_CONTROL_PADCONF_MUX_PBASE,
+	return omap_mux_init("core", OMAP_MUX_REG_8BIT | OMAP_MUX_GPIO_IN_MODE3,
+			     OMAP2430_CONTROL_PADCONF_MUX_PBASE,
 			     OMAP2430_CONTROL_PADCONF_MUX_SIZE,
-				omap2430_muxmodes, NULL, board_subset,
-				package_balls);
+			     omap2430_muxmodes, NULL, board_subset,
+			     package_balls);
 }
diff --git a/arch/arm/mach-omap2/mux34xx.c b/arch/arm/mach-omap2/mux34xx.c
index 574e54e..4113c93 100644
--- a/arch/arm/mach-omap2/mux34xx.c
+++ b/arch/arm/mach-omap2/mux34xx.c
@@ -2053,8 +2053,9 @@ int __init omap3_mux_init(struct omap_board_mux *board_subset, int flags)
 		return -EINVAL;
 	}
 
-	return omap_mux_init(OMAP3_CONTROL_PADCONF_MUX_PBASE,
+	return omap_mux_init("core", 0,
+			     OMAP3_CONTROL_PADCONF_MUX_PBASE,
 			     OMAP3_CONTROL_PADCONF_MUX_SIZE,
-				omap3_muxmodes, package_subset, board_subset,
-				package_balls);
+			     omap3_muxmodes, package_subset, board_subset,
+			     package_balls);
 }
-- 
1.7.0.4


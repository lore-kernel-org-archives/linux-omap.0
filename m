From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC 1/5] OMAP: mux: Add support for control module split in several partitions
Date: Fri, 24 Sep 2010 11:15:44 +0200
Message-ID: <1285319748-28976-2-git-send-email-b-cousson@ti.com>
References: <1285319748-28976-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50590 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213Ab0IXJP4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 05:15:56 -0400
In-Reply-To: <1285319748-28976-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Starting on OMAP4, the pin mux configuration is located in two
different partitions of the control module (CODE_PAD and WKUP_PAD).
The first one is inside the core power domain whereas the second
one is inside the wakeup.
Since each partition has a different physical base address, an
ID is added for each mux entry in order to identify the proper
partition and thus the correct base address.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/mux.c     |  131 ++++++++++++++++++++++++++--------------
 arch/arm/mach-omap2/mux.h     |   44 +++++++++++---
 arch/arm/mach-omap2/mux2420.c |   22 +++++--
 arch/arm/mach-omap2/mux2430.c |   22 +++++--
 arch/arm/mach-omap2/mux34xx.c |   18 +++++-
 5 files changed, 165 insertions(+), 72 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 35050d0..83e7686 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -1,10 +1,10 @@
 /*
  * linux/arch/arm/mach-omap2/mux.c
  *
- * OMAP2 and OMAP3 pin multiplexing configurations
+ * OMAP2, OMAP3 and OMAP4 pin multiplexing configurations
  *
- * Copyright (C) 2004 - 2008 Texas Instruments Inc.
- * Copyright (C) 2003 - 2008 Nokia Corporation
+ * Copyright (C) 2004 - 2010 Texas Instruments Inc.
+ * Copyright (C) 2003 - 2010 Nokia Corporation
  *
  * Written by Tony Lindgren
  *
@@ -43,26 +43,32 @@
 #define OMAP_MUX_BASE_OFFSET		0x30	/* Offset from CTRL_BASE */
 #define OMAP_MUX_BASE_SZ		0x5ca
 #define MUXABLE_GPIO_MODE3		BIT(0)
+#define MAX_PARTITIONS_NR		2
 
 struct omap_mux_entry {
 	struct omap_mux		mux;
 	struct list_head	node;
 };
 
-static unsigned long mux_phys;
-static void __iomem *mux_base;
 static u8 omap_mux_flags;
 
-u16 omap_mux_read(u16 reg)
+static struct mux_partition mux_partitions[MAX_PARTITIONS_NR];
+static u32 mux_partitions_cnt;
+
+u16 omap_mux_read(u16 reg, u8 id)
 {
+	void __iomem *mux_base = mux_partitions[id].base;
+
 	if (cpu_is_omap24xx())
 		return __raw_readb(mux_base + reg);
 	else
 		return __raw_readw(mux_base + reg);
 }
 
-void omap_mux_write(u16 val, u16 reg)
+void omap_mux_write(u16 val, u16 reg, u8 id)
 {
+	void __iomem *mux_base = mux_partitions[id].base;
+
 	if (cpu_is_omap24xx())
 		__raw_writeb(val, mux_base + reg);
 	else
@@ -71,8 +77,9 @@ void omap_mux_write(u16 val, u16 reg)
 
 void omap_mux_write_array(struct omap_board_mux *board_mux)
 {
-	while (board_mux->reg_offset !=  OMAP_MUX_TERMINATOR) {
-		omap_mux_write(board_mux->value, board_mux->reg_offset);
+	while (board_mux->reg_offset != OMAP_MUX_TERMINATOR) {
+		omap_mux_write(board_mux->value, board_mux->reg_offset,
+			       board_mux->id);
 		board_mux++;
 	}
 }
@@ -114,7 +121,7 @@ int __init omap_mux_init_gpio(int gpio, int val)
 		return -EINVAL;
 	}
 
-	old_mode = omap_mux_read(gpio_mux->reg_offset);
+	old_mode = omap_mux_read(gpio_mux->reg_offset, gpio_mux->id);
 	mux_mode = val & ~(OMAP_MUX_NR_MODES - 1);
 	if (omap_mux_flags & MUXABLE_GPIO_MODE3)
 		mux_mode |= OMAP_MUX_MODE3;
@@ -122,7 +129,7 @@ int __init omap_mux_init_gpio(int gpio, int val)
 		mux_mode |= OMAP_MUX_MODE4;
 	pr_debug("mux: Setting signal %s.gpio%i 0x%04x -> 0x%04x\n",
 		 gpio_mux->muxnames[0], gpio, old_mode, mux_mode);
-	omap_mux_write(mux_mode, gpio_mux->reg_offset);
+	omap_mux_write(mux_mode, gpio_mux->reg_offset, gpio_mux->id);
 
 	return 0;
 }
@@ -160,12 +167,12 @@ int __init omap_mux_init_signal(char *muxname, int val)
 				u16 old_mode;
 				u16 mux_mode;
 
-				old_mode = omap_mux_read(m->reg_offset);
+				old_mode = omap_mux_read(m->reg_offset, m->id);
 				mux_mode = val | i;
 				pr_debug("mux: Setting signal "
 					 "%s.%s 0x%04x -> 0x%04x\n",
 					 m0_entry, muxname, old_mode, mux_mode);
-				omap_mux_write(mux_mode, m->reg_offset);
+				omap_mux_write(mux_mode, m->reg_offset, m->id);
 				found++;
 			}
 		}
@@ -194,6 +201,17 @@ int __init omap_mux_init_signal(char *muxname, int val)
 		flags[i] =  #mask;				\
 	}
 
+static void omap_mux_decode_id(struct seq_file *s, u8 id)
+{
+	if (id == PAD_CORE_ID)
+		seq_printf(s, "PAD_CORE_ID");
+	else if (id == PAD_WKUP_ID)
+		seq_printf(s, "PAD_WKUP_ID");
+	else
+		seq_printf(s, "INVALID");
+
+}
+
 /* REVISIT: Add checking for non-optimal mux settings */
 static inline void omap_mux_decode(struct seq_file *s, u16 val)
 {
@@ -249,7 +267,7 @@ static inline void omap_mux_decode(struct seq_file *s, u16 val)
 	} while (i-- > 0);
 }
 
-#define OMAP_MUX_DEFNAME_LEN	16
+#define OMAP_MUX_DEFNAME_LEN	32
 
 static int omap_mux_dbg_board_show(struct seq_file *s, void *unused)
 {
@@ -273,13 +291,18 @@ static int omap_mux_dbg_board_show(struct seq_file *s, void *unused)
 			}
 			m0_def[i] = toupper(m0_name[i]);
 		}
-		val = omap_mux_read(m->reg_offset);
+		val = omap_mux_read(m->reg_offset, m->id);
 		mode = val & OMAP_MUX_MODE7;
-
-		seq_printf(s, "OMAP%i_MUX(%s, ",
-					cpu_is_omap34xx() ? 3 : 0, m0_def);
+		if (cpu_is_omap44xx()) {
+			seq_printf(s, "OMAP4_MUX(%s, ", m0_def);
+			omap_mux_decode_id(s, m->id);
+			seq_printf(s, ", ");
+		} else {
+			seq_printf(s, "OMAP%i_MUX(%s, ",
+				      cpu_is_omap34xx() ? 3 : 0, m0_def);
+		}
 		omap_mux_decode(s, val);
-		seq_printf(s, "),\n");
+		seq_printf(s, "),\t/* %s */\n", m->muxnames[mode]);
 	}
 
 	return 0;
@@ -303,8 +326,9 @@ static int omap_mux_dbg_signal_show(struct seq_file *s, void *unused)
 	const char *none = "NA";
 	u16 val;
 	int mode;
+	unsigned long mux_phys = mux_partitions[m->id].phys;
 
-	val = omap_mux_read(m->reg_offset);
+	val = omap_mux_read(m->reg_offset, m->id);
 	mode = val & OMAP_MUX_MODE7;
 
 	seq_printf(s, "name: %s.%s (0x%08lx/0x%03x = 0x%04x), b %s, t %s\n",
@@ -359,7 +383,7 @@ static ssize_t omap_mux_dbg_signal_write(struct file *file,
 	seqf = file->private_data;
 	m = seqf->private;
 
-	omap_mux_write((u16)val, m->reg_offset);
+	omap_mux_write((u16)val, m->reg_offset, m->id);
 	*ppos += count;
 
 	return count;
@@ -426,7 +450,7 @@ static int __init omap_mux_late_init(void)
 
 	list_for_each_entry_safe(e, tmp, &muxmodes, node) {
 		struct omap_mux *m = &e->mux;
-		u16 mode = omap_mux_read(m->reg_offset);
+		u16 mode = omap_mux_read(m->reg_offset, m->id);
 
 		if (OMAP_MODE_GPIO(mode))
 			continue;
@@ -593,48 +617,48 @@ free:
 
 #endif	/* CONFIG_OMAP_MUX */
 
-static u16 omap_mux_get_by_gpio(int gpio)
+static struct omap_mux *omap_mux_get_by_gpio(int gpio)
 {
 	struct omap_mux_entry *e;
-	u16 offset = OMAP_MUX_TERMINATOR;
+	struct omap_mux *ret = NULL;
 
 	list_for_each_entry(e, &muxmodes, node) {
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
+	struct omap_mux *m;
 
-	offset = omap_mux_get_by_gpio(gpio);
-	if (offset == OMAP_MUX_TERMINATOR) {
+	m = omap_mux_get_by_gpio(gpio);
+	if (!m || m->reg_offset == OMAP_MUX_TERMINATOR) {
 		pr_err("mux: Could not get gpio%i\n", gpio);
-		return offset;
+		return OMAP_MUX_TERMINATOR;
 	}
 
-	return omap_mux_read(offset);
+	return omap_mux_read(m->reg_offset, m->id);
 }
 
 /* Needed for dynamic muxing of GPIO pins for off-idle */
 void omap_mux_set_gpio(u16 val, int gpio)
 {
-	u16 offset;
+	struct omap_mux *m;
 
-	offset = omap_mux_get_by_gpio(gpio);
-	if (offset == OMAP_MUX_TERMINATOR) {
+	m = omap_mux_get_by_gpio(gpio);
+	if (!m || m->reg_offset == OMAP_MUX_TERMINATOR) {
 		pr_err("mux: Could not set gpio%i\n", gpio);
 		return;
 	}
 
-	omap_mux_write(val, offset);
+	omap_mux_write(val, m->reg_offset, m->id);
 }
 
 static struct omap_mux * __init omap_mux_list_add(struct omap_mux *src)
@@ -727,22 +751,31 @@ static void omap_mux_init_signals(struct omap_board_mux *board_mux)
 
 #endif
 
-int __init omap_mux_init(u32 mux_pbase, u32 mux_size,
-				struct omap_mux *superset,
-				struct omap_mux *package_subset,
-				struct omap_board_mux *board_mux,
-				struct omap_ball *package_balls)
+int __init omap_mux_init(struct mux_partition *partitions, u32 partitions_cnt,
+			 struct omap_mux *superset,
+			 struct omap_mux *package_subset,
+			 struct omap_board_mux *board_mux,
+			 struct omap_ball *package_balls)
 {
-	if (mux_base)
+	int i;
+
+	if (partitions_cnt == 0 || partitions_cnt > MAX_PARTITIONS_NR)
 		return -EBUSY;
 
-	mux_phys = mux_pbase;
-	mux_base = ioremap(mux_pbase, mux_size);
-	if (!mux_base) {
-		pr_err("mux: Could not ioremap\n");
-		return -ENODEV;
+	for (i = 0; i < partitions_cnt; i++) {
+		mux_partitions[i].size = partitions[i].size;
+		mux_partitions[i].phys = partitions[i].phys;
+		mux_partitions[i].base = ioremap(partitions[i].phys,
+						 partitions[i].size);
+		if (!mux_partitions[i].base) {
+			pr_err("mux: Could not ioremap on partition: "
+			       "%d at 0x%08x\n", i, partitions[i].phys);
+			goto unmap;
+		}
 	}
 
+	mux_partitions_cnt = partitions_cnt;
+
 	if (cpu_is_omap24xx())
 		omap_mux_flags = MUXABLE_GPIO_MODE3;
 
@@ -751,5 +784,11 @@ int __init omap_mux_init(u32 mux_pbase, u32 mux_size,
 	omap_mux_init_signals(board_mux);
 
 	return 0;
+
+unmap:
+	for (i--; i >= 0; i--)
+		iounmap(mux_partitions[i].base);
+
+	return -ENODEV;
 }
 
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index a8e040c..9b28576 100644
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
@@ -66,18 +66,24 @@
 #define OMAP_PACKAGE_ZAF		1		/* 2420 447-pin SIP */
 
 
-#define OMAP_MUX_NR_MODES	8			/* Available modes */
-#define OMAP_MUX_NR_SIDES	2			/* Bottom & top */
+#define OMAP_MUX_NR_MODES		8		/* Available modes */
+#define OMAP_MUX_NR_SIDES		2		/* Bottom & top */
+
+/* identifier of the pad_conf partition introduced in OMAP4 */
+#define PAD_CORE_ID			0
+#define PAD_WKUP_ID			1
 
 /**
  * struct omap_mux - data for omap mux register offset and it's value
  * @reg_offset:	mux register offset from the mux base
  * @gpio:	GPIO number
+ * @id:		Partition identifier
  * @muxnames:	available signal modes for a ball
  */
 struct omap_mux {
 	u16	reg_offset;
 	u16	gpio;
+	u8	id;
 #ifdef CONFIG_OMAP_MUX
 	char	*muxnames[OMAP_MUX_NR_MODES];
 #ifdef CONFIG_DEBUG_FS
@@ -89,10 +95,12 @@ struct omap_mux {
 /**
  * struct omap_ball - data for balls on omap package
  * @reg_offset:	mux register offset from the mux base
+ * @id:		Partition identifier
  * @balls:	available balls on the package
  */
 struct omap_ball {
 	u16	reg_offset;
+	u8	id;
 	char	*balls[OMAP_MUX_NR_SIDES];
 };
 
@@ -100,10 +108,24 @@ struct omap_ball {
  * struct omap_board_mux - data for initializing mux registers
  * @reg_offset:	mux register offset from the mux base
  * @mux_value:	desired mux value to set
+ * @id:		Partition identifier
  */
 struct omap_board_mux {
 	u16	reg_offset;
 	u16	value;
+	u8	id;
+};
+
+/**
+ * struct mux_partition - data containing physical address and partition size
+ * @phys: physical address
+ * @size: partition size
+ * @base: virtual address after ioremap
+ */
+struct mux_partition {
+	u32		phys;
+	u32		size;
+	void __iomem	*base;
 };
 
 #if defined(CONFIG_OMAP_MUX)
@@ -153,18 +175,20 @@ void omap_mux_set_gpio(u16 val, int gpio);
 /**
  * omap_mux_read() - read mux register
  * @mux_offset:		Offset of the mux register
+ * @id:			identifier of the control module partition
  *
  */
-u16 omap_mux_read(u16 mux_offset);
+u16 omap_mux_read(u16 mux_offset, u8 id);
 
 /**
  * omap_mux_write() - write mux register
  * @val:		New mux register value
  * @mux_offset:		Offset of the mux register
+ * @id:			identifier of the control module partition
  *
  * This should be only needed for dynamic remuxing of non-gpio signals.
  */
-void omap_mux_write(u16 val, u16 mux_offset);
+void omap_mux_write(u16 val, u16 mux_offset, u8 id);
 
 /**
  * omap_mux_write_array() - write an array of mux registers
@@ -198,8 +222,8 @@ int omap3_mux_init(struct omap_board_mux *board_mux, int flags);
 /**
  * omap_mux_init - private mux init function, do not call
  */
-int omap_mux_init(u32 mux_pbase, u32 mux_size,
-				struct omap_mux *superset,
-				struct omap_mux *package_subset,
-				struct omap_board_mux *board_mux,
-				struct omap_ball *package_balls);
+int omap_mux_init(struct mux_partition *partitions, u32 partitions_cnt,
+		  struct omap_mux *superset,
+		  struct omap_mux *package_subset,
+		  struct omap_board_mux *board_mux,
+		  struct omap_ball *package_balls);
diff --git a/arch/arm/mach-omap2/mux2420.c b/arch/arm/mach-omap2/mux2420.c
index fdb04a7..5760c53 100644
--- a/arch/arm/mach-omap2/mux2420.c
+++ b/arch/arm/mach-omap2/mux2420.c
@@ -14,19 +14,21 @@
 
 #ifdef CONFIG_OMAP_MUX
 
-#define _OMAP2420_MUXENTRY(M0, g, m0, m1, m2, m3, m4, m5, m6, m7)		\
+#define _OMAP2420_MUXENTRY(M0, g, m0, m1, m2, m3, m4, m5, m6, m7)	\
 {									\
 	.reg_offset	= (OMAP2420_CONTROL_PADCONF_##M0##_OFFSET),	\
 	.gpio		= (g),						\
 	.muxnames	= { m0, m1, m2, m3, m4, m5, m6, m7 },		\
+	.id		= (PAD_CORE_ID),				\
 }
 
 #else
 
-#define _OMAP2420_MUXENTRY(M0, g, m0, m1, m2, m3, m4, m5, m6, m7)		\
+#define _OMAP2420_MUXENTRY(M0, g, m0, m1, m2, m3, m4, m5, m6, m7)	\
 {									\
 	.reg_offset	= (OMAP2420_CONTROL_PADCONF_##M0##_OFFSET),	\
 	.gpio		= (g),						\
+	.id		= (PAD_CORE_ID),				\
 }
 
 #endif
@@ -35,6 +37,7 @@
 {									\
 	.reg_offset	= (OMAP2420_CONTROL_PADCONF_##M0##_OFFSET),	\
 	.balls		= { bb, bt },					\
+	.id		= (PAD_CORE_ID),				\
 }
 
 /*
@@ -667,6 +670,13 @@ struct omap_ball __initdata omap2420_pop_ball[] = {
 #define omap2420_pop_ball	 NULL
 #endif
 
+static __initdata struct mux_partition omap2420_mux_partitions[] = {
+	[PAD_CORE_ID] = {
+		.phys = OMAP2420_CONTROL_PADCONF_MUX_PBASE,
+		.size = OMAP2420_CONTROL_PADCONF_MUX_SIZE,
+	},
+};
+
 int __init omap2420_mux_init(struct omap_board_mux *board_subset, int flags)
 {
 	struct omap_ball *package_balls = NULL;
@@ -681,8 +691,8 @@ int __init omap2420_mux_init(struct omap_board_mux *board_subset, int flags)
 		pr_warning("mux: No ball data available for omap2420 package\n");
 	}
 
-	return omap_mux_init(OMAP2420_CONTROL_PADCONF_MUX_PBASE,
-			     OMAP2420_CONTROL_PADCONF_MUX_SIZE,
-				omap2420_muxmodes, NULL, board_subset,
-				package_balls);
+	return omap_mux_init(omap2420_mux_partitions,
+			     ARRAY_SIZE(omap2420_mux_partitions),
+			     omap2420_muxmodes, NULL, board_subset,
+			     package_balls);
 }
diff --git a/arch/arm/mach-omap2/mux2430.c b/arch/arm/mach-omap2/mux2430.c
index 7dcaaa8..69fd7b8 100644
--- a/arch/arm/mach-omap2/mux2430.c
+++ b/arch/arm/mach-omap2/mux2430.c
@@ -14,19 +14,21 @@
 
 #ifdef CONFIG_OMAP_MUX
 
-#define _OMAP2430_MUXENTRY(M0, g, m0, m1, m2, m3, m4, m5, m6, m7)		\
+#define _OMAP2430_MUXENTRY(M0, g, m0, m1, m2, m3, m4, m5, m6, m7)	\
 {									\
 	.reg_offset	= (OMAP2430_CONTROL_PADCONF_##M0##_OFFSET),	\
 	.gpio		= (g),						\
 	.muxnames	= { m0, m1, m2, m3, m4, m5, m6, m7 },		\
+	.id		= (PAD_CORE_ID),				\
 }
 
 #else
 
-#define _OMAP2430_MUXENTRY(M0, g, m0, m1, m2, m3, m4, m5, m6, m7)		\
+#define _OMAP2430_MUXENTRY(M0, g, m0, m1, m2, m3, m4, m5, m6, m7)	\
 {									\
 	.reg_offset	= (OMAP2430_CONTROL_PADCONF_##M0##_OFFSET),	\
 	.gpio		= (g),						\
+	.id		= (PAD_CORE_ID),				\
 }
 
 #endif
@@ -35,6 +37,7 @@
 {									\
 	.reg_offset	= (OMAP2430_CONTROL_PADCONF_##M0##_OFFSET),	\
 	.balls		= { bb, bt },					\
+	.id		= (PAD_CORE_ID),				\
 }
 
 /*
@@ -772,6 +775,13 @@ struct omap_ball __initdata omap2430_pop_ball[] = {
 #define omap2430_pop_ball	 NULL
 #endif
 
+static __initdata struct mux_partition omap2430_mux_partitions[] = {
+	[PAD_CORE_ID] = {
+		.phys = OMAP2430_CONTROL_PADCONF_MUX_PBASE,
+		.size = OMAP2430_CONTROL_PADCONF_MUX_SIZE,
+	},
+};
+
 int __init omap2430_mux_init(struct omap_board_mux *board_subset, int flags)
 {
 	struct omap_ball *package_balls = NULL;
@@ -784,8 +794,8 @@ int __init omap2430_mux_init(struct omap_board_mux *board_subset, int flags)
 		pr_warning("mux: No ball data available for omap2420 package\n");
 	}
 
-	return omap_mux_init(OMAP2430_CONTROL_PADCONF_MUX_PBASE,
-			     OMAP2430_CONTROL_PADCONF_MUX_SIZE,
-				omap2430_muxmodes, NULL, board_subset,
-				package_balls);
+	return omap_mux_init(omap2430_mux_partitions,
+			     ARRAY_SIZE(omap2430_mux_partitions),
+			     omap2430_muxmodes, NULL, board_subset,
+			     package_balls);
 }
diff --git a/arch/arm/mach-omap2/mux34xx.c b/arch/arm/mach-omap2/mux34xx.c
index f64d7ee..7419d2c 100644
--- a/arch/arm/mach-omap2/mux34xx.c
+++ b/arch/arm/mach-omap2/mux34xx.c
@@ -19,6 +19,7 @@
 	.reg_offset	= (OMAP3_CONTROL_PADCONF_##M0##_OFFSET),	\
 	.gpio		= (g),						\
 	.muxnames	= { m0, m1, m2, m3, m4, m5, m6, m7 },		\
+	.id		= (PAD_CORE_ID),				\
 }
 
 #else
@@ -27,6 +28,7 @@
 {									\
 	.reg_offset	= (OMAP3_CONTROL_PADCONF_##M0##_OFFSET),	\
 	.gpio		= (g),						\
+	.id		= (PAD_CORE_ID),				\
 }
 
 #endif
@@ -35,6 +37,7 @@
 {									\
 	.reg_offset	= (OMAP3_CONTROL_PADCONF_##M0##_OFFSET),	\
 	.balls		= { bb, bt },					\
+	.id		= (PAD_CORE_ID),				\
 }
 
 /*
@@ -2026,6 +2029,13 @@ struct omap_ball __initdata omap36xx_cbp_ball[] = {
 #define omap36xx_cbp_ball	 NULL
 #endif
 
+static __initdata struct mux_partition omap3_mux_partitions[] = {
+	[PAD_CORE_ID] = {
+		.phys = OMAP3_CONTROL_PADCONF_MUX_PBASE,
+		.size = OMAP3_CONTROL_PADCONF_MUX_SIZE,
+	},
+};
+
 int __init omap3_mux_init(struct omap_board_mux *board_subset, int flags)
 {
 	struct omap_mux *package_subset;
@@ -2053,8 +2063,8 @@ int __init omap3_mux_init(struct omap_board_mux *board_subset, int flags)
 		return -EINVAL;
 	}
 
-	return omap_mux_init(OMAP3_CONTROL_PADCONF_MUX_PBASE,
-			     OMAP3_CONTROL_PADCONF_MUX_SIZE,
-				omap3_muxmodes, package_subset, board_subset,
-				package_balls);
+	return omap_mux_init(omap3_mux_partitions,
+			     ARRAY_SIZE(omap3_mux_partitions),
+			     omap3_muxmodes, package_subset, board_subset,
+			     package_balls);
 }
-- 
1.6.0.4


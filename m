From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/8] omap: mux: Add new style pin multiplexing code for omap3
Date: Wed, 25 Nov 2009 16:19:04 -0800
Message-ID: <20091126001904.1546.81281.stgit@localhost>
References: <20091126001646.1546.34352.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61758 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759752AbZKZATA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 19:19:00 -0500
In-Reply-To: <20091126001646.1546.34352.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Initially only for 34xx. This code allows us to:

- Make the code more generic as the omap internal signal
  names can stay the same across omap generations for some
  devices

- Map mux registers to GPIO registers that is needed for
  dynamic muxing of pins during off-idle

- Override bootloader mux values via kernel cmdline using
  omap_mux=some.signa1=0x1234,some.signal2=0x1234

- View and set the mux registers via debugfs if
  CONFIG_DEBUG_FS is enabled

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c |  358 +++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/mux.h |  148 +++++++++++++++++++
 arch/arm/plat-omap/mux.c  |    8 +
 3 files changed, 510 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-omap2/mux.h

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 64250c5..9091029 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -27,17 +27,25 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/spinlock.h>
+#include <linux/list.h>
 
 #include <asm/system.h>
 
 #include <plat/control.h>
 #include <plat/mux.h>
 
+#include "mux.h"
+
 #ifdef CONFIG_OMAP_MUX
 
 #define OMAP_MUX_BASE_OFFSET		0x30	/* Offset from CTRL_BASE */
 #define OMAP_MUX_BASE_SZ		0x5ca
 
+struct omap_mux_entry {
+	struct omap_mux		mux;
+	struct list_head	node;
+};
+
 static struct omap_mux_cfg arch_mux_cfg;
 static void __iomem *mux_base;
 
@@ -659,6 +667,352 @@ static int __init_or_module omap34xx_cfg_reg(const struct pin_config *cfg)
 #define omap34xx_cfg_reg	NULL
 #endif
 
+/*----------------------------------------------------------------------------*/
+
+#ifdef CONFIG_ARCH_OMAP34XX
+
+static LIST_HEAD(muxmodes);
+static DEFINE_MUTEX(muxmode_mutex);
+
+static char *omap_mux_options;
+
+int __init omap_mux_init_gpio(int gpio, int val)
+{
+	struct omap_mux_entry *e;
+	int found = 0;
+
+	if (!gpio)
+		return -EINVAL;
+
+	list_for_each_entry(e, &muxmodes, node) {
+		struct omap_mux *m = &e->mux;
+		if (gpio == m->gpio) {
+			u16 old_mode;
+			u16 mux_mode;
+
+			old_mode = omap_mux_read(m->reg_offset);
+			mux_mode = val & ~(OMAP_MUX_NR_MODES - 1);
+			mux_mode |= OMAP_MUX_MODE4;
+			printk(KERN_DEBUG "mux: Setting signal "
+				"%s.gpio%i 0x%04x -> 0x%04x\n",
+				m->muxnames[0], gpio, old_mode, mux_mode);
+			omap_mux_write(mux_mode, m->reg_offset);
+			found++;
+		}
+	}
+
+	if (found == 1)
+		return 0;
+
+	if (found > 1) {
+		printk(KERN_ERR "mux: Multiple gpio paths for gpio%i\n", gpio);
+		return -EINVAL;
+	}
+
+	printk(KERN_ERR "mux: Could not set gpio%i\n", gpio);
+
+	return -ENODEV;
+}
+
+int __init omap_mux_init_signal(char *muxname, int val)
+{
+	struct omap_mux_entry *e;
+	char *m0_name = NULL, *mode_name = NULL;
+	int found = 0;
+
+	mode_name = strchr(muxname, '.');
+	if (mode_name) {
+		*mode_name = '\0';
+		mode_name++;
+		m0_name = muxname;
+	} else {
+		mode_name = muxname;
+	}
+
+	list_for_each_entry(e, &muxmodes, node) {
+		struct omap_mux *m = &e->mux;
+		char *m0_entry = m->muxnames[0];
+		int i;
+
+		if (m0_name && strcmp(m0_name, m0_entry))
+			continue;
+
+		for (i = 0; i < OMAP_MUX_NR_MODES; i++) {
+			char *mode_cur = m->muxnames[i];
+
+			if (!mode_cur)
+				continue;
+
+			if (!strcmp(mode_name, mode_cur)) {
+				u16 old_mode;
+				u16 mux_mode;
+
+				old_mode = omap_mux_read(m->reg_offset);
+				mux_mode = val | i;
+				printk(KERN_DEBUG "mux: Setting signal "
+					"%s.%s 0x%04x -> 0x%04x\n",
+					m0_entry, muxname, old_mode, mux_mode);
+				omap_mux_write(mux_mode, m->reg_offset);
+				found++;
+			}
+		}
+	}
+
+	if (found == 1)
+		return 0;
+
+	if (found > 1) {
+		printk(KERN_ERR "mux: Multiple signal paths (%i) for %s\n",
+				found, muxname);
+		return -EINVAL;
+	}
+
+	printk(KERN_ERR "mux: Could not set signal %s\n", muxname);
+
+	return -ENODEV;
+}
+
+static void __init omap_mux_free_names(struct omap_mux *m)
+{
+	int i;
+
+	for (i = 0; i < OMAP_MUX_NR_MODES; i++)
+		kfree(m->muxnames[i]);
+
+#ifdef CONFIG_DEBUG_FS
+	for (i = 0; i < OMAP_MUX_NR_SIDES; i++)
+		kfree(m->balls[i]);
+#endif
+
+}
+
+static int __init omap_mux_late_init(void)
+{
+	struct omap_mux_entry *e, *tmp;
+
+	list_for_each_entry_safe(e, tmp, &muxmodes, node) {
+		struct omap_mux *m = &e->mux;
+		u16 mode = omap_mux_read(m->reg_offset);
+
+		if (OMAP_MODE_GPIO(mode))
+			continue;
+
+#ifndef CONFIG_DEBUG_FS
+		mutex_lock(&muxmode_mutex);
+		list_del(&e->node);
+		mutex_unlock(&muxmode_mutex);
+		omap_mux_free_names(m);
+		kfree(m);
+#endif
+
+	}
+
+	return 0;
+}
+late_initcall(omap_mux_late_init);
+
+static void __init omap_mux_package_fixup(struct omap_mux *p,
+					struct omap_mux *superset)
+{
+	while (p->reg_offset !=  OMAP_MUX_TERMINATOR) {
+		struct omap_mux *s = superset;
+		int found = 0;
+
+		while (s->reg_offset != OMAP_MUX_TERMINATOR) {
+			if (s->reg_offset == p->reg_offset) {
+				*s = *p;
+				found++;
+				break;
+			}
+			s++;
+		}
+		if (!found)
+			printk(KERN_ERR "mux: Unknown entry offset 0x%x\n",
+					p->reg_offset);
+		p++;
+	}
+}
+
+#ifdef CONFIG_DEBUG_FS
+
+static void __init omap_mux_package_init_balls(struct omap_ball *b,
+				struct omap_mux *superset)
+{
+	while (b->reg_offset != OMAP_MUX_TERMINATOR) {
+		struct omap_mux *s = superset;
+		int found = 0;
+
+		while (s->reg_offset != OMAP_MUX_TERMINATOR) {
+			if (s->reg_offset == b->reg_offset) {
+				s->balls[0] = b->balls[0];
+				s->balls[1] = b->balls[1];
+				found++;
+				break;
+			}
+			s++;
+		}
+		if (!found)
+			printk(KERN_ERR "mux: Unknown ball offset 0x%x\n",
+					b->reg_offset);
+		b++;
+	}
+}
+
+#else	/* CONFIG_DEBUG_FS */
+
+static inline void omap_mux_package_init_balls(struct omap_ball *b,
+					struct omap_mux *superset)
+{
+}
+
+#endif	/* CONFIG_DEBUG_FS */
+
+static int __init omap_mux_setup(char *options)
+{
+	if (!options)
+		return 0;
+
+	omap_mux_options = options;
+
+	return 1;
+}
+__setup("omap_mux=", omap_mux_setup);
+
+/*
+ * Note that the omap_mux=some.signal1=0x1234,some.signal2=0x1234
+ * cmdline options only override the bootloader values.
+ * During development, please enable CONFIG_DEBUG_FS, and use the
+ * signal specific entries under debugfs.
+ */
+static void __init omap_mux_set_cmdline_signals(void)
+{
+	char *options, *next_opt, *token;
+
+	if (!omap_mux_options)
+		return;
+
+	options = kmalloc(strlen(omap_mux_options) + 1, GFP_KERNEL);
+	if (!options)
+		return;
+
+	strcpy(options, omap_mux_options);
+	next_opt = options;
+
+	while ((token = strsep(&next_opt, ",")) != NULL) {
+		char *keyval, *name;
+		unsigned long val;
+
+		keyval = token;
+		name = strsep(&keyval, "=");
+		if (name) {
+			val = simple_strtoul(keyval, NULL, 0x10);
+			omap_mux_init_signal(name, (u16)val);
+		}
+	}
+
+	kfree(options);
+}
+
+static void __init omap_mux_set_board_signals(struct omap_board_mux *board_mux)
+{
+	while (board_mux->reg_offset !=  OMAP_MUX_TERMINATOR) {
+		omap_mux_write(board_mux->value, board_mux->reg_offset);
+		board_mux++;
+	}
+}
+
+static struct omap_mux * __init omap_mux_list_add(struct omap_mux *src)
+{
+	struct omap_mux_entry *entry;
+	struct omap_mux *m;
+
+	int i;
+
+	entry = kzalloc(sizeof(struct omap_mux_entry), GFP_KERNEL);
+	if (!entry)
+		return NULL;
+
+	m = &entry->mux;
+	memcpy(m, src, sizeof(struct omap_mux_entry));
+
+	for (i = 0; i < OMAP_MUX_NR_MODES; i++) {
+		if (src->muxnames[i]) {
+			m->muxnames[i] =
+				kmalloc(strlen(src->muxnames[i]) + 1,
+					GFP_KERNEL);
+			if (!m->muxnames[i])
+				goto free;
+			strcpy(m->muxnames[i], src->muxnames[i]);
+		}
+	}
+
+#ifdef CONFIG_DEBUG_FS
+	for (i = 0; i < OMAP_MUX_NR_SIDES; i++) {
+		if (src->balls[i]) {
+			m->balls[i] =
+				kmalloc(strlen(src->balls[i]) + 1,
+					GFP_KERNEL);
+			if (!m->balls[i])
+				goto free;
+			strcpy(m->balls[i], src->balls[i]);
+		}
+	}
+#endif
+
+	mutex_lock(&muxmode_mutex);
+	list_add_tail(&entry->node, &muxmodes);
+	mutex_unlock(&muxmode_mutex);
+
+	return m;
+
+free:
+	omap_mux_free_names(m);
+	kfree(entry);
+
+	return NULL;
+}
+
+static void __init omap_mux_init_list(struct omap_mux *superset)
+{
+	while (superset->reg_offset !=  OMAP_MUX_TERMINATOR) {
+		struct omap_mux *entry;
+
+		entry = omap_mux_list_add(superset);
+		if (!entry) {
+			printk(KERN_ERR "mux: Could not add entry\n");
+			return;
+		}
+		superset++;
+	}
+}
+
+int __init omap_mux_init(u32 mux_pbase, u32 mux_size,
+				struct omap_mux *superset,
+				struct omap_mux *package_subset,
+				struct omap_board_mux *board_mux,
+				struct omap_ball *package_balls)
+{
+	if (mux_base)
+		return -EBUSY;
+
+	mux_base = ioremap(mux_pbase, mux_size);
+	if (!mux_base) {
+		printk(KERN_ERR "mux: Could not ioremap\n");
+		return -ENODEV;
+	}
+	omap_mux_package_fixup(package_subset, superset);
+	omap_mux_package_init_balls(package_balls, superset);
+	omap_mux_set_cmdline_signals();
+	omap_mux_set_board_signals(board_mux);
+	omap_mux_init_list(superset);
+
+	return 0;
+}
+
+#endif
+
+/*----------------------------------------------------------------------------*/
+
 int __init omap2_mux_init(void)
 {
 	u32 mux_pbase;
@@ -667,8 +1021,8 @@ int __init omap2_mux_init(void)
 		mux_pbase = OMAP2420_CTRL_BASE + OMAP_MUX_BASE_OFFSET;
 	else if (cpu_is_omap2430())
 		mux_pbase = OMAP243X_CTRL_BASE + OMAP_MUX_BASE_OFFSET;
-	else if (cpu_is_omap34xx())
-		mux_pbase = OMAP343X_CTRL_BASE + OMAP_MUX_BASE_OFFSET;
+	else
+		return -ENODEV;
 
 	mux_base = ioremap(mux_pbase, OMAP_MUX_BASE_SZ);
 	if (!mux_base) {
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
new file mode 100644
index 0000000..cfb7360
--- /dev/null
+++ b/arch/arm/mach-omap2/mux.h
@@ -0,0 +1,148 @@
+/*
+ * Copyright (C) 2009 Nokia
+ * Copyright (C) 2009 Texas Instruments
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define OMAP_MUX_TERMINATOR	0xffff
+
+/* 34xx mux mode options for each pin. See TRM for options */
+#define OMAP_MUX_MODE0      0
+#define OMAP_MUX_MODE1      1
+#define OMAP_MUX_MODE2      2
+#define OMAP_MUX_MODE3      3
+#define OMAP_MUX_MODE4      4
+#define OMAP_MUX_MODE5      5
+#define OMAP_MUX_MODE6      6
+#define OMAP_MUX_MODE7      7
+
+/* 24xx/34xx mux bit defines */
+#define OMAP_PULL_ENA			(1 << 3)
+#define OMAP_PULL_UP			(1 << 4)
+#define OMAP_ALTELECTRICALSEL		(1 << 5)
+
+/* 34xx specific mux bit defines */
+#define OMAP_INPUT_EN			(1 << 8)
+#define OMAP_OFF_EN			(1 << 9)
+#define OMAP_OFFOUT_EN			(1 << 10)
+#define OMAP_OFFOUT_VAL			(1 << 11)
+#define OMAP_OFF_PULL_EN		(1 << 12)
+#define OMAP_OFF_PULL_UP		(1 << 13)
+#define OMAP_WAKEUP_EN			(1 << 14)
+
+/* Active pin states */
+#define OMAP_PIN_OUTPUT			0
+#define OMAP_PIN_INPUT			OMAP_INPUT_EN
+#define OMAP_PIN_INPUT_PULLUP		(OMAP_PULL_ENA | OMAP_INPUT_EN \
+						| OMAP_PULL_UP)
+#define OMAP_PIN_INPUT_PULLDOWN		(OMAP_PULL_ENA | OMAP_INPUT_EN)
+
+/* Off mode states */
+#define OMAP_PIN_OFF_NONE		0
+#define OMAP_PIN_OFF_OUTPUT_HIGH	(OMAP_OFF_EN | OMAP_OFFOUT_EN \
+						| OMAP_OFFOUT_VAL)
+#define OMAP_PIN_OFF_OUTPUT_LOW		(OMAP_OFF_EN | OMAP_OFFOUT_EN)
+#define OMAP_PIN_OFF_INPUT_PULLUP	(OMAP_OFF_EN | OMAP_OFF_PULL_EN \
+						| OMAP_OFF_PULL_UP)
+#define OMAP_PIN_OFF_INPUT_PULLDOWN	(OMAP_OFF_EN | OMAP_OFF_PULL_EN)
+#define OMAP_PIN_OFF_WAKEUPENABLE	OMAP_WAKEUP_EN
+
+#define OMAP_MODE_GPIO(x)	(((x) & OMAP_MUX_MODE7) == OMAP_MUX_MODE4)
+
+/* Flags for omap_mux_init */
+#define OMAP_PACKAGE_MASK		0xffff
+#define OMAP_PACKAGE_CUS		3		/* 423-pin 0.65 */
+#define OMAP_PACKAGE_CBB		2		/* 515-pin 0.40 0.50 */
+#define OMAP_PACKAGE_CBC		1		/* 515-pin 0.50 0.65 */
+
+
+#define OMAP_MUX_NR_MODES	8			/* Available modes */
+#define OMAP_MUX_NR_SIDES	2			/* Bottom & top */
+
+/**
+ * struct omap_mux - data for omap mux register offset and it's value
+ * @reg_offset:	mux register offset from the mux base
+ * @gpio:	GPIO number
+ * @muxnames:	available signal modes for a ball
+ */
+struct omap_mux {
+	u16	reg_offset;
+	u16	gpio;
+	char	*muxnames[OMAP_MUX_NR_MODES];
+#ifdef CONFIG_DEBUG_FS
+	char	*balls[OMAP_MUX_NR_SIDES];
+#endif
+};
+
+/**
+ * struct omap_ball - data for balls on omap package
+ * @reg_offset:	mux register offset from the mux base
+ * @balls:	available balls on the package
+ */
+struct omap_ball {
+	u16	reg_offset;
+	char	*balls[OMAP_MUX_NR_SIDES];
+};
+
+/**
+ * struct omap_board_mux - data for initializing mux registers
+ * @reg_offset:	mux register offset from the mux base
+ * @mux_value:	desired mux value to set
+ */
+struct omap_board_mux {
+	u16	reg_offset;
+	u16	value;
+};
+
+#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_ARCH_OMAP34XX)
+
+/**
+ * omap3_mux_init() - initialize mux system with board specific set
+ * @board_mux:		Board specific mux table
+ * @flags:		OMAP package type used for the board
+ */
+int omap3_mux_init(struct omap_board_mux *board_mux, int flags);
+
+/**
+ * omap_mux_init_gpio - initialize a signal based on the GPIO number
+ * @gpio:		GPIO number
+ * @val:		Options for the mux register value
+ */
+int omap_mux_init_gpio(int gpio, int val);
+
+/**
+ * omap_mux_init_signal - initialize a signal based on the signal name
+ * @muxname:		Mux name in mode0_name.signal_name format
+ * @val:		Options for the mux register value
+ */
+int omap_mux_init_signal(char *muxname, int val);
+
+/**
+ * omap_mux_init - private mux init function, do not call
+ */
+int omap_mux_init(u32 mux_pbase, u32 mux_size,
+				struct omap_mux *superset,
+				struct omap_mux *package_subset,
+				struct omap_board_mux *board_mux,
+				struct omap_ball *package_balls);
+
+#else
+
+static inline int omap3_mux_init(struct omap_board_mux *board_mux,
+					int flags)
+{
+	return 0;
+}
+static inline int omap_mux_init_gpio(int gpio, int val)
+{
+	return 0;
+}
+static inline int omap_mux_init_signal(char *muxname, int val)
+{
+	return 0;
+}
+
+#endif
diff --git a/arch/arm/plat-omap/mux.c b/arch/arm/plat-omap/mux.c
index 05aebca..0670363 100644
--- a/arch/arm/plat-omap/mux.c
+++ b/arch/arm/plat-omap/mux.c
@@ -54,8 +54,12 @@ int __init_or_module omap_cfg_reg(const unsigned long index)
 {
 	struct pin_config *reg;
 
-	if (cpu_is_omap44xx())
-		return 0;
+	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
+		printk(KERN_ERR "mux: Broken omap_cfg_reg(%lu) entry\n",
+				index);
+		WARN_ON(1);
+		return -EINVAL;
+	}
 
 	if (mux_cfg == NULL) {
 		printk(KERN_ERR "Pin mux table not initialized\n");


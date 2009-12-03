From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/9] omap: mux: Add debugfs support for new mux code
Date: Wed, 02 Dec 2009 16:22:12 -0800
Message-ID: <20091203002212.2769.29650.stgit@localhost>
References: <20091203001601.2769.20621.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59208 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbZLCAWG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 19:22:06 -0500
In-Reply-To: <20091203001601.2769.20621.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Add debugfs support for new mux code

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c |  227 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 227 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index b082b50..d968433 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -28,6 +28,10 @@
 #include <linux/io.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/ctype.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/uaccess.h>
 
 #include <asm/system.h>
 
@@ -44,6 +48,7 @@ struct omap_mux_entry {
 	struct list_head	node;
 };
 
+static unsigned long mux_phys;
 static void __iomem *mux_base;
 
 static inline u16 omap_mux_read(u16 reg)
@@ -807,6 +812,225 @@ int __init omap_mux_init_signal(char *muxname, int val)
 	return -ENODEV;
 }
 
+#ifdef CONFIG_DEBUG_FS
+
+#define OMAP_MUX_MAX_NR_FLAGS	10
+#define OMAP_MUX_TEST_FLAG(val, mask)				\
+	if (((val) & (mask)) == (mask)) {			\
+		i++;						\
+		flags[i] =  #mask;				\
+	}
+
+/* REVISIT: Add checking for non-optimal mux settings */
+static inline void omap_mux_decode(struct seq_file *s, u16 val)
+{
+	char *flags[OMAP_MUX_MAX_NR_FLAGS];
+	char mode[14];
+	int i = -1;
+
+	sprintf(mode, "OMAP_MUX_MODE%d", val & 0x7);
+	i++;
+	flags[i] = mode;
+
+	OMAP_MUX_TEST_FLAG(val, OMAP_PIN_OFF_WAKEUPENABLE);
+	if (val & OMAP_OFF_EN) {
+		if (!(val & OMAP_OFFOUT_EN)) {
+			if (!(val & OMAP_OFF_PULL_UP)) {
+				OMAP_MUX_TEST_FLAG(val,
+					OMAP_PIN_OFF_INPUT_PULLDOWN);
+			} else {
+				OMAP_MUX_TEST_FLAG(val,
+					OMAP_PIN_OFF_INPUT_PULLUP);
+			}
+		} else {
+			if (!(val & OMAP_OFFOUT_VAL)) {
+				OMAP_MUX_TEST_FLAG(val,
+					OMAP_PIN_OFF_OUTPUT_LOW);
+			} else {
+				OMAP_MUX_TEST_FLAG(val,
+					OMAP_PIN_OFF_OUTPUT_HIGH);
+			}
+		}
+	}
+
+	if (val & OMAP_INPUT_EN) {
+		if (val & OMAP_PULL_ENA) {
+			if (!(val & OMAP_PULL_UP)) {
+				OMAP_MUX_TEST_FLAG(val,
+					OMAP_PIN_INPUT_PULLDOWN);
+			} else {
+				OMAP_MUX_TEST_FLAG(val, OMAP_PIN_INPUT_PULLUP);
+			}
+		} else {
+			OMAP_MUX_TEST_FLAG(val, OMAP_PIN_INPUT);
+		}
+	} else {
+		i++;
+		flags[i] = "OMAP_PIN_OUTPUT";
+	}
+
+	do {
+		seq_printf(s, "%s", flags[i]);
+		if (i > 0)
+			seq_printf(s, " | ");
+	} while (i-- > 0);
+}
+
+#define OMAP_MUX_DEFNAME_LEN	16
+
+static int omap_mux_dbg_board_show(struct seq_file *s, void *unused)
+{
+	struct omap_mux_entry *e;
+
+	list_for_each_entry(e, &muxmodes, node) {
+		struct omap_mux *m = &e->mux;
+		char m0_def[OMAP_MUX_DEFNAME_LEN];
+		char *m0_name = m->muxnames[0];
+		u16 val;
+		int i, mode;
+
+		if (!m0_name)
+			continue;
+
+		for (i = 0; i < OMAP_MUX_DEFNAME_LEN; i++) {
+			if (m0_name[i] == '\0') {
+				m0_def[i] = m0_name[i];
+				break;
+			}
+			m0_def[i] = toupper(m0_name[i]);
+		}
+		val = omap_mux_read(m->reg_offset);
+		mode = val & OMAP_MUX_MODE7;
+
+		seq_printf(s, "OMAP%i_MUX(%s, ",
+					cpu_is_omap34xx() ? 3 : 0, m0_def);
+		omap_mux_decode(s, val);
+		seq_printf(s, "),\n");
+	}
+
+	return 0;
+}
+
+static int omap_mux_dbg_board_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, omap_mux_dbg_board_show, &inode->i_private);
+}
+
+static const struct file_operations omap_mux_dbg_board_fops = {
+	.open		= omap_mux_dbg_board_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int omap_mux_dbg_signal_show(struct seq_file *s, void *unused)
+{
+	struct omap_mux *m = s->private;
+	const char *none = "NA";
+	u16 val;
+	int mode;
+
+	val = omap_mux_read(m->reg_offset);
+	mode = val & OMAP_MUX_MODE7;
+
+	seq_printf(s, "name: %s.%s (0x%08lx/0x%03x = 0x%04x), b %s, t %s\n",
+			m->muxnames[0], m->muxnames[mode],
+			mux_phys + m->reg_offset, m->reg_offset, val,
+			m->balls[0] ? m->balls[0] : none,
+			m->balls[1] ? m->balls[1] : none);
+	seq_printf(s, "mode: ");
+	omap_mux_decode(s, val);
+	seq_printf(s, "\n");
+	seq_printf(s, "signals: %s | %s | %s | %s | %s | %s | %s | %s\n",
+			m->muxnames[0] ? m->muxnames[0] : none,
+			m->muxnames[1] ? m->muxnames[1] : none,
+			m->muxnames[2] ? m->muxnames[2] : none,
+			m->muxnames[3] ? m->muxnames[3] : none,
+			m->muxnames[4] ? m->muxnames[4] : none,
+			m->muxnames[5] ? m->muxnames[5] : none,
+			m->muxnames[6] ? m->muxnames[6] : none,
+			m->muxnames[7] ? m->muxnames[7] : none);
+
+	return 0;
+}
+
+#define OMAP_MUX_MAX_ARG_CHAR  7
+
+static ssize_t omap_mux_dbg_signal_write(struct file *file,
+						const char __user *user_buf,
+						size_t count, loff_t *ppos)
+{
+	char buf[OMAP_MUX_MAX_ARG_CHAR];
+	struct seq_file *seqf;
+	struct omap_mux *m;
+	unsigned long val;
+	int buf_size, ret;
+
+	if (count > OMAP_MUX_MAX_ARG_CHAR)
+		return -EINVAL;
+
+	memset(buf, 0, sizeof(buf));
+	buf_size = min(count, sizeof(buf) - 1);
+
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	ret = strict_strtoul(buf, 0x10, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val > 0xffff)
+		return -EINVAL;
+
+	seqf = file->private_data;
+	m = seqf->private;
+
+	omap_mux_write((u16)val, m->reg_offset);
+	*ppos += count;
+
+	return count;
+}
+
+static int omap_mux_dbg_signal_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, omap_mux_dbg_signal_show, inode->i_private);
+}
+
+static const struct file_operations omap_mux_dbg_signal_fops = {
+	.open		= omap_mux_dbg_signal_open,
+	.read		= seq_read,
+	.write		= omap_mux_dbg_signal_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static struct dentry *mux_dbg_dir;
+
+static void __init omap_mux_dbg_init(void)
+{
+	struct omap_mux_entry *e;
+
+	mux_dbg_dir = debugfs_create_dir("omap_mux", NULL);
+	if (!mux_dbg_dir)
+		return;
+
+	(void)debugfs_create_file("board", S_IRUGO, mux_dbg_dir,
+					NULL, &omap_mux_dbg_board_fops);
+
+	list_for_each_entry(e, &muxmodes, node) {
+		struct omap_mux *m = &e->mux;
+
+		(void)debugfs_create_file(m->muxnames[0], S_IWUGO, mux_dbg_dir,
+					m, &omap_mux_dbg_signal_fops);
+	}
+}
+
+#else
+static inline void omap_mux_dbg_init(void)
+{
+}
+#endif	/* CONFIG_DEBUG_FS */
+
 static void __init omap_mux_free_names(struct omap_mux *m)
 {
 	int i;
@@ -843,6 +1067,8 @@ static int __init omap_mux_late_init(void)
 
 	}
 
+	omap_mux_dbg_init();
+
 	return 0;
 }
 late_initcall(omap_mux_late_init);
@@ -1107,6 +1333,7 @@ int __init omap_mux_init(u32 mux_pbase, u32 mux_size,
 	if (mux_base)
 		return -EBUSY;
 
+	mux_phys = mux_pbase;
 	mux_base = ioremap(mux_pbase, mux_size);
 	if (!mux_base) {
 		printk(KERN_ERR "mux: Could not ioremap\n");


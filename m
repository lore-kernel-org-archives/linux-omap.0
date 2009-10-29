From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/5] omap: mux: Add debugfs support for new mux code
Date: Thu, 29 Oct 2009 13:36:54 -0700
Message-ID: <20091029203654.11843.87021.stgit@localhost>
References: <20091029203124.11843.89983.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63456 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394AbZJ2Ugu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 16:36:50 -0400
In-Reply-To: <20091029203124.11843.89983.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: mike.rapoport@gmail.com

Add debugfs support for new mux code

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c |  143 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 143 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 45e6d4d..a31bcfa 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -28,6 +28,9 @@
 #include <linux/io.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/ctype.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
 
 #include <asm/system.h>
 
@@ -780,6 +783,146 @@ static void __init omap_mux_apply_pins(struct omap_ball *b,
 	}
 }
 
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
+	} else {
+		i++;
+		flags[i] = "OMAP_PIN_OFF_NONE";
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
+		}
+		OMAP_MUX_TEST_FLAG(val, OMAP_PIN_INPUT);
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
+static int omap_mux_dbg_show(struct seq_file *s, void *unused)
+{
+	struct omap_mux_entry *e;
+
+	list_for_each_entry_reverse(e, &muxmodes, node) {
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
+		mode = val & 0x7;
+
+		seq_printf(s, "OMAP%i_MUX(%s, ",
+					cpu_is_omap34xx() ? 3: 0, m0_def);
+		omap_mux_decode(s, val);
+		seq_printf(s, ", 0),\n");
+
+		seq_printf(s, "padconf: %s\tsignal: %s:\toffset: 0x%03x\t"
+			"value: 0x%04x\n",
+			m->muxnames[0], m->muxnames[mode], m->reg_offset, val);
+		seq_printf(s, "m0: %-11s\tm1: %-10s\tm2: %-10s\tm3: %-10s\n"
+			"m4: %-10s\tm5: %-10s\tm6: %-10s\tm7: %-10s\n",
+			m->muxnames[0] ? m->muxnames[0] : "",
+			m->muxnames[1] ? m->muxnames[1] : "",
+			m->muxnames[2] ? m->muxnames[2] : "",
+			m->muxnames[3] ? m->muxnames[3] : "",
+			m->muxnames[4] ? m->muxnames[4] : "",
+			m->muxnames[5] ? m->muxnames[5] : "",
+			m->muxnames[6] ? m->muxnames[6] : "",
+			m->muxnames[7] ? m->muxnames[7] : "");
+		seq_printf(s, "phys: 0x%08lx\tball bottom: %s\t "
+			"ball top: %s\n\n",
+			cpu_is_omap34xx() ?
+			OMAP3_CONTROL_PADCONF_MUX_PBASE + m->reg_offset : 0,
+			m->balls[0] ? m->balls[0] : "",
+			m->balls[1] ? m->balls[1] : "");
+	}
+
+	return 0;
+}
+
+static int omap_mux_dbg_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, omap_mux_dbg_show, &inode->i_private);
+}
+
+static const struct file_operations omap_mux_dbg_fops = {
+	.open		= omap_mux_dbg_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init omap_mux_dbg_init(void)
+{
+	(void)debugfs_create_file("omap_mux", S_IRUGO, NULL, NULL,
+					&omap_mux_dbg_fops);
+
+	return 0;
+}
+late_initcall(omap_mux_dbg_init);
+
 #else	/* CONFIG_DEBUG_FS */
 
 static inline void omap_mux_apply_pins(struct omap_ball *b,


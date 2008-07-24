From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 1/3] Power off on state counter debugging
Date: Thu, 24 Jul 2008 16:00:32 +0300
Message-ID: <1216904434-7545-2-git-send-email-peter.de-schrijver@nokia.com>
References: <1216904434-7545-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:24094 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601AbYGXNBX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jul 2008 09:01:23 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m6OD0o9x021150
	for <linux-omap@vger.kernel.org>; Thu, 24 Jul 2008 08:01:21 -0500
In-Reply-To: <1216904434-7545-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/Makefile                  |    2 +-
 arch/arm/mach-omap2/off-state-counter-debug.c |   50 +++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/off-state-counter-debug.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 0d8507c..a48f832 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -5,7 +5,7 @@
 # Common support
 obj-y := irq.o id.o io.o memory.o control.o prcm.o clock.o mux.o \
 		devices.o serial.o gpmc.o timer-gp.o powerdomain.o \
-		clockdomain.o
+		clockdomain.o off-state-counter-debug.o
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
diff --git a/arch/arm/mach-omap2/off-state-counter-debug.c b/arch/arm/mach-omap2/off-state-counter-debug.c
new file mode 100644
index 0000000..7db54b6
--- /dev/null
+++ b/arch/arm/mach-omap2/off-state-counter-debug.c
@@ -0,0 +1,50 @@
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <asm/arch/powerdomain.h>
+
+
+int show_off_mode_count(struct powerdomain *pwrdm, void *user)
+{
+	struct seq_file *s = (struct seq_file *)user;
+
+	if (strcmp(pwrdm->name, "emu_pwrdm") &&
+		strcmp(pwrdm->name, "wkup_pwrdm"))
+		seq_printf(s, "%s : %d\n", pwrdm->name, pwrdm->offstate_count);
+
+	return 0;
+}
+
+int show_off_mode_counters(struct seq_file *s, void *unused)
+{
+	pwrdm_for_each(show_off_mode_count, s);
+
+	return 0;
+}
+
+static int off_mode_counter_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, show_off_mode_counters, &inode->i_private);
+}
+
+static const struct file_operations debug_fops = {
+	.open	= off_mode_counter_open,
+	.read	= seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int __init off_mode_counter_debug(void)
+{
+	struct dentry *d;
+
+	d = debugfs_create_dir("off_mode_counters", NULL);
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+
+	debugfs_create_file("count", S_IRUGO,
+				d, NULL, &debug_fops);
+
+	return 0;
+}
+
+late_initcall(off_mode_counter_debug);
-- 
1.5.6.3


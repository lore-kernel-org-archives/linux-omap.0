From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] Powerdomain debugging
Date: Fri,  5 Sep 2008 16:21:23 +0300
Message-ID: <1220620885-6096-2-git-send-email-peter.de-schrijver@nokia.com>
References: <1220620885-6096-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:64871 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbYIENWO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 09:22:14 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m85DLqfO008634
	for <linux-omap@vger.kernel.org>; Fri, 5 Sep 2008 16:22:11 +0300
In-Reply-To: <1220620885-6096-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/Makefile            |    2 +-
 arch/arm/mach-omap2/powerdomain-debug.c |   50 +++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/powerdomain-debug.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index d89b7cb..e1adb0e 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -24,7 +24,7 @@ obj-y					+= pm.o
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP24XX)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
-obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
+obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o powerdomain-debug.o
 endif
 
 # SmartReflex driver
diff --git a/arch/arm/mach-omap2/powerdomain-debug.c b/arch/arm/mach-omap2/powerdomain-debug.c
new file mode 100644
index 0000000..dda88e1
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomain-debug.c
@@ -0,0 +1,50 @@
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <mach/powerdomain.h>
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


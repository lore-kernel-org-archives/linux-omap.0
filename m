From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH: NOT FOR MERGING] clk_set_rate debugfs patch
Date: Tue, 8 Jul 2008 17:54:17 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0807081750060.12684@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40991 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672AbYGHXyR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2008 19:54:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, Hiroshi.DOYU@nokia.com, r-woodruff2@ti.com


Hi,

this patch allows one to set the rate of clocks without id fields from 
debugfs.  It also supports round_rate testing via debugfs also.
This is not for merging, at least not yet.  But people out there who are 
hacking on OMAP clock code may find it useful.

Here's an example:

mount -t debugfs none /debug
cd /debug/clock/virt_26m_ck/osc_sys_ck/sys_ck/dpll3_ck/dpll3_m2_ck

echo -n 166666666 > roundrate
echo -n 165941176 > rate

echo -n 331882352 > rate


- Paul

---

 arch/arm/plat-omap/clock.c |  119 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 118 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index c2e741d..5873f38 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/cpufreq.h>
 #include <linux/debugfs.h>
+#include <linux/uaccess.h>
 
 #include <asm/io.h>
 
@@ -418,6 +419,115 @@ int __init clk_init(struct clk_functions * custom_clocks)
  */
 static struct dentry *clk_debugfs_root;
 
+#define RBUFSIZE 11  /* strlen(2^sizeof(unsigned long)) + 1 */
+
+static ssize_t clk_debugfs_rate_read(struct file *f, char __user *userbuf,
+				     size_t count, loff_t *offs)
+{
+	struct clk *clk;
+	char buf[RBUFSIZE];
+	ssize_t ssize;
+
+	/*
+	 * XXX This is not going to work for clocks with an id number
+	 * appended
+	 */
+	clk = clk_get(NULL, f->f_dentry->d_parent->d_name.name);
+	if (!clk) {
+		pr_err("Cannot find clock named %s",
+		       f->f_dentry->d_parent->d_name.name);
+		return -EINVAL;
+	}
+
+	ssize = snprintf(buf, RBUFSIZE, "%lu", clk_get_rate(clk));
+
+	return simple_read_from_buffer(userbuf, count, offs, buf, ssize);
+}
+
+static ssize_t clk_debugfs_rate_write(struct file *f,
+				      const char __user *userbuf,
+				      size_t count, loff_t *offs)
+{
+	char buf[RBUFSIZE];
+	int buf_size;
+	unsigned long val;
+	int rrval;
+	struct clk *clk;
+
+	buf_size = min(count, (size_t)(RBUFSIZE - 1));
+	if (copy_from_user(buf, userbuf, buf_size))
+		return -EFAULT;
+	buf[buf_size] = '\0';
+
+	/*
+	 * XXX This is not going to work for clocks with an id number
+	 * appended
+	 */
+	clk = clk_get(NULL, f->f_dentry->d_parent->d_name.name);
+	if (!clk) {
+		pr_err("Cannot find clock named %s",
+		       f->f_dentry->d_parent->d_name.name);
+		return -EINVAL;
+	}
+
+	if (sscanf(buf, "%lu", &val) == 1) {
+		rrval = clk_set_rate(clk, val);
+
+		pr_info("clk: clk_set_rate(%s, %ld) returns %d\n", clk->name,
+			val, rrval);
+
+		return buf_size;
+	}
+	return -EINVAL;
+}
+
+static const struct file_operations clk_debugfs_rate_fops = {
+	.read = &clk_debugfs_rate_read,
+	.write = &clk_debugfs_rate_write,
+};
+
+
+static ssize_t clk_debugfs_roundrate_write(struct file *f,
+					   const char __user *userbuf,
+					   size_t count, loff_t *offs)
+{
+	char buf[RBUFSIZE];
+	int buf_size;
+	unsigned long val;
+	int rrval;
+	struct clk *clk;
+
+	buf_size = min(count, (size_t)(RBUFSIZE - 1));
+	if (copy_from_user(buf, userbuf, buf_size))
+		return -EFAULT;
+	buf[buf_size] = '\0';
+
+	/*
+	 * XXX This is not going to work for clocks with an id number
+	 * appended
+	 */
+	clk = clk_get(NULL, f->f_dentry->d_parent->d_name.name);
+	if (!clk) {
+		pr_err("Cannot find clock named %s",
+		       f->f_dentry->d_parent->d_name.name);
+		return -EINVAL;
+	}
+
+	if (sscanf(buf, "%lu", &val) == 1) {
+		rrval = clk_round_rate(clk, val);
+
+		pr_info("clk: %s: rounded rate from %ld to %ld\n",
+			clk->name, val, rrval);
+
+		return buf_size;
+	}
+	return -EINVAL;
+}
+
+static const struct file_operations clk_debugfs_roundrate_fops = {
+	.write = &clk_debugfs_roundrate_write,
+};
+
 static int clk_debugfs_register_one(struct clk *c)
 {
 	int err;
@@ -439,7 +549,14 @@ static int clk_debugfs_register_one(struct clk *c)
 		err = PTR_ERR(d);
 		goto err_out;
 	}
-	d = debugfs_create_u32("rate", S_IRUGO, c->dent, (u32 *)&c->rate);
+	d = debugfs_create_file("rate", S_IRUGO | S_IWUSR, c->dent,
+				NULL, &clk_debugfs_rate_fops);
+	if (IS_ERR(d)) {
+		err = PTR_ERR(d);
+		goto err_out;
+	}
+	d = debugfs_create_file("roundrate", S_IWUSR, c->dent,
+				NULL, &clk_debugfs_roundrate_fops);
 	if (IS_ERR(d)) {
 		err = PTR_ERR(d);
 		goto err_out;

From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: [RFC PATCH v2 6/6] ARM: OMAP3+: ABB: introduce debugfs entry
Date: Mon, 15 Apr 2013 16:28:11 +0300
Message-ID: <1366032491-4162-7-git-send-email-andrii.tseglytskyi@ti.com>
References: <1366032491-4162-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39390 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075Ab3DON2X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Apr 2013 09:28:23 -0400
In-Reply-To: <1366032491-4162-1-git-send-email-andrii.tseglytskyi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>

From: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>

Patch adds debugfs entry for each ABB:
/sys/kernel/debug/<ABB device name>

This entry is read-only. It prints current state of ABB.

Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi@ti.com>
---
 drivers/regulator/abb-regulator.c |   74 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/abb-regulator.c b/drivers/regulator/abb-regulator.c
index 5a828e2..dad517d 100644
--- a/drivers/regulator/abb-regulator.c
+++ b/drivers/regulator/abb-regulator.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/opp.h>
+#include <linux/debugfs.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
@@ -440,6 +441,74 @@ static struct regulator_ops omap_abb_reg_ops = {
 };
 
 /*
+ * omap_abb_info_dump() - ABB debug dump
+ *
+ * Returns 0
+ */
+static int omap_abb_info_dump(struct seq_file *sf, void *unused)
+{
+	const struct omap_abb *abb = (struct omap_abb *)sf->private;
+	struct opp *opp;
+	u32 abb_ctrl, abb_setup;
+	unsigned long freq = 0;
+
+	if (!abb) {
+		seq_printf(sf, "No ABB defined\n");
+		goto err;
+	}
+
+	abb_ctrl =  omap_abb_readl(abb, abb->data.control_offs);
+	abb_setup = omap_abb_readl(abb, abb->data.setup_offs);
+	seq_printf(sf, "Enabled\t->\t%d\n"
+		   "opp_sel\t->\t%u\n"
+		   "FBB mode\t->\t%u\n"
+		   "RBB mode\t->\t%u\n"
+		   "PRM_LDO_ABB_XXX_SETUP\t->\t0x%08x\n"
+		   "PRM_LDO_ABB_XXX_CTRL\t->\t0x%08x\n",
+		   !!(abb_setup & abb->data.sr2en_mask),
+		   abb->opp_sel,
+		   !!(abb_setup & abb->data.fbb_sel_mask),
+		   !!(abb_setup & abb->data.rbb_sel_mask),
+		   abb_setup,
+		   abb_ctrl);
+
+	seq_printf(sf, "OPP table\n");
+	rcu_read_lock();
+	do {
+		opp = opp_find_freq_ceil(abb->dev, &freq);
+		if (IS_ERR(opp))
+			break;
+
+		seq_printf(sf, "Voltage (%lu) ABB (%lu)\n",
+			   opp_get_freq(opp) / 1000,
+			   opp_get_voltage(opp));
+
+		freq++;
+	} while (1);
+	rcu_read_unlock();
+
+err:
+	return 0;
+}
+
+/*
+ * omap_abb_fops_open() - debugfs "open" callback
+ *
+ * Returns 0 on success or error code otherwise
+ */
+static int omap_abb_fops_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, omap_abb_info_dump, inode->i_private);
+}
+
+static const struct file_operations omap_abb_debug_fops = {
+	.open = omap_abb_fops_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+/*
  * omap_abb_init_timings() - Initialize ABB timings
  * @abb:	pointer to the ABB instance
  *
@@ -507,7 +576,6 @@ static int __init omap_abb_init_timings(struct omap_abb *abb)
 	clk_put(sys_clk);
 	return 0;
 }
-
 /*
  * omap_abb_probe() - Initialize an ABB ldo instance
  * @pdev: ABB platform device
@@ -615,6 +683,10 @@ static int __init omap_abb_probe(struct platform_device *pdev)
 	if (IS_ERR(abb->supply_reg))
 		abb->supply_reg = NULL;
 
+	/* create debugfs entry */
+	debugfs_create_file(dev_name(&pdev->dev), S_IRUGO, NULL,
+			    abb, &omap_abb_debug_fops);
+
 	return 0;
 
 err:
-- 
1.7.9.5


From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: [PATCH 6/6] ARM: OMAP3+: ABB: introduce debugfs entry
Date: Thu, 28 Mar 2013 19:16:08 +0200
Message-ID: <1364490968-13613-6-git-send-email-andrii.tseglytskyi@ti.com>
References: <1364490968-13613-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45461 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756932Ab3C1RQm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 13:16:42 -0400
In-Reply-To: <1364490968-13613-1-git-send-email-andrii.tseglytskyi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-patch-review@list.ti.com
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, linux-omap@vger.kernel.org

=46rom: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>

Patch adds debugfs entry for each ABB:
/sys/kernel/debug/<ABB device name>

This entry is read-only. It prints current state of ABB.

Cc: Mike Turquette <mturquette@linaro.org>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org

Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi@ti.com>
---
 drivers/power/avs/abb.c |   64 +++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/power/avs/abb.c b/drivers/power/avs/abb.c
index f5bbb8d..ac43841 100644
--- a/drivers/power/avs/abb.c
+++ b/drivers/power/avs/abb.c
@@ -19,6 +19,7 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/opp.h>
+#include <linux/debugfs.h>
=20
 /* NOMINAL_OPP bypasses the ABB ldo, FAST_OPP sets it to Forward Body-=
Bias */
 #define OMAP_ABB_NOMINAL_OPP	0
@@ -410,6 +411,66 @@ static const struct of_device_id __initdata omap_a=
bb_of_match[] =3D {
 MODULE_DEVICE_TABLE(of, omap_abb_of_match);
 #endif
=20
+static int omap_abb_info_dump(struct seq_file *sf, void *unused)
+{
+	struct opp *opp;
+	struct omap_abb *abb =3D (struct omap_abb *)sf->private;
+	u32 abb_ctrl, abb_setup, rate;
+	unsigned long freq =3D 0;
+
+	if (!abb) {
+		seq_printf(sf, "No ABB defined\n");
+		goto out;
+	}
+
+	abb_ctrl =3D  omap_abb_readl(abb, abb->data.control_offs);
+	abb_setup =3D omap_abb_readl(abb, abb->data.setup_offs);
+	rate =3D clk_get_rate(abb->notify_clk);
+	seq_printf(sf, "Enabled\t->\t%d\n"
+		   "opp_sel\t->\t%u\n"
+		   "FBB mode\t->\t%u\n"
+		   "RBB mode\t->\t%u\n"
+		   "PRM_LDO_ABB_XXX_SETUP\t->\t0x%08x\n"
+		   "PRM_LDO_ABB_XXX_CTRL\t->\t0x%08x\n"
+		   "Notify clk\t->\t(%s) rate (%u)\n",
+		   !!(abb_setup & abb->data.sr2en_mask),
+		   abb->opp_sel,
+		   !!(abb_setup & abb->data.fbb_sel_mask),
+		   !!(abb_setup & abb->data.rbb_sel_mask),
+		   abb_setup,
+		   abb_ctrl,
+		   __clk_get_name(abb->notify_clk), rate);
+
+	seq_printf(sf, "OPP table\n");
+	rcu_read_lock();
+	do {
+		opp =3D opp_find_freq_ceil(abb->dev, &freq);
+		if (IS_ERR(opp))
+			break;
+
+		seq_printf(sf, "Freq (%lu) ABB (%lu)\n", opp_get_freq(opp),
+			   opp_get_voltage(opp));
+
+		freq++;
+	} while (1);
+	rcu_read_unlock();
+
+out:
+	return 0;
+}
+
+static int omap_abb_fops_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, omap_abb_info_dump, inode->i_private);
+}
+
+static const struct file_operations omap_abb_debug_fops =3D {
+	.open =3D omap_abb_fops_open,
+	.read =3D seq_read,
+	.llseek =3D seq_lseek,
+	.release =3D single_release,
+};
+
 /*
  * omap_abb_probe() - Initialize an ABB ldo instance
  * @pdev: ABB platform device
@@ -544,6 +605,9 @@ static int __init omap_abb_probe(struct platform_de=
vice *pdev)
 		omap_abb_rmw(abb, abb->data.sr2en_mask,
 			     abb->data.sr2en_mask, abb->data.setup_offs);
=20
+	debugfs_create_file(dev_name(abb->dev), S_IRUGO, NULL,
+			    abb, &omap_abb_debug_fops);
+
 	clk_put(sys_clk);
 	return 0;
=20
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

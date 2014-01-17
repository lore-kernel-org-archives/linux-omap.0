From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v4 1/2] usb: musb: dsps, debugfs files
Date: Fri, 17 Jan 2014 10:22:35 +0100
Message-ID: <1389950556-6453-2-git-send-email-mpa@pengutronix.de>
References: <1389950556-6453-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389950556-6453-1-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Bin Liu <binmlist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

debugfs files to show the contents of important dsps registers.

Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/usb/musb/musb_dsps.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 593d3c9..d0a97d6 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -46,6 +46,8 @@
 #include <linux/of_irq.h>
 #include <linux/usb/of.h>
 
+#include <linux/debugfs.h>
+
 #include "musb_core.h"
 
 static const struct of_device_id musb_dsps_of_match[];
@@ -137,6 +139,26 @@ struct dsps_glue {
 	unsigned long last_timer;    /* last timer data for each instance */
 
 	struct dsps_context context;
+	struct debugfs_regset32 regset;
+	struct dentry *dbgfs_root;
+};
+
+static const struct debugfs_reg32 dsps_musb_regs[] = {
+	{ "revision",		0x00 },
+	{ "control",		0x14 },
+	{ "status",		0x18 },
+	{ "eoi",		0x24 },
+	{ "intr0_stat",		0x30 },
+	{ "intr1_stat",		0x34 },
+	{ "intr0_set",		0x38 },
+	{ "intr1_set",		0x3c },
+	{ "txmode",		0x70 },
+	{ "rxmode",		0x74 },
+	{ "autoreq",		0xd0 },
+	{ "srpfixtime",		0xd4 },
+	{ "tdown",		0xd8 },
+	{ "phy_utmi",		0xe0 },
+	{ "mode",		0xe8 },
 };
 
 static void dsps_musb_try_idle(struct musb *musb, unsigned long timeout)
@@ -369,6 +391,30 @@ out:
 	return ret;
 }
 
+static int dsps_musb_dbg_init(struct musb *musb, struct dsps_glue *glue)
+{
+	struct dentry *root;
+	struct dentry *file;
+	char buf[128];
+
+	sprintf(buf, "%s.dsps", dev_name(musb->controller));
+	root = debugfs_create_dir(buf, NULL);
+	if (!root)
+		return -ENOMEM;
+	glue->dbgfs_root = root;
+
+	glue->regset.regs = dsps_musb_regs;
+	glue->regset.nregs = ARRAY_SIZE(dsps_musb_regs);
+	glue->regset.base = musb->ctrl_base;
+
+	file = debugfs_create_regset32("regdump", S_IRUGO, root, &glue->regset);
+	if (!file) {
+		debugfs_remove_recursive(root);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
 static int dsps_musb_init(struct musb *musb)
 {
 	struct device *dev = musb->controller;
@@ -378,6 +424,7 @@ static int dsps_musb_init(struct musb *musb)
 	void __iomem *reg_base;
 	struct resource *r;
 	u32 rev, val;
+	int ret;
 
 	r = platform_get_resource_byname(parent, IORESOURCE_MEM, "control");
 	if (!r)
@@ -411,6 +458,10 @@ static int dsps_musb_init(struct musb *musb)
 	val &= ~(1 << wrp->otg_disable);
 	dsps_writel(musb->ctrl_base, wrp->phy_utmi, val);
 
+	ret = dsps_musb_dbg_init(musb, glue);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -659,6 +710,9 @@ static int dsps_remove(struct platform_device *pdev)
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	kfree(glue);
+
+	debugfs_remove_recursive(glue->dbgfs_root);
+
 	return 0;
 }
 
-- 
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Juan Gutierrez <jgutierrez@ti.com>
Subject: [PATCH v2 3/3] omap: remoteproc: add support for a boot register
Date: Fri, 13 Apr 2012 18:39:52 -0500
Message-ID: <1334360392-1494-4-git-send-email-jgutierrez@ti.com>
References: <1334360392-1494-1-git-send-email-jgutierrez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:47610 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932125Ab2DMXkR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Apr 2012 19:40:17 -0400
Received: by obbwd18 with SMTP id wd18so5969716obb.2
        for <linux-omap@vger.kernel.org>; Fri, 13 Apr 2012 16:40:16 -0700 (PDT)
In-Reply-To: <1334360392-1494-1-git-send-email-jgutierrez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ohad@wizery.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Juan Gutierrez <jgutierrez@ti.com>, Suman Anna <s-anna@ti.com>

Some remote processors (like Omap4's DSP) need to explicitly
configure a boot address in a special register or memory
location, and this is the address from which they start
executing code when taken out of reset.

Support for this infrastructure has been added to remoteproc
code. The memory or register address where the boot address
is to be stored is supplied through the boot_reg field of the
platform data in the remoteproc. The omap_rproc_start function
will fetch the boot address from the image, and write this
address into the boot register, if provided, before taking the
processor out of reset.

Signed-off-by: Juan Gutierrez <jgutierrez@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/plat-omap/include/plat/remoteproc.h |    2 ++
 drivers/remoteproc/omap_remoteproc.c         |   19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/remoteproc.h b/arch/arm/plat-omap/include/plat/remoteproc.h
index b10eac8..2066a14 100644
--- a/arch/arm/plat-omap/include/plat/remoteproc.h
+++ b/arch/arm/plat-omap/include/plat/remoteproc.h
@@ -30,6 +30,7 @@ struct platform_device;
  * @ops: start/stop rproc handlers
  * @device_enable: omap-specific handler for enabling a device
  * @device_shutdown: omap-specific handler for shutting down a device
+ * @boot_reg: physical address of the control register for storing boot address
  */
 struct omap_rproc_pdata {
 	const char *name;
@@ -40,6 +41,7 @@ struct omap_rproc_pdata {
 	const struct rproc_ops *ops;
 	int (*device_enable) (struct platform_device *pdev);
 	int (*device_shutdown) (struct platform_device *pdev);
+	u32 boot_reg;
 };
 
 #if defined(CONFIG_OMAP_REMOTEPROC) || defined(CONFIG_OMAP_REMOTEPROC_MODULE)
diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index 69425c4..e9b2f85 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -39,11 +39,13 @@
  * @mbox: omap mailbox handle
  * @nb: notifier block that will be invoked on inbound mailbox messages
  * @rproc: rproc handle
+ * @boot_reg: virtual address of the register where the bootaddr is stored
  */
 struct omap_rproc {
 	struct omap_mbox *mbox;
 	struct notifier_block nb;
 	struct rproc *rproc;
+	void __iomem *boot_reg;
 };
 
 /**
@@ -114,6 +116,10 @@ static int omap_rproc_start(struct rproc *rproc)
 	struct omap_rproc_pdata *pdata = pdev->dev.platform_data;
 	int ret;
 
+	/* load remote processor boot address if needed. */
+	if (oproc->boot_reg)
+		writel(rproc->bootaddr, oproc->boot_reg);
+
 	oproc->nb.notifier_call = omap_rproc_mbox_callback;
 
 	/* every omap rproc is assigned a mailbox instance for messaging */
@@ -194,6 +200,12 @@ static int __devinit omap_rproc_probe(struct platform_device *pdev)
 	oproc = rproc->priv;
 	oproc->rproc = rproc;
 
+	if (pdata->boot_reg) {
+		oproc->boot_reg = ioremap(pdata->boot_reg, sizeof(u32));
+		if (!oproc->boot_reg)
+			goto err_ioremap;
+	}
+
 	platform_set_drvdata(pdev, rproc);
 
 	ret = rproc_register(rproc);
@@ -203,6 +215,9 @@ static int __devinit omap_rproc_probe(struct platform_device *pdev)
 	return 0;
 
 free_rproc:
+	if (oproc->boot_reg)
+		iounmap(oproc->boot_reg);
+err_ioremap:
 	rproc_free(rproc);
 	return ret;
 }
@@ -210,6 +225,10 @@ free_rproc:
 static int __devexit omap_rproc_remove(struct platform_device *pdev)
 {
 	struct rproc *rproc = platform_get_drvdata(pdev);
+	struct omap_rproc *oproc = rproc->priv;
+
+	if (oproc->boot_reg)
+		iounmap(oproc->boot_reg);
 
 	return rproc_unregister(rproc);
 }
-- 
1.7.1


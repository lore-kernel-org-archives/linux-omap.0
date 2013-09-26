From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 4/4] usb: musb: dsps: add support for suspend and resume
Date: Thu, 26 Sep 2013 15:09:02 +0200
Message-ID: <1380200942-28175-5-git-send-email-zonque@gmail.com>
References: <1380200942-28175-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:41297 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756986Ab3IZNJL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Sep 2013 09:09:11 -0400
In-Reply-To: <1380200942-28175-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, balbi@ti.com, gregkh@linuxfoundation.org, Daniel Mack <zonque@gmail.com>

The dsps platform needs to save save some registers at suspend time and
restore them after resume. This patch adds a struct for these registers,
and also lets the musb core know that the core registers need to be
saved as well.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/usb/musb/musb_dsps.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 4047cbb..c93c365 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -110,6 +110,17 @@ struct dsps_musb_wrapper {
 	u8		poll_seconds;
 };
 
+/*
+ * register shadow for suspend
+ */
+struct dsps_context {
+	u32 control;
+	u32 epintr;
+	u32 coreintr;
+	u32 phy_utmi;
+	u32 mode;
+};
+
 /**
  * DSPS glue structure.
  */
@@ -119,6 +130,8 @@ struct dsps_glue {
 	const struct dsps_musb_wrapper *wrp; /* wrapper register offsets */
 	struct timer_list timer;	/* otg_workaround timer */
 	unsigned long last_timer;    /* last timer data for each instance */
+
+	struct dsps_context context;
 };
 
 /**
@@ -502,6 +515,7 @@ static int dsps_create_musb_pdev(struct dsps_glue *glue,
 	}
 	pdata.config = config;
 	pdata.platform_ops = &dsps_ops;
+	pdata.restore_after_suspend = 1;
 
 	config->num_eps = get_int_prop(dn, "mentor,num-eps");
 	config->ram_bits = get_int_prop(dn, "mentor,ram-bits");
@@ -623,11 +637,51 @@ static const struct of_device_id musb_dsps_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, musb_dsps_of_match);
 
+#ifdef CONFIG_PM
+static int dsps_suspend(struct device *dev)
+{
+	struct dsps_glue *glue = dev_get_drvdata(dev);
+	const struct dsps_musb_wrapper *wrp = glue->wrp;
+	struct musb *musb = platform_get_drvdata(glue->musb);
+	void __iomem *mbase = musb->ctrl_base;
+
+	glue->context.control = dsps_readl(mbase, wrp->control);
+	glue->context.epintr = dsps_readl(mbase, wrp->epintr_set);
+	glue->context.coreintr = dsps_readl(mbase, wrp->coreintr_set);
+	glue->context.phy_utmi = dsps_readl(mbase, wrp->phy_utmi);
+	glue->context.mode = dsps_readl(mbase, wrp->mode);
+
+	return 0;
+}
+
+static int dsps_resume(struct device *dev)
+{
+	struct dsps_glue *glue = dev_get_drvdata(dev);
+	const struct dsps_musb_wrapper *wrp = glue->wrp;
+	struct musb *musb = platform_get_drvdata(glue->musb);
+	void __iomem *mbase = musb->ctrl_base;
+
+	dsps_writel(mbase, wrp->control, glue->context.control);
+	dsps_writel(mbase, wrp->epintr_set, glue->context.epintr);
+	dsps_writel(mbase, wrp->coreintr_set, glue->context.coreintr);
+	dsps_writel(mbase, wrp->phy_utmi, glue->context.phy_utmi);
+	dsps_writel(mbase, wrp->mode, glue->context.mode);
+
+	musb->port_reset_state = false;
+	schedule_work(&musb->port_reset_work);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(dsps_pm_ops, dsps_suspend, dsps_resume);
+
 static struct platform_driver dsps_usbss_driver = {
 	.probe		= dsps_probe,
 	.remove         = dsps_remove,
 	.driver         = {
 		.name   = "musb-dsps",
+		.pm	= &dsps_pm_ops,
 		.of_match_table	= of_match_ptr(musb_dsps_of_match),
 	},
 };
-- 
1.8.3.1


From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3] usb: musb: dsps: add support for suspend and resume
Date: Tue,  1 Oct 2013 18:12:01 +0200
Message-ID: <1380643921-20642-1-git-send-email-zonque@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The dsps platform needs to save save some registers at suspend time and
restore them after resume. This patch adds a struct for these registers,
and also lets the musb core know that the core registers need to be
saved as well.

Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/musb_dsps.c | 60 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 5eba143..f2f4b3a 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -112,6 +112,19 @@ struct dsps_musb_wrapper {
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
+	u32 tx_mode;
+	u32 rx_mode;
+};
+
 /**
  * DSPS glue structure.
  */
@@ -121,6 +134,8 @@ struct dsps_glue {
 	const struct dsps_musb_wrapper *wrp; /* wrapper register offsets */
 	struct timer_list timer;	/* otg_workaround timer */
 	unsigned long last_timer;    /* last timer data for each instance */
+
+	struct dsps_context context;
 };
 
 /**
@@ -504,6 +519,7 @@ static int dsps_create_musb_pdev(struct dsps_glue *glue,
 	}
 	pdata.config = config;
 	pdata.platform_ops = &dsps_ops;
+	pdata.restore_after_suspend = 1;
 
 	config->num_eps = get_int_prop(dn, "mentor,num-eps");
 	config->ram_bits = get_int_prop(dn, "mentor,ram-bits");
@@ -627,11 +643,55 @@ static const struct of_device_id musb_dsps_of_match[] = {
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
+	glue->context.tx_mode = dsps_readl(mbase, wrp->tx_mode);
+	glue->context.rx_mode = dsps_readl(mbase, wrp->rx_mode);
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
+	dsps_writel(mbase, wrp->tx_mode, glue->context.tx_mode);
+	dsps_writel(mbase, wrp->rx_mode, glue->context.rx_mode);
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
 		.of_match_table	= musb_dsps_of_match,
 	},
 };
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

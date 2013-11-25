From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 4/4] usb: musb: dsps: add support for suspend and resume
Date: Mon, 25 Nov 2013 22:26:43 +0100
Message-ID: <1385414803-13212-5-git-send-email-zonque@gmail.com>
References: <1385414803-13212-1-git-send-email-zonque@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385414803-13212-1-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The dsps platform needs to save save some registers at suspend time and
restore them after resume. This patch adds a struct for these registers,
and also lets the musb core know that the core registers need to be
saved as well.

We also have to explicitly de-assert the port reset upon resume on this
platform, but musb_port_reset() should not be called from glue layers.

Hence, introduce a flag in struct musb_hdrc_config for this.

Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/musb_dsps.c    | 60 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/musb/musb_host.c    |  7 ++++-
 drivers/usb/musb/musb_host.h    |  2 ++
 drivers/usb/musb/musb_virthub.c |  2 +-
 include/linux/usb/musb.h        |  3 +++
 5 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index e57d712..4a6ab1a 100644
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
 
 static void dsps_musb_try_idle(struct musb *musb, unsigned long timeout)
@@ -506,9 +521,11 @@ static int dsps_create_musb_pdev(struct dsps_glue *glue,
 	}
 	pdata.config = config;
 	pdata.platform_ops = &dsps_ops;
+	pdata.restore_after_suspend = 1;
 
 	config->num_eps = get_int_prop(dn, "mentor,num-eps");
 	config->ram_bits = get_int_prop(dn, "mentor,ram-bits");
+	config->host_port_deassert_reset_at_resume = 1;
 	pdata.mode = get_musb_port_mode(dev);
 	/* DT keeps this entry in mA, musb expects it as per USB spec */
 	pdata.power = get_int_prop(dn, "mentor,power") / 2;
@@ -632,11 +649,54 @@ static const struct of_device_id musb_dsps_of_match[] = {
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
+	//musb_port_reset(musb, false);
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
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 81caf9f..8224138 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -2464,7 +2464,12 @@ static int musb_bus_suspend(struct usb_hcd *hcd)
 
 static int musb_bus_resume(struct usb_hcd *hcd)
 {
-	/* resuming child port does the work */
+	struct musb *musb = hcd_to_musb(hcd);
+
+	if (musb->config &&
+	    musb->config->host_port_deassert_reset_at_resume)
+		musb_port_reset(musb, false);
+
 	return 0;
 }
 
diff --git a/drivers/usb/musb/musb_host.h b/drivers/usb/musb/musb_host.h
index e660af9..7436c24 100644
--- a/drivers/usb/musb/musb_host.h
+++ b/drivers/usb/musb/musb_host.h
@@ -93,6 +93,7 @@ extern void musb_root_disconnect(struct musb *musb);
 extern void musb_host_resume_root_hub(struct musb *musb);
 extern void musb_host_poke_root_hub(struct musb *musb);
 extern void musb_port_suspend(struct musb *musb, bool do_suspend);
+extern void musb_port_reset(struct musb *musb, bool do_reset);
 #else
 static inline struct musb *hcd_to_musb(struct usb_hcd *hcd)
 {
@@ -123,6 +124,7 @@ static inline void musb_host_resume_root_hub(struct musb *musb)	{}
 static inline void musb_host_poll_rh_status(struct musb *musb)	{}
 static inline void musb_host_poke_root_hub(struct musb *musb)	{}
 static inline void musb_port_suspend(struct musb *musb, bool do_suspend) {}
+static inline void musb_port_reset(struct musb *musb)		{}
 #endif
 
 struct usb_hcd;
diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_virthub.c
index e977441..24e46c0 100644
--- a/drivers/usb/musb/musb_virthub.c
+++ b/drivers/usb/musb/musb_virthub.c
@@ -109,7 +109,7 @@ void musb_port_suspend(struct musb *musb, bool do_suspend)
 	}
 }
 
-static void musb_port_reset(struct musb *musb, bool do_reset)
+void musb_port_reset(struct musb *musb, bool do_reset)
 {
 	u8		power;
 	void __iomem	*mbase = musb->mregs;
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index eb50525..a4ee1b5 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -76,6 +76,9 @@ struct musb_hdrc_config {
 	unsigned	dma:1 __deprecated; /* supports DMA */
 	unsigned	vendor_req:1 __deprecated; /* vendor registers required */
 
+	/* need to explicitly de-assert the port reset after resume? */
+	unsigned	host_port_deassert_reset_at_resume:1;
+
 	u8		num_eps;	/* number of endpoints _with_ ep0 */
 	u8		dma_channels __deprecated; /* number of dma channels */
 	u8		dyn_fifo_size;	/* dynamic size in bytes */
-- 
1.8.4.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

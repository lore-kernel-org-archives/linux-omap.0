From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 5/5] usb: musb: dsps: indentation and whitespace fixes
Date: Fri, 18 Oct 2013 11:39:35 +0200
Message-ID: <1382089175-13487-6-git-send-email-zonque@gmail.com>
References: <1382089175-13487-1-git-send-email-zonque@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382089175-13487-1-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Just a cosmetic thing, no functional change.

Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/musb_dsps.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index ce5bbc6..0fa3468 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -131,9 +131,9 @@ struct dsps_context {
 struct dsps_glue {
 	struct device *dev;
 	struct platform_device *musb;	/* child musb pdev */
-	const struct dsps_musb_wrapper *wrp; /* wrapper register offsets */
+	const struct dsps_musb_wrapper *wrp;	/* wrapper register offsets */
 	struct timer_list timer;	/* otg_workaround timer */
-	unsigned long last_timer;    /* last timer data for each instance */
+	unsigned long last_timer;	/* last timer data for each instance */
 
 	struct dsps_context context;
 };
@@ -213,7 +213,7 @@ static void dsps_musb_disable(struct musb *musb)
 
 	dsps_writel(reg_base, wrp->coreintr_clear, wrp->usb_bitmap);
 	dsps_writel(reg_base, wrp->epintr_clear,
-			 wrp->txep_bitmap | wrp->rxep_bitmap);
+		    wrp->txep_bitmap | wrp->rxep_bitmap);
 	dsps_writeb(musb->mregs, MUSB_DEVCTL, 0);
 }
 
@@ -234,7 +234,7 @@ static void otg_timer(unsigned long _musb)
 	 */
 	devctl = dsps_readb(mregs, MUSB_DEVCTL);
 	dev_dbg(musb->controller, "Poll devctl %02x (%s)\n", devctl,
-				usb_otg_state_string(musb->xceiv->state));
+		usb_otg_state_string(musb->xceiv->state));
 
 	spin_lock_irqsave(&musb->lock, flags);
 	switch (musb->xceiv->state) {
@@ -298,7 +298,7 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 		dsps_writel(reg_base, wrp->coreintr_status, usbintr);
 
 	dev_dbg(musb->controller, "usbintr (%x) epintr(%x)\n",
-			usbintr, epintr);
+		usbintr, epintr);
 	/*
 	 * DRVVBUS IRQs are the only proxy we have (a very poor one!) for
 	 * DSPS IP's missing ID change IRQ.  We need an ID change IRQ to
@@ -348,10 +348,9 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 
 		/* NOTE: this must complete power-on within 100 ms. */
 		dev_dbg(musb->controller, "VBUS %s (%s)%s, devctl %02x\n",
-				drvvbus ? "on" : "off",
-				usb_otg_state_string(musb->xceiv->state),
-				err ? " ERROR" : "",
-				devctl);
+			drvvbus ? "on" : "off",
+			usb_otg_state_string(musb->xceiv->state),
+			err ? " ERROR" : "", devctl);
 		ret = IRQ_HANDLED;
 	}
 
@@ -692,9 +691,9 @@ static SIMPLE_DEV_PM_OPS(dsps_pm_ops, dsps_suspend, dsps_resume);
 
 static struct platform_driver dsps_usbss_driver = {
 	.probe		= dsps_probe,
-	.remove         = dsps_remove,
-	.driver         = {
-		.name   = "musb-dsps",
+	.remove		= dsps_remove,
+	.driver		= {
+		.name	= "musb-dsps",
 		.pm	= &dsps_pm_ops,
 		.of_match_table	= musb_dsps_of_match,
 	},
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

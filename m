From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 4/4] usb: musb: Simplify PM runtime for 2430 glue layer
Date: Thu, 18 Aug 2016 15:46:50 -0700
Message-ID: <1471560410-6428-5-git-send-email-tony@atomide.com>
References: <1471560410-6428-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471560410-6428-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

With musb core now blocking PM based on the devctl status
bit, we can remove related quirks from the 2430 glue layer
and simplify PM runtime further.

Lets's also use musb->controller instead of dev to make it
clear we make the PM runtime calls for the core, not the
glue layer.

And we can now also lower the autoidle timeout.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/omap2430.c | 76 ++++++---------------------------------------
 1 file changed, 10 insertions(+), 66 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 0b4cec9..1ab6973 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -49,9 +49,6 @@ struct omap2430_glue {
 	enum musb_vbus_id_status status;
 	struct work_struct	omap_musb_mailbox_work;
 	struct device		*control_otghs;
-	bool			cable_connected;
-	bool			enabled;
-	bool			powered;
 };
 #define glue_to_musb(g)		platform_get_drvdata(g->musb)
 
@@ -141,45 +138,6 @@ static inline void omap2430_low_level_init(struct musb *musb)
 	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
 }
 
-/*
- * We can get multiple cable events so we need to keep track
- * of the power state. Only keep power enabled if USB cable is
- * connected and a gadget is started.
- */
-static void omap2430_set_power(struct musb *musb, bool enabled, bool cable)
-{
-	struct device *dev = musb->controller;
-	struct omap2430_glue *glue = dev_get_drvdata(dev->parent);
-	bool power_up;
-	int res;
-
-	if (glue->enabled != enabled)
-		glue->enabled = enabled;
-
-	if (glue->cable_connected != cable)
-		glue->cable_connected = cable;
-
-	power_up = glue->enabled && glue->cable_connected;
-	if (power_up == glue->powered) {
-		dev_warn(musb->controller, "power state already %i\n",
-			 power_up);
-		return;
-	}
-
-	glue->powered = power_up;
-
-	if (power_up) {
-		res = pm_runtime_get_sync(musb->controller);
-		if (res < 0) {
-			dev_err(musb->controller, "could not enable: %i", res);
-			glue->powered = false;
-		}
-	} else {
-		pm_runtime_mark_last_busy(musb->controller);
-		pm_runtime_put_autosuspend(musb->controller);
-	}
-}
-
 static int omap2430_musb_mailbox(enum musb_vbus_id_status status)
 {
 	struct omap2430_glue	*glue = _glue;
@@ -203,21 +161,15 @@ static int omap2430_musb_mailbox(enum musb_vbus_id_status status)
 static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 {
 	struct musb *musb = glue_to_musb(glue);
-	struct device *dev = musb->controller;
-	struct musb_hdrc_platform_data *pdata = dev_get_platdata(dev);
+	struct musb_hdrc_platform_data *pdata =
+		dev_get_platdata(musb->controller);
 	struct omap_musb_board_data *data = pdata->board_data;
 	struct usb_otg *otg = musb->xceiv->otg;
-	bool cable_connected;
-
-	cable_connected = ((glue->status == MUSB_ID_GROUND) ||
-			   (glue->status == MUSB_VBUS_VALID));
-
-	if (cable_connected)
-		omap2430_set_power(musb, glue->enabled, cable_connected);
 
+	pm_runtime_get_sync(musb->controller);
 	switch (glue->status) {
 	case MUSB_ID_GROUND:
-		dev_dbg(dev, "ID GND\n");
+		dev_dbg(musb->controller, "ID GND\n");
 
 		otg->default_a = true;
 		musb->xceiv->otg->state = OTG_STATE_A_IDLE;
@@ -230,7 +182,7 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 		break;
 
 	case MUSB_VBUS_VALID:
-		dev_dbg(dev, "VBUS Connect\n");
+		dev_dbg(musb->controller, "VBUS Connect\n");
 
 		otg->default_a = false;
 		musb->xceiv->otg->state = OTG_STATE_B_IDLE;
@@ -240,7 +192,7 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 
 	case MUSB_ID_FLOAT:
 	case MUSB_VBUS_OFF:
-		dev_dbg(dev, "VBUS Disconnect\n");
+		dev_dbg(musb->controller, "VBUS Disconnect\n");
 
 		musb->xceiv->last_event = USB_EVENT_NONE;
 		if (musb->gadget_driver)
@@ -253,12 +205,10 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 			USB_MODE_DISCONNECT);
 		break;
 	default:
-		dev_dbg(dev, "ID float\n");
+		dev_dbg(musb->controller, "ID float\n");
 	}
-
-	if (!cable_connected)
-		omap2430_set_power(musb, glue->enabled, cable_connected);
-
+	pm_runtime_mark_last_busy(musb->controller);
+	pm_runtime_put_autosuspend(musb->controller);
 	atomic_notifier_call_chain(&musb->xceiv->notifier,
 			musb->xceiv->last_event, NULL);
 }
@@ -376,8 +326,6 @@ static void omap2430_musb_enable(struct musb *musb)
 	if (!WARN_ON(!musb->phy))
 		phy_power_on(musb->phy);
 
-	omap2430_set_power(musb, true, glue->cable_connected);
-
 	switch (glue->status) {
 
 	case MUSB_ID_GROUND:
@@ -419,8 +367,6 @@ static void omap2430_musb_disable(struct musb *musb)
 	if (glue->status != MUSB_UNKNOWN)
 		omap_control_usb_set_mode(glue->control_otghs,
 			USB_MODE_DISCONNECT);
-
-	omap2430_set_power(musb, false, glue->cable_connected);
 }
 
 static int omap2430_musb_exit(struct musb *musb)
@@ -571,7 +517,7 @@ static int omap2430_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(glue->dev);
 	pm_runtime_use_autosuspend(glue->dev);
-	pm_runtime_set_autosuspend_delay(glue->dev, 500);
+	pm_runtime_set_autosuspend_delay(glue->dev, 100);
 
 	ret = platform_device_add(musb);
 	if (ret) {
@@ -591,11 +537,9 @@ err0:
 static int omap2430_remove(struct platform_device *pdev)
 {
 	struct omap2430_glue *glue = platform_get_drvdata(pdev);
-	struct musb *musb = glue_to_musb(glue);
 
 	pm_runtime_get_sync(glue->dev);
 	platform_device_unregister(glue->musb);
-	omap2430_set_power(musb, false, false);
 	pm_runtime_put_sync(glue->dev);
 	pm_runtime_dont_use_autosuspend(glue->dev);
 	pm_runtime_disable(glue->dev);
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

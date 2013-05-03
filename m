From: Tony Lindgren <tony@atomide.com>
Subject: Re: usb: musb: Fix LapDock enumeration on omap for boot and slow
 cable insertion
Date: Fri, 3 May 2013 11:01:33 -0700
Message-ID: <20130503180132.GW28721@atomide.com>
References: <20130503175016.GV28721@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:43662 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934019Ab3ECSBf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 May 2013 14:01:35 -0400
Content-Disposition: inline
In-Reply-To: <20130503175016.GV28721@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>

* Tony Lindgren <tony@atomide.com> [130503 10:55]:
> Looks like we can get VBUS interrupt before the ID interrupt
> at least with a Motorola LapDock if the USB mini-A cable is
> inserted slowly at the omap end. This issue also prevents
> enumerating the LapDock during the boot.
> 
> It seems that the issue is caused by musb getting confused and
> trying to do things on it's own as the LapDock provides VBUS.
> Fix the issue by disconnecting the transceiver before setting the
> host mode if the previous state was VBUS, and check that musb
> is in a sane state with the session bit cleared before we attempt
> to start the session.
> 
> With this patch the LapDock is properly enumerated during the
> boot and on slow insertion after a cold boot. This means that
> the LapDock can be used for both power and keyboard with at
> least omap panda es.
> 
> However, there seems to be a separate issue with musb not
> resetting properly after a warm reset which also leads to
> devices not enumerating.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> ---
> 
> Can you guys please test that this does not cause regressions
> on other devices when connecting USB devices?
> 

Sorry forgot to stg refresh, one line was missing. Updated patch
below.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Wed, 1 May 2013 14:28:46 -0700
Subject: [PATCH] usb: musb: Fix LapDock enumeration on omap for boot and slow cable insertion

Looks like we can get VBUS interrupt before the ID interrupt
at least with a Motorola LapDock if the USB mini-A cable is
inserted slowly at the omap end. This issue also prevents
enumerating the LapDock during the boot.

It seems that the issue is caused by musb getting confused and
trying to do things on it's own as the LapDock provides VBUS.
Fix the issue by disconnecting the transceiver before setting the
host mode if the previous state was VBUS, and check that musb
is in a sane state with the session bit cleared before we attempt
to start the session.

With this patch the LapDock is properly enumerated during the
boot and on slow insertion after a cold boot. This means that
the LapDock can be used for both power and keyboard with at
least omap panda es.

However, there seems to be a separate issue with musb not
resetting properly after a warm reset which also leads to
devices not enumerating.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -251,6 +251,21 @@ void omap_musb_mailbox(enum omap_musb_vbus_id_status status)
 }
 EXPORT_SYMBOL_GPL(omap_musb_mailbox);
 
+static void omap_musb_disconnect(struct musb *musb, struct omap2430_glue *glue)
+{
+	struct device *dev = musb->controller;
+	int loops = 100;
+
+	omap_control_usb_set_mode(glue->control_otghs,
+				  USB_MODE_DISCONNECT);
+	while (loops--) {
+		u8 devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
+		if (!(devctl & MUSB_DEVCTL_SESSION))
+			break;
+		dev_dbg(dev, "disconnecting: %02x\n", devctl);
+	}
+}
+
 static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 {
 	struct musb *musb = glue_to_musb(glue);
@@ -258,6 +273,7 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 	struct musb_hdrc_platform_data *pdata = dev->platform_data;
 	struct omap_musb_board_data *data = pdata->board_data;
 	struct usb_otg *otg = musb->xceiv->otg;
+	int disconnect = 0;
 
 	switch (glue->status) {
 	case OMAP_MUSB_ID_GROUND:
@@ -265,9 +281,13 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 
 		otg->default_a = true;
 		musb->xceiv->state = OTG_STATE_A_IDLE;
+		if (musb->xceiv->last_event == USB_EVENT_VBUS)
+			disconnect = 1;
 		musb->xceiv->last_event = USB_EVENT_ID;
 		if (musb->gadget_driver) {
 			pm_runtime_get_sync(dev);
+			if (disconnect)
+				omap_musb_disconnect(musb, glue);
 			omap_control_usb_set_mode(glue->control_otghs,
 				USB_MODE_HOST);
 			omap2430_musb_set_vbus(musb, 1);

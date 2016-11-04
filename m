From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: [PATCH 0/2] musb-fixes for v4.9-rc2
Date: Fri, 4 Nov 2016 11:40:26 +0100
Message-ID: <20161104104026.GA27621@localhost.localdomain>
References: <1476896620-15432-1-git-send-email-b-liu@ti.com>
 <20161020082318.GA2903@localhost.localdomain>
 <20161020123524.oepmqvlhzzu7elgj@atomide.com>
 <20161020193612.GA29736@localhost.localdomain>
 <20161021071722.2cetd2mt23t245ao@atomide.com>
 <20161024180708.kpx6s2jb7dpg6xfx@atomide.com>
 <20161101211358.GA2597@localhost.localdomain>
 <20161103205902.GB21430@atomide.com>
 <20161103225532.GD21430@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161103225532.GD21430-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Thu, Nov 03, 2016 at 03:55:32PM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161103 13:59]:
> > * Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> [161101 14:14]:
> > > > cacaaf80c3a6 ("usb: musb: Call pm_runtime from musb_gadget_queue")
> > > > d8e5f0eca1e8 ("usb: musb: Fix hardirq-safe hardirq-unsafe lock order error")
> > > 
> > > tested with v4.9-rc3 which have these included.
> > 
> > OK thanks.
> 
> So here's something to test, v4.9-rc3 + the PHY patch I
> posted + the patch below.
> 
> > Hmm yeah playing with a hub connected devices don't always enumerate.
> > When that happens, I get this:
> > 
> > usb 1-1: reset high-speed USB device number 45 using musb-hdrc
> > usb 1-1: reset high-speed USB device number 45 using musb-hdrc
> > usb 1-1: reset high-speed USB device number 45 using musb-hdrc
> > usb 1-1: USB disconnect, device number 45
> > usb 1-1: new high-speed USB device number 47 using musb-hdrc
> > usb 1-1: new high-speed USB device number 48 using musb-hdrc
> > ...
> > 
> > And that keeps on going until I reconnect the hub.
> 
> The patch below seems to work with PM for me, except I
> the dsps glue layer won't go to idle after disconnecting
> the hub. On 2430 glue layer things idle for me properly
> and I don't seem to get any more vbus errors.

All your patches on top of current Linus' git and revert of:
commit 87326e858448c40e32f142c0b8dcc59d7b27c641
Author: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Date:   Tue May 31 10:05:20 2016 -0500

    usb: musb: Remove extra PM runtime calls from 2430 glue layer

does the trick for me (reverted patch which applies bellow). I also
alternatively tried to increase pm_runtime_set_autosuspend_delay up
to 1000 without luck.

Hope this helps,

	ladis

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 451b372..a623e45 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -218,8 +218,13 @@ static void omap_musb_mailbox_work(struct work_struct *mailbox_work)
 {
 	struct omap2430_glue *glue = container_of(mailbox_work,
 				struct omap2430_glue, omap_musb_mailbox_work);
+	struct musb *musb = glue_to_musb(glue);
+	struct device *dev = musb->controller;
 
+	pm_runtime_get_sync(dev);
 	omap_musb_set_mailbox(glue);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 }
 
 static irqreturn_t omap2430_musb_interrupt(int irq, void *__hci)
@@ -289,6 +294,16 @@ static int omap2430_musb_init(struct musb *musb)
 	phy_init(musb->phy);
 	phy_power_on(musb->phy);
 
+	/*
+	 * Enable runtime PM for musb parent (this driver). We can't
+	 * do it earlier as struct musb is not yet allocated and we
+	 * need to touch the musb registers for runtime PM.
+	 */
+	pm_runtime_enable(glue->dev);
+	status = pm_runtime_get_sync(glue->dev);
+	if (status < 0)
+		goto err1;
+
 	l = musb_readl(musb->mregs, OTG_INTERFSEL);
 
 	if (data->interface_type == MUSB_INTERFACE_UTMI) {
@@ -312,7 +327,11 @@ static int omap2430_musb_init(struct musb *musb)
 	if (glue->status != MUSB_UNKNOWN)
 		omap_musb_set_mailbox(glue);
 
+	pm_runtime_put(glue->dev);
 	return 0;
+
+err1:
+	return status;
 }
 
 static void omap2430_musb_enable(struct musb *musb)
@@ -512,10 +531,6 @@ static int omap2430_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
-	pm_runtime_enable(glue->dev);
-	pm_runtime_use_autosuspend(glue->dev);
-	pm_runtime_set_autosuspend_delay(glue->dev, 100);

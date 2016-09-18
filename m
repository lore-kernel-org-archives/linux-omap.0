From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2] usb: musb: Fix unbalanced platform_disable
Date: Sun, 18 Sep 2016 08:19:02 -0700
Message-ID: <20160918151901.k7go65s4jauldxcl@atomide.com>
References: <20160912153947.k4gnggur6usyujii@atomide.com>
 <14745757.ahNt4Zeunj@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <14745757.ahNt4Zeunj@avalon>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [160918 05:13]:
> 
> FYI, while this patch allows me to boot my Panda board with NFS over usbnet, 
> it only works with cold boots. A warm reboot results in the following warning, 
> and no ethernet traffic going through. The USB device is detected by the host 
> though.

Yeah I noticed too that we still have issues. For example doing rmmod of
omap2430 with gadget configured and connected will produce a hardirq-safe
hardirq-unsafe lock order error. That also happens with reboot with gadget
configured and connected.

> I'm not sure whether this is a regression introduced by commit a83e17d0f73b 
> ("usb: musb: Improve PM runtime and phy handling for 2430 glue layer") or an 
> entirely different issue;
...
> [    5.711303] [<c0872788>] (_raw_spin_unlock_irqrestore) from [<c069b260>] 
> (musb_gadget_queue+0x128/0x4ac)
> [    5.711303] [<c069b260>] (musb_gadget_queue) from [<c06a9ae4>] 
> (usb_ep_queue+0x38/0x1d4)
> [    5.729766] [<c06a9ae4>] (usb_ep_queue) from [<c06aba40>] 
> (rx_submit+0xc8/0x19c)
> [    5.737548] [<c06aba40>] (rx_submit) from [<c06abb90>] (rx_fill+0x7c/0xa0)
> [    5.737548] [<c06abb90>] (rx_fill) from [<c06abbdc>] (eth_start+0x28/0x48)
> [    5.751983] [<c06abbdc>] (eth_start) from [<c06abe7c>] (eth_open+0x6c/0x7c)
> [    5.751983] [<c06abe7c>] (eth_open) from [<c0778c2c>] 
> (__dev_open+0x9c/0x104)

This could be something else though. Care to email me your .config, maybe
this is related to legacy g_ether being built in?

Anyways, please also give the following patch a try. The reason why we
currently have no chance of getting musb_platform_enable/disable balanced
is because we need to try to set the musb devctl session bit in various
places and possibly retry too. So musb_start should really be called
musb_try_start_session() or something.

So I think the only sane thing to do at this point is to revert the changes
trying to enable/disable USB PHY from omap2430_musb_enable/disable. The other
fixes are OK too as they get us a bit closer to making the platform glue calls
balanced.

Regards,

Tony

8< ----------------------
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -337,6 +337,7 @@ static int omap2430_musb_init(struct musb *musb)
 	}
 	musb->isr = omap2430_musb_interrupt;
 	phy_init(musb->phy);
+	phy_power_on(musb->phy);
 
 	l = musb_readl(musb->mregs, OTG_INTERFSEL);
 
@@ -373,9 +374,6 @@ static void omap2430_musb_enable(struct musb *musb)
 	struct musb_hdrc_platform_data *pdata = dev_get_platdata(dev);
 	struct omap_musb_board_data *data = pdata->board_data;
 
-	if (!WARN_ON(!musb->phy))
-		phy_power_on(musb->phy);
-
 	omap2430_set_power(musb, true, glue->cable_connected);
 
 	switch (glue->status) {
@@ -413,9 +411,6 @@ static void omap2430_musb_disable(struct musb *musb)
 	struct device *dev = musb->controller;
 	struct omap2430_glue *glue = dev_get_drvdata(dev->parent);
 
-	if (!WARN_ON(!musb->phy))
-		phy_power_off(musb->phy);

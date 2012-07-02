From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [FYI/RFC] usb: musb: DMA doesn't work with "nop" PHYs
Date: Mon, 2 Jul 2012 15:38:37 -0700
Message-ID: <20120702223837.GA31796@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:45922 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755159Ab2GBWij (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 18:38:39 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: Felipe Balbi <balbi@ti.com>

[The reason I'm sending this is that there is an issue but I probably
 won't be able to spend much time on it for a while.  So, I'm sending
 it in case a) it helps someone else who bumps into it and b) someone
 else picks up and completes the fix.]

Hello.

In testing USB OTG Gadget on the am37x EVM with the mainline kernel
I discovered that DMA doesn't work (but PIO does).  When I tested
the same kernel on the BeagleBoard-xM (BBxM), which has essentially
the same SoC, it worked fine.  They do have different OTG PHYs, though.
The am37x EVM uses an ISP 1507 and the BBxM uses the PHY on the
TPS65950 (twl4030).  The different PHYs means that they use different
drivers in drivers/usb/otg.  The am37x EVM uses nop-usb-xceiv.c and
the BBxM uses twl4030-usb.c.

After a little digging, the issue appears to be that the generic musb
code, which uses pm_runtime calls to shut things off when its not busy,
assumes that PHY code will turn things back on when there is activity.
For example, on the BBxM (twl4030-usb.c) there is a PHY interrupt that
is handled by twl4030_usb_irq() which notifies the generic code and
eventually calls the appropriate pm_runtime call to turn things on again.
There isn't interrupt support like that in nop-usb-xceiv.c so the IP
stays off when DMA should be happening.

There are at least a couple options for fixing this (that I can think of):
a) Enhance ulip.c to support interrupt generation from the PHY.  IIUC, this
   will cause a non-dma interrupt so there would be some hacking in the
   generic musb code required to handle this.
b) Add pm_runtime hooks to musbhsdma.c since its the DMA driver being used
   and it probably makes sense for it to be pm_runtime-ized anyway.

I went down the path of b) and added pm_runtime calls to the channel_alloc()
and channel_release() DMA driver hooks.  The patch is here:

<PATCH>

diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 57a6085..8eb13c7 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -76,10 +76,17 @@ static struct dma_channel *dma_channel_allocate(struct dma_controller *c,
 {
 	struct musb_dma_controller *controller = container_of(c,
 			struct musb_dma_controller, controller);
+	struct musb *musb = controller->private_data;
 	struct musb_dma_channel *musb_channel = NULL;
 	struct dma_channel *channel = NULL;
 	u8 bit;
 
+	if (!controller->used_channels) {
+		spin_unlock(&musb->lock);
+		pm_runtime_get_sync(musb->controller);
+		spin_lock(&musb->lock);
+	}
+
 	for (bit = 0; bit < MUSB_HSDMA_CHANNELS; bit++) {
 		if (!(controller->used_channels & (1 << bit))) {
 			controller->used_channels |= (1 << bit);
@@ -105,15 +112,25 @@ static struct dma_channel *dma_channel_allocate(struct dma_controller *c,
 static void dma_channel_release(struct dma_channel *channel)
 {
 	struct musb_dma_channel *musb_channel = channel->private_data;
+	struct musb_dma_controller *controller = musb_channel->controller;
+	struct musb *musb = controller->private_data;
+	u8 prev_used_channels;
 
 	channel->actual_len = 0;
 	musb_channel->start_addr = 0;
 	musb_channel->len = 0;
 
-	musb_channel->controller->used_channels &=
-		~(1 << musb_channel->idx);
+	prev_used_channels = controller->used_channels;
+	controller->used_channels &= ~(1 << musb_channel->idx);
 
 	channel->status = MUSB_DMA_STATUS_UNKNOWN;
+
+	/* Only _put() when going from 1 channel to 0 channels */
+	if (prev_used_channels && !controller->used_channels) {
+		spin_unlock(&musb->lock);
+		pm_runtime_put(musb->controller);
+		spin_lock(&musb->lock);
+	}
 }
 
 static void configure_channel(struct dma_channel *channel,

</PATCH>

I also have a simpler version that calls pm_runtime every time those
routines are called.  Either way, the gadget code resets the device
and it doesn't work.  I don't understand the code well enough to know
why and I don't have time to pursue it right now.

In the meantime, if pm_runtime calls are added to the start() and stop()
hooks of the DMA driver, it will work fine.  The problem with putting the
pm_runtime calls there is that it will stay powered on even when DMA isn't
being used.  This patch works for me on the am37x EVM:

<PATCH>

diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 57a6085..b69e1e1 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -39,7 +39,12 @@
 
 static int dma_controller_start(struct dma_controller *c)
 {
-	/* nothing to do */
+	struct musb_dma_controller *controller = container_of(c,
+			struct musb_dma_controller, controller);
+	struct musb *musb = controller->private_data;
+
+	pm_runtime_get_sync(musb->controller);
+
 	return 0;
 }
 
@@ -68,6 +73,8 @@ static int dma_controller_stop(struct dma_controller *c)
 		}
 	}
 
+	pm_runtime_put(musb->controller);
+
 	return 0;
 }

</PATCH>

I'm not very familiar with the musb code so I could be way off in the weeds.
If you have comments or better ideas, please let me know.  If you have
the time to fix it, even better! :)

Thanks,

Mark

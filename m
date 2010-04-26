From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] usb: Fix tusb6010 for DMA API (Re: [patch-2.6.34-rc2+
 00/11] musb patches (v2))
Date: Mon, 26 Apr 2010 10:53:24 -0700
Message-ID: <20100426175324.GE7225@atomide.com>
References: <1269515673-27980-1-git-send-email-felipe.balbi@nokia.com>
 <20100423210854.GA13366@kroah.com>
 <20100423212307.GY18272@atomide.com>
 <20100423220853.GA16165@kroah.com>
 <20100425133531.GB2219@gandalf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="v9Ux+11Zm5mwPlX6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58729 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213Ab0DZRxe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 13:53:34 -0400
Content-Disposition: inline
In-Reply-To: <20100425133531.GB2219@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Greg KH <greg@kroah.com>, Felipe Balbi <felipe.balbi@nokia.com>, Anand Gadiyar <gadiyar@ti.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Felipe Balbi <me@felipebalbi.com> [100425 06:30]:
> On Fri, Apr 23, 2010 at 03:08:53PM -0700, Greg KH wrote:
> > On Fri, Apr 23, 2010 at 02:23:08PM -0700, Tony Lindgren wrote:
> > > * Greg KH <greg@kroah.com> [100423 14:05]:
> > > > On Thu, Mar 25, 2010 at 01:14:22PM +0200, Felipe Balbi wrote:
> > > > > Hi Greg,
> > > > > 
> > > > > sorry for the last time. There was a bug in my script
> > > > > which caused it to rebased against the wrong branch.
> > > > 
> > > > All queued up, thanks
> > > 
> > > This compile fix still needs to be queued too. Can also
> > > merge via omap tree if you guys ack.
> > 
> > That's up to Felipe.  I have no objection to it, it's his call.
> 
> please Greg take it. I seem to have missed from my queue.
> 
> fwiw:
> 
> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

Greg, here's the patch for you one more time with updated comments
as suggested by Anand regarding the dummy musb_platform_save and
restore functions. Also added Felipe's Ack there.

Regards,

Tony

--v9Ux+11Zm5mwPlX6
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="tusb-dma.patch"

>From 0eb7eef01c52f25a7d22c9612ccbd89368941b95 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 23 Apr 2010 17:41:15 -0700
Subject: [PATCH] usb: Fix tusb6010 for DMA API

Commit 18eabe2347ae7a11b3db768695913724166dfb0e introduced
DMA buffer ownership. Fix tusb6010 accordingly. To compile,
also dummy musb_platform_save and restore functions need to
be added.

Also change the order of musb_read_fifo() to happen after
dma_cache_maint to have the DMA operations completed before
moving the remaining unaligned bytes with PIO. The DMA
access and PIO touch different areas of the FIFO, so this
change only makes the code a bit easier to follow.

Tested on n810 and g_ether with variable size ping test.
The test seems to fail for some ping sizes, but that seems to
be a different problem.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index ab776a8..60d3938 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -29,6 +29,19 @@ static void tusb_source_power(struct musb *musb, int is_on);
 #define TUSB_REV_MAJOR(reg_val)		((reg_val >> 4) & 0xf)
 #define TUSB_REV_MINOR(reg_val)		(reg_val & 0xf)
 
+#ifdef CONFIG_PM
+/* REVISIT: These should be only needed if somebody implements off idle */
+void musb_platform_save_context(struct musb *musb,
+			struct musb_context_registers *musb_context)
+{
+}
+
+void musb_platform_restore_context(struct musb *musb,
+			struct musb_context_registers *musb_context)
+{
+}
+#endif
+
 /*
  * Checks the revision. We need to use the DMA register as 3.0 does not
  * have correct versions for TUSB_PRCM_REV or TUSB_INT_CTRL_REV.
diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index 5afa070..c061a88 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -39,7 +39,7 @@ struct tusb_omap_dma_ch {
 
 	struct tusb_omap_dma	*tusb_dma;
 
-	void __iomem		*dma_addr;
+	dma_addr_t		dma_addr;
 
 	u32			len;
 	u16			packet_sz;
@@ -126,6 +126,7 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 	struct tusb_omap_dma_ch	*chdat = to_chdat(channel);
 	struct tusb_omap_dma	*tusb_dma = chdat->tusb_dma;
 	struct musb		*musb = chdat->musb;
+	struct device		*dev = musb->controller;
 	struct musb_hw_ep	*hw_ep = chdat->hw_ep;
 	void __iomem		*ep_conf = hw_ep->conf;
 	void __iomem		*mbase = musb->mregs;
@@ -173,13 +174,15 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 		DBG(3, "Using PIO for remaining %lu bytes\n", pio);
 		buf = phys_to_virt((u32)chdat->dma_addr) + chdat->transfer_len;
 		if (chdat->tx) {
-			dma_cache_maint(phys_to_virt((u32)chdat->dma_addr),
-					chdat->transfer_len, DMA_TO_DEVICE);
+			dma_unmap_single(dev, chdat->dma_addr,
+						chdat->transfer_len,
+						DMA_TO_DEVICE);
 			musb_write_fifo(hw_ep, pio, buf);
 		} else {
+			dma_unmap_single(dev, chdat->dma_addr,
+						chdat->transfer_len,
+						DMA_FROM_DEVICE);
 			musb_read_fifo(hw_ep, pio, buf);
-			dma_cache_maint(phys_to_virt((u32)chdat->dma_addr),
-					chdat->transfer_len, DMA_FROM_DEVICE);
 		}
 		channel->actual_len += pio;
 	}
@@ -224,6 +227,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 	struct tusb_omap_dma_ch		*chdat = to_chdat(channel);
 	struct tusb_omap_dma		*tusb_dma = chdat->tusb_dma;
 	struct musb			*musb = chdat->musb;
+	struct device			*dev = musb->controller;
 	struct musb_hw_ep		*hw_ep = chdat->hw_ep;
 	void __iomem			*mbase = musb->mregs;
 	void __iomem			*ep_conf = hw_ep->conf;
@@ -299,14 +303,16 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 	chdat->packet_sz = packet_sz;
 	chdat->len = len;
 	channel->actual_len = 0;
-	chdat->dma_addr = (void __iomem *)dma_addr;
+	chdat->dma_addr = dma_addr;
 	channel->status = MUSB_DMA_STATUS_BUSY;
 
 	/* Since we're recycling dma areas, we need to clean or invalidate */
 	if (chdat->tx)
-		dma_cache_maint(phys_to_virt(dma_addr), len, DMA_TO_DEVICE);
+		dma_map_single(dev, phys_to_virt(dma_addr), len,
+				DMA_TO_DEVICE);
 	else
-		dma_cache_maint(phys_to_virt(dma_addr), len, DMA_FROM_DEVICE);
+		dma_map_single(dev, phys_to_virt(dma_addr), len,
+				DMA_FROM_DEVICE);
 
 	/* Use 16-bit transfer if dma_addr is not 32-bit aligned */
 	if ((dma_addr & 0x3) == 0) {

--v9Ux+11Zm5mwPlX6--

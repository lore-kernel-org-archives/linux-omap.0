From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: [PATCH RESEND v2 1/1] usb: musb: implement (un)map_urb_for_dma hooks
Date: Thu, 14 Mar 2013 20:12:09 +0200
Message-ID: <1363284729-24228-2-git-send-email-ruslan.bilovol@ti.com>
References: <1363284729-24228-1-git-send-email-ruslan.bilovol@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:62064 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934489Ab3CNSMU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Mar 2013 14:12:20 -0400
In-Reply-To: <1363284729-24228-1-git-send-email-ruslan.bilovol@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

MUSB controller cannot work in DMA mode with misaligned buffers,
switching in PIO mode.

HCD core has hooks that allow to override the default DMA
mapping and unmapping routines for host controllers that have
special DMA requirements, such as alignment contraints.

It is observed that work in PIO mode is slow and it's better
to align buffers properly before passing them to MUSB

This increased throughput 80->120 MBits/s over musb@omap4 with
USB Gigabit ethernet adapter attached.

Some ideas taken from ehci-tegra.c

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
---
 drivers/usb/musb/musb_core.c |   14 ++++++
 drivers/usb/musb/musb_host.c |  102 +++++++++++++++++++++++++++++++++++++++++-
 drivers/usb/musb/musb_host.h |    2 +-
 3 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 60b41cc..91ac166 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1431,6 +1431,20 @@ static int musb_core_init(u16 musb_type, struct musb *musb)
 
 	/* log release info */
 	musb->hwvers = musb_read_hwvers(mbase);
+
+#ifndef CONFIG_MUSB_PIO_ONLY
+	/*
+	 * The DMA engine in RTL1.8 and above cannot handle
+	 * DMA addresses that are not aligned to a 4 byte boundary.
+	 * For such engine implemented (un)map_urb_for_dma hooks.
+	 * Do not use these hooks for RTL<1.8
+	 */
+	if (musb->hwvers < MUSB_HWVERS_1800) {
+		musb_hc_driver.map_urb_for_dma = NULL;
+		musb_hc_driver.unmap_urb_for_dma = NULL;
+	}
+#endif
+
 	snprintf(aRevision, 32, "%d.%d%s", MUSB_HWVERS_MAJOR(musb->hwvers),
 		MUSB_HWVERS_MINOR(musb->hwvers),
 		(musb->hwvers & MUSB_HWVERS_RC) ? "RC" : "");
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 1ce1fcf..b55bb36 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -2465,7 +2465,102 @@ static int musb_bus_resume(struct usb_hcd *hcd)
 	return 0;
 }
 
-const struct hc_driver musb_hc_driver = {
+
+#ifndef CONFIG_MUSB_PIO_ONLY
+
+#define MUSB_USB_DMA_ALIGN 4
+
+struct musb_temp_buffer {
+	void *kmalloc_ptr;
+	void *old_xfer_buffer;
+	u8 data[0];
+};
+
+static void musb_free_temp_buffer(struct urb *urb)
+{
+	enum dma_data_direction dir;
+	struct musb_temp_buffer *temp;
+
+	if (!(urb->transfer_flags & URB_ALIGNED_TEMP_BUFFER))
+		return;
+
+	dir = usb_urb_dir_in(urb) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+
+	temp = container_of(urb->transfer_buffer, struct musb_temp_buffer,
+			    data);
+
+	if (dir == DMA_FROM_DEVICE) {
+		memcpy(temp->old_xfer_buffer, temp->data,
+		       urb->transfer_buffer_length);
+	}
+	urb->transfer_buffer = temp->old_xfer_buffer;
+	kfree(temp->kmalloc_ptr);
+
+	urb->transfer_flags &= ~URB_ALIGNED_TEMP_BUFFER;
+}
+
+static int musb_alloc_temp_buffer(struct urb *urb, gfp_t mem_flags)
+{
+	enum dma_data_direction dir;
+	struct musb_temp_buffer *temp;
+	void *kmalloc_ptr;
+	size_t kmalloc_size;
+
+	if (urb->num_sgs || urb->sg ||
+	    urb->transfer_buffer_length == 0 ||
+	    !((uintptr_t)urb->transfer_buffer & (MUSB_USB_DMA_ALIGN - 1)))
+		return 0;
+
+	dir = usb_urb_dir_in(urb) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+
+	/* Allocate a buffer with enough padding for alignment */
+	kmalloc_size = urb->transfer_buffer_length +
+		sizeof(struct musb_temp_buffer) + MUSB_USB_DMA_ALIGN - 1;
+
+	kmalloc_ptr = kmalloc(kmalloc_size, mem_flags);
+	if (!kmalloc_ptr)
+		return -ENOMEM;
+
+	/* Position our struct temp_buffer such that data is aligned */
+	temp = PTR_ALIGN(kmalloc_ptr, MUSB_USB_DMA_ALIGN);
+
+
+	temp->kmalloc_ptr = kmalloc_ptr;
+	temp->old_xfer_buffer = urb->transfer_buffer;
+	if (dir == DMA_TO_DEVICE)
+		memcpy(temp->data, urb->transfer_buffer,
+		       urb->transfer_buffer_length);
+	urb->transfer_buffer = temp->data;
+
+	urb->transfer_flags |= URB_ALIGNED_TEMP_BUFFER;
+
+	return 0;
+}
+
+static int musb_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
+				      gfp_t mem_flags)
+{
+	int ret;
+
+	ret = musb_alloc_temp_buffer(urb, mem_flags);
+	if (ret)
+		return ret;
+
+	ret = usb_hcd_map_urb_for_dma(hcd, urb, mem_flags);
+	if (ret)
+		musb_free_temp_buffer(urb);
+
+	return ret;
+}
+
+static void musb_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
+{
+	usb_hcd_unmap_urb_for_dma(hcd, urb);
+	musb_free_temp_buffer(urb);
+}
+#endif /* !CONFIG_MUSB_PIO_ONLY */
+
+struct hc_driver musb_hc_driver = {
 	.description		= "musb-hcd",
 	.product_desc		= "MUSB HDRC host driver",
 	.hcd_priv_size		= sizeof(struct musb),
@@ -2484,6 +2579,11 @@ const struct hc_driver musb_hc_driver = {
 	.urb_dequeue		= musb_urb_dequeue,
 	.endpoint_disable	= musb_h_disable,
 
+#ifndef CONFIG_MUSB_PIO_ONLY
+	.map_urb_for_dma	= musb_map_urb_for_dma,
+	.unmap_urb_for_dma	= musb_unmap_urb_for_dma,
+#endif
+
 	.hub_status_data	= musb_hub_status_data,
 	.hub_control		= musb_hub_control,
 	.bus_suspend		= musb_bus_suspend,
diff --git a/drivers/usb/musb/musb_host.h b/drivers/usb/musb/musb_host.h
index 5a9c8fe..4af9529 100644
--- a/drivers/usb/musb/musb_host.h
+++ b/drivers/usb/musb/musb_host.h
@@ -94,7 +94,7 @@ extern int musb_hub_control(struct usb_hcd *hcd,
 			u16 typeReq, u16 wValue, u16 wIndex,
 			char *buf, u16 wLength);
 
-extern const struct hc_driver musb_hc_driver;
+extern struct hc_driver musb_hc_driver;
 
 static inline struct urb *next_urb(struct musb_qh *qh)
 {
-- 
1.7.9.5


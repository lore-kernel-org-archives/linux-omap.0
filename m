From: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 1/1] usb: musb: implement (un)map_urb_for_dma hooks
Date: Fri, 29 Mar 2013 19:15:21 +0200
Message-ID: <1364577321-1102-2-git-send-email-ruslan.bilovol@ti.com>
References: <1364577321-1102-1-git-send-email-ruslan.bilovol@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1364577321-1102-1-git-send-email-ruslan.bilovol-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

MUSB controller cannot work in DMA mode with misaligned buffers,
switching in PIO mode.

HCD core has hooks that allow to override the default DMA
mapping and unmapping routines for host controllers that have
special DMA requirements, such as alignment constraints.

It is observed that work in PIO mode is slow and it's better
to align buffers properly before passing them to MUSB

This increased throughput 80->120 MBits/s over musb@omap4 with
USB Gigabit Ethernet adapter attached.

Some ideas are taken from ehci-tegra.c

Signed-off-by: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_host.c |  117 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 1ce1fcf..33277c9 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -2465,6 +2465,118 @@ static int musb_bus_resume(struct usb_hcd *hcd)
 	return 0;
 }
 
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
+	struct musb	*musb = hcd_to_musb(hcd);
+	int ret;
+
+	/*
+	 * The DMA engine in RTL1.8 and above cannot handle
+	 * DMA addresses that are not aligned to a 4 byte boundary.
+	 * For such engine implemented (un)map_urb_for_dma hooks.
+	 * Do not use these hooks for RTL<1.8
+	 */
+	if (musb->hwvers < MUSB_HWVERS_1800)
+		return usb_hcd_map_urb_for_dma(hcd, urb, mem_flags);
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
+	struct musb	*musb = hcd_to_musb(hcd);
+
+	usb_hcd_unmap_urb_for_dma(hcd, urb);
+
+	/* Do not use this hook for RTL<1.8 (see description above) */
+	if (musb->hwvers < MUSB_HWVERS_1800)
+		return;
+
+	musb_free_temp_buffer(urb);
+}
+#endif /* !CONFIG_MUSB_PIO_ONLY */
+
 const struct hc_driver musb_hc_driver = {
 	.description		= "musb-hcd",
 	.product_desc		= "MUSB HDRC host driver",
@@ -2484,6 +2596,11 @@ const struct hc_driver musb_hc_driver = {
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
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

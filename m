From: Swaminathan S <swami.iyer@ti.com>
Subject: Patch [1/2] DaVinci CPPI TX DMA tasklet
Date: Thu, 21 Aug 2008 19:28:21 +0530
Message-ID: <1219327101-28313-1-git-send-email-swami.iyer@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46077 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168AbYHUNPI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Aug 2008 09:15:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, felipe.balbi@nokia.com

    Signed-off-by: Swaminathan S <swami.iyer@ti.com>
    
    This patch adds tasklet structures to musb to enable
    polling for FIFO empty status on the Mentor TX FIFO.
    This is requried to enable proper functioning of
    DaVinci CPPI TX DMA when performing Tx transfers.

diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 2096469..804caaf 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -273,6 +273,9 @@ struct musb_hw_ep {
 
 	u8			rx_reinit;
 	u8			tx_reinit;
+#ifdef CONFIG_ARCH_DAVINCI
+	u8			fifo_flush_check;	/* Check FIFO empty */
+#endif
 #endif
 
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
@@ -331,6 +334,9 @@ struct musb {
 	struct list_head	in_bulk;	/* of musb_qh */
 	struct list_head	out_bulk;	/* of musb_qh */
 	struct musb_qh		*periodic[32];	/* tree of interrupt+iso */
+#ifdef CONFIG_ARCH_DAVINCI
+	struct tasklet_struct	fifo_check;	/* FIFO empty check tasklet */
+#endif
 #endif
 
 	/* called with IRQs blocked; ON/nonzero implies starting a session,
diff --git a/drivers/usb/musb/musb_host.h b/drivers/usb/musb/musb_host.h
index 77bcdb9..29e1863 100644
--- a/drivers/usb/musb/musb_host.h
+++ b/drivers/usb/musb/musb_host.h
@@ -69,6 +69,7 @@ struct musb_qh {
 	u16			maxpacket;
 	u16			frame;		/* for periodic schedule */
 	unsigned		iso_idx;	/* in urb->iso_frame_desc[] */
+	u8			num_req;	/* Number of active requests */
 };
 
 /* map from control or bulk queue head to the first qh on that ring */
@@ -89,6 +90,10 @@ extern int musb_hub_control(struct usb_hcd *hcd,
 			u16 typeReq, u16 wValue, u16 wIndex,
 			char *buf, u16 wLength);
 
+#ifdef CONFIG_ARCH_DAVINCI
+extern void musb_fifo_check_tasklet(unsigned long data);
+#endif
+
 extern const struct hc_driver musb_hc_driver;
 
 static inline struct urb *next_urb(struct musb_qh *qh)

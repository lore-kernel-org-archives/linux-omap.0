From: "Dasgupta, Romit" <romit-l0cyMroinI0@public.gmane.org>
Subject: RE: Patch [1/2] DaVinci CPPI TX DMA tasklet
Date: Thu, 21 Aug 2008 19:49:39 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593019FE3BA45@dbde02.ent.ti.com>
References: <1219327101-28313-1-git-send-email-swami.iyer@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1219327101-28313-1-git-send-email-swami.iyer-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Subbrathnam, Swaminathan" <swami.iyer-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

As far as I understand, you need to save the toggle bit only after an entire URB transfer is complete. So if we know that we are transmitting 512 * N bytes. If N is even we would know that we don't have to change the data toggle and if it is odd we have to. So, if we start the transfer and the entire urb is transferred without error then this logic would work fine. On a USB endpoint error however, we can check the number of BDs successfully transmitted (by traversing the BD chain) and set the toggle correctly.
Comments? 

>-----Original Message-----
>From: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org]
>On Behalf Of Subbrathnam, Swaminathan
>Sent: Thursday, August 21, 2008 7:28 PM
>To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
>Subject: Patch [1/2] DaVinci CPPI TX DMA tasklet
>
>    Signed-off-by: Swaminathan S <swami.iyer-l0cyMroinI0@public.gmane.org>
>
>    This patch adds tasklet structures to musb to enable
>    polling for FIFO empty status on the Mentor TX FIFO.
>    This is requried to enable proper functioning of
>    DaVinci CPPI TX DMA when performing Tx transfers.
>
>diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
>index 2096469..804caaf 100644
>--- a/drivers/usb/musb/musb_core.h
>+++ b/drivers/usb/musb/musb_core.h
>@@ -273,6 +273,9 @@ struct musb_hw_ep {
>
> 	u8			rx_reinit;
> 	u8			tx_reinit;
>+#ifdef CONFIG_ARCH_DAVINCI
>+	u8			fifo_flush_check;	/* Check FIFO empty */
>+#endif
> #endif
>
> #ifdef CONFIG_USB_GADGET_MUSB_HDRC
>@@ -331,6 +334,9 @@ struct musb {
> 	struct list_head	in_bulk;	/* of musb_qh */
> 	struct list_head	out_bulk;	/* of musb_qh */
> 	struct musb_qh		*periodic[32];	/* tree of interrupt+iso */
>+#ifdef CONFIG_ARCH_DAVINCI
>+	struct tasklet_struct	fifo_check;	/* FIFO empty check tasklet */
>+#endif
> #endif
>
> 	/* called with IRQs blocked; ON/nonzero implies starting a session,
>diff --git a/drivers/usb/musb/musb_host.h b/drivers/usb/musb/musb_host.h
>index 77bcdb9..29e1863 100644
>--- a/drivers/usb/musb/musb_host.h
>+++ b/drivers/usb/musb/musb_host.h
>@@ -69,6 +69,7 @@ struct musb_qh {
> 	u16			maxpacket;
> 	u16			frame;		/* for periodic schedule */
> 	unsigned		iso_idx;	/* in urb->iso_frame_desc[] */
>+	u8			num_req;	/* Number of active requests */
> };
>
> /* map from control or bulk queue head to the first qh on that ring */
>@@ -89,6 +90,10 @@ extern int musb_hub_control(struct usb_hcd *hcd,
> 			u16 typeReq, u16 wValue, u16 wIndex,
> 			char *buf, u16 wLength);
>
>+#ifdef CONFIG_ARCH_DAVINCI
>+extern void musb_fifo_check_tasklet(unsigned long data);
>+#endif
>+
> extern const struct hc_driver musb_hc_driver;
>
> static inline struct urb *next_urb(struct musb_qh *qh)
>--
>To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

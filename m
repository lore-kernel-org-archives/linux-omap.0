From: "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>
Subject: RE: [RFC] MUSB: Workaround for Ethernet data alignment issue
Date: Mon, 14 Dec 2009 23:09:08 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FABD2171@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DEAB8723@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DEAB8723-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Patra, Nilkesh" <nilkesh.patra-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


Nilkesh

>-----Original Message-----
>From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Patra,
>Nilkesh
>Sent: Sunday, December 13, 2009 10:51 PM
>To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; David Brownell; Gadiyar, Anand
>Subject: [RFC] MUSB: Workaround for Ethernet data alignment issue
>
>On the latest version of MUSB, DMA is not working properly if the Data in the packet doesn't start at
>32bit aligned address. This issue was found while using MUSB as g_ether. The basic ping does not
>work, if the data in the Ethernet  packet does not start at 32bit aligned address.
>
>To overcome this issue, we found one solution mentioned in the below patch. This patch moves data
>(skb->data) by 2 bytes backwards in ethernet packet, which is nothing but skb->head.
>
>I want to know, if there are any better approaches to fix this issue.

I would NAK the first part of patch for following reasons (and suggestions are inlined):
a) this change is specific to OMAP hw only and so should not try to change generic files like usb/gadget/u_ether.c
that get compiled for all the architectures having usb.

b) there are two issues to be handled separately ( separate patches are good for review )
	RX side buffer alignments handling
	TX side buffer alignments handling

>
>Signed-off-by: Nilkesh Patra <nilkesh.patra-l0cyMroinI0@public.gmane.org>
>---
> drivers/usb/gadget/u_ether.c |   14 ++++++++++----
> 1 files changed, 10 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/usb/gadget/u_ether.c b/drivers/usb/gadget/u_ether.c
>index 2fc02bd..432b1bd 100644
>--- a/drivers/usb/gadget/u_ether.c
>+++ b/drivers/usb/gadget/u_ether.c
>@@ -249,7 +249,6 @@ rx_submit(struct eth_dev *dev, struct usb_request *req, gfp_t gfp_flags)
> 	 * but on at least one, checksumming fails otherwise.  Note:
> 	 * RNDIS headers involve variable numbers of LE32 values.
> 	 */
>-	skb_reserve(skb, NET_IP_ALIGN);

NAK. Do not remove this line, 
Instead over-ride the NET_IP_ALIGN macro for your architecture. 

One suggestion to do so:

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 058e7e9..b16c5f7 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -514,6 +514,10 @@ static inline unsigned long long __cmpxchg64_mb(volatile void *ptr,

 #define arch_align_stack(x) (x)

+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+#define NET_IP_ALIGN 0
+#endif
+
 #endif /* __KERNEL__ */

 #endif

This has been verified to work for OMAP3630.

>
> 	req->buf = skb->data;
> 	req->length = size;
>@@ -500,6 +499,8 @@ static netdev_tx_t eth_start_xmit(struct sk_buff *skb,
> 	unsigned long		flags;
> 	struct usb_ep		*in;
> 	u16			cdc_filter;
>+	int			i = 0;
>+
>
> 	spin_lock_irqsave(&dev->lock, flags);
> 	if (dev->port_usb) {
>@@ -573,9 +574,6 @@ static netdev_tx_t eth_start_xmit(struct sk_buff *skb,
>
> 		length = skb->len;
> 	}
>-	req->buf = skb->data;
>-	req->context = skb;
>-	req->complete = tx_complete;

This change would be to handle TX un-alignments. 
So I would prefer to handle it separately ( a separate patch)
Have you explored the option of over-riding #define NET_SKB_PAD ??

>
> 	/* use zlp framing on tx for strict CDC-Ether conformance,
> 	 * though any robust network rx path ignores extra padding.
>@@ -585,6 +583,14 @@ static netdev_tx_t eth_start_xmit(struct sk_buff *skb,
> 	if (!dev->zlp && (length % in->maxpacket) == 0)
> 		length++;
>
>+	if ((int)skb->data & 0x2) {
>+		skb_push(skb, 2);

Where have you made sure that skb->data allocation has this extra space of two bytes? 

>+		for (i = 0; i < length; i++)
>+			skb->data[i] = skb->data[i+2];
>+	}
>+	req->buf = skb->data;
>+	req->context = skb;
>+	req->complete = tx_complete;
> 	req->length = length;
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

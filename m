From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] USB: musb: allow unaligned memory data transfers
Date: Thu, 14 Jan 2010 13:23:54 +0200
Message-ID: <20100114112354.GG19526@nokia.com>
References: <1263310937-7249-1-git-send-email-vikram.pandita@ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1263310937-7249-1-git-send-email-vikram.pandita-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>, Nilkesh Patra <nilkesh.patra-l0cyMroinI0@public.gmane.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Jan 12, 2010 at 04:42:17PM +0100, ext Vikram Pandita wrote:
>diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
>index a237550..f118ae2 100644
>--- a/drivers/usb/musb/musbhsdma.c
>+++ b/drivers/usb/musb/musbhsdma.c
>@@ -166,6 +166,8 @@ static int dma_channel_program(struct dma_channel *channel,
> 				dma_addr_t dma_addr, u32 len)
> {
> 	struct musb_dma_channel *musb_channel = channel->private_data;
>+	struct musb_dma_controller *controller = musb_channel->controller;
>+	struct musb *musb = controller->private_data;
>
> 	DBG(2, "ep%d-%s pkt_sz %d, dma_addr 0x%x length %d, mode %d\n",
> 		musb_channel->epnum,
>@@ -175,6 +177,15 @@ static int dma_channel_program(struct dma_channel *channel,
> 	BUG_ON(channel->status == MUSB_DMA_STATUS_UNKNOWN ||
> 		channel->status == MUSB_DMA_STATUS_BUSY);
>
>+	/* On MUSB:RTL1.8 and above, DMA has to be word aligned */
>+	if ((dma_addr % 4) &&
>+		(musb->hwvers >= MUSB_HWVERS_1800)) {

is it only inventra dma that suffers from this ? If not, we could move 
this check before even calling the dma routine.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

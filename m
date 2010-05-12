From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH 4/5] musb: use system DMA for unaligned buffers on RTL
 >= 1.8
Date: Wed, 12 May 2010 20:54:33 +0300
Message-ID: <20100512175433.GC3285@gandalf>
References: <1273664979-493-1-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-2-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-3-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-4-git-send-email-ajay.gupta@ti.com>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1273664979-493-4-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, May 12, 2010 at 05:19:38PM +0530, Ajay Kumar Gupta wrote:
> MUSB RTL version 1.8 onward (OMAP3630, AM/DM37x, OMAP4) DMA requires
> the buffers to be aligned on a four byte boundary. This affects USB
> CDC/RNDIS class application where buffers are always unaligned.
> 
> Use system DMA for unaligned buffers as a workaround of this issue.
> 
> Current patch supports device side CDC/RNDIS. Host side would require
> change in Tx programming path for mode-0 operation when transfer length
> is more than packet size.
> 
> Also fixed an issue in device Tx completion path where 'is_dma' is getting
> set unconditionally. This would fail the io if Tx transfer is done in
> mode-0. Fixed it by updating it based on 'request->actual' length.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

[..]

> @@ -166,6 +166,12 @@ config MUSB_USE_SYSTEM_DMA_WORKAROUND
>            DMA channels are simultaneously enabled. To work around this issue,
>            you can choose to use System DMA for RX channels.
>  
> +	  Also on Mentor DMA in MUSB RTL version 1.8 (OMAP3630, AM/DM37x)
> +	  requires buffers to be aligned on a four byte boundary. This affects
> +	  USB CDC/RNDIS class application where buffers are always unaligned.
> +	  To work around this issue, you can choose to use System DMA for
> +	  unaligned buffers.

instead of this patch, it's a whole lot easier to simply use a bounce
buffer:

if (unaligned) {
	bounce = dma_alloc_coherent(......);
	memcpy(request->buf, bounce, request->length);
}

and use that buffer on channel_program();

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

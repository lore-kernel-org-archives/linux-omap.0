From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH 2/5] musb: use system DMA to fix Inventra DMA issue on
 RTL-1.4
Date: Wed, 12 May 2010 20:51:14 +0300
Message-ID: <20100512175113.GA3285@gandalf>
References: <1273664979-493-1-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-2-git-send-email-ajay.gupta@ti.com>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1273664979-493-2-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, May 12, 2010 at 05:19:36PM +0530, Ajay Kumar Gupta wrote:
> MUSB RTL version 1.4 has a hardware issue when TX and RX DMA channels are
> simultaneously enabled which results in DMA lockup.

I've seen it on rtl1.8 also if I remember correctly.

> Use system DMA for all RX channels as a workaround of this issue as this
> will have minimal throughput overhead based on the fact that Rx transfers
> are done in DMA mode-0 on OMAP34x/35x platforms.
> 
> Another approach to use PIO mode in opposite direction would increase the
> cpu loading and thus using system DMA is preferred workaround.
> 
> Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

I think falling back to pio is better than this patch. It will most
likely be only one transfer. Another approach is to allocate dma
channels on a transfer basis. This is way too big of a problem.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

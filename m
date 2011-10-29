From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] usb: ehci: report Data Buffer Error in debug mode
Date: Sat, 29 Oct 2011 13:00:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1110291255390.883-100000@netrider.rowland.org>
References: <1319846874-10106-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1319846874-10106-1-git-send-email-vikram.pandita-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, 28 Oct 2011, Vikram Pandita wrote:

> From: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
> 
> Data Buffer Error as per spec section 4.15.1.1.2
> results when there is Underrun or Overrun condition.
> 
> This error is considered non-fatal and never gets reported.
> Its a very good indication on things going wrong at system level,
> like running memory at much slower speed.
> 
> This is a good error to flag allowing system level corrections.
> 
> An issue was found with OMAP4460 board where DDR had to be run
> at full speed and this logging helped.

Generally okay, but ...

> Signed-off-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/host/ehci-q.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
> index 4e4066c..2451361 100644
> --- a/drivers/usb/host/ehci-q.c
> +++ b/drivers/usb/host/ehci-q.c
> @@ -373,6 +373,20 @@ qh_completions (struct ehci_hcd *ehci, struct ehci_qh *qh)
>   retry_xacterr:
>  		if ((token & QTD_STS_ACTIVE) == 0) {
>  
> +			/* Report Data Buffer Error: non-fatal but useful */
> +			if (token & QTD_STS_DBE) {
> +
> +				ehci_dbg(ehci,
> +				"detected DataBufferErr %s for urb %p ep%d%s len %d, qtd %p [qh %p]\n",
> +				(urb->ep->desc.bEndpointAddress & USB_DIR_IN) ?
> +						"OVER-RUN" : "UNDER-RUN",
> +				urb, urb->ep->desc.bEndpointAddress & 0x0f,
> +				(urb->ep->desc.bEndpointAddress & USB_DIR_IN) ? "in" : "out",

You should use the usb_endpoint_dir_in() routine instead of open-coding 
it.  (Or, if you prefer, use usb_pipein(urb->pipe).)  Similarly, use 
usb_endpoint_num().

Also, what point is there in checking the direction twice?  Get rid of
the OVER-RUN/UNDER-RUN part of the message; it doesn't add any new
information.

> +				urb->transfer_buffer_length,
> +				qtd, urb->ep->hcpriv);
> +

Unnecessary blank line here and above.

> +			}
> +

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

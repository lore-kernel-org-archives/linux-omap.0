From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH v3] usb: ehci: report Data Buffer Error in debug mode
Date: Mon, 31 Oct 2011 10:17:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1110311016510.1998-100000@iolanthe.rowland.org>
References: <1320004509-9411-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1320004509-9411-1-git-send-email-vikram.pandita-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sun, 30 Oct 2011, Vikram Pandita wrote:

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
> 
> Signed-off-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
> Reviewed-by: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
> ---
> v1: original patch
> 
> v2: fix review comments from Alan Stern
>     * use usb_endpoint_num, usb_endpoint_dir_in
> 
> v3: More comments from Alan Stern
>     * indent, use qh
> 
>  drivers/usb/host/ehci-q.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
> index 4e4066c..f136f7f1 100644
> --- a/drivers/usb/host/ehci-q.c
> +++ b/drivers/usb/host/ehci-q.c
> @@ -373,6 +373,17 @@ qh_completions (struct ehci_hcd *ehci, struct ehci_qh *qh)
>   retry_xacterr:
>  		if ((token & QTD_STS_ACTIVE) == 0) {
>  
> +			/* Report Data Buffer Error: non-fatal but useful */
> +			if (token & QTD_STS_DBE)
> +				ehci_dbg(ehci,
> +					"detected DataBufferErr for urb %p ep%d%s len %d, qtd %p [qh %p]\n",
> +					urb,
> +					usb_endpoint_num(&urb->ep->desc),
> +					usb_endpoint_dir_in(&urb->ep->desc) ? "in" : "out",
> +					urb->transfer_buffer_length,
> +					qtd,
> +					qh);
> +
>  			/* on STALL, error, and short reads this urb must
>  			 * complete and all its qtds must be recycled.
>  			 */

Signed-off-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

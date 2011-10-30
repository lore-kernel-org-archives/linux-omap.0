From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2] usb: ehci: report Data Buffer Error in debug mode
Date: Sun, 30 Oct 2011 15:14:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1110301512170.17906-100000@netrider.rowland.org>
References: <1319932425-10404-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:52118 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751088Ab1J3TOi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 30 Oct 2011 15:14:38 -0400
In-Reply-To: <1319932425-10404-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Sat, 29 Oct 2011, Vikram Pandita wrote:

> From: Vikram Pandita <vikram.pandita@ti.com>
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
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
> ---
> v1: original patch
> 
> v2: fix review comments from Alan Stern<stern@rowland.harvard.edu>

I'm sorry, there was one more thing that I forgot to mention last time.

>  drivers/usb/host/ehci-q.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
> index 4e4066c..f81c6de 100644
> --- a/drivers/usb/host/ehci-q.c
> +++ b/drivers/usb/host/ehci-q.c
> @@ -373,6 +373,16 @@ qh_completions (struct ehci_hcd *ehci, struct ehci_qh *qh)
>   retry_xacterr:
>  		if ((token & QTD_STS_ACTIVE) == 0) {
>  
> +			/* Report Data Buffer Error: non-fatal but useful */
> +			if (token & QTD_STS_DBE) {
> +				ehci_dbg(ehci,
> +				"detected DataBufferErr for urb %p ep%d%s len %d, qtd %p [qh %p]\n",
> +				urb, usb_endpoint_num(urb->ep),
> +				usb_endpoint_dir_in(urb->ep) ? "in" : "out",
> +				urb->transfer_buffer_length,
> +				qtd, urb->ep->hcpriv);

Don't use urb->ep->hcpriv; use qh instead.  Also, the continuation 
lines should be indented relative to the start of the statement.

Alan Stern


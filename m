From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] usb: ehci: report Data Buffer Error in debug mode
Date: Sat, 29 Oct 2011 02:22:22 +0200
Message-ID: <201110290222.22990.marek.vasut@gmail.com>
References: <1319846874-10106-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35993 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755945Ab1J2AWZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Oct 2011 20:22:25 -0400
In-Reply-To: <1319846874-10106-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: stern@rowland.harvard.edu, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

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
> ---
>  drivers/usb/host/ehci-q.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
> index 4e4066c..2451361 100644
> --- a/drivers/usb/host/ehci-q.c
> +++ b/drivers/usb/host/ehci-q.c
> @@ -373,6 +373,20 @@ qh_completions (struct ehci_hcd *ehci, struct ehci_qh
> *qh) retry_xacterr:
>  		if ((token & QTD_STS_ACTIVE) == 0) {
> 
> +			/* Report Data Buffer Error: non-fatal but useful */
> +			if (token & QTD_STS_DBE) {
> +
> +				ehci_dbg(ehci,
> +				"detected DataBufferErr %s for urb %p ep%d%s len 
%d, qtd %p [qh
> %p]\n", +				(urb->ep->desc.bEndpointAddress & 
USB_DIR_IN) ?
> +						"OVER-RUN" : "UNDER-RUN",
> +				urb, urb->ep->desc.bEndpointAddress & 0x0f,
> +				(urb->ep->desc.bEndpointAddress & USB_DIR_IN) ? 
"in" : "out",
> +				urb->transfer_buffer_length,
> +				qtd, urb->ep->hcpriv);
> +
> +			}
> +
>  			/* on STALL, error, and short reads this urb must
>  			 * complete and all its qtds must be recycled.
>  			 */

Looks basically ok to me.

Reviewed-by: Marek Vasut <marek.vasut@gmail.com>

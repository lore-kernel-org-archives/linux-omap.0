From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2] OMAP:MUSB: Corrects urb unlink function path
Date: Fri, 22 Aug 2008 13:32:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0808221330310.2230-100000@iolanthe.rowland.org>
References: <1219425190-13540-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35927 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752871AbYHVRcN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Aug 2008 13:32:13 -0400
In-Reply-To: <1219425190-13540-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, felipe.balbi@nokia.com

On Fri, 22 Aug 2008 ajay.gupta@ti.com wrote:

> @@ -1785,9 +1784,11 @@ static int musb_urb_enqueue(
>  	 * REVISIT consider a dedicated qh kmem_cache, so it's harder
>  	 * for bugs in other kernel code to break this driver...
>  	 */
> +	spin_lock_irqsave(&musb->lock, flags);
>  	qh = kzalloc(sizeof *qh, mem_flags);
>  	if (!qh) {
>  		usb_hcd_unlink_urb_from_ep(hcd, urb);
> +		spin_unlock_irqrestore(&musb->lock, flags);
>  		return -ENOMEM;
>  	}

This doesn't look right.  After calling spin_lock_irqsave you are in an 
atomic context, so you can't pass mem_flags to kzalloc.

Either move the spin_lock_irqsave after the call to kzalloc or else 
change mem_flags to GFP_ATOMIC.

Alan Stern


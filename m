From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] OMAP:MUSB: Corrects urb unlink function path
Date: Fri, 22 Aug 2008 20:44:17 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403CD5D4D6F@dbde02.ent.ti.com>
References: <1219386656-31072-1-git-send-email-ajay.gupta@ti.com>,<Pine.LNX.4.44L0.0808221038330.30309-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46685 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109AbYHVPTN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Aug 2008 11:19:13 -0400
In-Reply-To: <Pine.LNX.4.44L0.0808221038330.30309-100000@netrider.rowland.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "ajaykuee@gmail.com" <ajaykuee@gmail.com>

On Fri, 22 Aug 2008 ajay.gupta@ti.com wrote:

> From: Ajay Kumar Gupta <ajay.gupta@ti.com>
>
> Fixes kernel panic while ISO IN transfer is aborted.Replaced usb_hcd_unlink_urb_from_ep() from musb_giveback() to __musb_giveback() to make sure urb is unlinked before giveback when __musb_giveback() is called from musb_urb_dequeue().
>
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> ---
>  drivers/usb/musb/musb_host.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> index 93b0678..a889ac4 100644
> --- a/drivers/usb/musb/musb_host.c
> +++ b/drivers/usb/musb/musb_host.c
> @@ -292,6 +292,7 @@ __acquires(musb->lock)
>                       );
>
>       spin_unlock(&musb->lock);
> +     usb_hcd_unlink_urb_from_ep(musb_to_hcd(musb), urb);
>       usb_hcd_giveback_urb(musb_to_hcd(musb), urb, status);
>       spin_lock(&musb->lock);

This is wrong.  You must call usb_hcd_unlink_urb_from_ep() while
holding musb->lock.

You are correct. the unlink function should be moved above spin_unlock().  as,

+       usb_hcd_unlink_urb_from_ep(musb_to_hcd(musb), urb);
         spin_unlock(&musb->lock);
         usb_hcd_giveback_urb(musb_to_hcd(musb), urb, status);
         spin_lock(&musb->lock);

Simiar locking issue is also in enqueue path where unlink is being done 
without holding musb->lock.

Alan Stern
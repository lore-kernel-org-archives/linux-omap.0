From: kishon <kishon@ti.com>
Subject: Re: [PATCH 6/7] usb: musb: omap2430: turn off vbus on cable disconnect
Date: Tue, 12 Mar 2013 19:07:00 +0530
Message-ID: <513F2F7C.3040803@ti.com>
References: <1362877681-8102-1-git-send-email-notasas@gmail.com> <1362877681-8102-7-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59789 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755112Ab3CLNhs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Mar 2013 09:37:48 -0400
In-Reply-To: <1362877681-8102-7-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, NeilBrown <neilb@suse.de>

Hi,

On Sunday 10 March 2013 06:38 AM, Grazvydas Ignotas wrote:
> On USB_EVENT_ID event the musb glue enables VBUS by calling
> omap2430_musb_set_vbus(musb, 1) that sets the session bit, but on
> USB_EVENT_NONE reverse action is never made, and that breaks PM.
>
> Disable VBUS unconditionally on USB_EVENT_NONE to be sure musb
> session is ended on cable unplug so that PM works.
>
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
>   drivers/usb/musb/omap2430.c |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 2a39c11..d430677 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -296,6 +296,7 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
>   			pm_runtime_put_autosuspend(dev);
>   		}
>
> +		omap2430_musb_set_vbus(musb, 0);
>   		if (data->interface_type == MUSB_INTERFACE_UTMI) {
>   			if (musb->xceiv->otg->set_vbus)
>   				otg_set_vbus(musb->xceiv->otg, 0);
Shouldn't this otg_set_vbus be done inside omap2430_musb_set_vbus? Any 
idea why they were doing this only for UTMI?

Thanks
Kishon

From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 3/3] usb: musb: fix null pointer check in
	musb_platform_init()
Date: Fri, 23 Jan 2009 12:16:55 +0200
Message-ID: <20090123101655.GO9233@scadufax.research.nokia.com>
References: <1231326860-22727-1-git-send-email-ajay.gupta@ti.com> <20090112223154.GO25493@frodo> <19F8576C6E063C45BE387C64729E739403ECF70AC7@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35592 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760717AbZAWK25 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 05:28:57 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403ECF70AC7@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "david-b@pacbell.net" <david-b@pacbell.net>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

this one is also safe to apply

On Tue, Jan 13, 2009 at 12:17:39PM +0530, Ajay Kumar Gupta wrote:
> Fixes kernel panic when musb is selected for OMAP35x EVM but twl4030 is not
> selected as in this case otg_get_transceiver() returns null.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/usb/musb/omap2430.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 3f99536..93252c9 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -232,6 +232,10 @@ int __init musb_platform_init(struct musb *musb)
>  #if defined(CONFIG_ARCH_OMAP2430)
>  	omap_cfg_reg(AE5_2430_USB0HS_STP);
>  #endif
> +	if (!x) {
> +		pr_err("omap: musb: null transceiver found\n");
> +		return -ENODEV;
> +	}
>  
>  	musb->xceiv = *x;
>  	musb_platform_resume(musb);
> -- 
> 1.5.6

-- 
balbi

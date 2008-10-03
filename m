From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] usb: add back otg_get_transceiver
Date: Fri, 3 Oct 2008 17:31:34 +0300
Message-ID: <20081003143132.GG6251@atomide.com>
References: <1223043350-17588-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50452 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbYJCO2k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 10:28:40 -0400
Content-Disposition: inline
In-Reply-To: <1223043350-17588-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [081003 17:18]:
> make twl4030_usb transceiver reach musb.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/usb/musb/omap2430.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 9d2dcb1..be4e779 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -215,12 +215,14 @@ void musb_platform_set_mode(struct musb *musb, u8 musb_mode)
>  
>  int __init musb_platform_init(struct musb *musb)
>  {
> +	struct otg_transceiver *x = otg_get_transceiver();
>  	u32 l;
>  
>  #if defined(CONFIG_ARCH_OMAP2430)
>  	omap_cfg_reg(AE5_2430_USB0HS_STP);
>  #endif
>  
> +	musb->xceiv = *x;
>  	musb_platform_resume(musb);
>  
>  	l = omap_readl(OTG_SYSCONFIG);

Pushed until you have something in mainline.

Tony

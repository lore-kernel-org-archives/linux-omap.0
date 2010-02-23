From: Thomas Weber <weber@corscience.de>
Subject: Re: [PATCH 10/11] omap: musb: get rid of dyn_fifo
Date: Tue, 23 Feb 2010 15:55:56 +0100
Message-ID: <4B83EC7C.6020406@corscience.de>
References: <20100219232648.10559.380.stgit@baageli.muru.com> <20100219233036.10559.29778.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:55891 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893Ab0BWO4A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 09:56:00 -0500
In-Reply-To: <20100219233036.10559.29778.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

Tony Lindgren wrote:
> From: Felipe Balbi <felipe.balbi@nokia.com>
>
> that's deprecated as we can check dyn_fifo from
> CONFIGDATA register.
>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/usb-musb.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
> index 2221a6c..85feb60 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -49,7 +49,6 @@ static struct resource musb_resources[] = {
>  
>  static struct musb_hdrc_config musb_config = {
>  	.multipoint	= 1,
> -	.dyn_fifo	= 1,
>  	.num_eps	= 16,
>  	.ram_bits	= 12,
>  };
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>   
Hi,

I think this patch breaks musb_hdrc.

In musb_core_init is musb->config->dyn_fifo checked but is never set.

So I get the following dmesg output:

musb_hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk split,
HB-ISO Rx, HB-ISO Tx, SoftConn)
musb_hdrc: MHDRC RTL version 1.400
musb_core_init 1405: reconfigure software for Dynamic FIFOs
musb_hdrc musb_hdrc: musb_init_controller failed with status -19

Thomas

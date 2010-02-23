From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 10/11] omap: musb: get rid of dyn_fifo
Date: Tue, 23 Feb 2010 14:32:50 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DA9946D@dbde02.ent.ti.com>
References: <20100219232648.10559.380.stgit@baageli.muru.com>
 <20100219233036.10559.29778.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39181 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124Ab0BWJC7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 04:02:59 -0500
In-Reply-To: <20100219233036.10559.29778.stgit@baageli.muru.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

> -----Original Message-----
> From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-
> kernel-bounces@lists.infradead.org] On Behalf Of Tony Lindgren
> Sent: Saturday, February 20, 2010 5:01 AM
> To: linux-arm-kernel@lists.infradead.org
> Cc: Felipe Balbi; linux-omap@vger.kernel.org; linux-usb@vger.kernel.org
> Subject: [PATCH 10/11] omap: musb: get rid of dyn_fifo
> 
> From: Felipe Balbi <felipe.balbi@nokia.com>
> 
> that's deprecated as we can check dyn_fifo from
> CONFIGDATA register.
> 
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Felipe,

This patch causes musb init failure if below patch[1] is not taken.

[1] http://marc.info/?l=linux-omap&m=126088393130177&w=2

I don't see patch [1] in Greg's queue also so please forward it to
Greg.

Regards,
Ajay 

> ---
>  arch/arm/mach-omap2/usb-musb.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-
> musb.c
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
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

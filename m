From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [rfc/rft/patch 3/9] arm: omap: zoom: use vmmc1 regulator supply
Date: Tue, 1 Dec 2009 18:38:26 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030ABC1E20@dbde02.ent.ti.com>
References: <1259672635-12306-1-git-send-email-felipe.balbi@nokia.com>
 <1259672635-12306-4-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58915 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752426AbZLANI7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 08:08:59 -0500
In-Reply-To: <1259672635-12306-4-git-send-email-felipe.balbi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Kalle Valo <kalle.valo@iki.fi>, Jean Pihet <jpihet@mvista.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe Balbi
> Sent: Tuesday, December 01, 2009 6:34 PM
> To: Tony Lindgren
> Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh; Kevin 
> Hilman; Kalle Valo; Jean Pihet; Pandita, Vikram; Paul 
> Walmsley; Hiroshi DOYU; David Brownell; Felipe Balbi
> Subject: [rfc/rft/patch 3/9] arm: omap: zoom: use vmmc1 
> regulator supply
> 
> the structure was there but it was used by the
> twl4030 pdata. Just adding the missing field.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

I had already posted this patch.

- Anand

http://marc.info/?l=linux-omap&m=125855155611214&w=2

> ---
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c 
> b/arch/arm/mach-omap2/board-zoom-peripherals.c
> index f14baa3..221a8e3 100755
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -236,6 +236,7 @@ static struct twl4030_platform_data 
> zoom_twldata = {
>  	.gpio		= &zoom_gpio_data,
>  	.keypad		= &zoom_kp_twl4030_data,
>  	.codec		= &zoom_codec_data,
> +	.vmmc1          = &zoom_vmmc1,
>  	.vmmc2          = &zoom_vmmc2,
>  	.vsim           = &zoom_vsim,
>  
> -- 
> 1.6.6.rc0
> 

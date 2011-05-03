From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] arm: omap3: cm-t3517: fix section mismatch warning
Date: Tue, 03 May 2011 18:30:58 +0300
Message-ID: <4DC01FB2.9060806@compulab.co.il>
References: <1303850474-25106-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:49808
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753013Ab1ECPa6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 11:30:58 -0400
In-Reply-To: <1303850474-25106-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

ping!


Just to make sure you haven't missed this one liner ;)


On 04/26/11 23:41, Igor Grinberg wrote:

> WARNING: arch/arm/mach-omap2/built-in.o(.text+0x11014): Section mismatch
> in reference from the function cm_t3517_init_usbh() to the (unknown
> reference) .init.data:(unknown)
> The function cm_t3517_init_usbh() references
> the (unknown reference) __initdata (unknown).
> This is often because cm_t3517_init_usbh lacks a __initdata
> annotation or the annotation of (unknown) is wrong.
>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
>  arch/arm/mach-omap2/board-cm-t3517.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
> index a27e3ee..802cb60 100644
> --- a/arch/arm/mach-omap2/board-cm-t3517.c
> +++ b/arch/arm/mach-omap2/board-cm-t3517.c
> @@ -178,7 +178,7 @@ static struct usbhs_omap_board_data cm_t3517_ehci_pdata __initdata = {
>  	.reset_gpio_port[2]  = -EINVAL,
>  };
>  
> -static int cm_t3517_init_usbh(void)
> +static int __init cm_t3517_init_usbh(void)
>  {
>  	int err;
>  

-- 
Regards,
Igor.


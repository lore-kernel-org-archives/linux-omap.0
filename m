From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: serial: Change MAX_HSUART_PORTS to 6
Date: Mon, 24 Sep 2012 10:18:29 -0700
Message-ID: <20120924171829.GF28835@atomide.com>
References: <1340182169-3840-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:53483 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752835Ab2IXRSc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 13:18:32 -0400
Content-Disposition: inline
In-Reply-To: <1340182169-3840-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com

* AnilKumar Ch <anilkumar@ti.com> [120620 01:54]:
> Extends the maximum number of UART ports to 6 from 4 because AM335X
> device have six UART ports.

Sorry for the delay, looks like this one is still
valid. I'll apply this.

Regards,

Tony
 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/omap-serial.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
> index 1a52725..71eca9c 100644
> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
> @@ -54,7 +54,7 @@
>  
>  #define OMAP_UART_DMA_CH_FREE	-1
>  
> -#define OMAP_MAX_HSUART_PORTS	4
> +#define OMAP_MAX_HSUART_PORTS	6
>  
>  #define MSR_SAVE_FLAGS		UART_MSR_ANY_DELTA
>  
> -- 
> 1.7.9.5
> 

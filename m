From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: omap4-panda: add UART2 muxing for WiLink shared
 transport
Date: Mon, 21 Jan 2013 10:21:59 -0800
Message-ID: <20130121182158.GD22517@atomide.com>
References: <1358766852-24503-1-git-send-email-coelho@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:40863 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752008Ab3AUSWD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jan 2013 13:22:03 -0500
Content-Disposition: inline
In-Reply-To: <1358766852-24503-1-git-send-email-coelho@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: peter.ujfalusi@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Luciano Coelho <coelho@ti.com> [130121 03:18]:
> Add the UART2 muxing data to the board file (this used to be,
> erroneously, done in the bootloader).
> 
> Cc: stable <stable@vger.kernel.org> [3.7]
> Signed-off-by: Luciano Coelho <coelho@ti.com>

Thanks applying into omap-for-v3.8-rc4/fixes.

Regards,

Tony

> ---
>  arch/arm/mach-omap2/board-omap4panda.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index 5c8e9ce..769c1fe 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -397,6 +397,12 @@ static struct omap_board_mux board_mux[] __initdata = {
>  		  OMAP_PULL_ENA),
>  	OMAP4_MUX(ABE_MCBSP1_FSX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
>  
> +	/* UART2 - BT/FM/GPS shared transport */
> +	OMAP4_MUX(UART2_CTS,	OMAP_PIN_INPUT	| OMAP_MUX_MODE0),
> +	OMAP4_MUX(UART2_RTS,	OMAP_PIN_OUTPUT	| OMAP_MUX_MODE0),
> +	OMAP4_MUX(UART2_RX,	OMAP_PIN_INPUT	| OMAP_MUX_MODE0),
> +	OMAP4_MUX(UART2_TX,	OMAP_PIN_OUTPUT	| OMAP_MUX_MODE0),
> +
>  	{ .reg_offset = OMAP_MUX_TERMINATOR },
>  };
>  
> -- 
> 1.7.10.4
> 

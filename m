From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.28-rc2-omap] H4: fix i2c registration
Date: Thu, 13 Nov 2008 13:43:02 -0800
Message-ID: <20081113214302.GG3106@atomide.com>
References: <200811010038.05711.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61748 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbYKMVnF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 16:43:05 -0500
Content-Disposition: inline
In-Reply-To: <200811010038.05711.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081101 00:38]:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Registering the I2C devices on H4 boards once is enough;
> remove the extra call.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> Mainline doesn't have the call to register the I2C adapter
> along with its devices ... this has that call *plus* the call
> to register just the board_info.  Seems to be the only OMAP2/3
> board with this bug.

Pushing to l-o, not adding to upstream queue.

Tony

> 
>  arch/arm/mach-omap2/board-h4.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> --- a/arch/arm/mach-omap2/board-h4.c
> +++ b/arch/arm/mach-omap2/board-h4.c
> @@ -746,9 +746,6 @@ static void __init omap_h4_init(void)
>  	/* Menelaus interrupt */
>  	omap_cfg_reg(W19_24XX_SYS_NIRQ);
>  
> -	i2c_register_board_info(1, h4_i2c_board_info,
> -			ARRAY_SIZE(h4_i2c_board_info));
> -
>  	platform_add_devices(h4_devices, ARRAY_SIZE(h4_devices));
>  	omap_board_config = h4_config;
>  	omap_board_config_size = ARRAY_SIZE(h4_config);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

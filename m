From: Tony Lindgren <tony@atomide.com>
Subject: Re: linux-next: manual merge of the omap tree with the arm tree
Date: Thu, 20 Aug 2009 13:20:05 +0300
Message-ID: <20090820102004.GD12309@atomide.com>
References: <20090819150433.4c12c612.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090819150433.4c12c612.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-omap@vger.kernel.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Syed Rafiuddin <rafiuddin.syed@ti.com>, Russell King <rmk@arm.linux.org.uk>, Kalle Valo <kalle.valo@iki.fi>
List-Id: linux-omap@vger.kernel.org

* Stephen Rothwell <sfr@canb.auug.org.au> [090819 08:04]:
> Hi all,
> 
> Today's linux-next merge of the omap tree got a conflict in
> arch/arm/mach-omap2/board-4430sdp.c between commit
> 085b54d99b8ee999e7905b8f16e201e0da8ba369 ("ARM: OMAP4: Add UART4
> support") from the arm tree and commit
> 4c29fa3e47342666e12e46f35f40dd90b12cd1a4 ("OMAP: remove OMAP_TAG_UART")
> from the omap tree.
> 
> Just context changes (I think).  I fixed it up (see below) and can carry
> the fix as necessary.

Thanks yeh the fix looks right. I'll take a look if I can squeeze something
like that into my queue so the merge conflict disappears.

Regards,

Tony

> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> 
> diff --cc arch/arm/mach-omap2/board-4430sdp.c
> index 1b22307,646079f..0000000
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@@ -38,8 -38,8 +38,8 @@@ static struct platform_device *sdp4430_
>   	&sdp4430_lcd_device,
>   };
>   
> - static struct omap_uart_config sdp4430_uart_config __initdata = {
> + static struct omap_uart_platform_data sdp4430_uart_config __initdata = {
>  -	.enabled_uarts	= (1 << 0) | (1 << 1) | (1 << 2),
>  +	.enabled_uarts	= (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3),
>   };
>   
>   static struct omap_lcd_config sdp4430_lcd_config __initdata = {

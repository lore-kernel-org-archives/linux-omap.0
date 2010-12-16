From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] OMAP: RM-680: fix omap2_init_common_hw compile break
Date: Thu, 16 Dec 2010 18:05:14 +0000
Message-ID: <20101216180514.GA31322@n2100.arm.linux.org.uk>
References: <1292520438-29122-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53891 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932093Ab0LPSF0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 13:05:26 -0500
Content-Disposition: inline
In-Reply-To: <1292520438-29122-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 16, 2010 at 11:27:18AM -0600, Omar Ramirez Luna wrote:
> diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
> index 8ba4047..781ed25 100644
> --- a/arch/arm/mach-omap2/board-am3517crane.c
> +++ b/arch/arm/mach-omap2/board-am3517crane.c
> @@ -47,7 +47,8 @@ static void __init am3517_crane_init_irq(void)
>  	omap_board_config = am3517_crane_config;
>  	omap_board_config_size = ARRAY_SIZE(am3517_crane_config);
>  
> -	omap2_init_common_hw(NULL, NULL);
> +	omap2_init_common_infrastructure();
> +	omap2_init_common_devices(NULL, NULL);
>  	omap_init_irq();

Once I have the init_early() sorted, hopefully most of the abuse in
these callbacks can be moved into the init_early() callback.

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap: board-overo: reset GPIO for SMSC911x
Date: Tue, 18 Jun 2013 03:09:46 -0700
Message-ID: <20130618100945.GI5523@atomide.com>
References: <1369144071-10673-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41754 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754164Ab3FRKJu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jun 2013 06:09:50 -0400
Content-Disposition: inline
In-Reply-To: <1369144071-10673-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Steve Sakoman <sakoman@gmail.com>, Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Florian Vaussard <florian.vaussard@epfl.ch> [130521 07:01]:
> The reset GPIO should be set for the SMSC911x, otherwise the controller
> will not work and probing will fail. In the case of the tobi-duo
> expansion board, the second controller shares the same GPIO, thus no
> more changes are required (not tested).
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>

Thanks applying into omap-for-v3.11/board.

Regards,

Tony

> ---
>  arch/arm/mach-omap2/board-overo.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
> index 4ca6b68..5748b5d 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -68,6 +68,7 @@
>  
>  #define OVERO_SMSC911X_CS      5
>  #define OVERO_SMSC911X_GPIO    176
> +#define OVERO_SMSC911X_NRESET  64
>  #define OVERO_SMSC911X2_CS     4
>  #define OVERO_SMSC911X2_GPIO   65
>  
> @@ -122,7 +123,7 @@ static struct omap_smsc911x_platform_data smsc911x_cfg = {
>  	.id		= 0,
>  	.cs             = OVERO_SMSC911X_CS,
>  	.gpio_irq       = OVERO_SMSC911X_GPIO,
> -	.gpio_reset     = -EINVAL,
> +	.gpio_reset     = OVERO_SMSC911X_NRESET,
>  	.flags		= SMSC911X_USE_32BIT,
>  };
>  
> -- 
> 1.7.5.4
> 

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Extend gpio label column width in omap_gpio
	debugfs file
Date: Tue, 25 Nov 2008 14:33:46 -0800
Message-ID: <20081125223345.GW11997@atomide.com>
References: <1226476959-17093-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64025 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbYKYWdq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 17:33:46 -0500
Content-Disposition: inline
In-Reply-To: <1226476959-17093-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [081112 00:03]:
> There are already various drivers having bigger label than 10 bytes. Most
> of them fit well under 20 bytes but make column width exact so that
> oversized labels don't mess up output alignment.

Pushing & adding to omap-upstream queue.

Tony

> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> ---
>  arch/arm/plat-omap/gpio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 8bb4542..821100d 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -1820,7 +1820,7 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)
>  				seq_printf(s, "MPUIO %2d ", j);
>  			else
>  				seq_printf(s, "GPIO %3d ", gpio);
> -			seq_printf(s, "(%10s): %s %s",
> +			seq_printf(s, "(%-20.20s): %s %s",
>  					label,
>  					is_in ? "in " : "out",
>  					value ? "hi"  : "lo");
> -- 
> 1.5.6.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

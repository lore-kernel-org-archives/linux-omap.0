From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: OMAP: Extend gpio label column width in omap_gpio debugfs file
Date: Thu, 13 Nov 2008 17:26:59 -0800
Message-ID: <200811131726.59905.david-b@pacbell.net>
References: <1226476959-17093-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:26191 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757271AbYKNB1D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Nov 2008 20:27:03 -0500
In-Reply-To: <1226476959-17093-1-git-send-email-jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

On Wednesday 12 November 2008, Jarkko Nikula wrote:
> There are already various drivers having bigger label than 10 bytes. Most
> of them fit well under 20 bytes but make column width exact so that
> oversized labels don't mess up output alignment.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>

Acked-by: David Brownell <dbrownell@users.sourceforge.net>

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
> 
> 



From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP: mmc_twl4030 nicely disable vmmc_aux
Date: Tue, 24 Mar 2009 13:01:21 -0700
Message-ID: <200903241301.21570.david-b@pacbell.net>
References: <49C8CEFA.6020407@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n15b.bullet.mail.mud.yahoo.com ([68.142.207.236]:31916 "HELO
	n15b.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751014AbZCXUB0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Mar 2009 16:01:26 -0400
In-Reply-To: <49C8CEFA.6020407@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

On Tuesday 24 March 2009, Adrian Hunter wrote:
> >From 1a3f939d95122d8e58a3750cf5bce09247357203 Mon Sep 17 00:00:00 2001
> From: Adrian Hunter <adrian.hunter@nokia.com>
> 
> The MMC driver turns the power off before it turns it
> on. To avoid regulator warnings, vmmc_aux must only be
> disabled if it has previously been enabled.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>

Acked-by: David Brownell <dbrownell@users.sourceforge.net>

good catch.  


> ---
>  arch/arm/mach-omap2/mmc-twl4030.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
> index 2ff50f0..cb56fe2 100644
> --- a/arch/arm/mach-omap2/mmc-twl4030.c
> +++ b/arch/arm/mach-omap2/mmc-twl4030.c
> @@ -305,7 +305,7 @@ static int twl_mmc23_set_power(struct device *dev, int slot, int power_on, int v
>  				ret = mmc_regulator_set_ocr(c->vcc, 0);
>  		}
>  	} else {
> -		if (c->vcc_aux)
> +		if (c->vcc_aux && (ret = regulator_is_enabled(c->vcc_aux)) > 0)
>  			ret = regulator_disable(c->vcc_aux);
>  		if (ret == 0)
>  			ret = mmc_regulator_set_ocr(c->vcc, 0);
> -- 
> 1.5.6.3
> 
> 




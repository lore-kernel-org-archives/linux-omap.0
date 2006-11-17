From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 4/6] [RFC] Add MMC Password Protection (lock/unlock) support V6
Date: Fri, 17 Nov 2006 16:10:09 +0000
Message-ID: <20061117161009.GE28514@flint.arm.linux.org.uk>
References: <455DB50C.3020209@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933692AbWKQQKT@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <455DB50C.3020209@indt.org.br>
Sender: linux-kernel-owner@vger.kernel.org
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>, ext David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>, "Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 17, 2006 at 09:11:40AM -0400, Anderson Briglia wrote:
> OMAP platform specific patch.
> - Add the host MMC lock/unlock capability support.
> 
> Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>
> Signed-off-by: Anderson Lizardo <anderson.lizardo <at> indt.org.br>
> Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>
> 
> Index: linux-omap-2.6.git/drivers/mmc/omap.c
> ===================================================================
> --- linux-omap-2.6.git.orig/drivers/mmc/omap.c	2006-11-16 
> 15:35:19.000000000 -0400
> +++ linux-omap-2.6.git/drivers/mmc/omap.c	2006-11-17 
> 09:05:47.000000000 -0400
> @@ -1094,6 +1094,9 @@ static int __init mmc_omap_probe(struct
>  	if (minfo->wire4)
>  		 mmc->caps |= MMC_CAP_4_BIT_DATA;
> 
> +	/* Sets the lock/unlock capability */
> +	host->mmc->caps |= MMC_CAP_LOCK_UNLOCK;
> +

See additional comments to your first patch.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

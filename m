From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 06/11] gpio/omap: add clk_prepare and clk_unprepare
Date: Fri, 22 Jun 2012 13:17:06 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206221312400.10198@utopia.booyaka.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com> <1340372890-10091-7-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39002 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897Ab2FVTRH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jun 2012 15:17:07 -0400
In-Reply-To: <1340372890-10091-7-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, Pankaj Jangra <jangra.pankaj9@gmail.com>

Hi

On Fri, 22 Jun 2012, Rajendra Nayak wrote:

> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
> for omap gpio debounce clock.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
>  drivers/gpio/gpio-omap.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index c4ed172..6a73b01 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -893,6 +893,8 @@ static int gpio_debounce(struct gpio_chip *chip, unsigned offset,
>  		bank->dbck = clk_get(bank->dev, "dbclk");
>  		if (IS_ERR(bank->dbck))
>  			dev_err(bank->dev, "Could not get gpio dbck\n");
> +		else
> +			clk_prepare(bank->dbck);
>  	}
>  
>  	spin_lock_irqsave(&bank->lock, flags);

What code unprepares this clock?

Put differently, doesn't this driver need at least a platform_driver 
.remove function pointer, that would call clk_unprepare() and clk_put()?

Also, it looks to me that the bank->dbck init should be in 
omap_gpio_chip_init(), not gpio_debounce()?


- Paul

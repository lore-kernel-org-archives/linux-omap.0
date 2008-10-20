From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] i2c: omap: highspeed only over 1000mhz
Date: Mon, 20 Oct 2008 08:15:16 -0700
Message-ID: <20081020151512.GA8298@atomide.com>
References: <1224277795-17143-1-git-send-email-felipe.balbi@nokia.com> <20081020102659.GA31599@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63411 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbYJTPP1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Oct 2008 11:15:27 -0400
Content-Disposition: inline
In-Reply-To: <20081020102659.GA31599@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>

* Felipe Balbi <felipe.balbi@nokia.com> [081020 03:27]:
> up to 1000khz it's Fast Mode+, not highspeed.

Have you tested this? To me it seems this code is needed for
dev->speed > 400, and the comment may be wrong.

Tony

> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index a999606..53d6244 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -296,7 +296,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  		psc = psc - 1;
>  
>  		/* If configured for High Speed */
> -		if (dev->speed > 400) {
> +		if (dev->speed > 1000) {
>  			/* For first phase of HS mode */
>  			fsscll = internal_clk / (400 * 2) - 6;
>  			fssclh = internal_clk / (400 * 2) - 6;
> -- 
> 1.6.0.2.307.gc427
> 
> -- 
> balbi

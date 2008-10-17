From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] i2c: omap: highspeed only over 1000mhz
Date: Fri, 17 Oct 2008 22:51:24 +0100
Message-ID: <20081017215124.GL22711@trinity.fluff.org>
References: <1224277795-17143-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.145.97.151]:34793 "EHLO
	trinity.fluff.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbYJQVv0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 17:51:26 -0400
Content-Disposition: inline
In-Reply-To: <1224277795-17143-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Tony Lindgren <tony@atomide.com>

On Sat, Oct 18, 2008 at 12:09:55AM +0300, Felipe Balbi wrote:
> up to 1000mhz it's Fast Mode+, not highspeed.

mill-hz? 1MHz or 1000kHz.
 
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

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


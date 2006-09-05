From: tony@atomide.com
Subject: Re: [PATCH] ARM: OMAP: Fix mmc driver no_switch error path
Date: Tue, 5 Sep 2006 18:43:09 +0300
Message-ID: <20060905154308.GF18073@atomide.com>
References: <1157372209.5446.270078515@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1157372209.5446.270078515@webmail.messagingengine.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [060904 15:17]:
> Tony,
> 
> This patch fixes no_switch error path in probe function of mmc driver.
> 
> ---Komal Shah
> http://komalshah.blogspot.com
> 
> -- 
> http://www.fastmail.fm - One of many happy users:
>   http://www.fastmail.fm/docs/quotes.html
> 

> From nobody Mon Sep 17 00:00:00 2001
> From: Komal Shah <komal_shah802003@yahoo.com>
> Date: Mon, 4 Sep 2006 23:15:57 +0530
> Subject: [PATCH] ARM: OMAP: Fix mmc driver no_switch error path.
> 
> Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>
> 
> ---
> 
>  drivers/mmc/omap.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> 35eb9be4d20ac2e274a0a4b685db94b1b5b3d908
> diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
> index 0f1f99b..ae08a37 100644
> --- a/drivers/mmc/omap.c
> +++ b/drivers/mmc/omap.c
> @@ -1163,8 +1163,9 @@ static int __init mmc_omap_probe(struct 
>  
>  	mmc_add_host(mmc);
>  
> -no_switch:
>  	return 0;
> +
> +no_switch:
>  	/* FIXME: Free other resources too. */
>  	if (host) {
>  		if (host->iclk && !IS_ERR(host->iclk))
> -- 
> 1.3.3
> 

Thanks, pushing today.

Tony

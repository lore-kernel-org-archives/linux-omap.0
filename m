From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mmc/omap.c: add missing '\n'
Date: Fri, 2 Mar 2007 04:10:55 -0800
Message-ID: <20070302121054.GD6955@atomide.com>
References: <85sld62yx9.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <85sld62yx9.fsf@orfeo.duckcorp.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Arnaud Patard <arnaud.patard@rtp-net.org> [070216 02:14]:
> 
> This patch add a missing '\n' at the end of the 'cover is open' string
> in mmc_omap_switch_handler().
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> ---

> ---
>  drivers/mmc/omap.c |    2 	1 +	1 -	0 !
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-omap-2.6/drivers/mmc/omap.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/mmc/omap.c	2007-02-16 11:04:18.000000000 +0100
> +++ linux-omap-2.6/drivers/mmc/omap.c	2007-02-16 11:04:47.000000000 +0100
> @@ -606,7 +606,7 @@ static void mmc_omap_switch_handler(stru
>  	}
>  	if (mmc_omap_cover_is_open(host)) {
>  		if (!complained) {
> -			dev_info(mmc_dev(host->mmc), "cover is open");
> +			dev_info(mmc_dev(host->mmc), "cover is open\n");
>  			complained = 1;
>  		}
>  		if (mmc_omap_enable_poll)

Pushing today.

Tony

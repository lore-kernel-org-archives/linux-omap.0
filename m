From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Make omap_bl build again after API change.
Date: Tue, 9 Jan 2007 15:32:45 -0800
Message-ID: <20070109233244.GQ7384@atomide.com>
References: <1167956787968-git-send-email-balrog@zabor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1167956787968-git-send-email-balrog@zabor.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Andrzej Zaborowski <balrog@zabor.org> [070104 15:26]:
> [Oops, I sent this to Dirk eariler and forgot to CC the list.]
> Make omap_bl build again after API change.
> 
> Breakage spotted by Dirk Behme.
> Also remove comment about API glitch which has just been fixed.
> 
> Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
> ---
>  drivers/video/backlight/omap_bl.c |    8 ++------
>  1 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/backlight/omap_bl.c b/drivers/video/backlight/omap_bl.c
> index 22189b1..3b57b27 100644
> --- a/drivers/video/backlight/omap_bl.c
> +++ b/drivers/video/backlight/omap_bl.c
> @@ -152,12 +152,8 @@ static int omapbl_probe(struct platform_
>  	if (unlikely(!bl))
>  		return -ENOMEM;
>  
> -	/* REVISIT backlight API glitch:  we can't associate the
> -	 * class device with "pdev" ... probably pass &pdev->dev
> -	 * instead of a string.
> -	 */
> -
> -	dev = backlight_device_register("omap-bl", bl, &omapbl_data);
> +	dev = backlight_device_register("omap-bl", &pdev->dev,
> +			bl, &omapbl_data);
>  	if (IS_ERR(dev)) {
>  		kfree(bl);
>  		return PTR_ERR(dev);

Pushing today.

Tony

From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2 3/3] watchdog: omap_wdt: add device tree support
Date: Fri, 6 Jul 2012 01:28:01 -0700
Message-ID: <20120706082801.GO1122@atomide.com>
References: <1338525856-4359-1-git-send-email-jgq516@gmail.com>
 <1338525856-4359-4-git-send-email-jgq516@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1338525856-4359-4-git-send-email-jgq516-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: jgq516-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Wim,

* jgq516-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <jgq516-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [120531 20:56]:
> From: Xiao Jiang <jgq516-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Add device table for omap_wdt to support dt.

Care to ack this patch in the series?

Regards,

Tony

> 
> Signed-off-by: Xiao Jiang <jgq516-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/watchdog/omap_wdt.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index 8285d65..02ebfd5 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -430,6 +430,12 @@ static int omap_wdt_resume(struct platform_device *pdev)
>  #define	omap_wdt_resume		NULL
>  #endif
>  
> +static const struct of_device_id omap_wdt_of_match[] = {
> +	{ .compatible = "ti,omap3-wdt", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, omap_wdt_of_match);
> +
>  static struct platform_driver omap_wdt_driver = {
>  	.probe		= omap_wdt_probe,
>  	.remove		= __devexit_p(omap_wdt_remove),
> @@ -439,6 +445,7 @@ static struct platform_driver omap_wdt_driver = {
>  	.driver		= {
>  		.owner	= THIS_MODULE,
>  		.name	= "omap_wdt",
> +		.of_match_table = omap_wdt_of_match,
>  	},
>  };
>  
> -- 
> 1.7.3
> 

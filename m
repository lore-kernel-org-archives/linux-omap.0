From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 2/2] drm: omap: Enable DT support for DMM
Date: Thu, 31 Oct 2013 17:40:22 -0700
Message-ID: <20131101004020.GA8413@kartoffel>
References: <1379063679-4869-1-git-send-email-archit@ti.com>
 <1381820660-5501-1-git-send-email-archit@ti.com>
 <1381820660-5501-3-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381820660-5501-3-git-send-email-archit@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: "bcousson@baylibre.com" <bcousson@baylibre.com>, "tony@atomide.com" <tony@atomide.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "robdclark@gmail.com" <robdclark@gmail.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Andy Gross <andygro@gmail.com>, DRI Development <dri-devel@lists.freedesktop.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 15, 2013 at 08:04:20AM +0100, Archit Taneja wrote:
> Enable use of DT for DMM/Tiler.
> 
> Originally worked on by Andy Gross <andygro@gmail.com>
> 
> Cc: Andy Gross <andygro@gmail.com>
> Cc: DRI Development <dri-devel@lists.freedesktop.org>
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
> index acf6678..59f17de 100644
> --- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
> +++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
> @@ -968,12 +968,23 @@ static const struct dev_pm_ops omap_dmm_pm_ops = {
>  };
>  #endif
>  
> +#if defined(CONFIG_OF)
> +static const struct of_device_id dmm_of_match[] = {
> +	{ .compatible = "ti,omap4-dmm", },
> +	{ .compatible = "ti,omap5-dmm", },
> +	{},
> +};
> +#else
> +#define dmm_of_match NULL
> +#endif
> +
>  struct platform_driver omap_dmm_driver = {
>  	.probe = omap_dmm_probe,
>  	.remove = omap_dmm_remove,
>  	.driver = {
>  		.owner = THIS_MODULE,
>  		.name = DMM_DRIVER_NAME,
> +		.of_match_table = dmm_of_match,

If you use of_match_ptr(dmm_of_match) here you don't need the #else case above.

Thanks,
Mark.

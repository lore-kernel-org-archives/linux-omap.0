From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH 05/13] extcon: extcon-class: improve extcon client API
Date: Thu, 10 Apr 2014 21:09:06 +0300
Message-ID: <20140410180906.GD15736@drone.musicnaut.iki.fi>
References: <1397135811-12866-1-git-send-email-r.baldyga@samsung.com>
 <1397135811-12866-6-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397135811-12866-6-git-send-email-r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org, jonghwa3.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rongjun.ying-kQvG35nSl+M@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Apr 10, 2014 at 03:16:43PM +0200, Robert Baldyga wrote:
> +struct extcon_cable *extcon_get_cable_by_name(struct device *dev,
> +						 const char *name)
> +{
> +	return of_extcon_get_cable_by_name(dev->of_node, name);
> +}
> +EXPORT_SYMBOL_GPL(extcon_get_cable_by_name);

[...]

> @@ -96,17 +95,13 @@ static int omap_otg_probe(struct platform_device *pdev)
>  {
>  	const struct omap_usb_config *config = pdev->dev.platform_data;
                                                         ^^^^^^^^^^^^^

[...]

> -	ret = extcon_register_interest(&otg_dev->id_dev, config->extcon,
> -				       "USB-HOST", &otg_dev->id_nb);
> +	cable_id = extcon_get_cable_by_name(&pdev->dev, "USB-HOST");

NACK. OMAP1 is not using DT, so this driver would stop working
with this series.

A.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

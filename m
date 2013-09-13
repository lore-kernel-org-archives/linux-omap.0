From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] drm: omap: Enable DT support for DMM
Date: Fri, 13 Sep 2013 10:14:34 -0400
Message-ID: <CAF6AEGu7eRFhrQZUD-43AOHNQtRWeyxYga1dnir=qUo1mQ9ebA@mail.gmail.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com>
	<1379063679-4869-4-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379063679-4869-4-git-send-email-archit-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Valkeinen, Tomi" <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Gross <andygro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DRI Development <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 13, 2013 at 5:14 AM, Archit Taneja <archit-l0cyMroinI0@public.gmane.org> wrote:
> Enable use of DT for DMM/Tiler.
>
> Originally worked on by Andy Gross.

looks good.. but do we want to get information about # of LUT's, etc,
from DT?  Or did we decide that we can reliably get this from the hw?
I lost track of that discussion (I guess Andy would remember)..

BR,
-R

> Cc: Andy Gross <andygro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: DRI Development <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> Signed-off-by: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>
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
> +       { .compatible = "ti,omap4-dmm", },
> +       { .compatible = "ti,omap5-dmm", },
> +       {},
> +};
> +#else
> +#define dmm_of_match NULL
> +#endif
> +
>  struct platform_driver omap_dmm_driver = {
>         .probe = omap_dmm_probe,
>         .remove = omap_dmm_remove,
>         .driver = {
>                 .owner = THIS_MODULE,
>                 .name = DMM_DRIVER_NAME,
> +               .of_match_table = dmm_of_match,
>  #ifdef CONFIG_PM
>                 .pm = &omap_dmm_pm_ops,
>  #endif
> --
> 1.8.1.2
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCHv2 27/27] OMAPDSS: connector-analog-tv: Add DT support
Date: Tue, 26 Aug 2014 18:58:45 +0200
Message-ID: <21704808.AJTjtXoZly@avalon>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com> <1387205794-32246-28-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387205794-32246-28-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tomi,

On Monday 16 December 2013 16:56:34 Tomi Valkeinen wrote:
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
> ---
>  .../video/omap2/displays-new/connector-analog-tv.c | 66 ++++++++++++++++++-
>  1 file changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/omap2/displays-new/connector-analog-tv.c
> b/drivers/video/omap2/displays-new/connector-analog-tv.c index
> ccd9073f706f..ebed25a86487 100644
> --- a/drivers/video/omap2/displays-new/connector-analog-tv.c
> +++ b/drivers/video/omap2/displays-new/connector-analog-tv.c
> @@ -12,6 +12,7 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/of.h>
> 
>  #include <video/omapdss.h>
>  #include <video/omap-panel-data.h>
> @@ -42,6 +43,12 @@ static const struct omap_video_timings tvc_pal_timings =
> { .interlace	= true,
>  };
> 
> +static const struct of_device_id tvc_of_match[];
> +
> +struct tvc_of_data {
> +	enum omap_dss_venc_type connector_type;
> +};
> +
>  #define to_panel_data(x) container_of(x, struct panel_drv_data, dssdev)
> 
>  static int tvc_connect(struct omap_dss_device *dssdev)
> @@ -92,7 +99,10 @@ static int tvc_enable(struct omap_dss_device *dssdev)
>  	in->ops.atv->set_timings(in, &ddata->timings);
> 
>  	in->ops.atv->set_type(in, ddata->connector_type);
> -	in->ops.atv->invert_vid_out_polarity(in, ddata->invert_polarity);
> +
> +	if (!ddata->dev->of_node)
> +		in->ops.atv->invert_vid_out_polarity(in,
> +			ddata->invert_polarity);
> 
>  	r = in->ops.atv->enable(in);
>  	if (r)
> @@ -205,6 +215,35 @@ static int tvc_probe_pdata(struct platform_device
> *pdev) return 0;
>  }
> 
> +static int tvc_probe_of(struct platform_device *pdev)
> +{
> +	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
> +	struct device_node *node = pdev->dev.of_node;
> +	struct omap_dss_device *in;
> +	const struct of_device_id *match;
> +	const struct tvc_of_data *data;
> +
> +	match = of_match_node(tvc_of_match, pdev->dev.of_node);
> +	if (!match) {
> +		dev_err(&pdev->dev, "unsupported device\n");
> +		return -ENODEV;
> +	}
> +
> +	data = match->data;
> +
> +	in = omapdss_of_find_source_for_first_ep(node);
> +	if (IS_ERR(in)) {
> +		dev_err(&pdev->dev, "failed to find video source\n");
> +		return PTR_ERR(in);
> +	}
> +
> +	ddata->in = in;
> +
> +	ddata->connector_type = data->connector_type;
> +
> +	return 0;
> +}
> +
>  static int tvc_probe(struct platform_device *pdev)
>  {
>  	struct panel_drv_data *ddata;
> @@ -222,6 +261,10 @@ static int tvc_probe(struct platform_device *pdev)
>  		r = tvc_probe_pdata(pdev);
>  		if (r)
>  			return r;
> +	} else if (pdev->dev.of_node) {
> +		r = tvc_probe_of(pdev);
> +		if (r)
> +			return r;
>  	} else {
>  		return -ENODEV;
>  	}
> @@ -263,12 +306,33 @@ static int __exit tvc_remove(struct platform_device
> *pdev) return 0;
>  }
> 
> +static const struct tvc_of_data tv_svideo_data = {
> +	.connector_type = OMAP_DSS_VENC_TYPE_SVIDEO,
> +};
> +
> +static const struct tvc_of_data tv_composite_video_data = {
> +	.connector_type = OMAP_DSS_VENC_TYPE_COMPOSITE,
> +};
> +
> +static const struct of_device_id tvc_of_match[] = {
> +	{
> +		.compatible = "svideo-connector",
> +		.data = &tv_svideo_data,
> +	},
> +	{
> +		.compatible = "composite-video-connector",

I've just noticed that this doesn't match the bindings that document the 
compatible value to be "composite-connector".

> +		.data = &tv_composite_video_data,
> +	},
> +	{},
> +};
> +
>  static struct platform_driver tvc_connector_driver = {
>  	.probe	= tvc_probe,
>  	.remove	= __exit_p(tvc_remove),
>  	.driver	= {
>  		.name	= "connector-analog-tv",
>  		.owner	= THIS_MODULE,
> +		.of_match_table = tvc_of_match,
>  	},
>  };

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

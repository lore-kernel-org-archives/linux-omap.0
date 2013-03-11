From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 10/20] OMAPDSS: Resolve channels for outputs
Date: Mon, 11 Mar 2013 17:49:40 +0530
Message-ID: <513DCBDC.1020803@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com> <1362743515-10152-11-git-send-email-tomi.valkeinen@ti.com> <513D6D06.7030902@ti.com> <513DC870.3030908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37505 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478Ab3CKMUX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 08:20:23 -0400
In-Reply-To: <513DC870.3030908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Monday 11 March 2013 05:35 PM, Tomi Valkeinen wrote:
> On 2013-03-11 07:35, Archit Taneja wrote:
>> Hi,
>>
>> On Friday 08 March 2013 05:21 PM, Tomi Valkeinen wrote:
>>> The DISPC channel used for each output is currently passed in panel
>>> platform data from the board files.
>>>
>>> To simplify this, and to make the panel drivers less dependent on OMAP,
>>> this patch changes omapdss to resolve the channel independently. The
>>> channel is resolved based on the OMAP version and, in case of DSI, the
>>> DSI module id.
>>>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> ---
>>>    drivers/video/omap2/dss/dpi.c  |   37 ++++++++++++++++++++++++++-----
>>>    drivers/video/omap2/dss/dsi.c  |   48
>>> ++++++++++++++++++++++++++++++++++++++++
>>>    drivers/video/omap2/dss/rfbi.c |    2 ++
>>>    drivers/video/omap2/dss/sdi.c  |    2 ++
>>>    4 files changed, 84 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/video/omap2/dss/dpi.c
>>> b/drivers/video/omap2/dss/dpi.c
>>> index e282456..3261644 100644
>>> --- a/drivers/video/omap2/dss/dpi.c
>>> +++ b/drivers/video/omap2/dss/dpi.c
>>> @@ -396,12 +396,44 @@ static int __init dpi_verify_dsi_pll(struct
>>> platform_device *dsidev)
>>>        return 0;
>>>    }
>>>
>>> +/*
>>> + * Return a hardcoded channel for the DPI output. This should work for
>>> + * current use cases, but this can be later expanded to either resolve
>>> + * the channel in some more dynamic manner, or get the channel as a user
>>> + * parameter.
>>> + */
>>> +static enum omap_channel dpi_get_channel(void)
>>> +{
>>> +    switch (omapdss_get_version()) {
>>> +    case OMAPDSS_VER_OMAP24xx:
>>> +    case OMAPDSS_VER_OMAP34xx_ES1:
>>> +    case OMAPDSS_VER_OMAP34xx_ES3:
>>> +    case OMAPDSS_VER_OMAP3630:
>>> +    case OMAPDSS_VER_AM35xx:
>>> +        return OMAP_DSS_CHANNEL_LCD;
>>> +
>>> +    case OMAPDSS_VER_OMAP4430_ES1:
>>> +    case OMAPDSS_VER_OMAP4430_ES2:
>>> +    case OMAPDSS_VER_OMAP4:
>>> +        return OMAP_DSS_CHANNEL_LCD2;
>>> +
>>> +    case OMAPDSS_VER_OMAP5:
>>> +        return OMAP_DSS_CHANNEL_LCD2;
>>> +
>>> +    default:
>>> +        DSSWARN("unsupported DSS version\n");
>>> +        return OMAP_DSS_CHANNEL_LCD;
>>> +    }
>>> +}
>>> +
>>>    static int __init dpi_init_display(struct omap_dss_device *dssdev)
>>>    {
>>>        struct platform_device *dsidev;
>>>
>>>        DSSDBG("init_display\n");
>>>
>>> +    dssdev->channel = dpi_get_channel();
>>
>> In patch 14 of the series, we remove these dssdev->channel assignments.
>> I don't see the point of adding them in this patch in the first place.
>> The dssdev->channel assignments will not be modified in this series, so
>> we don't need to worry about a kernel crash or something after this patch.
>>
>> I feel this patch should only add the dpi_get_channel and
>> dsi_get_channel funcs.
>
> Here's the combined patch. I changed the recommended_channel to dispc_channel.
> "recommended" was not that good name, as currently the channel cannot be changed
> later, because, for example in DPI case, we store the DSI PLL which is based on
> the channel.

The patch looks fine now.

Reviewed-by: Archit Taneja <archit@ti.com>

Archit

>
>
> Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date:   Wed Feb 13 11:23:54 2013 +0200
>
>      OMAPDSS: add output->dispc_channel
>
>      The DISPC channel used for each output is currently passed in panel
>      platform data from the board files.
>
>      To simplify this, and to make the panel drivers less dependent on OMAP,
>      this patch changes omapdss to resolve the channel independently. The
>      channel is resolved based on the OMAP version and, in case of DSI, the
>      DSI module id. This resolved channel is stored into a new field in
>      output, dispc_channel.
>
>      The few places where dssdev->channel was used are changed to use
>      output->recommended_channel. After this patch, dssdev->channel is
>      obsolete.
>
>      Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>
> diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
> index e282456..409e53b 100644
> --- a/drivers/video/omap2/dss/dpi.c
> +++ b/drivers/video/omap2/dss/dpi.c
> @@ -396,6 +396,36 @@ static int __init dpi_verify_dsi_pll(struct platform_device *dsidev)
>   	return 0;
>   }
>
> +/*
> + * Return a hardcoded channel for the DPI output. This should work for
> + * current use cases, but this can be later expanded to either resolve
> + * the channel in some more dynamic manner, or get the channel as a user
> + * parameter.
> + */
> +static enum omap_channel dpi_get_channel(void)
> +{
> +	switch (omapdss_get_version()) {
> +	case OMAPDSS_VER_OMAP24xx:
> +	case OMAPDSS_VER_OMAP34xx_ES1:
> +	case OMAPDSS_VER_OMAP34xx_ES3:
> +	case OMAPDSS_VER_OMAP3630:
> +	case OMAPDSS_VER_AM35xx:
> +		return OMAP_DSS_CHANNEL_LCD;
> +
> +	case OMAPDSS_VER_OMAP4430_ES1:
> +	case OMAPDSS_VER_OMAP4430_ES2:
> +	case OMAPDSS_VER_OMAP4:
> +		return OMAP_DSS_CHANNEL_LCD2;
> +
> +	case OMAPDSS_VER_OMAP5:
> +		return OMAP_DSS_CHANNEL_LCD3;
> +
> +	default:
> +		DSSWARN("unsupported DSS version\n");
> +		return OMAP_DSS_CHANNEL_LCD;
> +	}
> +}
> +
>   static int __init dpi_init_display(struct omap_dss_device *dssdev)
>   {
>   	struct platform_device *dsidev;
> @@ -416,12 +446,7 @@ static int __init dpi_init_display(struct omap_dss_device *dssdev)
>   		dpi.vdds_dsi_reg = vdds_dsi;
>   	}
>
> -	/*
> -	 * XXX We shouldn't need dssdev->channel for this. The dsi pll clock
> -	 * source for DPI is SoC integration detail, not something that should
> -	 * be configured in the dssdev
> -	 */
> -	dsidev = dpi_get_dsidev(dssdev->channel);
> +	dsidev = dpi_get_dsidev(dpi.output.dispc_channel);
>
>   	if (dsidev && dpi_verify_dsi_pll(dsidev)) {
>   		dsidev = NULL;
> @@ -513,6 +538,7 @@ static void __init dpi_init_output(struct platform_device *pdev)
>   	out->id = OMAP_DSS_OUTPUT_DPI;
>   	out->type = OMAP_DISPLAY_TYPE_DPI;
>   	out->name = "dpi";
> +	out->dispc_channel = dpi_get_channel();
>
>   	dss_register_output(out);
>   }
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> index 1a6ad6f..28e0b99 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -4946,6 +4946,55 @@ void omapdss_dsi_set_videomode_timings(struct omap_dss_device *dssdev,
>   }
>   EXPORT_SYMBOL(omapdss_dsi_set_videomode_timings);
>
> +/*
> + * Return a hardcoded channel for the DSI output. This should work for
> + * current use cases, but this can be later expanded to either resolve
> + * the channel in some more dynamic manner, or get the channel as a user
> + * parameter.
> + */
> +static enum omap_channel dsi_get_channel(int module_id)
> +{
> +	switch (omapdss_get_version()) {
> +	case OMAPDSS_VER_OMAP24xx:
> +		DSSWARN("DSI not supported\n");
> +		return OMAP_DSS_CHANNEL_LCD;
> +
> +	case OMAPDSS_VER_OMAP34xx_ES1:
> +	case OMAPDSS_VER_OMAP34xx_ES3:
> +	case OMAPDSS_VER_OMAP3630:
> +	case OMAPDSS_VER_AM35xx:
> +		return OMAP_DSS_CHANNEL_LCD;
> +
> +	case OMAPDSS_VER_OMAP4430_ES1:
> +	case OMAPDSS_VER_OMAP4430_ES2:
> +	case OMAPDSS_VER_OMAP4:
> +		switch (module_id) {
> +		case 0:
> +			return OMAP_DSS_CHANNEL_LCD;
> +		case 1:
> +			return OMAP_DSS_CHANNEL_LCD2;
> +		default:
> +			DSSWARN("unsupported module id\n");
> +			return OMAP_DSS_CHANNEL_LCD;
> +		}
> +
> +	case OMAPDSS_VER_OMAP5:
> +		switch (module_id) {
> +		case 0:
> +			return OMAP_DSS_CHANNEL_LCD;
> +		case 1:
> +			return OMAP_DSS_CHANNEL_LCD3;
> +		default:
> +			DSSWARN("unsupported module id\n");
> +			return OMAP_DSS_CHANNEL_LCD;
> +		}
> +
> +	default:
> +		DSSWARN("unsupported DSS version\n");
> +		return OMAP_DSS_CHANNEL_LCD;
> +	}
> +}
> +
>   static int __init dsi_init_display(struct omap_dss_device *dssdev)
>   {
>   	struct platform_device *dsidev =
> @@ -5184,6 +5233,7 @@ static void __init dsi_init_output(struct platform_device *dsidev)
>
>   	out->type = OMAP_DISPLAY_TYPE_DSI;
>   	out->name = dsi->module_id == 0 ? "dsi0" : "dsi1";
> +	out->dispc_channel = dsi_get_channel(dsi->module_id);
>
>   	dss_register_output(out);
>   }
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
> index 888cfe3..e03619a 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -1012,8 +1012,6 @@ static void __init hdmi_probe_pdata(struct platform_device *pdev)
>   	hdmi.ls_oe_gpio = priv->ls_oe_gpio;
>   	hdmi.hpd_gpio = priv->hpd_gpio;
>
> -	dssdev->channel = OMAP_DSS_CHANNEL_DIGIT;
> -
>   	r = hdmi_init_display(dssdev);
>   	if (r) {
>   		DSSERR("device %s init failed: %d\n", dssdev->name, r);
> @@ -1047,6 +1045,7 @@ static void __init hdmi_init_output(struct platform_device *pdev)
>   	out->id = OMAP_DSS_OUTPUT_HDMI;
>   	out->type = OMAP_DISPLAY_TYPE_HDMI;
>   	out->name = "hdmi";
> +	out->dispc_channel = OMAP_DSS_CHANNEL_DIGIT;
>
>   	dss_register_output(out);
>   }
> diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
> index a47a9e5..05c0646 100644
> --- a/drivers/video/omap2/dss/rfbi.c
> +++ b/drivers/video/omap2/dss/rfbi.c
> @@ -1026,6 +1026,7 @@ static void __init rfbi_init_output(struct platform_device *pdev)
>   	out->id = OMAP_DSS_OUTPUT_DBI;
>   	out->type = OMAP_DISPLAY_TYPE_DBI;
>   	out->name = "rfbi";
> +	out->dispc_channel = OMAP_DSS_CHANNEL_LCD;
>
>   	dss_register_output(out);
>   }
> diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
> index 0802927..5d37db5 100644
> --- a/drivers/video/omap2/dss/sdi.c
> +++ b/drivers/video/omap2/dss/sdi.c
> @@ -279,6 +279,7 @@ static void __init sdi_init_output(struct platform_device *pdev)
>   	out->id = OMAP_DSS_OUTPUT_SDI;
>   	out->type = OMAP_DISPLAY_TYPE_SDI;
>   	out->name = "sdi";
> +	out->dispc_channel = OMAP_DSS_CHANNEL_LCD;
>
>   	dss_register_output(out);
>   }
> diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
> index c8130f8..866e015 100644
> --- a/drivers/video/omap2/dss/venc.c
> +++ b/drivers/video/omap2/dss/venc.c
> @@ -786,8 +786,6 @@ static void __init venc_probe_pdata(struct platform_device *vencdev)
>
>   	dss_copy_device_pdata(dssdev, plat_dssdev);
>
> -	dssdev->channel = OMAP_DSS_CHANNEL_DIGIT;
> -
>   	r = venc_init_display(dssdev);
>   	if (r) {
>   		DSSERR("device %s init failed: %d\n", dssdev->name, r);
> @@ -820,6 +818,7 @@ static void __init venc_init_output(struct platform_device *pdev)
>   	out->id = OMAP_DSS_OUTPUT_VENC;
>   	out->type = OMAP_DISPLAY_TYPE_VENC;
>   	out->name = "venc";
> +	out->dispc_channel = OMAP_DSS_CHANNEL_DIGIT;
>
>   	dss_register_output(out);
>   }
> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
> index ca585ef..f38348e 100644
> --- a/drivers/video/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> @@ -2388,7 +2388,7 @@ static int omapfb_init_connections(struct omapfb2_device *fbdev,
>   		struct omap_dss_device *dssdev = fbdev->displays[i].dssdev;
>   		struct omap_dss_output *out = dssdev->output;
>
> -		mgr = omap_dss_get_overlay_manager(dssdev->channel);
> +		mgr = omap_dss_get_overlay_manager(out->dispc_channel);
>
>   		if (!mgr || !out)
>   			continue;
> diff --git a/include/video/omapdss.h b/include/video/omapdss.h
> index ba9cea7..ec322a7 100644
> --- a/include/video/omapdss.h
> +++ b/include/video/omapdss.h
> @@ -547,6 +547,9 @@ struct omap_dss_output {
>   	/* display type supported by the output */
>   	enum omap_display_type type;
>
> +	/* DISPC channel for this output */
> +	enum omap_channel dispc_channel;
> +
>   	/* output instance */
>   	enum omap_dss_output_id id;
>
>
>


From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 4/4] drm/tilcdc: add support for LCD panels (v4)
Date: Thu, 24 Jan 2013 14:08:56 +0100
Message-ID: <20130124130856.GC31306@phenom.ffwll.local>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
 <1358894185-21617-5-git-send-email-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:64993 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919Ab3AXNGv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jan 2013 08:06:51 -0500
Received: by mail-wi0-f182.google.com with SMTP id hn14so415905wib.3
        for <linux-omap@vger.kernel.org>; Thu, 24 Jan 2013 05:06:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358894185-21617-5-git-send-email-robdclark@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Tue, Jan 22, 2013 at 04:36:25PM -0600, Rob Clark wrote:
> Add an output panel driver for LCD panels.  Tested with LCD3 cape on
> beaglebone.
> 
> v1: original
> v2: s/of_find_node_by_name()/of_get_child_by_name()/ from Pantelis
>     Antoniou
> v3: add backlight support
> v4: rebase to latest of video timing helpers
> 
> Signed-off-by: Rob Clark <robdclark@gmail.com>

So given that I'm utterly lacking clue about all things of (which seems to
be where all the magic in this patch lies) I'm just gonna ask a few funny
questions.

[cut]

> +static int panel_connector_get_modes(struct drm_connector *connector)
> +{
> +	struct drm_device *dev = connector->dev;
> +	struct panel_connector *panel_connector = to_panel_connector(connector);
> +	struct display_timings *timings = panel_connector->mod->timings;
> +	int i;
> +
> +	for (i = 0; i < timings->num_timings; i++) {
> +		struct drm_display_mode *mode = drm_mode_create(dev);
> +		struct videomode vm;
> +
> +		if (videomode_from_timing(timings, &vm, i))
> +			break;
> +
> +		drm_display_mode_from_videomode(&vm, mode);

Why do we need to jump through the intermediate videomode thing here? Is
that a deficiency of the of/videomode stuff?

[cut]

> +	ret |= of_property_read_u32(info_np, "ac-bias", &info->ac_bias);
> +	ret |= of_property_read_u32(info_np, "ac-bias-intrpt", &info->ac_bias_intrpt);
> +	ret |= of_property_read_u32(info_np, "dma-burst-sz", &info->dma_burst_sz);
> +	ret |= of_property_read_u32(info_np, "bpp", &info->bpp);
> +	ret |= of_property_read_u32(info_np, "fdd", &info->fdd);
> +	ret |= of_property_read_u32(info_np, "sync-edge", &info->sync_edge);
> +	ret |= of_property_read_u32(info_np, "sync-ctrl", &info->sync_ctrl);
> +	ret |= of_property_read_u32(info_np, "raster-order", &info->raster_order);
> +	ret |= of_property_read_u32(info_np, "fifo-th", &info->fifo_th);

Shouldn't these values all be documented somewhere in the devictree docs?
Or are they somewhat standardized?

> +
> +	/* optional: */
> +	info->tft_alt_mode      = of_property_read_bool(info_np, "tft-alt-mode");
> +	info->stn_565_mode      = of_property_read_bool(info_np, "stn-565-mode");
> +	info->mono_8bit_mode    = of_property_read_bool(info_np, "mono-8bit-mode");
> +	info->invert_pxl_clk    = of_property_read_bool(info_np, "invert-pxl-clk");
> +
> +	if (of_property_read_u32(info_np, "max-bpp", &info->max_bpp))
> +		info->max_bpp = info->bpp;
> +	if (of_property_read_u32(info_np, "min-bpp", &info->min_bpp))
> +		info->min_bpp = info->bpp;
> +
> +	if (ret) {
> +		pr_err("%s: error reading panel-info properties\n", __func__);
> +		kfree(info);
> +		return NULL;
> +	}
> +
> +	return info;
> +}
> +
> +static struct of_device_id panel_of_match[];
> +
> +static int panel_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct panel_module *panel_mod;
> +	struct tilcdc_module *mod;
> +	struct pinctrl *pinctrl;
> +	int ret = -EINVAL;
> +
> +
> +	/* bail out early if no DT data: */
> +	if (!node) {
> +		dev_err(&pdev->dev, "device-tree data is missing\n");
> +		return -ENXIO;
> +	}
> +
> +	panel_mod = kzalloc(sizeof(*panel_mod), GFP_KERNEL);
> +	if (!panel_mod)
> +		return -ENOMEM;
> +
> +	mod = &panel_mod->base;
> +
> +	tilcdc_module_init(mod, "panel", &panel_module_ops);
> +
> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl))
> +		dev_warn(&pdev->dev, "pins are not configured\n");
> +
> +
> +	panel_mod->timings = of_get_display_timings(node);
> +	if (!panel_mod->timings) {
> +		dev_err(&pdev->dev, "could not get panel timings\n");
> +		goto fail;
> +	}
> +
> +	panel_mod->info = of_get_panel_info(node);
> +	if (!panel_mod->info) {
> +		dev_err(&pdev->dev, "could not get panel info\n");
> +		goto fail;
> +	}
> +
> +	panel_mod->backlight = of_find_backlight_by_node(node);

If this _really_ works that easily, I'll have of-envy for the rest of my
life :(

/me hates the real-world abomination called Intel backlight handling


Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

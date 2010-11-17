From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/3] OMAP: DSS2: Add generic DPI panel display driver
Date: Wed, 17 Nov 2010 14:44:01 +0200
Message-ID: <1289997841.26444.21.camel@tubuntu>
References: <1289960640-8782-1-git-send-email-bryan.wu@canonical.com>
	 <1289960640-8782-2-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:45881 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933640Ab0KQMoJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Nov 2010 07:44:09 -0500
In-Reply-To: <1289960640-8782-2-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Bryan Wu <bryan.wu@canonical.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com

On Wed, 2010-11-17 at 10:23 +0800, ext Bryan Wu wrote:
> Generic DPI panel driver includes the driver and 4 similar panel configurations. It
> will match the panel name which is passed from platform data and setup the
> right configurations.
> 
> With generic DPI panel driver, we can remove those 4 duplicated panel display
> drivers. In the future, it is simple for us just add new panel configuration
> date in panel-generic-dpi.c to support new display panel.
> 
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> ---
>  .../arm/plat-omap/include/plat/panel-generic-dpi.h |   37 ++
>  drivers/video/omap2/displays/Kconfig               |    8 +
>  drivers/video/omap2/displays/Makefile              |    1 +
>  drivers/video/omap2/displays/panel-generic-dpi.c   |  348 ++++++++++++++++++++
>  4 files changed, 394 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-omap/include/plat/panel-generic-dpi.h
>  create mode 100644 drivers/video/omap2/displays/panel-generic-dpi.c
> 

<snip>

> +static int generic_dpi_panel_probe(struct omap_dss_device *dssdev)
> +{
> +	struct panel_generic_dpi_data *panel_data = get_panel_data(dssdev);
> +	struct panel_config *panel_config = NULL;
> +	struct panel_drv_data *drv_data = NULL;
> +	int i;
> +
> +	dev_dbg(&dssdev->dev, "probe\n");
> +
> +	if (!panel_data || !panel_data->name)
> +		return -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(generic_dpi_panels); i++) {
> +		if (strcmp(panel_data->name, generic_dpi_panels[i].name) == 0) {
> +			panel_config = &generic_dpi_panels[i];
> +			break;
> +		}
> +	}
> +
> +	if (!panel_config)
> +		return -EINVAL;
> +
> +	dssdev->panel.config = panel_config->config;
> +	dssdev->panel.timings = panel_config->timings;
> +	dssdev->panel.acb = panel_config->acb;
> +	dssdev->panel.acbi = panel_config->acbi;
> +
> +	drv_data = kzalloc(sizeof(*drv_data), GFP_KERNEL);
> +	if (!drv_data)
> +		return -ENOMEM;
> +
> +	drv_data->dssdev = dssdev;
> +	drv_data->panel_config = panel_config;
> +
> +	dev_set_drvdata(&dssdev->dev, drv_data);
> +
> +	return 0;
> +}
> +
> +static void generic_dpi_panel_remove(struct omap_dss_device *dssdev)
> +{
> +}

You need to free the drv_data here.

Perhaps this will be the last fix =).

 Tomi



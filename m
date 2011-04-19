From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/7] OMAP: DSS: Add i2c client driver for picodlp
Date: Tue, 19 Apr 2011 14:26:57 +0300
Message-ID: <1303212417.32281.24.camel@deskari>
References: <1303107350-22747-1-git-send-email-mayur@ti.com>
	 <1303107350-22747-5-git-send-email-mayur@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:38404 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750844Ab1DSL1E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 07:27:04 -0400
Received: by wwe15 with SMTP id 15so8346893wwe.9
        for <linux-omap@vger.kernel.org>; Tue, 19 Apr 2011 04:27:01 -0700 (PDT)
In-Reply-To: <1303107350-22747-5-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mayuresh Janorkar <mayur@ti.com>
Cc: linux-omap@vger.kernel.org, Mythri P K <mythripk@ti.com>

On Mon, 2011-04-18 at 11:45 +0530, Mayuresh Janorkar wrote:
> The configurations and data transfer with picodlp panel happens through i2c.
> An i2c client with name "picodlp_i2c_driver" is registered inside panel.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/displays/panel-picodlp.c |  130 +++++++++++++++++++++++++-
>  1 files changed, 126 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
> index 4f12903..e361674 100644
> --- a/drivers/video/omap2/displays/panel-picodlp.c
> +++ b/drivers/video/omap2/displays/panel-picodlp.c
> @@ -1,8 +1,10 @@
>  /*
>   * picodlp panel driver
> + * picodlp_i2c_driver: i2c_client driver
>   *
>   * Copyright (C) 2009-2011 Texas Instruments
>   * Author: Mythri P K <mythripk@ti.com>
> + * Mayuresh Janorkar <mayur@ti.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License version 2 as published by
> @@ -23,13 +25,29 @@
>  #include <linux/firmware.h>
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
> +#include <linux/i2c.h>
>  #include <linux/delay.h>
> +#include <linux/gpio.h>
>  
>  #include <plat/display.h>
>  #include <plat/panel-picodlp.h>
>  
> +#define DRIVER_NAME	"picodlp_i2c_driver"
>  struct picodlp_data {
>  	struct mutex lock;
> +	struct i2c_client *picodlp_i2c_client;
> +};
> +
> +static struct i2c_board_info picodlp_i2c_board_info = {
> +	I2C_BOARD_INFO("picodlp_i2c_driver", 0x1b),
> +};

Can this be const?

> +struct picodlp_i2c_data {
> +	struct mutex xfer_lock;
> +};
> +
> +struct i2c_device_id picodlp_i2c_id[] = {
> +	{ "picodlp_i2c_driver", 0 },
>  };

This should be static. Probably also const. 

>  static struct omap_video_timings pico_ls_timings = {
> @@ -46,9 +64,57 @@ static struct omap_video_timings pico_ls_timings = {
>  	.vbp		= 14,
>  };
>  
> +static inline struct picodlp_panel_data
> +		*get_panel_data(const struct omap_dss_device *dssdev)
> +{
> +	return (struct picodlp_panel_data *) dssdev->data;
> +}
> +
> +static int picodlp_i2c_probe(struct i2c_client *client,
> +		const struct i2c_device_id *id)
> +{
> +	struct picodlp_i2c_data *picodlp_i2c_data;
> +
> +	picodlp_i2c_data = kzalloc(sizeof(struct picodlp_i2c_data), GFP_KERNEL);
> +
> +	if (!picodlp_i2c_data)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, picodlp_i2c_data);
> +
> +	return 0;
> +}
> +
> +static int picodlp_i2c_remove(struct i2c_client *client)
> +{
> +	struct picodlp_i2c_data *picodlp_i2c_data =
> +					i2c_get_clientdata(client);
> +
> +	kfree(picodlp_i2c_data);
> +	i2c_unregister_device(client);
> +	return 0;
> +}
> +
> +static struct i2c_driver picodlp_i2c_driver = {
> +	.driver = {
> +		.name	= "picodlp_i2c_driver",
> +	},
> +	.probe		= picodlp_i2c_probe,
> +	.remove		= picodlp_i2c_remove,
> +	.id_table	= picodlp_i2c_id,
> +};
> +
>  static int picodlp_panel_power_on(struct omap_dss_device *dssdev)
>  {
> -	int r;
> +	int r = 0;
> +	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
> +	struct picodlp_panel_data *picodlp_pdata;
> +	struct picodlp_i2c_data *picodlp_i2c_data;

Local variables don't need to be very long. The reader knows this is
pico dlp driver, so prepending the variable names with "picodlp_" is
quite extra and only make the code more difficult to read.

> +	picodlp_pdata = get_panel_data(dssdev);
> +	gpio_set_value(picodlp_pdata->display_sel_gpio, 1);
> +	gpio_set_value(picodlp_pdata->park_gpio, 1);
> +	gpio_set_value(picodlp_pdata->phy_reset_gpio, 1);

Are these GIOs related to i2c? I can't find these from the DLP
documents, at least with these names.

>  	if (dssdev->platform_enable) {
>  		r = dssdev->platform_enable(dssdev);
> @@ -65,8 +131,10 @@ static int picodlp_panel_power_on(struct omap_dss_device *dssdev)
>  	msleep(675);
>  	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
>  
> -	return 0;
> +	picodlp_i2c_data =
> +		i2c_get_clientdata(picod->picodlp_i2c_client);
>  
> +	return r;
>  err:
>  	if (dssdev->platform_disable)
>  		dssdev->platform_disable(dssdev);
> @@ -85,6 +153,11 @@ static void picodlp_panel_power_off(struct omap_dss_device *dssdev)
>  static int picodlp_panel_probe(struct omap_dss_device *dssdev)
>  {
>  	struct picodlp_data *picod;
> +	struct picodlp_panel_data *picodlp_pdata;
> +	struct i2c_adapter *adapter;
> +	struct i2c_client *picodlp_i2c_client;
> +	struct picodlp_i2c_data *picodlp_i2c_data;
> +	int r = 0, picodlp_adapter_id;
>  
>  	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_ONOFF |
>  				OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IVS;
> @@ -96,8 +169,38 @@ static int picodlp_panel_probe(struct omap_dss_device *dssdev)
>  		return -ENOMEM;
>  
>  	mutex_init(&picod->lock);
> +
> +	picodlp_pdata = get_panel_data(dssdev);
> +	picodlp_adapter_id = picodlp_pdata->picodlp_adapter_id;
> +
> +	adapter = i2c_get_adapter(picodlp_adapter_id);
> +	if (!adapter) {
> +		dev_err(&dssdev->dev, "can't get i2c adapter\n");
> +		r = -ENODEV;
> +		goto err;
> +	}
> +
> +	picodlp_i2c_client = i2c_new_device(adapter, &picodlp_i2c_board_info);
> +	/* wait till i2c device creation is done */
> +	msleep(700);

What is this sleep for? I'm quite sure the device is already created
when i2c_new_device() returns.

 Tomi



From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: RE: [PATCH v3 4/4] OMAP: DSS: Add picodlp panel driver
Date: Tue, 10 May 2011 15:57:51 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB033DB0868E@dbde02.ent.ti.com>
References: <1304954319-8386-1-git-send-email-mayur@ti.com>
	 <1304954319-8386-5-git-send-email-mayur@ti.com>
 <1305020000.3237.16.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53155 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab1EJK2B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 May 2011 06:28:01 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4AARvGB022228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 10 May 2011 05:28:00 -0500
In-Reply-To: <1305020000.3237.16.camel@lappyti>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Valkeinen, Tomi
> Sent: Tuesday, May 10, 2011 3:03 PM
> To: Janorkar, Mayuresh
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v3 4/4] OMAP: DSS: Add picodlp panel driver
> 
> On Mon, 2011-05-09 at 20:48 +0530, Mayuresh Janorkar wrote:
> >


<snip>

> > +/* This defines the minit of data which is allowed into single write
> block */
> > +#define MAX_I2C_WRITE_BLOCK_SIZE	32
> > +#define PICO_MAJOR			1 /* 2 bits */
> > +#define PICO_MINOR			1 /* 2 bits */
> > +#define MAX_TRIAL_VALUE		50
> 
> The name of this define is not descriptive and you use this define in
> two places which have nothing to do with each other. I think it's better
> just to use the value where it's needed.

Looks fine.

> 
> > +struct picodlp_data {
> > +	struct mutex lock;
> > +	struct i2c_client *picodlp_i2c_client;
> > +};
> > +
> > +static struct i2c_board_info picodlp_i2c_board_info = {
> > +	I2C_BOARD_INFO("picodlp_i2c_driver", 0x1b),
> > +};
> > +	r = i2c_transfer(client->adapter, &msg, msg_count);
> > +	mutex_unlock(&picodlp_i2c_data->xfer_lock);
> > +
> > +	/*
> > +	 * i2c_transfer returns:
> > +	 * number of messages sent in case of success
> > +	 * a negative error number in case of failure
> > +	 * i2c controller might timeout, in such a case sleep for sometime
> > +	 * and then retry
> > +	 */
> 
> The comment here doesn't look right, there's no retry.

Fine.

> 
> > +	if (r != msg_count)
> > +		goto err;
> > +
> > +	/* In case of success */
> > +	for (i = 0; i < len; i++)
> > +		dev_dbg(&client->dev,


> > +		{SEQ_CONTROL, 1}
> > +	};
> > +
> > +	msleep(510);
> 
> You are again sleeping in a place where there are no clear actions after
> and before the sleep. You should always sleep between two well defined
> actions. In this case it's the emu_done going up and the first i2c
> transaction, so a better place for this sleep is in the power_on
> function, before calling this function. With a comment saying what we
> are waiting for.

I would move this to power_on function with an appropriate comment.

> 
> > +	r = picodlp_i2c_write_array(client, init_cmd_set1,
> > +						ARRAY_SIZE(init_cmd_set1));
> > +	if (r)
> > +		return r;
> > +		msleep(5);
> > +	}
> 
> You defined the trial value to 50, which means this could timeout after
> 250ms. If I remember right, it could take 500ms until emu_done changes.
> And your error says "going down", doesn't the emu_done gpio go up when
> it's ready?

Looks fine. I would change the counter.
My bad. I meant to say emu_done is still down.

> 
> > +
> > +	r = omapdss_dpi_display_enable(dssdev);
> > +	if (r) {
> > +		dev_err(&dssdev->dev, "failed to enable DPI\n");
> > +		goto err;
> > +static void picodlp_panel_power_off(struct omap_dss_device *dssdev)
> > +{
> > +	struct picodlp_panel_data *picodlp_pdata = get_panel_data(dssdev);
> > +
> > +	omapdss_dpi_display_disable(dssdev);
> > +
> > +	gpio_set_value(picodlp_pdata->emu_done_gpio, 0);
> 
> emu_done is an input pin, you can't set its value.
Yes.

> 
> > +	gpio_set_value(picodlp_pdata->pwrgood_gpio, 0);
> > +
> > +	if (dssdev->platform_disable)
> > +		dssdev->platform_disable(dssdev);
> > +}
> > +
> > +static int picodlp_panel_probe(struct omap_dss_device *dssdev)
> > +{
> > +	struct picodlp_data *picod;
> > +	struct picodlp_panel_data *picodlp_pdata = get_panel_data(dssdev);
> > +	struct i2c_adapter *adapter;
> > +	struct i2c_client *picodlp_i2c_client;
> > +	struct picodlp_i2c_data *picodlp_i2c_data;
> > +	struct gpio picodlp_gpios[] = {
> > +		{picodlp_pdata->emu_done_gpio, GPIOF_IN, "DLP EMU DONE"},
> > +		{picodlp_pdata->pwrgood_gpio, GPIOF_INIT_LOW, "DLP PWRGOOD"},
> > +	};
> 
> pwrgood_gpio should be GPIOF_OUT_INIT_LOW.

Looks fine

> 
> It is better to request and initialize the GPIOs in the board file. The
> reason for this is that the PicoDLP device should be off if it's not
> used, or if the driver is not even compiled in. So the board file should
> make sure that the GPIOs are in such state that the device is off.

The board file has only init. There is no exit.
So if I request gpios in init once, I could not find a place to free them.

Is it a good idea to request gpios in platform_enable and free them in platform_disable?

> 
> > +
> > +	int r = 0, picodlp_adapter_id;
> > +
> > +	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_ONOFF |
> > +				OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IVS;
> > +		r = -ENODEV;
> > +		goto err;
> > +	}
> > +
> > +	picod->picodlp_i2c_client = picodlp_i2c_client;
> > +
> > +	picodlp_i2c_data =
> > +		i2c_get_clientdata(picod->picodlp_i2c_client);
> > +
> > +	mutex_init(&picodlp_i2c_data->xfer_lock);
> 
> I don't think this is right. You have no guarantees that the i2c device
> probe would have been called when the execution reaches here. So
> picodlp_i2c_data could be NULL.

I would add a check for this.

> 
> And anyway, why would you initialize the mutex here, as the mutex
> belongs to the i2c side. The i2c probe would be more logical choice in
> any case.

I will move this to i2c_probe.

> 
>  Tomi
> 


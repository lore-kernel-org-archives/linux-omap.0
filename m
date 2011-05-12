From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: RE: [PATCH v4 4/4] OMAP: DSS: Add picodlp panel driver
Date: Thu, 12 May 2011 20:25:57 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB033DBC168B@dbde02.ent.ti.com>
References: <1305033947-4521-1-git-send-email-mayur@ti.com>
	 <1305033947-4521-5-git-send-email-mayur@ti.com>
 <1305210487.2062.58.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50463 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502Ab1ELO4G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 May 2011 10:56:06 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4CEu2A4006493
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 09:56:05 -0500
In-Reply-To: <1305210487.2062.58.camel@deskari>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "K, Mythri P" <mythripk@ti.com>



> -----Original Message-----
> From: Valkeinen, Tomi
> Sent: Thursday, May 12, 2011 7:58 PM
> To: Janorkar, Mayuresh
> Cc: linux-omap@vger.kernel.org; K, Mythri P
> Subject: Re: [PATCH v4 4/4] OMAP: DSS: Add picodlp panel driver
> 
> On Tue, 2011-05-10 at 18:55 +0530, Mayuresh Janorkar wrote:
> > picodlp panel driver is required for driving DLP dpp2600.
> > It consists of a dss driver and an i2c_client.
> >
> > i2c_client is required for sending commands to dpp (DLP Pico Projector).
> >
> > Based on original design from Mythri P K <mythripk@ti.com>
> >
> > The power-up sequence consists of:
> > Setting PWRGOOD to a logic low state. Once power is stable and thus the
> ++++++++++++++++++++++++++
> >  3 files changed, 622 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/video/omap2/displays/panel-picodlp.c

<snip>

> > +
> > +#include <plat/display.h>
> > +#include <plat/panel-picodlp.h>
> > +
> > +#include "panel-picodlp.h"
> > +
> > +#define DRIVER_NAME	"picodlp_i2c_driver"
> > +
> > +#define MAX_TRIAL_VALUE			100
> 
> I'll repeat my comment from previous review round:
> 
> The name of this define is not descriptive and you use this define in
> two places which have nothing to do with each other. I think it's better
> just to use the value where it's needed.

I think it looks more readable if we have a MACRO.
But as they are used at only couple of places I would remove these MACROs.

> 
> > +struct picodlp_data {
> > +	struct mutex lock;


> > +static int picodlp_i2c_remove(struct i2c_client *client)
> > +{
> > +	struct picodlp_i2c_data *picodlp_i2c_data =
> > +					i2c_get_clientdata(client);
> > +
> > +	kfree(picodlp_i2c_data);
> > +	i2c_unregister_device(client);
> 
> You add the i2c device in the dss probe function, but unregister it in
> i2c remove function. That's probably not right. These things should
> usually be symmetric, and the unregister should be at the dss remove
> function.
> 
Isnt it good to have a remove function removing i2c_client?

I will add this sequence at dss_remove

> > +	return 0;
> > +}


> > +	 * then only i2c commands can be successfully sent to dpp2600
> > +	 */
> > +	msleep(510);
> > +	if (omapdss_dpi_display_enable(dssdev)) {
> > +		dev_err(&dssdev->dev, "failed to enable DPI\n");
> > +		goto err;
> > +	}
> > +	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
> > +
> > +	picodlp_i2c_data =
> > +		i2c_get_clientdata(picod->picodlp_i2c_client);
> > +
> > +	if (!picodlp_i2c_data) {
> > +		dev_err(&dssdev->dev, "could not find picodlp i2c data\n");
> > +		goto err;
> 
> If you goto err here, you have to call dpi_display_disable.
> 
> I think it's simpler if you get the picodlp_i2c_data somewhere in the
> beginning of this function. That way you can bail out if it's NULL
> before doing any HW writes.

That looks to be the BEST approach.

> 
> > +	}
> > +	r = picodlp_i2c_init(picod->picodlp_i2c_client);
> > +	if (r)
> > +		goto err;
> 
> And same here.

Yes, I would add dpi_display_disable at err label.

> 
> > +
> > +	return r;
> > +err:
> > +	if (dssdev->platform_disable)
> > +		dssdev->platform_disable(dssdev);
> > +
> > +	return r;
> > +}
> > +
> > +static void picodlp_panel_power_off(struct omap_dss_device *dssdev)
> > +{
> > +	struct picodlp_panel_data *picodlp_pdata = get_panel_data(dssdev);
> > +
> > +	omapdss_dpi_display_disable(dssdev);


> > +
> > +	picod->picodlp_i2c_client = picodlp_i2c_client;
> > +
> > +	picodlp_i2c_data =
> > +		i2c_get_clientdata(picod->picodlp_i2c_client);
> > +
> > +	if (!picodlp_i2c_data) {
> > +		dev_err(&dssdev->dev, "could not fine picodlp i2c data");
> > +		r = -ENODEV;
> > +		goto err;
> > +	}
> 
> You shouldn't use picodlp_i2c_data here. You don't need it and there's
> no guarantee that the i2c probe has been ran yet.
> 
> It's enough to check it at power_on.

Looks fine.

> 
> > +	dev_set_drvdata(&dssdev->dev, picod);
> > +	return r;
> > +
> > +err:
> > +	kfree(picod);
> > +	return r;
> > +}
> > +
> > +static void picodlp_panel_remove(struct omap_dss_device *dssdev)
> > +{
> > +	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
> > +
> > +	dev_set_drvdata(&dssdev->dev, NULL);
> > +	dev_dbg(&dssdev->dev, "removing picodlp panel\n");
> > +	return r;
> > +}
> > +
> > +static void __exit picodlp_exit(void)
> > +{
> > +	i2c_del_driver(&picodlp_i2c_driver);
> > +	omap_dss_unregister_driver(&picodlp_driver);
> > +}
> 
> These two could be the other way around. I'm not sure it affects the
> removal, but it's usually safer to do things in reverse order.

Looks fine.

> 
>  Tomi
> 


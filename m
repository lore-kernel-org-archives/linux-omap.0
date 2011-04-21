From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: RE: [PATCH 5/7] OMAP: DSS: Adding initialization routine to picodlp
 panel
Date: Thu, 21 Apr 2011 16:47:57 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB033D8839FB@dbde02.ent.ti.com>
References: <1303107350-22747-1-git-send-email-mayur@ti.com>
	 <1303107350-22747-6-git-send-email-mayur@ti.com>
 <1303213962.32281.46.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42639 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115Ab1DULSY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Apr 2011 07:18:24 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p3LBIKP3001126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 21 Apr 2011 06:18:23 -0500
In-Reply-To: <1303213962.32281.46.camel@deskari>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "K, Mythri P" <mythripk@ti.com>



> -----Original Message-----
> From: Valkeinen, Tomi
> Sent: Tuesday, April 19, 2011 5:23 PM
> To: Janorkar, Mayuresh
> Cc: linux-omap@vger.kernel.org; K, Mythri P
> Subject: Re: [PATCH 5/7] OMAP: DSS: Adding initialization routine to
> picodlp panel
> 
> On Mon, 2011-04-18 at 11:45 +0530, Mayuresh Janorkar wrote:
> > From: Mythri P K <mythripk@ti.com>
> >
> > picodlp_i2c_client needs to send commands over i2c as a part of
> initialiazation.
> > system controller dlp pico processor dpp2600 is used.
> > It configures the splash screen of picodlp using a sequence of commands.
> > A programmer's guide is available at:
> > http://focus.ti.com/lit/ug/dlpu002a/dlpu002a.pdf
> >
> > API is defined for sending command over i2c as an i2c_write operation.
> >
> > Signed-off-by: Mythri P K <mythripk@ti.com>
> > Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
> > ---
> >  drivers/video/omap2/displays/panel-picodlp.c |  317
> ++++++++++++++++++++++++++
> >  1 files changed, 317 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/video/omap2/displays/panel-picodlp.c
> b/drivers/video/omap2/displays/panel-picodlp.c
> > index e361674..785e406 100644
> > --- a/drivers/video/omap2/displays/panel-picodlp.c
> > +++ b/drivers/video/omap2/displays/panel-picodlp.c
> > @@ -32,7 +32,15 @@
> >  #include <plat/display.h>
> >  #include <plat/panel-picodlp.h>
> >
> > +#include "panel-picodlp.h"
> > +
> >  #define DRIVER_NAME	"picodlp_i2c_driver"
> > +
> > +/* This defines the minit of data which is allowed into single write
> block */
> > +#define MAX_I2C_WRITE_BLOCK_SIZE	32
> > +#define PICO_MAJOR			1 /* 2 bits */
> > +#define PICO_MINOR			1 /* 2 bits */
> > +
> >  struct picodlp_data {
> >  	struct mutex lock;
> >  	struct i2c_client *picodlp_i2c_client;
> > @@ -50,6 +58,11 @@ struct i2c_device_id picodlp_i2c_id[] = {
> >  	{ "picodlp_i2c_driver", 0 },
> >  };
> >
> > +struct picodlp_i2c_command {
> > +	u8 reg;
> > +	u32 value;
> > +};
> > +
> >  static struct omap_video_timings pico_ls_timings = {
> >  	.x_res		= 864,
> >  	.y_res		= 480,
> > @@ -70,6 +83,305 @@ static inline struct picodlp_panel_data
> >  	return (struct picodlp_panel_data *) dssdev->data;
> >  }
> >
> > +static int picodlp_i2c_write_block(struct i2c_client *client,
> > +					u8 *data, int len)
> > +{
> > +	struct i2c_msg msg;
> > +	int i, r;
> > +
> > +	struct picodlp_i2c_data *picodlp_i2c_data =
> i2c_get_clientdata(client);
> > +
> > +	if (len < 1 || len > MAX_I2C_WRITE_BLOCK_SIZE) {
> > +		dev_err(&client->dev,
> > +			"too long syn_write_block len %d\n", len);
> > +		return -EIO;
> > +	}
> > +
> > +	mutex_lock(&picodlp_i2c_data->xfer_lock);
> > +
> > +	msg.addr = client->addr;
> > +	msg.flags = 0;
> > +	msg.len = len;
> > +	msg.buf = data;
> > +
> > +	r = i2c_transfer(client->adapter, &msg, 1);
> > +	mutex_unlock(&picodlp_i2c_data->xfer_lock);
> > +
> > +	if (r == 1) {
> > +		for (i = 0; i < len; i++)
> > +			dev_dbg(&client->dev,
> > +				"addr %x bw 0x%02x[%d]: 0x%02x\n",
> > +				client->addr, data[0] + i, i, data[i]);
> > +		return 0;
> > +	}
> > +
> > +	dev_err(&client->dev, " picodlp_i2c_write error\n");
> > +	return r;
> 
> This is, at least to my eyes, a bit uncommon way to do this. Usually the
> error path is handled inside an if(), and the ok path is at the end of
> the function.

Would change this as per the most used formats.

> 
> > +}
> > +	int r;
> > +	static const struct picodlp_i2c_command init_cmd_set1[] = {
> > +		{SOFT_RESET, 1}, {DMD_PARK_TRIGGER, 1},
> > +		{MISC_REG, (PICO_MAJOR << 2 | PICO_MINOR)}, {SEQ_CONTROL, 0},
> > +		{SEQ_VECTOR, 0x100}, {DMD_BLOCK_COUNT, 7},
> > +		{DMD_VCC_CONTROL, 0x109}, {DMD_PARK_PULSE_COUNT, 0xA},
> > +		{DMD_PARK_PULSE_WIDTH, 0xB}, {DMD_PARK_DELAY, 0x2ED},
> > +		{DMD_SHADOW_ENABLE, 0}, {FLASH_OPCODE, 0xB},
> > +		{FLASH_DUMMY_BYTES, 1}, {FLASH_ADDR_BYTES, 3},
> > +	};
> 
> It would make these command lists clearer if there was only one command
> per line.


Fine

> 
> > +
> > +	if (r)
> > +		return r;
> > +
> > +	/* display logo splash image */
> > +	r = picodlp_dpp2600_config_splash(client);
> > +	if (r)
> > +		return r;
> 
> So this will show some hardcoded splash screen? How much of the code
> could be removed if the splash screen feature is removed? I don't see
> much point in such a feature, and it looks to me that at least two of
> the functions above are just for the splash screen. It's just extra code
> for a feature nobody wants.

Yes, this would show a hardcoded splash screen.

> 
> > +	r = picodlp_i2c_write_array(client, init_cmd_set3,
> > +					ARRAY_SIZE(init_cmd_set3));
> > +	if (r)
> > +		return r;
> > +
> > +	r = picodlp_dpp2600_config_rgb(client);
> > +	if (r)
> > +		return r;
> > +
> > +	return 0;
> > +}
> > +
> >  static int picodlp_i2c_probe(struct i2c_client *client,
> >  		const struct i2c_device_id *id)
> >  {
> > @@ -134,6 +446,11 @@ static int picodlp_panel_power_on(struct
> omap_dss_device *dssdev)
> >  	picodlp_i2c_data =
> >  		i2c_get_clientdata(picod->picodlp_i2c_client);
> >
> > +	msleep(700); /* sleep till panel is settled */
> 
> And another huge sleep. This, unlike the other sleeps, make some sense,
> as there's an i2c transaction done below.
> 
> Somehow I get the feeling that you've just put big sleeps here and there
> until the driver started working... Can you point me to the
> documentation that describes the delays required?

Except msleep(5) in
/* transfer control to flash controller */
r = picodlp_i2c_write(client, PBC_CONTROL, 1);
        msleep(5);
r = picodlp_i2c_write(client, PBC_CONTROL, 0); 

Other delays are not documented. But it is practically observed that we need to wait otherwise the i2c_packet does not succeed.

As I mentioned earlier, I can follow one approach, in i2c_write see if packet transfer happens. If not, sleep for some time and retry.

This approach would remove these delays from this place.

> > +	r = picodlp_i2c_init(picod->picodlp_i2c_client);
> > +	if (r)
> > +		goto err;
> > +
> >  	return r;
> >  err:
> >  	if (dssdev->platform_disable)
> 


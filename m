From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 5/7] OMAP: DSS: Adding initialization routine to
 picodlp panel
Date: Tue, 03 May 2011 21:58:16 +0300
Message-ID: <1304449096.26126.35.camel@deskari>
References: <1304347971-1504-1-git-send-email-mayur@ti.com>
	 <1304347971-1504-6-git-send-email-mayur@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:44403 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754483Ab1ECS6W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 14:58:22 -0400
Received: by ewy8 with SMTP id 8so116864ewy.26
        for <linux-omap@vger.kernel.org>; Tue, 03 May 2011 11:58:20 -0700 (PDT)
In-Reply-To: <1304347971-1504-6-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mayuresh Janorkar <mayur@ti.com>
Cc: linux-omap@vger.kernel.org, Mythri P K <mythripk@ti.com>

On Mon, 2011-05-02 at 20:22 +0530, Mayuresh Janorkar wrote:
> From: Mythri P K <mythripk@ti.com>
> 
> picodlp_i2c_client needs to send commands over i2c as a part of initialiazation.
> system controller dlp pico processor dpp2600 is used.
> It configures the splash screen of picodlp using a sequence of commands.
> A programmer's guide is available at:
> http://focus.ti.com/lit/ug/dlpu002a/dlpu002a.pdf
> 
> API is defined for sending command over i2c as an i2c_write operation.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
> ---
> Changes since v1:
> 	1. Removed initial splash screen
> 	2. i2c_commands regrouped
> 	3. Removed long msleep
> 	4. Added try-after-sleep in i2c_write
> 
>  drivers/video/omap2/displays/panel-picodlp.c |  212 ++++++++++++++++++++++++++
>  1 files changed, 212 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
> index fdbfdcf..493a411 100644
> --- a/drivers/video/omap2/displays/panel-picodlp.c
> +++ b/drivers/video/omap2/displays/panel-picodlp.c
> @@ -32,7 +32,15 @@
>  #include <plat/display.h>
>  #include <plat/panel-picodlp.h>
>  
> +#include "panel-picodlp.h"
> +
>  #define DRIVER_NAME	"picodlp_i2c_driver"
> +
> +/* This defines the minit of data which is allowed into single write block */
> +#define MAX_I2C_WRITE_BLOCK_SIZE	32
> +#define PICO_MAJOR			1 /* 2 bits */
> +#define PICO_MINOR			1 /* 2 bits */
> +
>  struct picodlp_data {
>  	struct mutex lock;
>  	struct i2c_client *picodlp_i2c_client;
> @@ -50,6 +58,11 @@ struct i2c_device_id picodlp_i2c_id[] = {
>  	{ "picodlp_i2c_driver", 0 },
>  };
>  
> +struct picodlp_i2c_command {
> +	u8 reg;
> +	u32 value;
> +};
> +
>  static struct omap_video_timings pico_ls_timings = {
>  	.x_res		= 864,
>  	.y_res		= 480,
> @@ -70,6 +83,197 @@ static inline struct picodlp_panel_data
>  	return (struct picodlp_panel_data *) dssdev->data;
>  }
>  
> +static int picodlp_i2c_write_block(struct i2c_client *client,
> +					u8 *data, int len)
> +{
> +	struct i2c_msg msg;
> +	int i, r, msg_count = 1, trial = 4;
> +
> +	struct picodlp_i2c_data *picodlp_i2c_data = i2c_get_clientdata(client);
> +
> +	if (len < 1 || len > MAX_I2C_WRITE_BLOCK_SIZE) {
> +		dev_err(&client->dev,
> +			"too long syn_write_block len %d\n", len);
> +		return -EIO;
> +	}
> +retry:
> +	mutex_lock(&picodlp_i2c_data->xfer_lock);
> +
> +	msg.addr = client->addr;
> +	msg.flags = 0;
> +	msg.len = len;
> +	msg.buf = data;
> +	r = i2c_transfer(client->adapter, &msg, msg_count);
> +	mutex_unlock(&picodlp_i2c_data->xfer_lock);
> +
> +	/*
> +	 * i2c_transfer returns:
> +	 * number of messages sent in case of success
> +	 * a negative error number in case of failure
> +	 * i2c controller might timeout, in such a case sleep for sometime
> +	 * and then retry
> +	 */
> +	if (r != msg_count) {
> +		msleep(2);
> +		if (trial--)
> +			goto retry;

This is not good. Hacks like these should only be used as a last option.

I'm still saying that you should find the document mentioned in the
documents you have. I refuse to believe that we (TI) do not know what
our hardware does, especially in a basic issue like this.

I'm 99% sure there is documentation telling the required power-up
sequence. And if that 1% happens, we should find the HW designers and
yell at them until they make the documents.

 Tomi



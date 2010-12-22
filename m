From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v6 07/10] OMAP3: PM: Adding T2 enabling of smartreflex support
Date: Wed, 22 Dec 2010 12:30:35 -0800
Message-ID: <87mxnxr1n8.fsf@deeprootsystems.com>
References: <1292864357-13939-1-git-send-email-thara@ti.com>
	<1292864357-13939-8-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:42635 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880Ab0LVUam (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 15:30:42 -0500
Received: by gwb20 with SMTP id 20so3734876gwb.1
        for <linux-omap@vger.kernel.org>; Wed, 22 Dec 2010 12:30:41 -0800 (PST)
In-Reply-To: <1292864357-13939-8-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Mon, 20 Dec 2010 22:29:14 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, nm@ti.com

Hi Thara,

Thara Gopinath <thara@ti.com> writes:

> This patch adds support in the twl4030 driver to enable smartreflex.
> The smartreflex bit on twl4030 needs to be enabled by default irrespective
> of whether smartreflex module is enabled on the OMAP side or not.
> This is because without this bit enabled the voltage scaling through
> vp forceupdate does not function properly.

Is this true for OMAP2 as well?  

This patch actually hangs the boot on 2430SDP.  

For now, I'll be dropping this patch from my pull request.  Also, this patch
will also need an Ack from the MFD maintainers, or possibly even merge 
through their tree.  Please also Cc the MFD list on the fix.

While fixing this issue, another CodingStyle comment below...

> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  drivers/mfd/twl-core.c  |   13 +++++++++++++
>  include/linux/i2c/twl.h |   11 +++++++++++
>  2 files changed, 24 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 35275ba..b895ceb 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -1046,6 +1046,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	/* Disable TWL4030/TWL5030 I2C Pull-up on I2C1 and I2C4(SR) interface.
>  	 * Program I2C_SCL_CTRL_PU(bit 0)=0, I2C_SDA_CTRL_PU (bit 2)=0,
>  	 * SR_I2C_SCL_CTRL_PU(bit 4)=0 and SR_I2C_SDA_CTRL_PU(bit 6)=0.
> +	 * Also enable the smartreflex I2S bit.
>  	 */
>  
>  	if (twl_class_is_4030()) {
> @@ -1053,6 +1054,18 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  		temp &= ~(SR_I2C_SDA_CTRL_PU | SR_I2C_SCL_CTRL_PU | \
>  		I2C_SDA_CTRL_PU | I2C_SCL_CTRL_PU);
>  		twl_i2c_write_u8(TWL4030_MODULE_INTBR, temp, REG_GPPUPDCTR1);
> +
> +		/* The smartreflex bit on twl4030 needs to be enabled by
> +		 * default irrespective of whether smartreflex module is
> +		 * enabled on the OMAP side or not. This is because without
> +		 * this bit enabled the voltage scaling through
> +		 * vp forceupdate does not function properly.
> +		 */

please update multi-line coding style.

Kevin

> +		twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &temp,
> +			TWL4030_PM_RECEIVER_DCDC_GLOBAL_CFG);
> +		temp |= SMARTREFLEX_ENABLE;
> +		twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, temp,
> +			TWL4030_PM_RECEIVER_DCDC_GLOBAL_CFG);
>  	}
>  
>  	status = add_children(pdata, id->driver_data);
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index c760991..d392f06 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -434,6 +434,17 @@ static inline int twl6030_mmc_card_detect(struct device *dev, int slot)
>  
>  /*----------------------------------------------------------------------*/
>  
> +/*
> + * PM Receiver module register offsets (use TWL4030_MODULE_PM_RECEIVER)
> + */
> +
> +#define TWL4030_PM_RECEIVER_DCDC_GLOBAL_CFG	0x06
> +
> +/* Smartreflex I2S bus enable/ vmode enable bit */
> +#define SMARTREFLEX_ENABLE			BIT(3)
> +
> +/*----------------------------------------------------------------------*/
> +
>  /* Power bus message definitions */
>  
>  /* The TWL4030/5030 splits its power-management resources (the various

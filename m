From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/1] OMAP: I2C: Add mpu wake up latency constraint in
 i2c
Date: Thu, 1 Oct 2009 09:10:40 +0300
Message-ID: <20091001091040.dcc24d47.jhnikula@gmail.com>
References: <1253204923-21916-1-git-send-email-kalle.jokiniemi@digia.com>
	<1253204923-21916-2-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:64422 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbZJAGKY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 02:10:24 -0400
Received: by ey-out-2122.google.com with SMTP id 4so624038eyf.19
        for <linux-omap@vger.kernel.org>; Wed, 30 Sep 2009 23:10:27 -0700 (PDT)
In-Reply-To: <1253204923-21916-2-git-send-email-kalle.jokiniemi@digia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org

Hi Kalle

Few minor comments below.

On Thu, 17 Sep 2009 19:28:43 +0300
Kalle Jokiniemi <kalle.jokiniemi@digia.com> wrote:

> -static u32 i2c_rate[ARRAY_SIZE(i2c_resources)];
> +static struct omap_i2c_bus_platform_data i2c_pdata[ARRAY_SIZE(i2c_resources)];
>  static struct platform_device omap_i2c_devices[] = {
> -	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_rate[0]),
> +	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_pdata[0]),
>  #if	defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> -	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_rate[1]),
> +	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_pdata[1]),
>  #endif
>  #if	defined(CONFIG_ARCH_OMAP34XX)
> -	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_rate[2]),
> +	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_pdata[2]),
>  #endif
>  };
This is good idea. IRCC, e.g. the I2C_SCL t_high and t_low timing values
can be board dependent values so passing just the i2c_rate as a
platform_data seems to be not enough in the future.

> @@ -526,8 +529,10 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	 * REVISIT: We should abort the transfer on signals, but the bus goes
>  	 * into arbitration and we're currently unable to recover from it.
>  	 */
> +	dev->set_mpu_wkup_lat(dev->dev, 1);
>  	r = wait_for_completion_timeout(&dev->cmd_complete,
>  					OMAP_I2C_TIMEOUT);
> +	dev->set_mpu_wkup_lat(dev->dev, 0);

These lines here and lines below in omap_i2c_probe looks suspicious. I
would rather allow callback to be NULL (and then you would not need
empty function in arch/arm/plat-omap/i2c.c) and just test it here
before executing. Looks much more safe code then.

> +	if (pdata != NULL) {
> +		speed = pdata->clkrate;
> +		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
> +	} else {
> +		speed = 100;	/* Default speed */
> +		dev->set_mpu_wkup_lat = NULL;
> +	}


-- 
Jarkko

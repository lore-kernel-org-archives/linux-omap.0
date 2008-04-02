From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Stop AIC23 driver from Oopsing.
Date: Wed, 2 Apr 2008 10:09:14 +0300
Message-ID: <20080402070913.GB31913@atomide.com>
References: <12068100513180-git-send-email-balrogg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57246 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760684AbYDBHJS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Apr 2008 03:09:18 -0400
Content-Disposition: inline
In-Reply-To: <12068100513180-git-send-email-balrogg@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrzej Zaborowski <balrogg@gmail.com>
Cc: linux-omap@vger.kernel.org

* Andrzej Zaborowski <balrogg@gmail.com> [080329 18:30]:
> From: Andrzej Zaborowski <balrog@zabor.org>
> 
> Prevent AIC23 driver Oopsing when no AIC23 is present by moving some of the
> initialisation to after the chip is found.  There seems to be more that
> should be fixed in this driver but with this change it can at least be
> compiled into a kernel safely.

This does not seem to apply, can you please check?

Regards,

Tony

> 
> Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
> ---
>  drivers/i2c/chips/tlv320aic23.c |   92 ++++++++++++++++++++------------------
>  1 files changed, 48 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/i2c/chips/tlv320aic23.c b/drivers/i2c/chips/tlv320aic23.c
> index c1e27f1..1c498f2 100644
> --- a/drivers/i2c/chips/tlv320aic23.c
> +++ b/drivers/i2c/chips/tlv320aic23.c
> @@ -54,6 +54,7 @@ I2C_CLIENT_INSMOD;
>  static struct i2c_driver aic23_driver;
>  static struct i2c_client *new_client;
>  static int selftest;
> +static struct platform_device audio_i2c_device;
>  
>  static struct aic23_info {
>  	u16 volume_reg_left;
> @@ -95,6 +96,38 @@ int aic23_write_value(u8 reg, u16 value)
>  	return 0;
>  }
>  
> +/*
> + * Configures the McBSP3 which is used to send clock to the AIC23 codec.
> + * The input clock rate from DSP is 12MHz.
> + * The DSP clock must be on before this is called. 
> + */
> +static int omap_mcbsp3_aic23_clock_init(void)
> +{
> +	u16 w;
> +
> +	/* enable 12MHz clock to mcbsp 1 & 3 */
> +	__raw_writew(__raw_readw(DSP_IDLECT2) | (1<<1), DSP_IDLECT2);
> +	__raw_writew(__raw_readw(DSP_RSTCT2) | 1 | 1<<1, DSP_RSTCT2);
> +
> +	/* disable sample rate generator */
> +	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SPCR1, 0x0000);
> +	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SPCR2, 0x0000);
> +
> +	/* pin control register */
> +	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, PCR0,(CLKXM | CLKXP | CLKRP));
> +
> +	/* configure srg to send 12MHz pulse from dsp peripheral clock */
> +	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SRGR1, 0x0000);
> +	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SRGR2, CLKSM);
> +
> +	/* enable sample rate generator */
> +	w = OMAP_MCBSP_READ(OMAP1610_MCBSP3_BASE, SPCR2);
> +	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SPCR2, (w | FREE | GRST));
> +	printk("Clock enabled to MCBSP1 & 3 \n");
> +
> +	return 0;
> +}
> +
>  static int aic23_detect_client(struct i2c_adapter *adapter, int address,
>  				     int kind)
>  {
> @@ -128,6 +161,19 @@ static int aic23_detect_client(struct i2c_adapter *adapter, int address,
>  		kfree(new_client);
>  		return err;
>  	}
> +
> +	if (platform_device_register(&audio_i2c_device)) {
> +		printk(KERN_WARNING "Failed to register audio i2c device\n");
> +		selftest = -ENODEV;
> +		return selftest;
> +	}
> +	/* FIXME: Do in board-specific file */
> +	omap_mcbsp3_aic23_clock_init();
> +
> +	if (!aic23_info_l.power_down)
> +		aic23_power_up();
> +	aic23_info_l.initialized = 1;
> +
>  	return 0;
>  }
>  
> @@ -135,6 +181,8 @@ static int aic23_detach_client(struct i2c_client *client)
>  {
>  	int err;
>  
> +	platform_device_unregister(&audio_i2c_device);
> +
>  	if ((err = i2c_detach_client(client))) {
>  		printk("aic23.o: Client deregistration failed, \
>  		       client not detached.\n");
> @@ -162,38 +210,6 @@ static struct i2c_driver aic23_driver = {
>  	.detach_client	= aic23_detach_client,
>  };
>  
> -/*
> - * Configures the McBSP3 which is used to send clock to the AIC23 codec.
> - * The input clock rate from DSP is 12MHz.
> - * The DSP clock must be on before this is called. 
> - */
> -static int omap_mcbsp3_aic23_clock_init(void)
> -{
> -	u16 w;
> -
> -	/* enable 12MHz clock to mcbsp 1 & 3 */
> -	__raw_writew(__raw_readw(DSP_IDLECT2) | (1<<1), DSP_IDLECT2);
> -	__raw_writew(__raw_readw(DSP_RSTCT2) | 1 | 1<<1, DSP_RSTCT2);
> -
> -	/* disable sample rate generator */
> -	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SPCR1, 0x0000);
> -	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SPCR2, 0x0000);
> -
> -	/* pin control register */
> -	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, PCR0,(CLKXM | CLKXP | CLKRP));
> -
> -	/* configure srg to send 12MHz pulse from dsp peripheral clock */
> -	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SRGR1, 0x0000);
> -	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SRGR2, CLKSM);
> -
> -	/* enable sample rate generator */
> -	w = OMAP_MCBSP_READ(OMAP1610_MCBSP3_BASE, SPCR2);
> -	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SPCR2, (w | FREE | GRST));
> -	printk("Clock enabled to MCBSP1 & 3 \n");
> -
> -	return 0;
> -}
> -
>  static void update_volume_left(int volume)
>  {
>  	u16 val = 0;
> @@ -633,17 +649,6 @@ static int __init aic23_init(void)
>  		return selftest;
>  	}
>  
> -	if (platform_device_register(&audio_i2c_device)) {
> -		printk(KERN_WARNING "Failed to register audio i2c device\n");
> -		platform_driver_unregister(&audio_i2c_driver);
> -		selftest = -ENODEV;
> -		return selftest;
> -	}
> -	/* FIXME: Do in board-specific file */
> -	omap_mcbsp3_aic23_clock_init();
> -	if (!aic23_info_l.power_down)
> -		aic23_power_up();
> -	aic23_info_l.initialized = 1;
>  	printk("TLV320AIC23 I2C version %s (%s)\n", 
>  	       TLV320AIC23_VERSION, TLV320AIC23_DATE);
>  
> @@ -658,7 +663,6 @@ static void __exit aic23_exit(void)
>  	if ((res = i2c_del_driver(&aic23_driver))) 
>  		printk("aic23 i2c: Driver remove failed, module not removed.\n");
>  
> -	platform_device_unregister(&audio_i2c_device);
>  	platform_driver_unregister(&audio_i2c_driver);
>  }
>  
> -- 
> 1.5.3.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

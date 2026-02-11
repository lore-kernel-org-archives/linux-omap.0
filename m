Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA4330C606;
	Wed, 11 Feb 2026 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770810665; cv=pass; b=Fkz3cuo66qcLSELsbwa0w8mVDK4LvpCWyhBQ/YcWTRJgxDHxvC11D0DujW9PSAJ1W6vn0tp6C7V/d1x7jY6WDf0cGntO7kGYI/6OQcKM3nWQKiqJbj9gd9YMFM7T0x17n9TdGXqw6Ox37derVo97l9VWexV3bn8arxOZARUua44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770810665; c=relaxed/simple;
	bh=Fi4aw6nTMAtqK40oowJOdnGWGu03VYNG+X1auyEn6Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY1JlibfeEp4LajEmEOABgZyThs1UMzZE/JigrGC+48LBXLvsxwoR6SY4vypQ+Ti8gPwCKagGtuuQj9pxoIsRKjHD3QTLzmVmPnaAweqLhUPa2r0hzcqpY5q1hJmf5Y3OX68FE+3qZm6+4rEbp4yzfLZPlwzWC4ctJW5I7XZIDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=DHHF9Swo; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="DHHF9Swo"
Received: from darkstar.musicnaut.iki.fi (85-76-68-182-nat.elisa-mobile.fi [85.76.68.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4f9xPt08zKz49Q5P;
	Wed, 11 Feb 2026 13:42:57 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1770810180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DhOrUnGDwOZpo3bOt2i0FPNOeyumTwoy45hxUXnS4/8=;
	b=DHHF9SwoEIPPqb1Y95d96Dt7mnLOB6bZ/bkgDivsT85keHGXrYr0sNt/QITeY+i7xuX/qY
	dqVZO+QfgHBIKP9uiswFR4b+5ylbsEHjsBzStbjIVVrpTN2wpMP0wt6HGUfQbnFEak4/hW
	SaEZWYlnZ+OBS986J36tyGCul49nPk28URyfU20u5I5DCyVUVXtx5bMYPZPA7NWkDnfoCZ
	d7KRxOSlRtuUO0y4xvQZG61tGkmPKLGJR/Qs3bXz2jY0joTnGZBd0I2dxKZ0hD3+KBdl8d
	GknhHK7qfmCusQEkr9d9jpKQyUN3YTvvmOHAsUrt7iqrCjcP+Ibvowk8jEErSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1770810180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DhOrUnGDwOZpo3bOt2i0FPNOeyumTwoy45hxUXnS4/8=;
	b=kwHhvmP76adQ9GjuBxjK18his0ITyXZ/MVl/VP5Z2HT2Ra5syNgFTvtm6haggsi8AS5mlB
	ODkd5tkIttpHskQ/Cf1WKrXhyO6SucdJ6zTaHHzIUc7gVa1h0/Oy0py8+pzOHdKS0k00xR
	wJbJ3wSFL5uT6LcUpMUb4395JZUaf5EcmWI4TCglqbi3m6/BXZWIbM2W8ykn79aQl3wfUh
	e0UrqFKkSu2l6ge16LZv94Zk2P6qY0SDSBQ4BcFkI7TOK7gxtfumIcAu0GeFogIVNSuETk
	9LhviI5l35OKvxKvrgfn0P5Np5Xwdm+MHnWO+JLDy7yWphhxFR9n8s66WBvKtA==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1770810180;
	b=h+1Dg5tV5VH25sWJZB5zOqYCICtpnQfyQvt10BBA0dJeuN5uKT1InH4KAsGAmriRUfvh20
	/TvpT5jmo+5M43hB0mpw2FhRA0r1//mO15rFts1pYiGchNqkyo345h/Fs+ZJL2eY0I4HtP
	9Q8hgOOJp54GwKffFPssEoO8nTwpCsSwpRBRzgPDjLTNrBDTezJAEfVgqc0W2OCbIKdfpJ
	ntIkpsX3hfwKBRIitI5azzZapwxDBpLZngrlaU6XryFFDnZAZOEX5YJ/Y69RoHkVR+Gr3K
	lcZaVB9l9xU4nis2MK1GVvSyidRe4PJovfDyS7gcZyy4f3VjLPzFLq9MBbde2g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
Date: Wed, 11 Feb 2026 13:42:56 +0200
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arnd Bergmann <arnd@kernel.org>, Hans de Goede <hansg@kernel.org>,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, brgl@kernel.org
Subject: Re: [RFT PATCH] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
Message-ID: <aYxrQDFxcQ6G-tbB@darkstar.musicnaut.iki.fi>
References: <20260211111449.122593-1-bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211111449.122593-1-bartosz.golaszewski@oss.qualcomm.com>

Hi,

On Wed, Feb 11, 2026 at 12:14:49PM +0100, Bartosz Golaszewski wrote:
> Currently the board file for Nokia 770 creates dummy software nodes not
> attached in any way to the actual GPIO controller devices and uses the
> fact that GPIOLIB matching swnode's name to the GPIO chip's label during
> software node lookup. This behavior is wrong and we want to remove it.
> To that end, we need to first convert all existing users to creating
> actual fwnode links.
> 
> Create real software nodes for GPIO controllers on OMAP16xx and
> reference them from the software nodes in the nokia board file.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> This is a follow up to the following discussion[1]. I don't have the
> hardware for testing so only build-tested it.

I won't build with CONFIG_I2C_CBUS_GPIO - the CBUS is mandatory, otherwise
the board will power off 30 seconds after the reset.

A.

> [1] https://lore.kernel.org/all/aYkdKfP5fg6iywgr@jekhomev/
> 
>  arch/arm/mach-omap1/board-nokia770.c | 24 ++---------------------
>  arch/arm/mach-omap1/common.h         |  4 ++++
>  arch/arm/mach-omap1/gpio16xx.c       | 29 +++++++++++++++++++++++++++-
>  3 files changed, 34 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
> index a5bf5554800f..a81514c6f92c 100644
> --- a/arch/arm/mach-omap1/board-nokia770.c
> +++ b/arch/arm/mach-omap1/board-nokia770.c
> @@ -36,25 +36,6 @@
>  #include "clock.h"
>  #include "mmc.h"
>  
> -static const struct software_node nokia770_mpuio_gpiochip_node = {
> -	.name = "mpuio",
> -};
> -
> -static const struct software_node nokia770_gpiochip1_node = {
> -	.name = "gpio-0-15",
> -};
> -
> -static const struct software_node nokia770_gpiochip2_node = {
> -	.name = "gpio-16-31",
> -};
> -
> -static const struct software_node *nokia770_gpiochip_nodes[] = {
> -	&nokia770_mpuio_gpiochip_node,
> -	&nokia770_gpiochip1_node,
> -	&nokia770_gpiochip2_node,
> -	NULL
> -};
> -
>  #define ADS7846_PENDOWN_GPIO	15
>  
>  static const unsigned int nokia770_keymap[] = {
> @@ -112,7 +93,7 @@ static const struct omap_lcd_config nokia770_lcd_config __initconst = {
>  };
>  
>  static const struct property_entry nokia770_mipid_props[] = {
> -	PROPERTY_ENTRY_GPIO("reset-gpios", &nokia770_gpiochip1_node,
> +	PROPERTY_ENTRY_GPIO("reset-gpios", &omap16xx_gpio1_swnode,
>  			    13, GPIO_ACTIVE_LOW),
>  	{ }
>  };
> @@ -138,7 +119,7 @@ static const struct property_entry nokia770_ads7846_props[] = {
>  	PROPERTY_ENTRY_U16("ti,x-plate-ohms", 180),
>  	PROPERTY_ENTRY_U16("ti,debounce-tol", 3),
>  	PROPERTY_ENTRY_U16("ti,debounce-rep", 1),
> -	PROPERTY_ENTRY_GPIO("pendown-gpios", &nokia770_gpiochip1_node,
> +	PROPERTY_ENTRY_GPIO("pendown-gpios", &omap16xx_gpio1_swnode,
>  			    ADS7846_PENDOWN_GPIO, GPIO_ACTIVE_LOW),
>  	{ }
>  };
> @@ -318,7 +299,6 @@ static void __init omap_nokia770_init(void)
>  	/* Unmask SleepX signal */
>  	omap_writew((omap_readw(0xfffb5004) & ~2), 0xfffb5004);
>  
> -	software_node_register_node_group(nokia770_gpiochip_nodes);
>  	platform_add_devices(nokia770_devices, ARRAY_SIZE(nokia770_devices));
>  
>  	gpiod_add_lookup_table(&nokia770_irq_gpio_table);
> diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
> index 7a7c3d9eb84a..34659b5fc6f0 100644
> --- a/arch/arm/mach-omap1/common.h
> +++ b/arch/arm/mach-omap1/common.h
> @@ -35,6 +35,10 @@
>  #include "soc.h"
>  #include "i2c.h"
>  
> +extern const struct software_node omap16xx_mpu_gpio_swnode;
> +extern const struct software_node omap16xx_gpio1_swnode;
> +extern const struct software_node omap16xx_gpio2_swnode;
> +
>  #ifdef CONFIG_OMAP_SERIAL_WAKE
>  int omap_serial_wakeup_init(void);
>  #else
> diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
> index 55acec22fef4..6eedb87cbf6b 100644
> --- a/arch/arm/mach-omap1/gpio16xx.c
> +++ b/arch/arm/mach-omap1/gpio16xx.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/platform_data/gpio-omap.h>
> +#include <linux/property.h>
>  #include <linux/soc/ti/omap1-io.h>
>  
>  #include "hardware.h"
> @@ -55,6 +56,8 @@ static struct omap_gpio_platform_data omap16xx_mpu_gpio_config = {
>  	.regs                   = &omap16xx_mpuio_regs,
>  };
>  
> +const struct software_node omap16xx_mpu_gpio_swnode = { };
> +
>  static struct platform_device omap16xx_mpu_gpio = {
>  	.name           = "omap_gpio",
>  	.id             = 0,
> @@ -99,6 +102,8 @@ static struct omap_gpio_platform_data omap16xx_gpio1_config = {
>  	.regs                   = &omap16xx_gpio_regs,
>  };
>  
> +const struct software_node omap16xx_gpio1_swnode = { };
> +
>  static struct platform_device omap16xx_gpio1 = {
>  	.name           = "omap_gpio",
>  	.id             = 1,
> @@ -122,6 +127,8 @@ static struct resource omap16xx_gpio2_resources[] = {
>  	},
>  };
>  
> +const struct software_node omap16xx_gpio2_swnode = { };
> +
>  static struct omap_gpio_platform_data omap16xx_gpio2_config = {
>  	.bank_width		= 16,
>  	.regs                   = &omap16xx_gpio_regs,
> @@ -155,6 +162,8 @@ static struct omap_gpio_platform_data omap16xx_gpio3_config = {
>  	.regs                   = &omap16xx_gpio_regs,
>  };
>  
> +const struct software_node omap16xx_gpio3_swnode = { };
> +
>  static struct platform_device omap16xx_gpio3 = {
>  	.name           = "omap_gpio",
>  	.id             = 3,
> @@ -183,6 +192,8 @@ static struct omap_gpio_platform_data omap16xx_gpio4_config = {
>  	.regs                   = &omap16xx_gpio_regs,
>  };
>  
> +const struct software_node omap16xx_gpio4_swnode = { };
> +
>  static struct platform_device omap16xx_gpio4 = {
>  	.name           = "omap_gpio",
>  	.id             = 4,
> @@ -201,6 +212,14 @@ static struct platform_device *omap16xx_gpio_dev[] __initdata = {
>  	&omap16xx_gpio4,
>  };
>  
> +static const struct software_node *omap16xx_gpio_swnodes[] __initconst = {
> +	&omap16xx_mpu_gpio_swnode,
> +	&omap16xx_gpio1_swnode,
> +	&omap16xx_gpio2_swnode,
> +	&omap16xx_gpio3_swnode,
> +	&omap16xx_gpio4_swnode,
> +};
> +
>  /*
>   * omap16xx_gpio_init needs to be done before
>   * machine_init functions access gpio APIs.
> @@ -208,7 +227,7 @@ static struct platform_device *omap16xx_gpio_dev[] __initdata = {
>   */
>  static int __init omap16xx_gpio_init(void)
>  {
> -	int i;
> +	int i, ret;
>  	void __iomem *base;
>  	struct resource *res;
>  	struct platform_device *pdev;
> @@ -244,6 +263,14 @@ static int __init omap16xx_gpio_init(void)
>  		iounmap(base);
>  
>  		platform_device_register(omap16xx_gpio_dev[i]);
> +
> +		ret = device_add_software_node(&omap16xx_gpio_dev[i]->dev,
> +					       omap16xx_gpio_swnodes[i]);
> +
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to add software node.\n");
> +			return ret;
> +		}
>  	}
>  
>  	return 0;
> -- 
> 2.47.3
> 

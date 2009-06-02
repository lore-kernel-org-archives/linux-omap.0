From: Tony Lindgren <tony@atomide.com>
Subject: Re: Patch: Init/shutdown correctness fixes for drivers/cbus/tahvo*
Date: Tue, 2 Jun 2009 11:28:55 -0700
Message-ID: <20090602182855.GL27332@atomide.com>
References: <20090526002046.52484z9m6ufsxjb4@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51902 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757565AbZFBS2z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2009 14:28:55 -0400
Content-Disposition: inline
In-Reply-To: <20090526002046.52484z9m6ufsxjb4@lidskialf.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: linux-omap@vger.kernel.org

* Andrew de Quincey <adq_dvb@lidskialf.net> [090525 16:22]:
> This is a companion review patch to the cbus one that fixes  
> init/shutdown correctness in drivers/cbus/tahvo*
>

This one is missing Signed-off-by also.

Tony

> commit 76dfa5c81201df2340e4f5902a4552dea449d771
> Author: Andrew de Quincey <adq@lidskialf.net>
> Date:   Tue May 26 00:13:21 2009 +0100
> 
>     Fix tahvo errors
> 
> diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
> index df74d28..5f70c44 100644
> --- a/drivers/cbus/tahvo-usb.c
> +++ b/drivers/cbus/tahvo-usb.c
> @@ -651,10 +651,9 @@ static int tahvo_usb_probe(struct platform_device *pdev)
>  	dev_dbg(&(pdev->dev), "probe\n");
>  
>  	/* Create driver data */
> -	tu = kmalloc(sizeof(*tu), GFP_KERNEL);
> +	tu = kzalloc(sizeof(*tu), GFP_KERNEL);
>  	if (!tu)
>  		return -ENOMEM;
> -	memset(tu, 0, sizeof(*tu));
>  	tu->pt_dev = pdev;
>  #ifdef CONFIG_USB_OTG
>  	/* Default mode */
> @@ -683,11 +682,23 @@ static int tahvo_usb_probe(struct platform_device *pdev)
>  
>  	/* Attributes */
>  	ret = device_create_file(&(pdev->dev), &dev_attr_vbus_state);
> +	if (ret) {
> +		tahvo_free_irq(TAHVO_INT_VBUSON);
> +		kfree(tu);
> +		printk(KERN_ERR "attribute creation failed: %d\n", ret);
> +		return ret;
> +	}
> +
>  #ifdef CONFIG_USB_OTG
> -	ret |= device_create_file(&(pdev->dev), &dev_attr_otg_mode);
> -#endif
> -	if (ret)
> +	ret = device_create_file(&(pdev->dev), &dev_attr_otg_mode);
> +	if (ret) {
> +		device_remove_file(&(pdev->dev), &dev_attr_vbus_state);
> +		tahvo_free_irq(TAHVO_INT_VBUSON);
> +		kfree(tu);
>  		printk(KERN_ERR "attribute creation failed: %d\n", ret);
> +		return ret;
> +	}
> +#endif
>  
>  	/* Create OTG interface */
>  	tahvo_usb_power_off(tu);
> @@ -703,8 +714,12 @@ static int tahvo_usb_probe(struct platform_device *pdev)
>  	ret = otg_set_transceiver(&tu->otg);
>  	if (ret < 0) {
>  		printk(KERN_ERR "Cannot register USB transceiver\n");
> -		kfree(tu);
>  		tahvo_free_irq(TAHVO_INT_VBUSON);
> +		device_remove_file(&(pdev->dev), &dev_attr_vbus_state);
> +#ifdef CONFIG_USB_OTG
> +		device_remove_file(&(pdev->dev), &dev_attr_otg_mode);
> +#endif
> +		kfree(tu);
>  		return ret;
>  	}
>  
> @@ -718,6 +733,7 @@ static int tahvo_usb_probe(struct platform_device *pdev)
>  
>  static int tahvo_usb_remove(struct platform_device *pdev)
>  {
> +	struct tahvo_usb *tu = (struct tahvo_usb*) pdev->dev.driver_data;
>  	dev_dbg(&(pdev->dev), "remove\n");
>  
>  	tahvo_free_irq(TAHVO_INT_VBUSON);
> @@ -727,6 +743,7 @@ static int tahvo_usb_remove(struct platform_device *pdev)
>  #ifdef CONFIG_USB_OTG
>  	device_remove_file(&(pdev->dev), &dev_attr_otg_mode);
>  #endif
> +	kfree(tu);
>  	return 0;
>  }
>  
> diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
> index 29fd4b8..09a69c0 100644
> --- a/drivers/cbus/tahvo.c
> +++ b/drivers/cbus/tahvo.c
> @@ -298,6 +298,7 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
>  	em_asic_config = omap_get_config(OMAP_TAG_EM_ASIC_BB5,
>  					 struct omap_em_asic_bb5_config);
>  	if (em_asic_config == NULL) {
> +		tasklet_kill(&tahvo_tasklet);
>  		printk(KERN_ERR PFX "Unable to retrieve config data\n");
>  		return -ENODATA;
>  	}
> @@ -314,6 +315,7 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
>  		tahvo_is_betty = 1;
>  		tahvo_7bit_backlight = 1;
>  	} else {
> +		tasklet_kill(&tahvo_tasklet);
>  		printk(KERN_ERR "Tahvo/Betty chip not found");
>  		return -ENODEV;
>  	}
> @@ -324,6 +326,7 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
>  	tahvo_irq_pin = em_asic_config->tahvo_irq_gpio;
>  
>  	if ((ret = gpio_request(tahvo_irq_pin, "TAHVO irq")) < 0) {
> +		tasklet_kill(&tahvo_tasklet);
>  		printk(KERN_ERR PFX "Unable to reserve IRQ GPIO\n");
>  		return ret;
>  	}
> @@ -342,6 +345,7 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
>  	if (ret < 0) {
>  		printk(KERN_ERR PFX "Unable to register IRQ handler\n");
>  		gpio_free(tahvo_irq_pin);
> +		tasklet_kill(&tahvo_tasklet);
>  		return ret;
>  	}
>  #ifdef CONFIG_CBUS_TAHVO_USER
> @@ -350,6 +354,7 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
>  		printk(KERN_ERR "Unable to initialize driver\n");
>  		free_irq(gpio_to_irq(tahvo_irq_pin), 0);
>  		gpio_free(tahvo_irq_pin);
> +		tasklet_kill(&tahvo_tasklet);
>  		return ret;
>  	}
>  #endif

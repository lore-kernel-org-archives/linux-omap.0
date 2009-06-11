From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: Patch: Init/shutdown correctness fixes for drivers/cbus/tahvo*
Date: Thu, 11 Jun 2009 18:26:46 +0100
Message-ID: <20090611182646.68427jqmiduhec8w@lidskialf.net>
References: <20090526002046.52484z9m6ufsxjb4@lidskialf.net>
	<20090611093725.GB15374@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:48066 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbZFKR0p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2009 13:26:45 -0400
In-Reply-To: <20090611093725.GB15374@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Quoting Felipe Balbi <felipe.balbi@nokia.com>:

> Content-Description: tahvo-correctness.patch
>> @@ -683,11 +682,23 @@ static int tahvo_usb_probe(struct  
>> platform_device *pdev)
>>
>>  	/* Attributes */
>>  	ret = device_create_file(&(pdev->dev), &dev_attr_vbus_state);
>> +	if (ret) {
>> +		tahvo_free_irq(TAHVO_INT_VBUSON);
>> +		kfree(tu);
>> +		printk(KERN_ERR "attribute creation failed: %d\n", ret);
>
> use dev_dbg(&pdev->dev, "...");
>
>> @@ -703,8 +714,12 @@ static int tahvo_usb_probe(struct  
>> platform_device *pdev)
>>  	ret = otg_set_transceiver(&tu->otg);
>>  	if (ret < 0) {
>>  		printk(KERN_ERR "Cannot register USB transceiver\n");
>> -		kfree(tu);
>>  		tahvo_free_irq(TAHVO_INT_VBUSON);
>> +		device_remove_file(&(pdev->dev), &dev_attr_vbus_state);
>> +#ifdef CONFIG_USB_OTG
>> +		device_remove_file(&(pdev->dev), &dev_attr_otg_mode);
>> +#endif
>> +		kfree(tu);
>>  		return ret;
>>  	}
>>
>> @@ -718,6 +733,7 @@ static int tahvo_usb_probe(struct platform_device *pdev)
>>
>>  static int tahvo_usb_remove(struct platform_device *pdev)
>>  {
>> +	struct tahvo_usb *tu = (struct tahvo_usb*) pdev->dev.driver_data;
>
> tu = platform_get_drvdata(pdev);
>
>> diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
>> index 29fd4b8..09a69c0 100644
>> --- a/drivers/cbus/tahvo.c
>> +++ b/drivers/cbus/tahvo.c
>> @@ -298,6 +298,7 @@ static int __devinit tahvo_probe(struct  
>> platform_device *pdev)
>>  	em_asic_config = omap_get_config(OMAP_TAG_EM_ASIC_BB5,
>>  					 struct omap_em_asic_bb5_config);
>>  	if (em_asic_config == NULL) {
>> +		tasklet_kill(&tahvo_tasklet);
>>  		printk(KERN_ERR PFX "Unable to retrieve config data\n");
>>  		return -ENODATA;
>>  	}
>> @@ -314,6 +315,7 @@ static int __devinit tahvo_probe(struct  
>> platform_device *pdev)
>>  		tahvo_is_betty = 1;
>>  		tahvo_7bit_backlight = 1;
>>  	} else {
>> +		tasklet_kill(&tahvo_tasklet);
>>  		printk(KERN_ERR "Tahvo/Betty chip not found");
>>  		return -ENODEV;
>>  	}
>> @@ -324,6 +326,7 @@ static int __devinit tahvo_probe(struct  
>> platform_device *pdev)
>>  	tahvo_irq_pin = em_asic_config->tahvo_irq_gpio;
>>
>>  	if ((ret = gpio_request(tahvo_irq_pin, "TAHVO irq")) < 0) {
>> +		tasklet_kill(&tahvo_tasklet);
>>  		printk(KERN_ERR PFX "Unable to reserve IRQ GPIO\n");
>>  		return ret;
>>  	}
>> @@ -342,6 +345,7 @@ static int __devinit tahvo_probe(struct  
>> platform_device *pdev)
>>  	if (ret < 0) {
>>  		printk(KERN_ERR PFX "Unable to register IRQ handler\n");
>>  		gpio_free(tahvo_irq_pin);
>> +		tasklet_kill(&tahvo_tasklet);
>>  		return ret;
>>  	}
>>  #ifdef CONFIG_CBUS_TAHVO_USER
>> @@ -350,6 +354,7 @@ static int __devinit tahvo_probe(struct  
>> platform_device *pdev)
>>  		printk(KERN_ERR "Unable to initialize driver\n");
>>  		free_irq(gpio_to_irq(tahvo_irq_pin), 0);
>>  		gpio_free(tahvo_irq_pin);
>> +		tasklet_kill(&tahvo_tasklet);
>>  		return ret;
>>  	}
>>  #endif
>
> I would like to see this as a series of goto like:
>
> if (em_asic_config == NULL) {
> 	ret = -ENODATA;
> 	goto fail1;
> }
>
> ...
>
> ret = gpio_request(tahvo_irq_pin, "TAHVO irq");
> if (ret < 0) {
> 	...
> 	goto failN;
> }
>
> failN:
> 	...
>
> ...
>
> fail2:
> 	tasklet_kill(&tahvo_tasklet);
>
> fail1:
> 	return ret;

Hi - the current phase I'm in of this development is to simply get the  
thing working reliably again; that includes cleanup etc as appropriate.

Once that is complete, i want to go back and refactor all the drivers  
s that they do exactly what you suggest above, as well as using the  
latest kernel APIs, modularisation where appropriate etc, with a view  
to being suitable for mainline (even if they are not actually  
submitted to mainline).

I don't want to do both at once because I feel that is too big a step  
for this older slightly unmaintained code. Is it acceptable to you to  
commit this patch in the interim?


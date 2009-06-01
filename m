From: Tony Lindgren <tony@atomide.com>
Subject: Re: Tracking N770 breakage
Date: Mon, 1 Jun 2009 16:18:39 -0700
Message-ID: <20090601231839.GD22956@atomide.com>
References: <20090520151907.GC8308@atomide.com> <20090522184720.10616mt8vpjglk3k@lidskialf.net> <20090522193359.17514ptwyl8kdbls@lidskialf.net> <20090522231826.12833dwwkvi7rv0g@lidskialf.net> <20090523023901.33341jpwcx6nd70g@lidskialf.net> <20090523014717.GB9283@atomide.com> <20090523121108.14776dli2aeyapkw@lidskialf.net> <20090523123040.16971ty5wndy6mow@lidskialf.net> <20090523132812.14461t6dlahg2ew0@lidskialf.net> <20090523142542.10985fjvcwu3k9s0@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58119 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298AbZFAXSm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2009 19:18:42 -0400
Content-Disposition: inline
In-Reply-To: <20090523142542.10985fjvcwu3k9s0@lidskialf.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: linux-omap@vger.kernel.org, ladis@linux-mips.org

* Andrew de Quincey <adq_dvb@lidskialf.net> [090523 06:25]:

<snip snip>

> Ok, I spent some time looking for the magic code in =20
> drivers/base/platform.c that would mean you could use a device =20
> registered with register_platform_device() with a driver which had be=
en=20
> registered with just driver_register().
>
> As it turns out, there is no magic code:  it appears you must always =
use=20
> register_platform_driver() for platform_devices (because the =20
> drivers/base/platform.c code expects to be able to cast things =20
> internally to a struct platform_driver, which is NOT the case when us=
ing=20
> driver_register())
>
> Attached is v1 of a patch which converts everything in drivers/cbus t=
o =20
> use register_platform_driver(). This means the USB gadget stuff is no=
w =20
> working properly, but obviously this needs review!
>
> One problem though:  Juha Yrj=C3=B6l=C3=A4's name is being corrupted =
in the file =20
> headers. I'm using all-UTF8 here, but obviously the files are in a =20
> different encoding. What one is the correct to use? I can easily conv=
ert=20
> them to the appropriate UTF8 characters, but I don't want to piss peo=
ple=20
> off by just doing so.

Can you please repost the patch with proper Signed-off-by? And with
the subject that makes sense for commit.. That way I can apply it
cleanly using patchworks and no editing needed ;)

Tony


> diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
> index 1ebc33b..76343f9 100644
> --- a/drivers/cbus/retu-rtc.c
> +++ b/drivers/cbus/retu-rtc.c
> @@ -361,7 +361,7 @@ static int retu_rtc_init_irq(void)
>  }
> =20
> =20
> -static int __devinit retu_rtc_probe(struct device *dev)
> +static int __devinit retu_rtc_probe(struct platform_device *pdev)
>  {
>  	int r;
> =20
> @@ -380,48 +380,49 @@ static int __devinit retu_rtc_probe(struct devi=
ce *dev)
>  	else
>  		retu_rtc_do_reset();
> =20
> -	if ((r =3D device_create_file(dev, &dev_attr_time)) !=3D 0)
> +	if ((r =3D device_create_file(&(pdev->dev), &dev_attr_time)) !=3D 0=
)
>  		return r;
> -	else if ((r =3D device_create_file(dev, &dev_attr_reset)) !=3D 0)
> +	else if ((r =3D device_create_file(&(pdev->dev), &dev_attr_reset)) =
!=3D 0)
>  		goto err_unregister_time;
> -	else if ((r =3D device_create_file(dev, &dev_attr_alarm)) !=3D 0)
> +	else if ((r =3D device_create_file(&(pdev->dev), &dev_attr_alarm)) =
!=3D 0)
>  		goto err_unregister_reset;
> -	else if ((r =3D device_create_file(dev, &dev_attr_alarm_expired)) !=
=3D 0)
> +	else if ((r =3D device_create_file(&(pdev->dev), &dev_attr_alarm_ex=
pired)) !=3D 0)
>  		goto err_unregister_alarm;
> -	else if ((r =3D device_create_file(dev, &dev_attr_cal)) !=3D 0)
> +	else if ((r =3D device_create_file(&(pdev->dev), &dev_attr_cal)) !=3D=
 0)
>  		goto err_unregister_alarm_expired;
>  	else
>  		return r;
> =20
>  err_unregister_alarm_expired:
> -	device_remove_file(dev, &dev_attr_alarm_expired);
> +	device_remove_file(&(pdev->dev), &dev_attr_alarm_expired);
>  err_unregister_alarm:
> -	device_remove_file(dev, &dev_attr_alarm);
> +	device_remove_file(&(pdev->dev), &dev_attr_alarm);
>  err_unregister_reset:
> -	device_remove_file(dev, &dev_attr_reset);
> +	device_remove_file(&(pdev->dev), &dev_attr_reset);
>  err_unregister_time:
> -	device_remove_file(dev, &dev_attr_time);
> +	device_remove_file(&(pdev->dev), &dev_attr_time);
>  	return r;
>  }
> =20
> -static int __devexit retu_rtc_remove(struct device *dev)
> +static int __devexit retu_rtc_remove(struct platform_device *pdev)
>  {
>  	retu_disable_irq(RETU_INT_RTCS);
>  	retu_free_irq(RETU_INT_RTCS);
>  	retu_free_irq(RETU_INT_RTCA);
> -	device_remove_file(dev, &dev_attr_cal);
> -	device_remove_file(dev, &dev_attr_alarm_expired);
> -	device_remove_file(dev, &dev_attr_alarm);
> -	device_remove_file(dev, &dev_attr_reset);
> -	device_remove_file(dev, &dev_attr_time);
> +	device_remove_file(&(pdev->dev), &dev_attr_cal);
> +	device_remove_file(&(pdev->dev), &dev_attr_alarm_expired);
> +	device_remove_file(&(pdev->dev), &dev_attr_alarm);
> +	device_remove_file(&(pdev->dev), &dev_attr_reset);
> +	device_remove_file(&(pdev->dev), &dev_attr_time);
>  	return 0;
>  }
> =20
> -static struct device_driver retu_rtc_driver =3D {
> -	.name		=3D "retu-rtc",
> -	.bus		=3D &platform_bus_type,
> +static struct platform_driver retu_rtc_driver =3D {
>  	.probe		=3D retu_rtc_probe,
>  	.remove		=3D __devexit_p(retu_rtc_remove),
> +	.driver		=3D {
> +		.name		=3D "retu-rtc",
> +	}
>  };
> =20
>  static struct platform_device retu_rtc_device =3D {
> @@ -448,7 +449,7 @@ static int __init retu_rtc_init(void)
> =20
>  	init_completion(&retu_rtc_exited);
> =20
> -	if ((ret =3D driver_register(&retu_rtc_driver)) !=3D 0)
> +	if ((ret =3D platform_driver_register(&retu_rtc_driver)) !=3D 0)
>  		return ret;
> =20
>  	if ((ret =3D platform_device_register(&retu_rtc_device)) !=3D 0)
> @@ -457,14 +458,14 @@ static int __init retu_rtc_init(void)
>  	return 0;
> =20
>  err_unregister_driver:
> -	driver_unregister(&retu_rtc_driver);
> +	platform_driver_unregister(&retu_rtc_driver);
>  	return ret;
>  }
> =20
>  static void __exit retu_rtc_exit(void)
>  {
>  	platform_device_unregister(&retu_rtc_device);
> -	driver_unregister(&retu_rtc_driver);
> +	platform_driver_unregister(&retu_rtc_driver);
> =20
>  	wait_for_completion(&retu_rtc_exited);
>  }
> diff --git a/drivers/cbus/retu-wdt.c b/drivers/cbus/retu-wdt.c
> index b7b20b7..1fa181e 100644
> --- a/drivers/cbus/retu-wdt.c
> +++ b/drivers/cbus/retu-wdt.c
> @@ -104,20 +104,20 @@ static DEVICE_ATTR(period, S_IRUGO | S_IWUSR, r=
etu_wdt_period_show, \
>  			retu_wdt_period_store);
>  static DEVICE_ATTR(counter, S_IRUGO, retu_wdt_counter_show, NULL);
> =20
> -static int __devinit retu_wdt_probe(struct device *dev)
> +static int __devinit retu_wdt_probe(struct platform_device *pdev)
>  {
>  	int ret;
> =20
> -	ret =3D device_create_file(dev, &dev_attr_period);
> +	ret =3D device_create_file(&(pdev->dev), &dev_attr_period);
>  	if (ret) {
>  		printk(KERN_ERR "retu_wdt_probe: Error creating "
>  					"sys device file: period\n");
>  		return ret;
>  	}
> =20
> -	ret =3D device_create_file(dev, &dev_attr_counter);
> +	ret =3D device_create_file(&(pdev->dev), &dev_attr_counter);
>  	if (ret) {
> -		device_remove_file(dev, &dev_attr_period);
> +		device_remove_file(&(pdev->dev), &dev_attr_period);
>  		printk(KERN_ERR "retu_wdt_probe: Error creating "
>  					"sys device file: counter\n");
>  	}
> @@ -125,10 +125,10 @@ static int __devinit retu_wdt_probe(struct devi=
ce *dev)
>  	return ret;
>  }
> =20
> -static int __devexit retu_wdt_remove(struct device *dev)
> +static int __devexit retu_wdt_remove(struct platform_device *pdev)
>  {
> -	device_remove_file(dev, &dev_attr_period);
> -	device_remove_file(dev, &dev_attr_counter);
> +	device_remove_file(&(pdev->dev), &dev_attr_period);
> +	device_remove_file(&(pdev->dev), &dev_attr_counter);
>  	return 0;
>  }
> =20
> @@ -145,11 +145,12 @@ static struct platform_device retu_wdt_device =3D=
 {
>  	},
>  };
> =20
> -static struct device_driver retu_wdt_driver =3D {
> -	.name =3D "retu-watchdog",
> -	.bus =3D &platform_bus_type,
> +static struct platform_driver retu_wdt_driver =3D {
>  	.probe =3D retu_wdt_probe,
>  	.remove =3D __devexit_p(retu_wdt_remove),
> +	.driver =3D {
> +		.name =3D "retu-watchdog",
> +	}
>  };
> =20
>  static int __init retu_wdt_init(void)
> @@ -158,7 +159,7 @@ static int __init retu_wdt_init(void)
> =20
>  	init_completion(&retu_wdt_completion);
> =20
> -	ret =3D driver_register(&retu_wdt_driver);
> +	ret =3D platform_driver_register(&retu_wdt_driver);
>  	if (ret)
>  		return ret;
> =20
> @@ -178,7 +179,7 @@ static int __init retu_wdt_init(void)
>  	return ret;
> =20
>  exit1:
> -	driver_unregister(&retu_wdt_driver);
> +	platform_driver_unregister(&retu_wdt_driver);
>  	wait_for_completion(&retu_wdt_completion);
> =20
>  	return ret;
> @@ -187,7 +188,7 @@ exit1:
>  static void __exit retu_wdt_exit(void)
>  {
>  	platform_device_unregister(&retu_wdt_device);
> -	driver_unregister(&retu_wdt_driver);
> +	platform_driver_unregister(&retu_wdt_driver);
> =20
>  	wait_for_completion(&retu_wdt_completion);
>  }
> diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
> index 84d7840..d9f28d5 100644
> --- a/drivers/cbus/retu.c
> +++ b/drivers/cbus/retu.c
> @@ -5,7 +5,7 @@
>   *
>   * Copyright (C) 2004, 2005 Nokia Corporation
>   *
> - * Written by Juha Yrj?l? <juha.yrjola@nokia.com>,
> + * Written by Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>,
>   *	      David Weinehall <david.weinehall@nokia.com>, and
>   *	      Mikko Ylinen <mikko.k.ylinen@nokia.com>
>   *
> @@ -319,7 +319,7 @@ static void retu_power_off(void)
>   * Probe for the Retu ASIC and allocate memory
>   * for its device-struct if found
>   */
> -static int __devinit retu_probe(struct device *dev)
> +static int __devinit retu_probe(struct platform_device *pdev)
>  {
>  	const struct omap_em_asic_bb5_config * em_asic_config;
>  	int rev, ret;
> @@ -384,7 +384,7 @@ static int __devinit retu_probe(struct device *de=
v)
>  	return 0;
>  }
> =20
> -static int retu_remove(struct device *dev)
> +static int retu_remove(struct platform_device *pdev)
>  {
>  #ifdef CONFIG_CBUS_RETU_USER
>  	retu_user_cleanup();
> @@ -403,11 +403,12 @@ static void retu_device_release(struct device *=
dev)
>  	complete(&device_release);
>  }
> =20
> -static struct device_driver retu_driver =3D {
> -	.name		=3D "retu",
> -	.bus		=3D &platform_bus_type,
> +static struct platform_driver retu_driver =3D {
>  	.probe		=3D retu_probe,
>  	.remove		=3D retu_remove,
> +	.driver 	=3D {
> +		.name		=3D "retu",
> +	}
>  };
> =20
>  static struct platform_device retu_device =3D {
> @@ -431,11 +432,11 @@ static int __init retu_init(void)
> =20
>  	init_completion(&device_release);
> =20
> -	if ((ret =3D driver_register(&retu_driver)) < 0)
> +	if ((ret =3D platform_driver_register(&retu_driver)) < 0)
>  		return ret;
> =20
>  	if ((ret =3D platform_device_register(&retu_device)) < 0) {
> -		driver_unregister(&retu_driver);
> +		platform_driver_unregister(&retu_driver);
>  		return ret;
>  	}
>  	return 0;
> @@ -447,7 +448,7 @@ static int __init retu_init(void)
>  static void __exit retu_exit(void)
>  {
>  	platform_device_unregister(&retu_device);
> -	driver_unregister(&retu_driver);
> +	platform_driver_unregister(&retu_driver);
>  	wait_for_completion(&device_release);
>  }
> =20
> @@ -464,4 +465,4 @@ module_exit(retu_exit);
> =20
>  MODULE_DESCRIPTION("Retu ASIC control");
>  MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Juha Yrj?l?, David Weinehall, and Mikko Ylinen");
> +MODULE_AUTHOR("Juha Yrj=EF=BF=BDl=EF=BF=BD, David Weinehall, and Mik=
ko Ylinen");
> diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
> index d8ad836..df74d28 100644
> --- a/drivers/cbus/tahvo-usb.c
> +++ b/drivers/cbus/tahvo-usb.c
> @@ -9,9 +9,9 @@
>   * Copyright (C) 2004 Texas Instruments
>   * Copyright (C) 2004 David Brownell
>   *
> - * Written by Juha Yrj?l? <juha.yrjola@nokia.com>,
> + * Written by Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>,
>   *	      Tony Lindgren <tony@atomide.com>, and
> - *	      Timo Ter?s <timo.teras@nokia.com>
> + *	      Timo Ter=EF=BF=BDs <timo.teras@nokia.com>
>   *
>   * This file is subject to the terms and conditions of the GNU Gener=
al
>   * Public License. See the file "COPYING" in the main directory of t=
his
> @@ -186,11 +186,11 @@ static int omap_otg_init(void)
>  	return 0;
>  }
> =20
> -static int omap_otg_probe(struct device *dev)
> +static int omap_otg_probe(struct platform_device *pdev)
>  {
>  	int ret;
> =20
> -	tahvo_otg_dev =3D to_platform_device(dev);
> +	tahvo_otg_dev =3D pdev;
>  	ret =3D omap_otg_init();
>  	if (ret !=3D 0) {
>  		printk(KERN_ERR "tahvo-usb: omap_otg_init failed\n");
> @@ -202,19 +202,21 @@ static int omap_otg_probe(struct device *dev)
>  			   &tahvo_usb_device);
>  }
> =20
> -static int omap_otg_remove(struct device *dev)
> +static int omap_otg_remove(struct platform_device *pdev)
>  {
> -	free_irq(tahvo_otg_dev->resource[1].start, &tahvo_usb_device);
> +	if (tahvo_otg_dev !=3D NULL)
> +		free_irq(tahvo_otg_dev->resource[1].start, &tahvo_usb_device);
>  	tahvo_otg_dev =3D NULL;
> =20
>  	return 0;
>  }
> =20
> -struct device_driver omap_otg_driver =3D {
> -	.name		=3D "omap_otg",
> -	.bus		=3D &platform_bus_type,
> +struct platform_driver omap_otg_driver =3D {
>  	.probe		=3D omap_otg_probe,
>  	.remove		=3D omap_otg_remove,
> +	.driver		=3D {
> +		.name		=3D "omap_otg",
> +	}
>  };
> =20
>  /*
> @@ -641,19 +643,19 @@ static ssize_t otg_mode_store(struct device *de=
vice,
>  static DEVICE_ATTR(otg_mode, 0644, otg_mode_show, otg_mode_store);
>  #endif
> =20
> -static int tahvo_usb_probe(struct device *dev)
> +static int tahvo_usb_probe(struct platform_device *pdev)
>  {
>  	struct tahvo_usb *tu;
>  	int ret;
> =20
> -	dev_dbg(dev, "probe\n");
> +	dev_dbg(&(pdev->dev), "probe\n");
> =20
>  	/* Create driver data */
>  	tu =3D kmalloc(sizeof(*tu), GFP_KERNEL);
>  	if (!tu)
>  		return -ENOMEM;
>  	memset(tu, 0, sizeof(*tu));
> -	tu->pt_dev =3D container_of(dev, struct platform_device, dev);
> +	tu->pt_dev =3D pdev;
>  #ifdef CONFIG_USB_OTG
>  	/* Default mode */
>  #ifdef CONFIG_CBUS_TAHVO_USB_HOST_BY_DEFAULT
> @@ -680,9 +682,9 @@ static int tahvo_usb_probe(struct device *dev)
>  	}
> =20
>  	/* Attributes */
> -	ret =3D device_create_file(dev, &dev_attr_vbus_state);
> +	ret =3D device_create_file(&(pdev->dev), &dev_attr_vbus_state);
>  #ifdef CONFIG_USB_OTG
> -	ret |=3D device_create_file(dev, &dev_attr_otg_mode);
> +	ret |=3D device_create_file(&(pdev->dev), &dev_attr_otg_mode);
>  #endif
>  	if (ret)
>  		printk(KERN_ERR "attribute creation failed: %d\n", ret);
> @@ -706,7 +708,7 @@ static int tahvo_usb_probe(struct device *dev)
>  		return ret;
>  	}
> =20
> -	dev->driver_data =3D tu;
> +	pdev->dev.driver_data =3D tu;
> =20
>  	/* Act upon current vbus state once at startup. A vbus state irq ma=
y or
>  	 * may not be generated in addition to this. */
> @@ -714,25 +716,26 @@ static int tahvo_usb_probe(struct device *dev)
>  	return 0;
>  }
> =20
> -static int tahvo_usb_remove(struct device *dev)
> +static int tahvo_usb_remove(struct platform_device *pdev)
>  {
> -	dev_dbg(dev, "remove\n");
> +	dev_dbg(&(pdev->dev), "remove\n");
> =20
>  	tahvo_free_irq(TAHVO_INT_VBUSON);
>  	flush_scheduled_work();
>  	otg_set_transceiver(0);
> -	device_remove_file(dev, &dev_attr_vbus_state);
> +	device_remove_file(&(pdev->dev), &dev_attr_vbus_state);
>  #ifdef CONFIG_USB_OTG
> -	device_remove_file(dev, &dev_attr_otg_mode);
> +	device_remove_file(&(pdev->dev), &dev_attr_otg_mode);
>  #endif
>  	return 0;
>  }
> =20
> -static struct device_driver tahvo_usb_driver =3D {
> -	.name		=3D "tahvo-usb",
> -	.bus		=3D &platform_bus_type,
> +static struct platform_driver tahvo_usb_driver =3D {
>  	.probe		=3D tahvo_usb_probe,
>  	.remove		=3D tahvo_usb_remove,
> +	.driver		=3D {
> +		.name		=3D "tahvo-usb",
> +	}
>  };
> =20
>  static struct platform_device tahvo_usb_device =3D {
> @@ -745,18 +748,18 @@ static int __init tahvo_usb_init(void)
>  	int ret =3D 0;
> =20
>  	printk(KERN_INFO "Tahvo USB transceiver driver initializing\n");
> -	ret =3D driver_register(&tahvo_usb_driver);
> +	ret =3D platform_driver_register(&tahvo_usb_driver);
>  	if (ret)
>  		return ret;
>  	ret =3D platform_device_register(&tahvo_usb_device);
>  	if (ret < 0) {
> -		driver_unregister(&tahvo_usb_driver);
> +		platform_driver_unregister(&tahvo_usb_driver);
>  		return ret;
>  	}
> -	ret =3D driver_register(&omap_otg_driver);
> +	ret =3D platform_driver_register(&omap_otg_driver);
>  	if (ret) {
>  		platform_device_unregister(&tahvo_usb_device);
> -		driver_unregister(&tahvo_usb_driver);
> +		platform_driver_unregister(&tahvo_usb_driver);
>  		return ret;
>  	}
>  	return 0;
> @@ -766,12 +769,12 @@ subsys_initcall(tahvo_usb_init);
> =20
>  static void __exit tahvo_usb_exit(void)
>  {
> -	driver_unregister(&omap_otg_driver);
> +	platform_driver_unregister(&omap_otg_driver);
>  	platform_device_unregister(&tahvo_usb_device);
> -	driver_unregister(&tahvo_usb_driver);
> +	platform_driver_unregister(&tahvo_usb_driver);
>  }
>  module_exit(tahvo_usb_exit);
> =20
>  MODULE_DESCRIPTION("Tahvo USB OTG Transceiver Driver");
>  MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Juha Yrj?l?, Tony Lindgren, and Timo Ter?s");
> +MODULE_AUTHOR("Juha Yrj=EF=BF=BDl=EF=BF=BD, Tony Lindgren, and Timo =
Ter=EF=BF=BDs");
> diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
> index e734c4c..29fd4b8 100644
> --- a/drivers/cbus/tahvo.c
> +++ b/drivers/cbus/tahvo.c
> @@ -5,7 +5,7 @@
>   *
>   * Copyright (C) 2004, 2005 Nokia Corporation
>   *
> - * Written by Juha Yrj?l? <juha.yrjola@nokia.com>,
> + * Written by Juha Yrj=EF=BF=BDl=EF=BF=BD <juha.yrjola@nokia.com>,
>   *	      David Weinehall <david.weinehall@nokia.com>, and
>   *	      Mikko Ylinen <mikko.k.ylinen@nokia.com>
>   *
> @@ -287,7 +287,7 @@ void tahvo_free_irq(int id)
>   * Probe for the Tahvo ASIC and allocate memory
>   * for its device-struct if found
>   */
> -static int __devinit tahvo_probe(struct device *dev)
> +static int __devinit tahvo_probe(struct platform_device *pdev)
>  {
>  	const struct omap_em_asic_bb5_config * em_asic_config;
>  	int rev, id, ret;
> @@ -356,7 +356,7 @@ static int __devinit tahvo_probe(struct device *d=
ev)
>  	return 0;
>  }
> =20
> -static int tahvo_remove(struct device *dev)
> +static int tahvo_remove(struct platform_device *pdev)
>  {
>  #ifdef CONFIG_CBUS_TAHVO_USER
>  	tahvo_user_cleanup();
> @@ -375,11 +375,12 @@ static void tahvo_device_release(struct device =
*dev)
>  	complete(&device_release);
>  }
> =20
> -static struct device_driver tahvo_driver =3D {
> -	.name		=3D "tahvo",
> -	.bus		=3D &platform_bus_type,
> +static struct platform_driver tahvo_driver =3D {
>  	.probe		=3D tahvo_probe,
>  	.remove		=3D tahvo_remove,
> +	.driver		=3D {
> +		.name		=3D "tahvo",
> +	}
>  };
> =20
>  static struct platform_device tahvo_device =3D {
> @@ -403,11 +404,11 @@ static int __init tahvo_init(void)
> =20
>  	init_completion(&device_release);
> =20
> -	if ((ret =3D driver_register(&tahvo_driver)) < 0)
> +	if ((ret =3D platform_driver_register(&tahvo_driver)) < 0)
>  		return ret;
> =20
>  	if ((ret =3D platform_device_register(&tahvo_device)) < 0) {
> -		driver_unregister(&tahvo_driver);
> +		platform_driver_unregister(&tahvo_driver);
>  		return ret;
>  	}
>  	return 0;
> @@ -419,7 +420,7 @@ static int __init tahvo_init(void)
>  static void __exit tahvo_exit(void)
>  {
>  	platform_device_unregister(&tahvo_device);
> -	driver_unregister(&tahvo_driver);
> +	platform_driver_unregister(&tahvo_driver);
>  	wait_for_completion(&device_release);
>  }
> =20
> @@ -439,4 +440,4 @@ module_exit(tahvo_exit);
> =20
>  MODULE_DESCRIPTION("Tahvo ASIC control");
>  MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Juha Yrj?l?, David Weinehall, and Mikko Ylinen");
> +MODULE_AUTHOR("Juha Yrj=EF=BF=BDl=EF=BF=BD, David Weinehall, and Mik=
ko Ylinen");
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

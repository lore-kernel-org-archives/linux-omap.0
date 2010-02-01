From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH] DSPBRIDGE: Get rid of driver_minor global variable
Date: Mon, 1 Feb 2010 21:48:43 +0200
Message-ID: <4B67301B.10900@ti.com>
References: <8a14e4992a92e3bc31d518ca71b14f214cf0f764.1265048264.git.ameya.palande@nokia.com>
Reply-To: <nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40162 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755845Ab0BATsy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Feb 2010 14:48:54 -0500
In-Reply-To: <8a14e4992a92e3bc31d518ca71b14f214cf0f764.1265048264.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>

Ameya Palande said the following on 02/01/2010 08:18 PM:
> Since there is only 1 device there is no need of driver_minor global variable.
i am a little skeptical about this change - mainly coz, it might be a good idea for a userspace option
to be able to define what the minor id could be -> maybe an example could be /dev/mem which has a minor
id of 1, not 0. having a module_param might be better as such.. just my 2 cents..
> 
> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> ---
>  drivers/dsp/bridge/rmgr/drv_interface.c |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
> index a02a32a..de79f26 100644
> --- a/drivers/dsp/bridge/rmgr/drv_interface.c
> +++ b/drivers/dsp/bridge/rmgr/drv_interface.c
> @@ -93,7 +93,6 @@ static u32 driverContext;
>  static char *GT_str;
>  #endif /* CONFIG_BRIDGE_DEBUG */
>  static s32 driver_major;
> -static s32 driver_minor;
>  static char *base_img;
>  char *iva_img;
>  static s32 shm_size = 0x500000;	/* 5 MB */
> @@ -236,7 +235,7 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
>  	omap_dspbridge_dev = pdev;
>  
>  	/* use 2.6 device model */
> -	result = alloc_chrdev_region(&dev, driver_minor, 1, driver_name);
> +	result = alloc_chrdev_region(&dev, 0, 1, driver_name);
>  	if (result < 0) {
>  		GT_1trace(driverTrace, GT_7CLASS, "bridge_init: "
>  				"Can't get Major %d \n", driver_major);
> @@ -268,7 +267,7 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
>  		GT_0trace(driverTrace, GT_7CLASS,
>  				"Error creating bridge class \n");
>  
> -	device_create(bridge_class, NULL, MKDEV(driver_major, driver_minor),
> +	device_create(bridge_class, NULL, MKDEV(driver_major, 0),
>  			NULL, "DspBridge");
>  
>  	GT_init();
> @@ -428,7 +427,7 @@ func_cont:
>  	SERVICES_Exit();
>  	GT_exit();
>  
> -	devno = MKDEV(driver_major, driver_minor);
> +	devno = MKDEV(driver_major, 0);
>  	if (bridge_device) {
>  		cdev_del(&bridge_device->cdev);
>  		kfree(bridge_device);
> @@ -436,7 +435,7 @@ func_cont:
>  	unregister_chrdev_region(devno, 1);
>  	if (bridge_class) {
>  		/* remove the device from sysfs */
> -		device_destroy(bridge_class, MKDEV(driver_major, driver_minor));
> +		device_destroy(bridge_class, MKDEV(driver_major, 0));
>  		class_destroy(bridge_class);
>  
>  	}

Regards,
Nishanth Menon

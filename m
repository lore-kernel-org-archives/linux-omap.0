From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP:DSS: Enable TV Detection support
Date: Mon, 28 Jun 2010 11:52:29 +0300
Message-ID: <1277715149.2474.35.camel@tubuntu.research.nokia.com>
References: <FF55437E1F14DA4BAEB721A458B6701706BDB39F8D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:16410 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680Ab0F1Iwp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jun 2010 04:52:45 -0400
In-Reply-To: <FF55437E1F14DA4BAEB721A458B6701706BDB39F8D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Nagarajan, Rajkumar" <x0133774@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi,

On Sat, 2010-06-26 at 13:09 +0200, ext Nagarajan, Rajkumar wrote:
> Enabled TVDET and created a sysfs entry for TV Detection

You could be a bit more verbose. Also, use the same patch subject as
other patches, "OMAP: DSS2: <subsys>:..."

> To detect if tv set is connected run this command
> cat /sys/devices/platform/omapdss/display1/device_state
> 1: TV set connected
> 0: TV set disconnected
> 
> Signed-off-by: Axel Castaneda Gonzalez <x0055901@ti.com>
> Signed-off-by: Kishore Y <kishore.y@ti.com>
> Signed-off-by: Mukund Mittal <mmittal@ti.com>
> Signed-off-by: Rajkumar N <rajkumar.nagarajan@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/display.h |    2 +
>  drivers/video/omap2/dss/display.c         |   23 +++++++++++++
>  drivers/video/omap2/dss/venc.c            |   52 +++++++++++++++++++++++++++++
>  3 files changed, 77 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
> index 7842efa..522240b 100644
> --- a/arch/arm/plat-omap/include/plat/display.h
> +++ b/arch/arm/plat-omap/include/plat/display.h
> @@ -464,6 +464,8 @@ struct omap_dss_device {
>  
>  	enum omap_dss_display_state state;
>  
> +	u32 (*get_device_state)(struct omap_dss_device *dssdev);

device_state is quite vague name. The feature is only about TV cable
detection, isn't it?

And actually, I don't think this function pointer is needed at all. venc
driver should just add a sysfs entry and handle it privately. There's no
need to add a common sysfs entry for all devices.

>  	/* platform specific  */
>  	int (*platform_enable)(struct omap_dss_device *dssdev);
>  	void (*platform_disable)(struct omap_dss_device *dssdev);
> diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
> index ef8c852..2b937fe 100644
> --- a/drivers/video/omap2/dss/display.c
> +++ b/drivers/video/omap2/dss/display.c
> @@ -278,6 +278,26 @@ static ssize_t display_wss_store(struct device *dev,
>  	return size;
>  }
>  
> +static ssize_t device_state_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct omap_dss_device *dssdev = to_dss_device(dev);
> +	unsigned int device_state;
> +
> +	if (!dssdev->get_device_state)
> +		return -ENOENT;
> +
> +	device_state = dssdev->get_device_state(dssdev);
> +
> +	return snprintf(buf, PAGE_SIZE, "%u\n", device_state);
> +}
> +
> +static ssize_t device_state_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t size)
> +{
> +	return size;
> +}
> +
>  static DEVICE_ATTR(enabled, S_IRUGO|S_IWUSR,
>  		display_enabled_show, display_enabled_store);
>  static DEVICE_ATTR(update_mode, S_IRUGO|S_IWUSR,
> @@ -290,6 +310,8 @@ static DEVICE_ATTR(rotate, S_IRUGO|S_IWUSR,
>  		display_rotate_show, display_rotate_store);
>  static DEVICE_ATTR(mirror, S_IRUGO|S_IWUSR,
>  		display_mirror_show, display_mirror_store);
> +static DEVICE_ATTR(device_state, S_IRUGO|S_IWUSR,
> +		device_state_show, device_state_store);
>  static DEVICE_ATTR(wss, S_IRUGO|S_IWUSR,
>  		display_wss_show, display_wss_store);
>  
> @@ -301,6 +323,7 @@ static struct device_attribute *display_sysfs_attrs[] = {
>  	&dev_attr_rotate,
>  	&dev_attr_mirror,
>  	&dev_attr_wss,
> +	&dev_attr_device_state,
>  	NULL
>  };
>  
> diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
> index eff3505..3b5093b 100644
> --- a/drivers/video/omap2/dss/venc.c
> +++ b/drivers/video/omap2/dss/venc.c
> @@ -33,12 +33,15 @@
>  #include <linux/seq_file.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/gpio.h>
>  
>  #include <plat/display.h>
>  #include <plat/cpu.h>
>  
>  #include "dss.h"
>  
> +#define TV_INT_GPIO			33

Is TV INT GPIO hardcoded to 33 on all OMAP versions and boards?

> +#define TV_DETECT_DELAY			40 /*Delay for TV detection logic*/

Use space after /* and before */. It'd be good to tell the units of the
delay. Is 40ms defined in the TRM as the only proper delay?

>  #define VENC_BASE	0x48050C00
>  
>  /* Venc registers */
> @@ -612,6 +615,46 @@ static int venc_set_wss(struct omap_dss_device *dssdev,	u32 wss)
>  	return 0;
>  }
>  
> +/**
> + * Enables TVDET pulse generation
> + */
> +static void venc_enable_tv_detect(void)
> +{
> +       u32 l;
> +
> +       l = venc_read_reg(VENC_GEN_CTRL);
> +       /* TVDET Active High Setting */
> +       l |= FLD_VAL(1, 16, 16);
> +       /* Enable TVDET pulse generation */
> +       l |= FLD_VAL(1, 0, 0);
> +       venc_write_reg(VENC_GEN_CTRL, l);
> +}
> +
> +/**
> + * Disables TVDET pulse generation
> + */
> +static void venc_disable_tv_detect(void)
> +{
> +       u32 l;
> +
> +       /* Disable TVDET pulse generation */
> +       l = venc_read_reg(VENC_GEN_CTRL);
> +       l |= FLD_VAL(0, 0, 0);
> +       venc_write_reg(VENC_GEN_CTRL, l);
> +}
> +
> +static u32 venc_detect_device(struct omap_dss_device *dssdev)
> +{
> +       u32 tv_state;
> +
> +       venc_enable_tv_detect();
> +       mdelay(TV_DETECT_DELAY);
> +       tv_state = gpio_get_value(TV_INT_GPIO);
> +       venc_disable_tv_detect();
> +
> +       return tv_state;
> +}
> +
>  static struct omap_dss_driver venc_driver = {
>  	.probe		= venc_panel_probe,
>  	.remove		= venc_panel_remove,
> @@ -646,6 +689,7 @@ static struct omap_dss_driver venc_driver = {
>  int venc_init(struct platform_device *pdev)
>  {
>  	u8 rev_id;
> +	int ret;
>  
>  	mutex_init(&venc.venc_lock);
>  
> @@ -671,7 +715,14 @@ int venc_init(struct platform_device *pdev)
>  
>  	venc_enable_clocks(0);
>  
> +	ret = gpio_request(TV_INT_GPIO, "tv_detect");

What if GPIO 33 is used for something else by some boards?

> +	if (ret)
> +		pr_err("Failed to get TV_INT_GPIO gpio_33.\n");
> +	else
> +		gpio_direction_input(TV_INT_GPIO);
> +
>  	return omap_dss_register_driver(&venc_driver);
> +

Extra linefeed.

 Tomi



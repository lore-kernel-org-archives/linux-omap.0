From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] OMAPDSS: restore "name" sysfs entry.
Date: Tue, 24 Feb 2015 18:08:01 +0100
Message-ID: <54237011-FA81-4669-A182-797C4284680D@goldelico.com>
References: <20150224203706.1eafa129@notabene.brown>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150224203706.1eafa129@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

I have tested it with

X.Org X Server 1.12.4
Release Date: 2012-08-27
X Protocol Version 11, Revision 0
Build Operating System: Linux 3.2.0-4-mx5 armv7l Debian

(coming from Debian Wheezy) on:

* gta04 (SPI panel)
* openpandora (SPI panel)
* BeagleBoard XM (with RGB panel)
* PandaBoard ES (w/o panel)
* omap5432-evm + Pyra prototype (MIPI panel)

Without this patch, X Server simply fails with:

Fatal server error:
no screens found

So please add
Tested-by: Nikolaus Schaller <hns@goldelico.com>

Thanks,
Nikolaus


Am 24.02.2015 um 10:37 schrieb NeilBrown <neilb@suse.de>:

> 
> 
> commit 303e4697e762dc92a40405f4e4b8aac02cd0d70b
>    OMAPDSS: rename display-sysfs 'name' entry
> 
> broke the xorg X server on my device as it couldn't find the display
> any more.  It needs the 'name' file and now there isn't one.
> 
> That commit claims that 'name' is not compatible with i2c or spi.
> i2c does register it own 'name' file, but spi does not, hence my
> problem - I have an spi display.
> 
> So create a special case for i2c: add the name attribute for non-i2c
> devices.
> 
> Fixes: 303e4697e762dc92a40405f4e4b8aac02cd0d70b
> Signed-off-by: NeilBrown <neilb@suse.de>
> 
> --
> 
> Hi Tomi,
> I wonder if you would consider this for the next merge window (or maybe even sooner as a bug-fix).
> I haven't tested it with an i2c display, but it certainly allows xorg to work
> on my spi-attached display.
> 
> Thanks,
> NeilBrown
> 
> 
> diff --git a/drivers/video/fbdev/omap2/dss/display-sysfs.c b/drivers/video/fbdev/omap2/dss/display-sysfs.c
> index 5a2095a98ed8..53897b743130 100644
> --- a/drivers/video/fbdev/omap2/dss/display-sysfs.c
> +++ b/drivers/video/fbdev/omap2/dss/display-sysfs.c
> @@ -25,6 +25,15 @@
> #include <linux/platform_device.h>
> #include <linux/sysfs.h>
> 
> +#if IS_ENABLED(CONFIG_I2C)
> +#include <linux/i2c.h>
> +#else
> +static inline int i2c_verify_client(struct device *dev)
> +{
> +	return NULL;
> +}
> +#endif
> +
> #include <video/omapdss.h>
> #include "dss.h"
> 
> @@ -278,6 +287,7 @@ static ssize_t display_wss_store(struct device *dev,
> }
> 
> static DEVICE_ATTR(display_name, S_IRUGO, display_name_show, NULL);
> +static DEVICE_ATTR(name, S_IRUGO, display_name_show, NULL);
> static DEVICE_ATTR(enabled, S_IRUGO|S_IWUSR,
> 		display_enabled_show, display_enabled_store);
> static DEVICE_ATTR(tear_elim, S_IRUGO|S_IWUSR,
> @@ -315,6 +325,17 @@ int display_init_sysfs(struct platform_device *pdev)
> 			DSSERR("failed to create sysfs files\n");
> 			goto err;
> 		}
> +		if (!i2c_verify_client(dssdev->dev)) {
> +			/*
> +			 * Add 'name' file - not compatible with i2c, but
> +			 * need by Xorg for other devices.
> +			 */
> +			r = sysfs_create_file(kobj, &dev_attr_name.attr);
> +			if (r) {
> +				DSSERR("fail to create 'name' sysfs file\n");
> +				goto err;
> +			}
> +		}
> 
> 		r = sysfs_create_link(&pdev->dev.kobj, kobj, dssdev->alias);
> 		if (r) {
> @@ -341,5 +362,7 @@ void display_uninit_sysfs(struct platform_device *pdev)
> 		sysfs_remove_link(&pdev->dev.kobj, dssdev->alias);
> 		sysfs_remove_files(&dssdev->dev->kobj,
> 				display_sysfs_attrs);
> +		sysfs_remove_file(&dssdev->dev->kobj,
> +				  &dev_attr_name.attr);
> 	}
> }

From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH] drm: omap: fix: Defer probe if an omapdss device requests
 for it at connect
Date: Fri, 20 Sep 2013 14:19:02 +0530
Message-ID: <523C0BFE.5010409@ti.com>
References: <1379502502-8781-1-git-send-email-archit@ti.com> <523C02C8.30207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47244 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754388Ab3ITItz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Sep 2013 04:49:55 -0400
In-Reply-To: <523C02C8.30207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: robdclark@gmail.com, linux-omap@vger.kernel.org

On Friday 20 September 2013 01:39 PM, Tomi Valkeinen wrote:

<snip>

>> +static int omap_connect_dssdevs(void)
>> +{
>> +	int r;
>> +	struct omap_dss_device *dssdev = NULL;
>> +
>> +	for_each_dss_dev(dssdev) {
>> +		r = dssdev->driver->connect(dssdev);
>> +		if (r == -EPROBE_DEFER) {
>> +			return r;
>> +		} else if (r) {
>> +			dev_warn(dssdev->dev, "could not connect display: %s\n",
>> +				dssdev->name);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>
> Beagle-xm with DT boot doesn't work with this. There are no displays at
> omapdrm probe time, so omapdrm doesn't find any displays. I added the
> changes below, which made it work.
>
>   Tomi
>
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
> index cbe5d8e..e315413 100644
> --- a/drivers/gpu/drm/omapdrm/omap_drv.c
> +++ b/drivers/gpu/drm/omapdrm/omap_drv.c
> @@ -91,6 +91,7 @@ static int omap_connect_dssdevs(void)
>   {
>          int r;
>          struct omap_dss_device *dssdev = NULL;
> +       bool no_displays = true;
>
>          for_each_dss_dev(dssdev) {
>                  r = dssdev->driver->connect(dssdev);
> @@ -99,9 +100,14 @@ static int omap_connect_dssdevs(void)
>                  } else if (r) {
>                          dev_warn(dssdev->dev, "could not connect display: %s\n",
>                                  dssdev->name);
> +               } else {
> +                       no_displays = false;
>                  }
>          }
>
> +       if (no_displays)
> +               return -EPROBE_DEFER;
> +
>          return 0;
>   }

I suppose we would hit this case if all of the displays are deferred 
because of some dependency and are probed after omapdrm probes.

Is that the case with beagle-xm?

I think we need to move this from pdev_probe() anyway. I don't see other 
drivers doing much in pdev_probe(), they do most of their stuff in 
dev_load() itself. I'll try with that along with disabling of the 
dssdevs in encoder's destroy.

Archit


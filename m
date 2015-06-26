From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] thermal: Switch mode to enabled once the cooling device
 is bound
Date: Fri, 26 Jun 2015 12:17:21 +0100
Message-ID: <20150626111720.GB2673@e104805>
References: <1435236635-20830-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435236635-20830-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: "edubezval@gmail.com" <edubezval@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "t-kristo@ti.com" <t-kristo@ti.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 25, 2015 at 01:50:35PM +0100, Keerthy wrote:
> Currently mode is still disabled even after the cooling device is bound
> to the appropriate device. Hence changing the mode to enabled as soon as
> the cooling device is registered successfully.

This should have been fixed by 528012c1f437 ("thermal: of: Enable
thermal_zoneX when sensor is correctly added"), which was merged in
4.0.  With this, the thermal zone is enabled when it is registered.
Can you elaborate on why is this needed?

Cheers,
Javi

> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/thermal/of-thermal.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 04b1be7..bc84485 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -163,6 +163,9 @@ static int of_thermal_bind(struct thermal_zone_device *thermal,
>  		}
>  	}
>  
> +	/* Now that cooling device is bound enable the thermal device*/
> +	data->mode = THERMAL_DEVICE_ENABLED;
> +
>  	return 0;
>  }
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

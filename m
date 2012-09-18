From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpufreq: OMAP: Check IS_ERR() instead of NULL for omap_device_get_by_hwmod_name
Date: Tue, 18 Sep 2012 20:52:57 +0200
Message-ID: <201209182052.57414.rjw@sisk.pl>
References: <1347932747.6562.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1347932747.6562.3.camel@phoenix>
Sender: cpufreq-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>, Kevin Hilman <khilman@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday, September 18, 2012, Axel Lin wrote:
> omap_device_get_by_hwmod_name() returns ERR_PTR on error.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Kevin, should I take this?

Rafael


> ---
>  drivers/cpufreq/omap-cpufreq.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
> index 6e22f44..65f8e9a 100644
> --- a/drivers/cpufreq/omap-cpufreq.c
> +++ b/drivers/cpufreq/omap-cpufreq.c
> @@ -266,9 +266,9 @@ static int __init omap_cpufreq_init(void)
>  	}
>  
>  	mpu_dev = omap_device_get_by_hwmod_name("mpu");
> -	if (!mpu_dev) {
> +	if (IS_ERR(mpu_dev)) {
>  		pr_warning("%s: unable to get the mpu device\n", __func__);
> -		return -EINVAL;
> +		return PTR_ERR(mpu_dev);
>  	}
>  
>  	mpu_reg = regulator_get(mpu_dev, "vcc");
> 


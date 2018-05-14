From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/11] driver core: Respect all error codes from
 dev_pm_domain_attach()
Date: Mon, 14 May 2018 08:19:07 -0700
Message-ID: <20180514151907.GK98604@atomide.com>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
 <1524732790-2234-8-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1524732790-2234-8-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Russell King <linux@armlinux.org.uk>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Sanyog Kale <sanyog.r.kale@intel.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Ulf,

* Ulf Hansson <ulf.hansson@linaro.org> [180426 09:01]:
> The limitation of being able to check only for -EPROBE_DEFER from
> dev_pm_domain_attach() has been removed. Hence let's respect all error
> codes and bail out accordingly.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/platform.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 8075ddc..9460139 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -572,17 +572,16 @@ static int platform_drv_probe(struct device *_dev)
>  		return ret;
>  
>  	ret = dev_pm_domain_attach(_dev, true);
> -	if (ret != -EPROBE_DEFER) {
> -		if (drv->probe) {
> -			ret = drv->probe(dev);
> -			if (ret)
> -				dev_pm_domain_detach(_dev, true);
> -		} else {
> -			/* don't fail if just dev_pm_domain_attach failed */
> -			ret = 0;
> -		}
> +	if (ret)
> +		goto out;
> +
> +	if (drv->probe) {
> +		ret = drv->probe(dev);
> +		if (ret)
> +			dev_pm_domain_detach(_dev, true);
>  	}
>  
> +out:
>  	if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
>  		dev_warn(_dev, "probe deferral not supported\n");
>  		ret = -ENXIO;
> -- 

Looks like this causes Linux next to not boot for me with device
probes failing with error -17. So that's at least omaps, looks
like kernelci has others failing too.

Reverting for 8c123c14bbba ("driver core: Respect all error codes from
dev_pm_domain_attach()") fixes the issue for me.

Sounds like something is missing, any ideas?

Regards,

Tony

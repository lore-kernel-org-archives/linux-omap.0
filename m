From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH] cpufreq: ti: Use generic platdev driver
Date: Wed, 14 Sep 2016 16:36:02 -0500
Message-ID: <57D9C2C2.6070807@ti.com>
References: <20160914204137.20346-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160914204137.20346-1-d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On 09/14/2016 03:41 PM, Dave Gerlach wrote:
> Now that the cpufreq-dt-platdev is used to create the cpufreq-dt platform
> device for all OMAP platforms and the platform code that did it
> before has been removed, add ti,am33xx and ti,dra7xx to the machine list
> in cpufreq-dt-platdev which had relied on the removed platform code to do
> this previously.
>
> Fixes: 7694ca6e1d6f ("cpufreq: omap: Use generic platdev driver")
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---

This got left out when OMAP was originally added to the 
cpufreq-dt-platdev, so cpufreq disappeared on am335x and dra7 platforms. 
This patch together with the series here [1] will fix this regression.

Regards,
Dave

[1] http://marc.info/?l=linux-pm&m=147388667613317&w=2

>   drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 0bb44d5b5df4..d5e8ba50f8a3 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -68,6 +68,8 @@ static const struct of_device_id machines[] __initconst = {
>
>   	{ .compatible = "sigma,tango4" },
>
> +	{ .compatible = "ti,am33xx", },
> +	{ .compatible = "ti,dra7", },
>   	{ .compatible = "ti,omap2", },
>   	{ .compatible = "ti,omap3", },
>   	{ .compatible = "ti,omap4", },
>


From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: am33xx: Use generic platdev driver
Date: Mon, 1 Aug 2016 10:04:56 -0700
Message-ID: <20160801170435.GN4605@ubuntu>
References: <1470062332-4616-1-git-send-email-matwey@sai.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1470062332-4616-1-git-send-email-matwey@sai.msu.ru>
Sender: linux-pm-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, iippolitov@gmail.com, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 01-08-16, 17:38, Matwey V. Kornilov wrote:
> TI am33xx based platforms (i.e. BeagleBone) rely on
> platform:cpufreq-dt creation in arch/arm/mach-omap2/pm.c
> 
> Add missed ti,am33xx compatible to cpufreq-dt-platdev
> 
> Fixes: 7694ca6e1d6f ("cpufreq: omap: Use generic platdev driver")
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> Cc: stable@vger.kernel.org # 4.7
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 0bb44d5..7a590b4 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -68,6 +68,7 @@ static const struct of_device_id machines[] __initconst = {
>  
>  	{ .compatible = "sigma,tango4" },
>  
> +	{ .compatible = "ti,am33xx", },
>  	{ .compatible = "ti,omap2", },
>  	{ .compatible = "ti,omap3", },
>  	{ .compatible = "ti,omap4", },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

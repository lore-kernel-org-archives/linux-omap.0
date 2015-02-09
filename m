From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] thermal: ti-soc-thermal: bandgap: Fix build warning if
 !CONFIG_PM_SLEEP
Date: Mon, 9 Feb 2015 09:01:06 -0600
Message-ID: <20150209150106.GB21362@kahuna>
References: <1423234546-10458-1-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423234546-10458-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
To: grygorii.strashko@linaro.org
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, sumit.semwal@linaro.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 16:55-20150206, grygorii.strashko@linaro.org wrote:
> From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> 
> Fix following build warning if CONFIG_PM_SLEEP is not set:
> 
> drivers/thermal/ti-soc-thermal/ti-bandgap.c:1478:12: warning: 'ti_bandgap_suspend' defined but not used [-Wunused-function]
>  static int ti_bandgap_suspend(struct device *dev)
>             ^
> drivers/thermal/ti-soc-thermal/ti-bandgap.c:1492:12: warning: 'ti_bandgap_resume' defined but not used [-Wunused-function]
>  static int ti_bandgap_resume(struct device *dev)
>             ^
> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> ---
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> index 74c0e34..5d46660 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -1402,7 +1402,7 @@ int ti_bandgap_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  static int ti_bandgap_save_ctxt(struct ti_bandgap *bgp)
>  {
>  	int i;
> -- 
> 1.9.1
> 

Suggest aligning with Paul as well:
https://patchwork.kernel.org/patch/5795391/

Otherwise:
Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon

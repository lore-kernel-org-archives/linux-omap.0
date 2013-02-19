From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v3 2/3] arm: gpmc: Low power transition support
Date: Tue, 19 Feb 2013 07:27:10 -0800
Message-ID: <87bobgz5m9.fsf@linaro.org>
References: <1361278219-23108-1-git-send-email-avinashphilip@ti.com>
	<1361278219-23108-3-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361278219-23108-3-git-send-email-avinashphilip@ti.com> (Philip
	Avinash's message of "Tue, 19 Feb 2013 18:20:18 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Philip Avinash <avinashphilip@ti.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, dwmw2@infradead.org, afzal@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, nsekhar@ti.com, gururaja.hebbar@ti.com, hvaibhav@ti.com
List-Id: linux-omap@vger.kernel.org

Philip Avinash <avinashphilip@ti.com> writes:

> With GPMC converted to platform driver recently, adds low power
> transition support in driver itself.
>
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> ---
> Changes since v1:
> 	Module disable & enable added using pm_runtime support.
>
>  arch/arm/mach-omap2/gpmc.c |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index b1cd6c1..cc57988 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1361,9 +1361,29 @@ static __devexit int gpmc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM

This should be CONFIG_PM_SLEEP for suspend/resume specific stuff.

> +static int gpmc_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	omap3_gpmc_save_context();
> +	pm_runtime_put_sync(&pdev->dev);
> +	return 0;
> +}
> +
> +static int gpmc_resume(struct platform_device *pdev)
> +{
> +	pm_runtime_get_sync(&pdev->dev);
> +	omap3_gpmc_restore_context();
> +	return 0;
> +}
> +#endif
> +
>  static struct platform_driver gpmc_driver = {
>  	.probe		= gpmc_probe,
>  	.remove		= __devexit_p(gpmc_remove),
> +#ifdef CONFIG_PM
> +	.suspend	= gpmc_suspend,
> +	.resume		= gpmc_resume,
> +#endif

These are the legacy PM operations, you need to use the ones in the
drivers struct dev_pm_ops.

>  	.driver		= {
>  		.name	= DEVICE_NAME,
>  		.owner	= THIS_MODULE,

Kevin

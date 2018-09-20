From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 2/3] gpio: omap: Remove custom PM calls and use cpu_pm
 instead
Date: Thu, 20 Sep 2018 18:01:22 -0500
Message-ID: <35a1dccf-2b15-2d61-9210-7f3893c27795@ti.com>
References: <20180920193532.7714-1-tony@atomide.com>
 <20180920193532.7714-3-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180920193532.7714-3-tony@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Ladislav Michl <ladis@linux-mips.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 09/20/2018 02:35 PM, Tony Lindgren wrote:
> For a long time the gpio-omap custom PM calls have been annoying me so
> let's replace them with cpu_pm instead. This will enable GPIO PM for
> deeper idle states on omap4. And we can handle GPIO PM for omap2/3/4
> in the same way.
> 
> Note that with this patch we are also slightly changing GPIO PM to be
> less aggressive for omap3 and only will idle GPIO when PER context
> may be lost.
> 
> For omap2, we don't need to save context and don't want to remove any
> triggering so let's add a quirk flag for that.
> 
> Let's do this all in a single patch to avoid a situation where old
> custom calls still are used with new code.
> 
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Ladislav Michl <ladis@linux-mips.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   arch/arm/mach-omap2/pm24xx.c            |   7 +-
>   arch/arm/mach-omap2/pm34xx.c            |  14 +-
>   drivers/gpio/gpio-omap.c                | 178 ++++++++++++++----------
>   include/linux/platform_data/gpio-omap.h |  13 --
>   4 files changed, 116 insertions(+), 96 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
> --- a/arch/arm/mach-omap2/pm24xx.c
> +++ b/arch/arm/mach-omap2/pm24xx.c
> @@ -18,6 +18,7 @@
>    * published by the Free Software Foundation.
>    */
>   

[...]

>   
> +static int __maybe_unused omap_gpio_runtime_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct gpio_bank *bank = platform_get_drvdata(pdev);
> +	unsigned long flags;
> +	int error = 0;
> +
> +	raw_spin_lock_irqsave(&bank->lock, flags);
> +	/* Must be idled only by CPU_CLUSTER_PM_ENTER? */
> +	if (bank->irq_usage) {
> +		error = -EBUSY;

Sry, I didn't get how will it work with suspend to ram?
omap_device will call this handler and, seems, abort suspend always
if gpio bank has gpios requested as IRQ. Am I missing smth?

> +		goto unlock;
> +	}
> +	omap_gpio_idle(bank, true);
> +	bank->is_suspended = true;
> +unlock:
> +	raw_spin_unlock_irqrestore(&bank->lock, flags);
> +
> +	return error;
> +}
> +
> +static int __maybe_unused omap_gpio_runtime_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct gpio_bank *bank = platform_get_drvdata(pdev);
> +	unsigned long flags;
> +	int error = 0;
> +
> +	raw_spin_lock_irqsave(&bank->lock, flags);
> +	/* Must be unidled only by CPU_CLUSTER_PM_ENTER? */
> +	if (bank->irq_usage) {
> +		error = -EBUSY;
> +		goto unlock;
> +	}
> +	omap_gpio_unidle(bank);
> +	bank->is_suspended = false;
> +unlock:
> +	raw_spin_unlock_irqrestore(&bank->lock, flags);
> +
> +	return error;
> +}
> +
> +#ifdef CONFIG_ARCH_OMAP2PLUS
>   static const struct dev_pm_ops gpio_pm_ops = {
>   	SET_RUNTIME_PM_OPS(omap_gpio_runtime_suspend, omap_gpio_runtime_resume,
>   									NULL)
>   };
> +#else
> +static const struct dev_pm_ops gpio_pm_ops;
> +#endif	/* CONFIG_ARCH_OMAP2PLUS */
>   
>   #if defined(CONFIG_OF)
>   static struct omap_gpio_reg_offs omap2_gpio_regs = {
> @@ -1774,6 +1805,11 @@ static struct omap_gpio_reg_offs omap4_gpio_regs = {
>   	.fallingdetect =	OMAP4_GPIO_FALLINGDETECT,
>   };
>   

[...]

-- 
regards,
-grygorii

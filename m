From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 10/61] gpio: simplify getting .drvdata
Date: Thu, 19 Apr 2018 10:14:11 -0500
Message-ID: <b0c1e303-ca95-8bc8-a5d4-65e75dc8398a@ti.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-11-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180419140641.27926-11-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org, Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Michal Simek <michal.simek@xilinx.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 04/19/2018 09:05 AM, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.

for gpio-omap.c:
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
>   drivers/gpio/gpio-dwapb.c     |  6 ++----
>   drivers/gpio/gpio-lynxpoint.c |  3 +--
>   drivers/gpio/gpio-omap.c      | 12 ++++--------
>   drivers/gpio/gpio-tegra.c     |  6 ++----
>   drivers/gpio/gpio-zynq.c      |  6 ++----
>   5 files changed, 11 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index 226977f78482..caaabb79e31f 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -732,8 +732,7 @@ static int dwapb_gpio_remove(struct platform_device *pdev)
>   #ifdef CONFIG_PM_SLEEP
>   static int dwapb_gpio_suspend(struct device *dev)
>   {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct dwapb_gpio *gpio = platform_get_drvdata(pdev);
> +	struct dwapb_gpio *gpio = dev_get_drvdata(dev);
>   	struct gpio_chip *gc	= &gpio->ports[0].gc;
>   	unsigned long flags;
>   	int i;
> @@ -777,8 +776,7 @@ static int dwapb_gpio_suspend(struct device *dev)
>   
>   static int dwapb_gpio_resume(struct device *dev)
>   {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct dwapb_gpio *gpio = platform_get_drvdata(pdev);
> +	struct dwapb_gpio *gpio = dev_get_drvdata(dev);
>   	struct gpio_chip *gc	= &gpio->ports[0].gc;
>   	unsigned long flags;
>   	int i;
> diff --git a/drivers/gpio/gpio-lynxpoint.c b/drivers/gpio/gpio-lynxpoint.c
> index 1e557b10d73e..55fa33b7209f 100644
> --- a/drivers/gpio/gpio-lynxpoint.c
> +++ b/drivers/gpio/gpio-lynxpoint.c
> @@ -408,8 +408,7 @@ static int lp_gpio_runtime_resume(struct device *dev)
>   
>   static int lp_gpio_resume(struct device *dev)
>   {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct lp_gpio *lg = platform_get_drvdata(pdev);
> +	struct lp_gpio *lg = dev_get_drvdata(dev);
>   	unsigned long reg;
>   	int i;
>   
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 35971a341c40..b4f8a048a2a1 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -856,8 +856,7 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
>   
>   static int omap_mpuio_suspend_noirq(struct device *dev)
>   {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct gpio_bank	*bank = platform_get_drvdata(pdev);
> +	struct gpio_bank	*bank = dev_get_drvdata(dev);
>   	void __iomem		*mask_reg = bank->base +
>   					OMAP_MPUIO_GPIO_MASKIT / bank->stride;
>   	unsigned long		flags;
> @@ -871,8 +870,7 @@ static int omap_mpuio_suspend_noirq(struct device *dev)
>   
>   static int omap_mpuio_resume_noirq(struct device *dev)
>   {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct gpio_bank	*bank = platform_get_drvdata(pdev);
> +	struct gpio_bank	*bank = dev_get_drvdata(dev);
>   	void __iomem		*mask_reg = bank->base +
>   					OMAP_MPUIO_GPIO_MASKIT / bank->stride;
>   	unsigned long		flags;
> @@ -1284,8 +1282,7 @@ static void omap_gpio_restore_context(struct gpio_bank *bank);
>   
>   static int omap_gpio_runtime_suspend(struct device *dev)
>   {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct gpio_bank *bank = platform_get_drvdata(pdev);
> +	struct gpio_bank *bank = dev_get_drvdata(dev);
>   	u32 l1 = 0, l2 = 0;
>   	unsigned long flags;
>   	u32 wake_low, wake_hi;
> @@ -1352,8 +1349,7 @@ static void omap_gpio_init_context(struct gpio_bank *p);
>   
>   static int omap_gpio_runtime_resume(struct device *dev)
>   {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct gpio_bank *bank = platform_get_drvdata(pdev);
> +	struct gpio_bank *bank = dev_get_drvdata(dev);
>   	u32 l = 0, gen, gen0, gen1;
>   	unsigned long flags;
>   	int c;
> diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
> index 94396caaca75..04c963f03b68 100644
> --- a/drivers/gpio/gpio-tegra.c
> +++ b/drivers/gpio/gpio-tegra.c
> @@ -403,8 +403,7 @@ static void tegra_gpio_irq_handler(struct irq_desc *desc)
>   #ifdef CONFIG_PM_SLEEP
>   static int tegra_gpio_resume(struct device *dev)
>   {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct tegra_gpio_info *tgi = platform_get_drvdata(pdev);
> +	struct tegra_gpio_info *tgi = dev_get_drvdata(dev);
>   	unsigned long flags;
>   	unsigned int b, p;
>   
> @@ -443,8 +442,7 @@ static int tegra_gpio_resume(struct device *dev)
>   
>   static int tegra_gpio_suspend(struct device *dev)
>   {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct tegra_gpio_info *tgi = platform_get_drvdata(pdev);
> +	struct tegra_gpio_info *tgi = dev_get_drvdata(dev);
>   	unsigned long flags;
>   	unsigned int b, p;
>   
> diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
> index 75ee877e5cd5..49534241bb1e 100644
> --- a/drivers/gpio/gpio-zynq.c
> +++ b/drivers/gpio/gpio-zynq.c
> @@ -697,8 +697,7 @@ static int __maybe_unused zynq_gpio_resume(struct device *dev)
>   
>   static int __maybe_unused zynq_gpio_runtime_suspend(struct device *dev)
>   {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct zynq_gpio *gpio = platform_get_drvdata(pdev);
> +	struct zynq_gpio *gpio = dev_get_drvdata(dev);
>   
>   	clk_disable_unprepare(gpio->clk);
>   
> @@ -707,8 +706,7 @@ static int __maybe_unused zynq_gpio_runtime_suspend(struct device *dev)
>   
>   static int __maybe_unused zynq_gpio_runtime_resume(struct device *dev)
>   {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct zynq_gpio *gpio = platform_get_drvdata(pdev);
> +	struct zynq_gpio *gpio = dev_get_drvdata(dev);
>   
>   	return clk_prepare_enable(gpio->clk);
>   }
> 

-- 
regards,
-grygorii

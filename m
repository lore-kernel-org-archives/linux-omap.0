From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 2/2] gpio: omap : Add missing clk_unprepare().
Date: Tue, 1 Aug 2017 14:40:07 -0500
Message-ID: <6a5f3a21-c69f-1437-85fb-bd5fafc07f52@ti.com>
References: <e84a2b010f0632369030f92fa30572ba1e4aaaf2.1501569628.git.arvind.yadav.cs@gmail.com>
 <f41f83c5a540065ca9fc1cae754b5b4d4a2749a2.1501569628.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <f41f83c5a540065ca9fc1cae754b5b4d4a2749a2.1501569628.git.arvind.yadav.cs@gmail.com>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, ssantosh@kernel.org, khilman@kernel.org, linus.walleij@linaro.org
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 08/01/2017 01:44 AM, Arvind Yadav wrote:
> omap_gpio_probe() can fail here and we must disable clock.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>   drivers/gpio/gpio-omap.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index f8c550de..dbf869f 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1247,6 +1247,8 @@ static int omap_gpio_probe(struct platform_device *pdev)
>   	if (ret) {
>   		pm_runtime_put_sync(dev);
>   		pm_runtime_disable(dev);
> +		if (bank->dbck_flag)
> +			clk_unprepare(bank->dbck);
>   		return ret;
>   	}
>   
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii

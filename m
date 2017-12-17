From: Haojian Zhuang <haojian.zhuang@linaro.org>
Subject: Re: [PATCH] pinctrl: single: Remove invalid message
Date: Sun, 17 Dec 2017 13:25:13 +0800
Message-ID: <c51cd2c7-3d36-3dc5-11f8-06c162ca3639@linaro.org>
References: <20171214165115.27150-1-tony@atomide.com>
Reply-To: haojian.zhuang@linaro.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171214165115.27150-1-tony@atomide.com>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 2017/12/15 0:51, Tony Lindgren wrote:
> Pinctrl single should just show how many pins were found, the physical
> address is already in the dev information. So let's remove the wrong
> information that claims to show the physical address but really prints
> a virtual address that is now hashed.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   drivers/pinctrl/pinctrl-single.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -1774,8 +1774,7 @@ static int pcs_probe(struct platform_device *pdev)
>   			dev_warn(pcs->dev, "initialized with no interrupts\n");
>   	}
>   
> -	dev_info(pcs->dev, "%i pins at pa %p size %u\n",
> -		 pcs->desc.npins, pcs->base, pcs->size);
> +	dev_info(pcs->dev, "%i pins, size %u\n", pcs->desc.npins, pcs->size);
>   
>   	return pinctrl_enable(pcs->pctl);
>   
> 
Hi Tony,

If there's only one pinctrl region in SoC, it's fine to remove the pa 
part. But there're always multiple pinctrl regions in Hisilicon SoCs. It 
causes multiple pinctrl register bases are used. Will it cause debug 
information harder to read when pa parts are removed?

Best Regards
Haojian

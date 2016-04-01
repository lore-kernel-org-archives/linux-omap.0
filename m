From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] extcon: palmas: Drop stray IRQF_EARLY_RESUME flag
Date: Fri, 1 Apr 2016 12:54:28 +0300
Message-ID: <56FE4554.9090702@ti.com>
References: <1459458951-4882-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459458951-4882-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On 04/01/2016 12:15 AM, Nishanth Menon wrote:
> Palams extcon IRQs are nested threaded and wired to the Palmas
> inerrupt controller. So, this flag is not required for nested
> irqs anymore, since commit 3c646f2c6aa9 ("genirq: Don't suspend
> nested_thread irqs over system suspend") was merged. However, the
> fix missed a stray flag causing the following crash on resume on

Ok. Sry, my bad I've had to check next.
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

>
> Fixes: ae64e42cc2b3 ("extcon: palmas: Drop IRQF_EARLY_RESUME flag")
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Roger Quadros <rogerq@ti.com>
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   drivers/extcon/extcon-palmas.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
> index 841a4b586395..8b3226dca1d9 100644
> --- a/drivers/extcon/extcon-palmas.c
> +++ b/drivers/extcon/extcon-palmas.c
> @@ -348,8 +348,7 @@ static int palmas_usb_probe(struct platform_device *pdev)
>   						palmas_vbus_irq_handler,
>   						IRQF_TRIGGER_FALLING |
>   						IRQF_TRIGGER_RISING |
> -						IRQF_ONESHOT |
> -						IRQF_EARLY_RESUME,
> +						IRQF_ONESHOT,
>   						"palmas_usb_vbus",
>   						palmas_usb);
>   		if (status < 0) {
>


-- 
regards,
-grygorii

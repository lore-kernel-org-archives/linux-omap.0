From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH 5/8] gpio: omap: convert gpio irq functions to use GPIO
 offset
Date: Fri, 20 Mar 2015 09:49:18 -0700
Message-ID: <550C4F8E.6020405@oracle.com>
References: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org> <1426785944-17255-6-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426785944-17255-6-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@linaro.org, Javier Martinez Canillas <javier@dowhile0.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 3/19/15 10:25 AM, grygorii.strashko@linaro.org wrote:
> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>
> Convert GPIO IRQ functions to use GPIO offset instead of system
> GPIO numbers. This allows to drop unneeded conversations between
> system GPIO <-> GPIO offset which are done in many places and
> many times.
> It is safe to do now because:
> - gpiolib always passes GPIO offset to GPIO controller
> - OMAP GPIO driver converted to use IRQ domain, so
>    struct irq_data->hwirq contains GPIO offset
>
> This is preparation step before removing:
>   #define GPIO_INDEX(bank, gpio)
>   #define GPIO_BIT(bank, gpio)
>   int omap_irq_to_gpio()
>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
> ---

Once you take care of the bisect/build issue, feel free to add
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

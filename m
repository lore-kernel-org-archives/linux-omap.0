From: santosh shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH] gpio: omap: drop dev field from gpio_bank structure
Date: Fri, 4 Mar 2016 08:23:10 -0800
Message-ID: <56D9B66E.7020807@oracle.com>
References: <1457105135-28124-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1457105135-28124-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 3/4/2016 7:25 AM, Grygorii Strashko wrote:
> GPIO chip structure already has "parent" field which is used for the
> same purpose as "dev" field in gpio_bank structure - store pointer on
> GPIO device.
>
> Hence, drop duplicated "dev" field from gpio_bank structure.
>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
Looks good.

Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

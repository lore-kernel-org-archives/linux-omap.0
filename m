From: santosh shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH] gpio: omap: Fix regression for MPUIO interrupts
Date: Fri, 24 Apr 2015 08:29:28 -0700
Message-ID: <553A6158.1050705@oracle.com>
References: <1429833257-28188-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1429833257-28188-1-git-send-email-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Felipe Balbi <balbi@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Grygorii Strashko <grygorii.strashko@linaro.org>, Kevin Hilman <khilman@deeprootsystems.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 4/23/2015 4:54 PM, Tony Lindgren wrote:
> At some point with all the GPIO clean-up we've broken the
> MPUIO interrupts. Those are just a little bit different from
> the GPIO interrupts, so we can fix it up just by setting
> different irqchip functions for it. And then we can just
> remove all old code trying to do the same.
>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Grygorii Strashko <grygorii.strashko@linaro.org>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

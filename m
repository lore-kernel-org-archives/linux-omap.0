From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpio: omap: get rid of the conditional PM runtime calls
Date: Fri, 28 Sep 2018 15:33:49 -0700
Message-ID: <20180928223349.GR5662@atomide.com>
References: <20180928213950.27415-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180928213950.27415-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [180928 21:44]:
> As result safely drop !BANK_USED() checks from omap_gpio_request/free(),
> omap_gpio_irq_bus_lock/unlock() and enable PM runtime management for OMAP
> GPIO IRQ chip.

Nice to get rid of the conditional PM runtime calls :)

Tony

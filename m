From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7] gpio: omap: fixes and improvements
Date: Tue, 18 Aug 2015 23:38:52 -0700
Message-ID: <20150819063851.GI4215@atomide.com>
References: <1439896258-26449-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1439896258-26449-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Javier Martinez Canillas <javier@dowhile0.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Grygorii Strashko <grygorii.strashko@ti.com> [150818 04:14]:
> Hi,
> 
> This patch series contains set of trivial fixes and improvements, and also
> patches which fixes wrong APIs usage in atomic context as for -RT as for
> non-RT kernel. The final goal of this series is to make TI OMAP GPIO
> driver compatible with -RT kernel as much as possible.
> 
> Patch 1-4: trivial fixes and improvements
> Patch 5: fixes wrong CLK clk_prepare/unprepare APIs usage in atomic contexet
> Patch 6(rfc): required to be compatible with -RT kernel, because PM runtime
>  can't be used in atimic context on -RT.
> Patch 7(rfc): This patch converts TI OMAP GPIO driver to use generic irq
>  handler instead of chained IRQ handler. This way OMAP GPIO driver will be
>  compatible with RT kernel where it will be forced thread IRQ handler
>  while in non-RT kernel it still will be executed in HW IRQ context.

Based on quick testing this series breaks at least core off idle for omap3.
You probably should add a beagle xm to your test devices so you can
properly test PM features.

Regards,

Tony

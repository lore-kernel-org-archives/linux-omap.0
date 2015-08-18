From: santosh shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH 0/7] gpio: omap: fixes and improvements
Date: Tue, 18 Aug 2015 09:12:57 -0700
Message-ID: <55D35989.9030508@oracle.com>
References: <1439896258-26449-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439896258-26449-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, tony@atomide.com
Cc: Javier Martinez Canillas <javier@dowhile0.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 8/18/2015 4:10 AM, Grygorii Strashko wrote:
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
>   can't be used in atimic context on -RT.
> Patch 7(rfc): This patch converts TI OMAP GPIO driver to use generic irq
>   handler instead of chained IRQ handler. This way OMAP GPIO driver will be
>   compatible with RT kernel where it will be forced thread IRQ handler
>   while in non-RT kernel it still will be executed in HW IRQ context.
>
> Based on
> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
> branch: devel
> commit: 929550b gpio: mxc: fix section mismatch warning
>
> Boot, basic gpio functionality tested on:
>   dra7-evm, BeagleBone(white), am43xx-gpevm, am437x-sk
> Manually tested on dra7-evm including suspend/resume and wakeup.
>
> Grygorii Strashko (7):
>    gpio: omap: remove wrong irq_domain_remove usage in probe
>    gpio: omap: switch to use platform_get_irq
>    gpio: omap: fix omap2_set_gpio_debounce
>    gpio: omap: protect regs access in omap_gpio_irq_handler
>    gpio: omap: fix clk_prepare/unprepare usage
>    gpio: omap: move pm runtime in irq_chip.irq_bus_lock/sync_unlock
>    gpio: omap: convert to use generic irq handler
>
>   drivers/gpio/gpio-omap.c | 146 +++++++++++++++++++++++++++--------------------
>   1 file changed, 85 insertions(+), 61 deletions(-)
>
Patch 1 to 5 looks fine to me. You can have that one as a series.
Am not convinced about 6 and 7. Will look at it again in detail.

For 1 to 5,
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

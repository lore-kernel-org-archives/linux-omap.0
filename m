From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] gpio: omap: convert to use generic irq handler
Date: Fri, 2 Oct 2015 13:17:01 -0700
Message-ID: <CACRpkdYDrcwa+h2Lxd65RBMc-1n9CCyVDz1qjc2U1MEU2GP7hA@mail.gmail.com>
References: <1443209283-20781-1-git-send-email-grygorii.strashko@ti.com>
	<1443209283-20781-3-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443209283-20781-3-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Austin Schuh <austin@peloton-tech.com>, philipp@peloton-tech.com, linux-rt-users@vger.kernel.org, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 25, 2015 at 12:28 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> This patch converts TI OMAP GPIO driver to use generic irq handler
> instead of chained IRQ handler. This way OMAP GPIO driver will be
> compatible with RT kernel where it will be forced thread IRQ handler
> while in non-RT kernel it still will be executed in HW IRQ context.
> As part of this change the IRQ wakeup configuration is applied to
> GPIO Bank IRQ as it now will be under control of IRQ PM Core during
> suspend.
>
> There are also additional benefits:
>  - on-RT kernel there will be no complains any more about PM runtime usage
>    in atomic context  "BUG: sleeping function called from invalid context";
>  - GPIO bank IRQs will appear in /proc/interrupts and its usage statistic
>     will be  visible;
>  - GPIO bank IRQs could be configured through IRQ proc_fs interface and,
>    as result, could be a part of IRQ balancing process if needed;
>  - GPIO bank IRQs will be under control of IRQ PM Core during
>    suspend to RAM.
>
> Disadvantage:
>  - additional runtime overhed as call chain till
>    omap_gpio_irq_handler() will be longer now
>  - necessity to use wa_lock in omap_gpio_irq_handler() to W/A warning
>    in handle_irq_event_percpu()
>    WARNING: CPU: 1 PID: 35 at kernel/irq/handle.c:149 handle_irq_event_percpu+0x51c/0x638()
>
> This patch doesn't fully follows recommendations provided by Sebastian
> Andrzej Siewior [1], because It's required to go through and check all
> GPIO IRQ pin states as fast as possible and pass control to handle_level_irq
> or handle_edge_irq. handle_level_irq or handle_edge_irq will perform actions
> specific for IRQ triggering type and wakeup corresponding registered
> threaded IRQ handler (at least it's expected to be threaded).
> IRQs can be lost if handle_nested_irq() will be used, because excecution
> time of some pin specific GPIO IRQ handler can be very significant and
> require accessing ext. devices (I2C).
>
> Idea of such kind reworking was also discussed in [2].
>
> [1] http://www.spinics.net/lists/linux-omap/msg120665.html
> [2] http://www.spinics.net/lists/linux-omap/msg119516.html
>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Austin Schuh <austin@peloton-tech.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

I'm thinking that we need some recommendations on how to write
IRQ handlers in order to be RT-compatible. Can you help me lining
up the requirements in Documentation/gpio/driver.txt?

I will write an RFC patch and let you write some additional text
to it in response then we can iterate it a bit.

Yours,
Linus Walleij

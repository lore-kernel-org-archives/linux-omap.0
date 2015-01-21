From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/1] gpio: omap: Fix bad device access with setup_irq()
Date: Wed, 21 Jan 2015 22:39:54 +0100
Message-ID: <CABxcv=nE8F7Jjy3Ojf_PE6LEDi_H2tZSbAwpeu+3spP4zF==RQ@mail.gmail.com>
References: <1421448650-15904-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1421448650-15904-1-git-send-email-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux GPIO List <linux-gpio@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello Tony,

On Fri, Jan 16, 2015 at 11:50 PM, Tony Lindgren <tony@atomide.com> wrote:
> Similar to omap_gpio_irq_type() let's make sure that the GPIO
> is usable as an interrupt if the platform init code did not
> call gpio_request(). Otherwise we can get invalid device access
> after setup_irq():
>
> WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x214/0x340()
> 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4CFG (Idle): Data Access in Supervisor mode during Functional access
> ...
> [<c05f21e4>] (__irq_svc) from [<c05f1974>] (_raw_spin_unlock_irqrestore+0x34/0x44)
> [<c05f1974>] (_raw_spin_unlock_irqrestore) from [<c00914a8>] (__setup_irq+0x244/0x530)
> [<c00914a8>] (__setup_irq) from [<c00917d4>] (setup_irq+0x40/0x8c)
> [<c00917d4>] (setup_irq) from [<c0039c8c>] (omap_system_dma_probe+0x1d4/0x2b4)
> [<c0039c8c>] (omap_system_dma_probe) from [<c03b2200>] (platform_drv_probe+0x44/0xa4)
> ...
>
> We can fix this the same way omap_gpio_irq_type() is handling it.
>

I see that Linus already picked this patch but fwiw:

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>

> Note that the long term solution is to change the gpio-omap driver
> to handle the banks as separate driver instances. This will allow
> us to rely on just runtime PM for tracking the bank specific state.
>

Agreed.

Best regards,
Javier

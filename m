From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: omap: fix irq triggering in smart-idle wakeup mode
Date: Tue, 26 Apr 2016 15:58:18 +0200
Message-ID: <CACRpkdavUOR-CQVOgxLBRXhkDozpuuQQm3pj0xNUP5ZSti9M-Q@mail.gmail.com>
References: <1460458351-24187-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1460458351-24187-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 12, 2016 at 12:52 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> Now GPIO IRQ loss is observed on dra7-evm after suspend/resume cycle
> in the following case:
>   extcon_usb1(id_irq) ->  pcf8575.gpio1 -> omapgpio6.gpio11 -> gic
>
> the extcon_usb1 is wake up source and it enables IRQ wake up for
> id_irq by calling enable/disable_irq_wake() during suspend/resume
> which, in turn, causes execution of omap_gpio_wake_enable(). And
> omap_gpio_wake_enable() will set/clear corresponding bit in
> GPIO_IRQWAKEN_x register.
>
> omapgpio6 configuration after boot - wakeup is enabled for GPIO IRQs
> by default from  omap_gpio_irq_type:
> GPIO_IRQSTATUS_SET_0    | 0x00000400
> GPIO_IRQSTATUS_CLR_0    | 0x00000400
> GPIO_IRQWAKEN_0         | 0x00000400
> GPIO_RISINGDETECT       | 0x00000000
> GPIO_FALLINGDETECT      | 0x00000400
>
> omapgpio6 configuration after after suspend/resume cycle:
> GPIO_IRQSTATUS_SET_0    | 0x00000400
> GPIO_IRQSTATUS_CLR_0    | 0x00000400
> GPIO_IRQWAKEN_0         | 0x00000000 <---
> GPIO_RISINGDETECT       | 0x00000000
> GPIO_FALLINGDETECT      | 0x00000400
>
> As result, system will start to lose interrupts from pcf8575 GPIO
> expander, because when OMAP GPIO IP is in smart-idle wakeup mode, there
> is no guarantee that transition(s) on input non wake up GPIO pin will
> trigger asynchronous wake-up request to PRCM and then IRQ generation.
> IRQ will be generated when GPIO is in active mode - for example, some
> time after accessing GPIO bank registers IRQs will be generated
> normally, but issue will happen again once PRCM will put GPIO in low
> power smart-idle wakeup mode.
>
> Note 1. Issue is not reproduced if debounce clk is enabled for GPIO
> bank.
>
> Note 2. Issue hardly reproducible if GPIO pins group contains both
> wakeup/non-wakeup gpios - for example, it will be hard to reproduce
> issue with pin2 if GPIO_IRQWAKEN_0=0x1 GPIO_IRQSTATUS_SET_0=0x3
> GPIO_FALLINGDETECT = 0x3 (TRM "Power Saving by Grouping the Edge/Level
> Detection").
>
> Note 3. There nothing common bitween System wake up and OMAP GPIO bank
> IP wake up logic - the last one defines how the GPIO bank ON-IDLE-ON
> transition will happen inside SoC under control of PRCM.
>
> Hence, fix the problem by removing omap_set_gpio_wakeup() function
> completely and so keeping always in sync GPIO IRQ mask/unmask
> (IRQSTATUS_SET) and wake up enable (GPIO_IRQWAKEN) bits; and adding
> IRQCHIP_MASK_ON_SUSPEND flag in OMAP GPIO irqchip. That way non wakeup
> GPIO IRQs will be properly masked/unmask by IRQ PM core during
> suspend/resume cycle.
>
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied with the arrived ACKs

Yours,
Linus Walleij

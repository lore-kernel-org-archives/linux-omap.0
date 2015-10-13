From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 2/2] gpio: omap: convert to use generic irq handler
Date: Tue, 13 Oct 2015 21:25:47 +0300
Message-ID: <561D4CAB.1060704@ti.com>
References: <1443209283-20781-1-git-send-email-grygorii.strashko@ti.com>
 <1443209283-20781-3-git-send-email-grygorii.strashko@ti.com>
 <CACRpkdYDrcwa+h2Lxd65RBMc-1n9CCyVDz1qjc2U1MEU2GP7hA@mail.gmail.com>
 <560F07CC.9050205@ti.com> <alpine.DEB.2.11.1510120947220.6097@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1510120947220.6097@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Dan Murphy <dmurphy@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Austin Schuh <austin@peloton-tech.com>, philipp@peloton-tech.com, linux-rt-users@vger.kernel.org, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Thomas,

On 10/12/2015 10:52 AM, Thomas Gleixner wrote:
> Grygorii,
> 
> can you please provide a patch set against 4.1-RT? That stuff rejects
> left and right.
> 

This is really not easy thing to do :( and I don't know how to do it the best way.

This patches are based on top of big set of other patches. As result we've back-ported
mostly all GPIO patches from upstream kernel to TI's 4.1 kernel to keep things
consistent and avoid complicated conflicts during back-porting of fixes.
The branch linux-4.1.y-rt is continuously merged in TI's 4.1 rt-kernel.

So, on top of linux-4.1.y there is below set of patches in TI's kernel now:
*bc6b549 gpio: omap: convert to use generic irq handler
*d8b79f8 gpio: omap: move pm runtime in irq_chip.irq_bus_lock/sync_unlock
c5d9d80 gpio: omap: fix static checker warning
8e3f97d gpio: omap: Fix GPIO numbering for deferred probe
a5fafaa gpio: omap: Fix gpiochip_add() handling for deferred probe
*a79afac gpio: omap: fix clk_prepare/unprepare usage
*e967fb8 gpio: omap: protect regs access in omap_gpio_irq_handler
7f66a45 gpio: omap: fix omap2_set_gpio_debounce
225b622 gpio: omap: switch to use platform_get_irq
4ad92d9 gpio: omap: remove wrong irq_domain_remove usage in probe
f76691a gpio: omap: Fix missing raw locks conversion
*97e1a2c gpio: omap: use raw locks for locking
7a74d02 ARM: OMAP2: Drop the concept of certain power domains not being able to lose context.
76281a5 gpio: omap: prevent module from being unloaded while in use
7aa88c9 gpio: omap: add missed spin_unlock_irqrestore in omap_gpio_irq_type
79d3bc2 gpio: omap: rework omap_gpio_irq_startup to handle current pin state properly
81dcc40 gpio: omap: rework omap_gpio_request to touch only gpio specific registers
e44665c gpio: omap: rework omap_x_irq_shutdown to touch only irqs specific registers
23c487f gpio: omap: fix error handling in omap_gpio_irq_type
b328dfc gpio: omap: fix omap_gpio_free to not clean up irq configuration
2966641 gpio: omap: Allow building as a loadable module

I'd very appreciate for any advice of how to better proceed with your request.
 - I can try to apply and re-send only patches marked by '*'
 - I can prepare branch with all above patches
 - smth. else


-- 
regards,
-grygorii

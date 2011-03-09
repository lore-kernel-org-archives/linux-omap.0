From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/7] OMAP2+: mux: Enable wakeup for wakeup enable requested pads
Date: Tue, 08 Mar 2011 17:14:46 -0800
Message-ID: <87mxl5m6wp.fsf@ti.com>
References: <1299064343-28534-1-git-send-email-govindraj.raja@ti.com>
	<87lj0u8mrf.fsf@ti.com>
	<AANLkTin2f7n-v5Hg7NHB8a4fEmpzt_07xy-M1wjnKHtU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <AANLkTin2f7n-v5Hg7NHB8a4fEmpzt_07xy-M1wjnKHtU@mail.gmail.com>
	(Govindraj's message of "Tue, 8 Mar 2011 17:49:31 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Govindraj <govindraj.ti@gmail.com> writes:

> Module level wakeup doesn't seem to work and only
> way it seem to wakeup is through using resume_idle
> from sram_idle.

Have you verified if the module wakeups themselves are not working, or
just that the wakeup is not propagating to a device IRQ?

As a quick test, I did a suspend-only test shows that module-level
wakeups (at least from PER UART) are working.

On 3530/Beagle, which has console on UART3 (in PER), I successfully
tested module level wakeups from suspend.

First, I added a simple debug printk[1] to show the wakeup source.
Then, I ensure CORE stays 'ON' during suspend.  If CORE stays on, the IO
ring is never armed, so only module wakeups can happen:

   # echo 3 > /debug/pm_debug/core_pwrdm/suspend 

then I suspend

   # echo mem > /sys/power/state 

and type a key on the console to wakeup, and I see:

   PRCM IRQ: mod 0x800: WKST=0x00000800

Which shows PER wakeup from UART3.  If you do the same without setting
CORE to ON, you'll see that the first wakeup is in the WKUP powerdomain
from the IO ring.

So module-level wakeups are indeed working.

The problem is actually not that module wakeups are working, but rather
that the module does not generate an interrupt upon wakeup if it is
idle.  The resume_from_idle hack works because as soon as clocks are
enabled, the module generates the interrupt (special thanks to Paul
Walmsley for helping me understand this.)

>
> One simple way to reproduce the problem with
> existing code base also is adding this patch which
> will enable module level wakeup always.
>
> https://patchwork.kernel.org/patch/501211/
>
> and with below change.
>
> govindraj@Linux-BSP-Server:~/clones/linux-omap-2.6$ gd
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 47eef48..6343773 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -380,6 +380,7 @@ static void omap_uart_allow_sleep(struct
> omap_uart_state *uart)
>         omap_uart_smart_idle_enable(uart, 1);
>         uart->can_sleep = 1;
>         del_timer(&uart->timer);
> +       omap_uart_disable_clocks(uart);
>  }
>
> We can see module level wakeup doesn't wakeup the uart.
> once we set sleep_timeout for uart and timer starts.

The above change alone can never work.  I'm pretty sure you wouldn't see
IO-ring wakeups will not happen with this change either because the
kernel will probably hang.

If you disable the clocks here, then any console usage between the
timeout and the idle path will hang the kernel.  You can't do this
without taking the console lock.  Doing that will be much easier in your
new driver.

Kevin


[1]
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 6e2bd38..677a235 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -219,6 +219,8 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs)
 		iclk = omap2_cm_read_mod_reg(module, iclk_off);
 		fclk = omap2_cm_read_mod_reg(module, fclk_off);
 		while (wkst) {
+			printk("PRCM IRQ: mod 0x%x: WKST=0x%08x\n",
+			       module, wkst);
 			clken = wkst;
 			omap2_cm_set_mod_reg_bits(clken, module, iclk_off);
 			/*


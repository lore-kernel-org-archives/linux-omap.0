From: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] i2c: omap: fix spurious IRQs: disable/enable IRQ at INTC when idle
Date: Fri, 07 Jun 2013 13:51:27 -0700
Message-ID: <87li6llk4w.fsf@linaro.org>
References: <1370630768-4077-1-git-send-email-grygorii.strashko@ti.com>
	<1370630768-4077-2-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1370630768-4077-2-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
	(Grygorii Strashko's message of "Fri, 7 Jun 2013 21:46:04 +0300")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:

> From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>
> Currently, runtime PM is used to keep the device enabled only during
> active transfers and for a configurable runtime PM autosuspend timout
> after an xfer.
>
> In addition to idling the device, driver's ->runtime_suspend() method
> currently disables device interrupts when idle.  However, on some SoCs
> (notably OMAP4+), the I2C hardware may shared with other coprocessors.
> This means that the MPU will still recieve interrupts if a coprocessor
> is using the I2C device.  To avoid this, also disable interrupts at
> the MPU INTC when idling the device in ->runtime_suspend() (and
> re-enable them in ->runtime_resume().)  This part based on an original
> patch from Shubhrajyoti Datta.  NOTE: for proper sharing the I2C with
> a coprocessor, this driver still needs hwspinlock support added.
>
> More over, this patch fixes the kernel boot failure which happens when
> CONFIG_SENSORS_LM75=y:
>
> [    2.251220] WARNING: at drivers/bus/omap_l3_noc.c:113 l3_interrupt_handler+0x140/0x184()
> [    2.257781] L3 custom error: MASTER:MPU TARGET:L4 PER2
> [    2.264373] Modules linked in:
> [    2.268463] CPU: 0 PID: 2 Comm: kthreadd Not tainted 3.10.0-rc4-00034-g042dd60-dirty #64
> [    2.270385] [<c001a80c>] (unwind_backtrace+0x0/0xf0) from [<c0017238>] (show_stack+0x10/0x14)
> [    2.286102] [<c0017238>] (show_stack+0x10/0x14) from [<c0040fd0>] (warn_slowpath_common+0x4c/0x68)
> [    2.295593] [<c0040fd0>] (warn_slowpath_common+0x4c/0x68) from [<c0041080>] (warn_slowpath_fmt+0x30/0x40)
> [    2.299987] [<c0041080>] (warn_slowpath_fmt+0x30/0x40) from [<c02c5ed0>] (l3_interrupt_handler+0x140/0x184)
> [    2.315582] [<c02c5ed0>] (l3_interrupt_handler+0x140/0x184) from [<c009ffb8>] (handle_irq_event_percpu+0x58/0x258)
> [    2.323364] [<c009ffb8>] (handle_irq_event_percpu+0x58/0x258) from [<c00a01f4>] (handle_irq_event+0x3c/0x5c)
> [    2.327819] [<c00a01f4>] (handle_irq_event+0x3c/0x5c) from [<c00a2f7c>] (handle_fasteoi_irq+0xbc/0x164)
> [    2.337829] [<c00a2f7c>] (handle_fasteoi_irq+0xbc/0x164) from [<c009f978>] (generic_handle_irq+0x20/0x30)
> [    2.357513] [<c009f978>] (generic_handle_irq+0x20/0x30) from [<c0014168>] (handle_IRQ+0x4c/0xac)
> [    2.366821] [<c0014168>] (handle_IRQ+0x4c/0xac) from [<c00085b4>] (gic_handle_irq+0x28/0x5c)
> [    2.375762] [<c00085b4>] (gic_handle_irq+0x28/0x5c) from [<c04f08a4>] (__irq_svc+0x44/0x5c)
> [    2.379821] Exception stack(0xdb085ec0 to 0xdb085f08)
> [    2.389953] 5ec0: 00000001 00000001 00000000 db07ea00 40000113 db2317a8 db084000 000002f1
> [    2.389953] 5ee0: db07ea00 00000000 00000000 00000000 c04fd990 db085f08 c009170c c04f03e8
> [    2.405609] 5f00: 20000113 ffffffff
> [    2.408355] [<c04f08a4>] (__irq_svc+0x44/0x5c) from [<c04f03e8>] (_raw_spin_unlock_irqrestore+0x34/0x44)
> [    2.418304] [<c04f03e8>] (_raw_spin_unlock_irqrestore+0x34/0x44) from [<c00403c0>] (do_fork+0xa4/0x2d4)
> [    2.427795] [<c00403c0>] (do_fork+0xa4/0x2d4) from [<c0040620>] (kernel_thread+0x30/0x38)
> [    2.437805] [<c0040620>] (kernel_thread+0x30/0x38) from [<c0063888>] (kthreadd+0xd4/0x13c)
> [    2.448364] [<c0063888>] (kthreadd+0xd4/0x13c) from [<c0013308>] (ret_from_fork+0x14/0x2c)
> [    2.448364] ---[ end trace da8cf92c433d1616 ]---
>
> The root casue of crash is race between omap_i2c_runtime_suspend()
>  and omap_i2c_isr_thread()

If there's a race here, then it's not the same problem which is
described above, unless the CPU2 IRQ is happening because of a shared
user of I2C, in which case it doesn't need any additional explanation.

>
> CPU1:                                   CPU2:
> |-omap_i2c_xfer                         |
>   |- pm_runtime_put_autosuspend()       |
>      |-timeout                          |-omap_i2c_isr()
>                                           |-return IRQ_WAKE_THREAD;
>      |-omap_i2c_runtime_suspend()       |
>                                         |-omap_i2c_isr_thread()
>                                           |- oops is here - I2C module is in idle state

If this is happening, I don't think it's related to $SUBJECT patch (but
is probably hidden by it.)

Instead, what probably needs to happen in this is case is that
omap_i2c_isr() should be doing a "mark last busy" to reset the
autosuspend timeout.  And, that should be done in a separate patch.

> Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Both the From: and Signed-off should be from my TI address since the
work was done while I was working for TI.

Also, if you change the original patch/changelog, you should add a line
here like:

[grygorii.strashko-l0cyMroinI0@public.gmane.org]: updated changlog

> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>

Kevin

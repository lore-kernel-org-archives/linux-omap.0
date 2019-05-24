From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [Qemu-devel] Running linux on qemu omap
Date: Fri, 24 May 2019 21:59:22 +0300
Message-ID: <20190524185922.GA4597@t60.musicnaut.iki.fi>
References: <20190520190533.GA28160@Red>
 <20190521232323.GD3621@darkstar.musicnaut.iki.fi>
 <20190522093341.GA32154@Red>
 <20190522181904.GE3621@darkstar.musicnaut.iki.fi>
 <8977e2bb-8d9e-f4fd-4c44-b4f67e0e7314@redhat.com>
 <c2972889-fe60-7614-fb6e-e57ddf780a54@redhat.com>
 <20190523183623.GB5234@darkstar.musicnaut.iki.fi>
 <CAFEAcA8C0WN5FwaW2kfWiRm1T8wML_fWXDKqRXP-Lv_P7ysy8A@mail.gmail.com>
 <20190524150018.GA3156@t60.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190524150018.GA3156@t60.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Corentin Labbe <clabbe.montjoie@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, May 24, 2019 at 06:00:18PM +0300, Aaro Koskinen wrote:
> Please don't delete OMAP boards quite yet :) In the mainline kernel
> they are not orphaned, they frequently get tested using actual hardware,
> and QEMU would help in additional testing. I'll try to get N8x0 boot to
> work with the minimal kernel I use on real HW.

So it was only a matter of attaching the serial console at the QEMU side
(a hackish patch at the end of the mail).

$ qemu-system-arm --version
QEMU emulator version 4.0.0 (v4.0.0-dirty)
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers
$ qemu-system-arm -M n810 -kernel zImage -nographic
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.1.0-n8x0_tiny-los_b1ac4+-00007-g7435e73d8ac4 (aaro@amd-fx-6350) (gcc version 8.3.0 (GCC)) #1 Fri May 24 20:43:02 EEST 2019
[    0.000000] CPU: ARMv6-compatible processor [4107b362] revision 2 (ARMv6TEJ), cr=00c5387d
[    0.000000] CPU: VIPT aliasing data cache, unknown instruction cache
[    0.000000] OF: fdt: Machine model: Nokia N810
[    0.000000] printk: bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache writeback
[    0.000000] OMAP2420
[...]

However there are plenty of WARNs that are not present on real hardware.
Anyway, it's a start.

A.

...

diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 906b7ca22d43..52ff83ec5147 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -792,6 +792,7 @@ static void n8x0_uart_setup(struct n800_s *s)
     qdev_connect_gpio_out(s->mpu->gpio, N8X0_BT_WKUP_GPIO,
                     csrhci_pins_get(radio)[csrhci_pin_wakeup]);
 
+    omap_uart_attach(s->mpu->uart[2], serial_hd(0));
     omap_uart_attach(s->mpu->uart[BT_UART], radio);
 }
 

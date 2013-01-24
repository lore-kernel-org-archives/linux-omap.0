From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 2/6] i2c: omap: also complete() when stat becomes zero
Date: Thu, 24 Jan 2013 11:56:16 +0200
Message-ID: <20130124095616.GC23053@blackmetal.musicnaut.iki.fi>
References: <20130123095813.GG3767@nekote.pengutronix.de>
 <1358936588-16375-1-git-send-email-balbi@ti.com>
 <1358936588-16375-3-git-send-email-balbi@ti.com>
 <20130124090511.GB23053@blackmetal.musicnaut.iki.fi>
 <20130124091339.GF27304@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:47330 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab3AXJ4U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jan 2013 04:56:20 -0500
Content-Disposition: inline
In-Reply-To: <20130124091339.GF27304@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: w.sang@pengutronix.de, linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi.

On Thu, Jan 24, 2013 at 11:13:39AM +0200, Felipe Balbi wrote:
> On Thu, Jan 24, 2013 at 11:05:11AM +0200, Aaro Koskinen wrote:
> > On Wed, Jan 23, 2013 at 12:23:04PM +0200, Felipe Balbi wrote:
> > > In case we loop on IRQ handler until stat is
> > > finally zero, we would end up in a situation
> > > where all I2C transfers would misteriously
> > > timeout because we were not calling complete()
> > > in that situation.
> > 
> > This is wrong, you may still have bytes to transfer,
> > but a new interrupt has not arrived yet.
> > 
> > This patch also breaks bisection; if you just apply patches 1-2 of
> > this series the I2C does not work at all.
> 
> probably another n900-thing. What I had seen is that we could endup in a
> situation where we wouldn't "break" out of the look, and rather would
> fall in the "goto out" when STAT register is zero. In that case, even if
> we had transferred all bytes, we wouldn't call complete() and, thus, our
> commands would timeout.
> 
> Care to send console logs of the error you have seen ? I kinda doubt we
> can fall into the situation you described above where IRQ hasn't been
> updated to STAT register.

Here's the log:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.8.0-rc4-n9xx-00075-g52e4245 (aaro@blackmetal) (gcc version 4.7.2 (GCC) ) #10 Thu Jan 24 11:48:36 EET 2013
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
[    0.000000] Machine: Nokia RX-51 board
[    0.000000] Ignoring unrecognised tag 0x414f4d50
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 65280
[    0.000000] free_area_init_node: node 0, pgdat c0b35294, node_mem_map c0c4c000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 64768 pages, LIFO batch:15
[    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
[    0.000000] Clocking rate (Crystal/Core/MPU): 19.2/332/500 MHz
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64768
[    0.000000] Kernel command line: console=tty console=ttyO2,115200 loglevel=9
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] Memory: 255MB = 255MB total
[    0.000000] Memory: 246232k/246232k available, 15912k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc03d3fcc   (3888 kB)
[    0.000000]       .init : 0xc03d4000 - 0xc0afcb88   (7331 kB)
[    0.000000]       .data : 0xc0afe000 - 0xc0b35d20   ( 224 kB)
[    0.000000]        .bss : 0xc0b35d20 - 0xc0c4b65c   (1111 kB)
[    0.000000] SLUB: Genslabs=11, HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] console [tty0] enabled
[    0.001098] Calibrating delay loop... 331.40 BogoMIPS (lpj=1296384)
[    0.054687] pid_max: default: 32768 minimum: 301
[    0.054901] Mount-cache hash table entries: 512
[    0.055633] CPU: Testing write buffer coherency: ok
[    0.056091] Setting up static identity map for 0x802de4e8 - 0x802de540
[    0.057159] devtmpfs: initialized
[    0.064514] omap_hwmod: mcbsp2: cannot be enabled for reset (3)
[    0.083801] pinctrl core: initialized pinctrl subsystem
[    0.085235] regulator-dummy: no parameters
[    0.085662] NET: Registered protocol family 16
[    0.087219] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.088104] omap-gpmc omap-gpmc: GPMC revision 5.0
[    0.092590] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.092742] OMAP GPIO hardware version 2.5
[    0.093627] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.094604] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.095489] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.096435] gpiochip_add: registered GPIOs 128 to 159 on device: gpio
[    0.097381] gpiochip_add: registered GPIOs 160 to 191 on device: gpio
[    0.099517] i2c-core: driver [dummy] registered
[    0.100158] omap_mux_init: Add partition: #1: core, flags: 4
[    0.103942] Reprogramming SDRC clock to 332000000 Hz
[    0.110076] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.116485] Reserving DMA channels 0 and 1 for HS ROM code
[    0.116516] OMAP DMA hardware revision 4.0
[    0.118499]  arm-pmu: alias fck already exists
[    0.137786] bio: create slab <bio-0> at 0
[    0.176635] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.177307] i2c-core: driver [tps65023] registered
[    0.178314] i2c-core: driver [twl] registered
[    0.179351] SCSI subsystem initialized
[    0.179962] usbcore: registered new interface driver usbfs
[    0.180297] usbcore: registered new interface driver hub
[    0.180664] usbcore: registered new device driver usb
[    0.181304] musb-omap2430 musb-omap2430: invalid resource
[    0.183532] i2c i2c-1: adapter [OMAP I2C adapter] registered
[    0.183746] i2c 1-0048: uevent
[    0.184082] twl 1-0048: probe
[    0.184539] i2c 1-0049: uevent
[    0.184753] dummy 1-0049: probe
[    0.184814] i2c i2c-1: client [dummy] registered with bus id 1-0049
[    0.184967] i2c 1-004a: uevent
[    0.185180] dummy 1-004a: probe
[    0.185211] i2c i2c-1: client [dummy] registered with bus id 1-004a
[    0.185363] i2c 1-004b: uevent
[    0.185577] dummy 1-004b: probe
[    0.185607] i2c i2c-1: client [dummy] registered with bus id 1-004b
[    0.185699] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[    0.185729] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop: 1
[    0.185821] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[    0.185913] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[    0.185974] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[    0.186004] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop: 1
[    0.186096] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[    0.186157] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[    0.195343] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[    0.195373] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop: 1
[    0.195465] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[    0.195526] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[    0.210937] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[    0.210998] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop: 1
[    0.211059] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[    0.211151] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[    0.226562] i2c i2c-1: master_xfer[0] W, addr=0x49, len=2
[    0.226623] omap_i2c omap_i2c.1: addr: 0x0049, len: 2, flags: 0x0, stop: 1
[    0.226684] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[    0.226745] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[    0.226806] i2c i2c-1: master_xfer[0] W, addr=0x49, len=1
[    0.226867] i2c i2c-1: master_xfer[1] R, addr=0x49, len=4
[    0.226898] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x0, stop: 0
[    0.226959] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[    0.226989] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[    0.227050] omap_i2c omap_i2c.1: addr: 0x0049, len: 4, flags: 0x1, stop: 1
[    0.227142] omap_i2c omap_i2c.1: IRQ (ISR = 0x0008)
[    0.227172] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[    0.227233] i2c i2c-1: master_xfer[0] W, addr=0x49, len=2
[    0.227264] omap_i2c omap_i2c.1: addr: 0x0049, len: 2, flags: 0x0, stop: 1
[    0.227355] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[    0.227416] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[    0.227447] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop: 1
[    0.227539] omap_i2c omap_i2c.1: IRQ (ISR = 0x0014)
[    1.242187] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    1.242248] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[    2.257812] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    2.257843] twl: Write failed (mod 20, reg 0x0e count 1)
[    2.257873] TWL4030 Unable to unlock registers
[    2.258270] i2c i2c-1: master_xfer[0] W, addr=0x49, len=4
[    3.273437] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    3.273468] twl: Write failed (mod 2, reg 0x1c count 3)
[    3.273498] twl4030: err -110 initializing gpio IMR
[    3.273559] i2c i2c-1: master_xfer[0] W, addr=0x49, len=2
[    4.289062] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    4.289093] twl: Write failed (mod 2, reg 0x2d count 1)
[    4.289123] twl4030: err -110 initializing gpio SIH_CTRL
[    4.289184] i2c i2c-1: master_xfer[0] W, addr=0x4a, len=2
[    5.304687] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    5.304718] twl: Write failed (mod 6, reg 0x12 count 1)
[    5.304748] twl4030: err -110 initializing keypad IMR
[    5.304809] i2c i2c-1: master_xfer[0] W, addr=0x4a, len=2
[    6.320312] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    6.320343] twl: Write failed (mod 6, reg 0x17 count 1)
[    6.320373] twl4030: err -110 initializing keypad SIH_CTRL
[    6.320434] i2c i2c-1: master_xfer[0] W, addr=0x4a, len=3
[    7.335937] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    7.335968] twl: Write failed (mod 8, reg 0x02 count 2)
[    7.335998] twl4030: err -110 initializing bci IMR
[    7.336059] i2c i2c-1: master_xfer[0] W, addr=0x4a, len=2
[    8.351562] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    8.351593] twl: Write failed (mod 8, reg 0x0d count 1)
[    8.351623] twl4030: err -110 initializing bci SIH_CTRL
[    8.351684] i2c i2c-1: master_xfer[0] W, addr=0x4a, len=2
[    9.367187] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    9.367218] twl: Write failed (mod 7, reg 0x62 count 1)
[    9.367248] twl4030: err -110 initializing madc IMR
[    9.367309] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   10.382812] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   10.382843] twl: Write failed (mod 19, reg 0x01 count 1)
[   10.382873] twl4030: err -110 initializing power IMR
[   10.382934] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   11.398437] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   11.398468] twl: Write failed (mod 19, reg 0x07 count 1)
[   11.398498] twl4030: err -110 initializing power SIH_CTRL
[   11.398559] i2c i2c-1: master_xfer[0] W, addr=0x49, len=1
[   11.398590] i2c i2c-1: master_xfer[1] R, addr=0x49, len=3
[   12.414062] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   12.414093] twl: Read failed (mod 2, reg 0x19 count 3)
[   12.414123] twl4030: err -110 initializing gpio ISR
[   12.414184] i2c i2c-1: master_xfer[0] W, addr=0x49, len=1
[   12.414215] i2c i2c-1: master_xfer[1] R, addr=0x49, len=3
[   13.429687] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   13.429718] twl: Read failed (mod 2, reg 0x19 count 3)
[   13.429748] twl4030: err -110 initializing gpio ISR
[   13.429779] i2c i2c-1: master_xfer[0] W, addr=0x4a, len=1
[   13.429840] i2c i2c-1: master_xfer[1] R, addr=0x4a, len=1
[   14.445312] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   14.445343] twl: Read failed (mod 6, reg 0x11 count 1)
[   14.445373] twl4030: err -110 initializing keypad ISR
[   14.445404] i2c i2c-1: master_xfer[0] W, addr=0x4a, len=1
[   14.445465] i2c i2c-1: master_xfer[1] R, addr=0x4a, len=1
[   15.460937] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   15.460968] twl: Read failed (mod 6, reg 0x11 count 1)
[   15.460998] twl4030: err -110 initializing keypad ISR
[   15.461029] i2c i2c-1: master_xfer[0] W, addr=0x4a, len=1
[   15.461090] i2c i2c-1: master_xfer[1] R, addr=0x4a, len=2
[   16.476562] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   16.476593] twl: Read failed (mod 8, reg 0x00 count 2)
[   16.476623] twl4030: err -110 initializing bci ISR
[   16.476654] i2c i2c-1: master_xfer[0] W, addr=0x4a, len=1
[   16.476715] i2c i2c-1: master_xfer[1] R, addr=0x4a, len=2
[   17.492187] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   17.492218] twl: Read failed (mod 8, reg 0x00 count 2)
[   17.492248] twl4030: err -110 initializing bci ISR
[   17.492279] i2c i2c-1: master_xfer[0] W, addr=0x4a, len=1
[   17.492340] i2c i2c-1: master_xfer[1] R, addr=0x4a, len=1
[   18.507812] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   18.507843] twl: Read failed (mod 7, reg 0x61 count 1)
[   18.507873] twl4030: err -110 initializing madc ISR
[   18.507934] i2c i2c-1: master_xfer[0] W, addr=0x4a, len=2
[   19.523437] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   19.523468] twl: Write failed (mod 7, reg 0x61 count 1)
[   19.523529] i2c i2c-1: master_xfer[0] W, addr=0x4a, len=1
[   19.523559] i2c i2c-1: master_xfer[1] R, addr=0x4a, len=1
[   20.539062] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   20.539093] twl: Read failed (mod 7, reg 0x61 count 1)
[   20.539123] twl4030: err -110 initializing madc ISR
[   20.539154] i2c i2c-1: master_xfer[0] W, addr=0x4a, len=2
[   21.554687] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   21.554718] twl: Write failed (mod 7, reg 0x61 count 1)
[   21.554779] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   21.554809] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   22.570312] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   22.570343] twl: Read failed (mod 19, reg 0x00 count 1)
[   22.570373] twl4030: err -110 initializing power ISR
[   22.570404] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   22.570465] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   23.585937] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   23.585968] twl: Read failed (mod 19, reg 0x00 count 1)
[   23.585998] twl4030: err -110 initializing power ISR
[   23.586059] twl 1-0048: PIH (irq 23) chaining IRQs 338..346
[   23.586212] twl 1-0048: power (irq 343) chaining IRQs 346..353
[   23.586364] i2c i2c-1: master_xfer[0] W, addr=0x49, len=1
[   23.586425] i2c i2c-1: master_xfer[1] R, addr=0x49, len=1
[   24.601562] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   24.601593] twl: Read failed (mod 3, reg 0x0f count 1)
[   24.601654] i2c i2c-1: master_xfer[0] W, addr=0x49, len=2
[   25.617187] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   25.617218] twl: Write failed (mod 3, reg 0x0f count 1)
[   25.618164] twl4030_gpio twl4030_gpio: gpio (irq 338) chaining IRQs 354..371
[   25.618255] i2c i2c-1: master_xfer[0] W, addr=0x49, len=6
[   26.632812] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   26.632873] twl: Write failed (mod 2, reg 0x13 count 5)
[   26.632904] twl4030_gpio twl4030_gpio: pullups 00000 3ff3f --> -110
[   26.632934] i2c i2c-1: master_xfer[0] W, addr=0x49, len=4
[   27.648437] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   27.648468] twl: Write failed (mod 2, reg 0x0f count 3)
[   27.648529] twl4030_gpio twl4030_gpio: debounce 000 0 --> -110
[   27.648559] gpiochip_find_base: found new base at 238
[   27.648925] gpiochip_add: registered GPIOs 238 to 255 on device: twl4030
[   27.648986] i2c i2c-1: master_xfer[0] W, addr=0x49, len=2
[   28.664062] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   28.664093] twl: Write failed (mod 2, reg 0x12 count 1)
[   28.664123] gpio_request: gpio-244 (backlight_pwm) status -110
[   28.664184] i2c i2c-1: master_xfer[0] W, addr=0x49, len=2
[   29.679687] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   29.679718] twl: Write failed (mod 2, reg 0x12 count 1)
[   29.679748] gpio_request: gpio-245 (speaker_en) status -110
[   29.681152] VUSB1V5: 1500 mV normal standby
[   29.681243] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   30.695312] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   30.695343] twl: Write failed (mod 21, reg 0x73 count 1)
[   30.696014] VUSB1V8: 1800 mV normal standby
[   30.696105] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   31.710937] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   31.710968] twl: Write failed (mod 21, reg 0x76 count 1)
[   31.711639] VUSB3V1: 3100 mV normal standby
[   31.711730] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   32.726562] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   32.726593] twl: Write failed (mod 21, reg 0x79 count 1)
[   32.726989] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   33.742187] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   33.742218] twl: Write failed (mod 20, reg 0x0e count 1)
[   33.742279] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   34.757812] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   34.757843] twl: Write failed (mod 20, reg 0x0e count 1)
[   34.757904] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   35.773437] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   35.773468] twl: Write failed (mod 21, reg 0x7d count 1)
[   35.773529] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   36.789062] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   36.789093] twl: Write failed (mod 21, reg 0x77 count 1)
[   36.789184] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   37.804687] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   37.804718] twl: Write failed (mod 21, reg 0x78 count 1)
[   37.804779] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   38.820312] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   38.820343] twl: Write failed (mod 21, reg 0x71 count 1)
[   38.820404] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   39.835937] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   39.835968] twl: Write failed (mod 21, reg 0x72 count 1)
[   39.836029] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   40.851562] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   40.851593] twl: Write failed (mod 21, reg 0x74 count 1)
[   40.851654] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   41.867187] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   41.867218] twl: Write failed (mod 21, reg 0x75 count 1)
[   41.867279] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   42.882812] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   42.882843] twl: Write failed (mod 20, reg 0x0e count 1)
[   42.882965] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   43.898437] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   43.898468] twl: Write failed (mod 19, reg 0x01 count 1)
[   43.898498] twl4030: twl4030_sih_bus_sync_unlock, write --> -110
[   43.898559] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   43.898590] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=2
[   44.914062] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   44.914093] twl: Read failed (mod 19, reg 0x05 count 2)
[   44.914123] twl4030: twl4030_sih_bus_sync_unlock, read --> -110
[   44.914184] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   44.914215] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   45.929687] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   45.929718] twl: Read failed (mod 20, reg 0x0f count 1)
[   45.929779] twl4030_usb twl4030_usb: TWL4030:readb[0x14,0xf] Error -110
[   45.929809] twl4030_usb twl4030_usb: USB link status err -110
[   45.929840] twl4030_usb twl4030_usb: HW_CONDITIONS 0xffffff92/-110; link 0
[   45.929870] twl4030_usb twl4030_usb: Initialized TWL4030 USB module
[   45.931243] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   45.931304] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   46.945312] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   46.945343] twl: Read failed (mod 21, reg 0x2f count 1)
[   46.945404] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   47.960937] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   47.960968] twl: Write failed (mod 21, reg 0x32 count 1)
[   47.960998] VPLL: failed to apply 1800000uV constraint
[   47.961334] twl_reg twl_reg.4: can't register VPLL1, -110
[   47.961395] twl_reg: probe of twl_reg.4 failed with error -110
[   47.962066] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   47.962097] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   48.976562] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   48.976593] twl: Read failed (mod 21, reg 0x4b count 1)
[   48.976623] VIO: failed to enable
[   48.976928] twl_reg twl_reg.2: can't register VIO, -110
[   48.976989] twl_reg: probe of twl_reg.2 failed with error -110
[   48.977600] vdd_mpu_iva: 600 <--> 1450 mV normal 
[   48.977691] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   49.992187] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   49.992218] twl: Write failed (mod 21, reg 0x57 count 1)
[   49.992889] vdd_core: 600 <--> 1450 mV normal 
[   49.992980] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   51.007812] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   51.007843] twl: Write failed (mod 21, reg 0x65 count 1)
[   51.008544] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   51.008575] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   52.023437] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   52.023468] twl: Read failed (mod 21, reg 0x2a count 1)
[   52.023498] VMMC1: 1850 <--> 3150 mV normal standby
[   52.023559] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   52.023590] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   53.039062] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   53.039093] twl: Read failed (mod 21, reg 0x2a count 1)
[   53.039215] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   54.054687] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   54.054718] twl: Write failed (mod 21, reg 0x29 count 1)
[   54.055419] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   54.055450] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   55.070312] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   55.070343] twl: Read failed (mod 21, reg 0x3b count 1)
[   55.070404] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   56.085937] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   56.085968] twl: Write failed (mod 21, reg 0x3e count 1)
[   56.085998] VDAC: failed to apply 1800000uV constraint
[   56.086303] twl_reg twl_reg.3: can't register VDAC, -110
[   56.086364] twl_reg: probe of twl_reg.3 failed with error -110
[   56.087005] VCSI: 1800 mV normal standby
[   56.087066] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   56.087097] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   57.101562] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   57.101593] twl: Read failed (mod 21, reg 0x1e count 1)
[   57.101684] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   58.117187] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   58.117218] twl: Write failed (mod 21, reg 0x1d count 1)
[   58.117919] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   58.117950] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   59.132812] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   59.132843] twl: Read failed (mod 21, reg 0x3f count 1)
[   59.132873] VINTANA1: failed to enable
[   59.133178] twl_reg twl_reg.14: can't register VINTANA1, -110
[   59.133239] twl_reg: probe of twl_reg.14 failed with error -110
[   59.133880] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   59.133941] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   60.148437] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   60.148468] twl: Read failed (mod 21, reg 0x43 count 1)
[   60.148529] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   61.164062] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   61.164093] twl: Write failed (mod 21, reg 0x46 count 1)
[   61.164123] VINTANA2: failed to apply 2750000uV constraint
[   61.164428] twl_reg twl_reg.15: can't register VINTANA2, -110
[   61.164489] twl_reg: probe of twl_reg.15 failed with error -110
[   61.165161] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   61.165191] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   62.179687] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   62.179718] twl: Read failed (mod 21, reg 0x47 count 1)
[   62.179748] VINTDIG: failed to enable
[   62.180053] twl_reg twl_reg.16: can't register VINTDIG, -110
[   62.180084] twl_reg: probe of twl_reg.16 failed with error -110
[   62.180755] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   62.180786] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   63.195312] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   63.195343] twl: Read failed (mod 21, reg 0x33 count 1)
[   63.195404] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   64.210937] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   64.210968] twl: Write failed (mod 21, reg 0x36 count 1)
[   64.210998] VSDI_CSI: failed to apply 1800000uV constraint
[   64.211303] twl_reg twl_reg.5: can't register VPLL2, -110
[   64.211364] twl_reg: probe of twl_reg.5 failed with error -110
[   64.212005] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   64.212036] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   65.226562] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   65.226593] twl: Read failed (mod 21, reg 0x2b count 1)
[   65.226623] V28_A: failed to enable
[   65.226928] twl_reg twl_reg.7: can't register VMMC2, -110
[   65.226959] twl_reg: probe of twl_reg.7 failed with error -110
[   65.227630] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   65.227661] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   66.242187] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   66.242218] twl: Read failed (mod 21, reg 0x37 count 1)
[   66.242279] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   67.257812] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   67.257843] twl: Write failed (mod 21, reg 0x3a count 1)
[   67.257873] VMMC2_IO_18: failed to apply 1800000uV constraint
[   67.258178] twl_reg twl_reg.8: can't register VSIM, -110
[   67.258239] twl_reg: probe of twl_reg.8 failed with error -110
[   67.258880] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   67.258941] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   68.273437] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   68.273468] twl: Read failed (mod 21, reg 0x17 count 1)
[   68.273498] V28: failed to enable
[   68.273803] twl_reg twl_reg.9: can't register VAUX1, -110
[   68.273834] twl_reg: probe of twl_reg.9 failed with error -110
[   68.274505] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   68.274536] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   69.289062] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   69.289093] twl: Read failed (mod 21, reg 0x22 count 1)
[   69.289123] VMMC2_30: 2800 <--> 3000 mV normal standby
[   69.289184] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   69.289215] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   70.304687] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   70.304718] twl: Read failed (mod 21, reg 0x22 count 1)
[   70.304840] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   71.320312] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   71.320343] twl: Write failed (mod 21, reg 0x21 count 1)
[   71.321014] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   71.321075] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   72.335937] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   72.335968] twl: Read failed (mod 21, reg 0x23 count 1)
[   72.336029] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   73.351562] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   73.351593] twl: Write failed (mod 21, reg 0x26 count 1)
[   73.351623] VCAM_ANA_28: failed to apply 2800000uV constraint
[   73.351928] twl_reg twl_reg.13: can't register VAUX4, -110
[   73.351989] twl_reg: probe of twl_reg.13 failed with error -110
[   73.352050] i2c i2c-1: client [twl5030] registered with bus id 1-0048
[   73.352111] omap_i2c omap_i2c.1: bus 1 rev3.3 at 2200 kHz
[   73.352844] i2c i2c-2: adapter [OMAP I2C adapter] registered
[   73.353027] i2c 2-0018: uevent
[   73.353302] i2c i2c-2: client [tlv320aic3x] registered with bus id 2-0018
[   73.353485] i2c 2-0019: uevent
[   73.353698] i2c i2c-2: client [tlv320aic3x] registered with bus id 2-0019
[   73.353851] i2c 2-0055: uevent
[   73.354064] i2c i2c-2: client [bq27200] registered with bus id 2-0055
[   73.354217] i2c 2-0060: uevent
[   73.354431] i2c i2c-2: client [tpa6130a2] registered with bus id 2-0060
[   73.354492] omap_i2c omap_i2c.2: bus 2 rev3.3 at 100 kHz
[   73.355133] i2c i2c-3: adapter [OMAP I2C adapter] registered
[   73.355194] omap_i2c omap_i2c.3: bus 3 rev3.3 at 400 kHz
[   73.358154] Switching to clocksource 32k_counter
[   73.384735] NET: Registered protocol family 2
[   73.385498] TCP established hash table entries: 2048 (order: 2, 16384 bytes)
[   73.385589] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[   73.385650] TCP: Hash tables configured (established 2048 bind 2048)
[   73.385833] TCP: reno registered
[   73.385864] UDP hash table entries: 256 (order: 0, 4096 bytes)
[   73.385925] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[   73.458770] CPU PMU: probing PMU on CPU 0
[   73.458831] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, 5 counters available
[   73.823699] msgmni has been set to 480
[   73.832733] io scheduler noop registered
[   73.833801] io scheduler cfq registered (default)
[   73.859344] OMAP DSS rev 2.0
[   73.870971] omapdss SDI error: can't get VDDS_SDI regulator
[   73.871063] omapdss SDI error: device lcd init failed: -517
[   73.881652] omapdss VENC error: can't get VDDA_DAC regulator
[   73.881744] omapdss VENC error: device tv init failed: -517
[   73.902069] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   73.938201] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq = 88) is a OMAP UART0
[   73.943939] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq = 89) is a OMAP UART1
[   73.949768] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq = 90) is a OMAP UART2
[   76.695678] console [ttyO2] enabled
[   76.735900] mtdoops: mtd device (mtddev=name/number) must be supplied
[   76.752044] OneNAND driver initializing
[   76.756591] omap2-onenand omap2-onenand: initializing on CS0, phys base 0x04000000, virtual base d0880000, freq 66 MHz
[   76.768005] OneNAND Manufacturer: Samsung (0xec)
[   76.772918] Muxed OneNAND 256MB 1.8V 16-bit (0x40)
[   76.778015] OneNAND version = 0x0121
[   76.781799] Chip support all block unlock
[   76.786071] Chip has 2 plane
[   76.790863] Scanning device for bad blocks
[   76.873596] onenand_bbt_wait: ecc 0x2222 ctrl 0x2400 intr 0x8080 addr1 0x4cd addr8 0x0
[   76.882019] OneNAND eraseblock 1229 is an initial bad block
[   76.944488] Creating 6 MTD partitions on "omap2-onenand":
[   76.950256] 0x000000000000-0x000000020000 : "bootloader"
[   76.972839] 0x000000020000-0x000000080000 : "config"
[   76.999328] 0x000000080000-0x0000000c0000 : "log"
[   77.025512] 0x0000000c0000-0x0000002c0000 : "kernel"
[   77.051940] 0x0000002c0000-0x0000004c0000 : "initfs"
[   77.078002] 0x0000004c0000-0x000010000000 : "rootfs"
[   77.120513] omap-dma-engine omap-dma-engine: allocating channel for 40
[   77.127563] omap-dma-engine omap-dma-engine: allocating channel for 39
[   77.139678] omap-dma-engine omap-dma-engine: allocating channel for 36
[   77.146636] omap-dma-engine omap-dma-engine: allocating channel for 35
[   77.174896] omap-dma-engine omap-dma-engine: allocating channel for 71
[   77.181976] omap-dma-engine omap-dma-engine: allocating channel for 70
[   77.195007] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
[   77.201660] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   77.207458] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   77.213256] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0
[   77.220611] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   77.225830] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.235382] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop: 1
[   77.242828] omap_i2c omap_i2c.1: IRQ (ISR = 0x0008)
[   77.247985] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.253234] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   77.259002] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   77.264739] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0
[   77.272033] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   77.277252] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.282470] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop: 1
[   77.289886] omap_i2c omap_i2c.1: IRQ (ISR = 0x0008)
[   77.295043] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.300262] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   77.306030] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop: 1
[   77.313354] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   77.318572] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.327117] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   77.332855] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   77.338592] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0
[   77.345916] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   77.351104] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.356292] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop: 1
[   77.363739] omap_i2c omap_i2c.1: IRQ (ISR = 0x0008)
[   77.368896] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.374114] i2c i2c-1: master_xfer[0] W, addr=0x48, len=1
[   77.379852] i2c i2c-1: master_xfer[1] R, addr=0x48, len=1
[   77.385589] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x0, stop: 0
[   77.392913] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   77.398132] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.403289] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x1, stop: 1
[   77.410736] omap_i2c omap_i2c.1: IRQ (ISR = 0x0008)
[   77.415893] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.421112] i2c i2c-1: master_xfer[0] W, addr=0x48, len=2
[   77.426818] omap_i2c omap_i2c.1: addr: 0x0048, len: 2, flags: 0x0, stop: 1
[   77.434173] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   77.439392] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.444580] i2c i2c-1: master_xfer[0] W, addr=0x48, len=1
[   77.450317] i2c i2c-1: master_xfer[1] R, addr=0x48, len=1
[   77.456054] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x0, stop: 0
[   77.463378] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   77.468597] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.473785] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x1, stop: 1
[   77.481201] omap_i2c omap_i2c.1: IRQ (ISR = 0x0008)
[   77.486358] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.491577] i2c i2c-1: master_xfer[0] W, addr=0x48, len=1
[   77.497283] i2c i2c-1: master_xfer[1] R, addr=0x48, len=1
[   77.503051] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x0, stop: 0
[   77.510375] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   77.515563] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.520751] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x1, stop: 1
[   77.528198] omap_i2c omap_i2c.1: IRQ (ISR = 0x0008)
[   77.533355] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.538574] i2c i2c-1: master_xfer[0] W, addr=0x48, len=2
[   77.544281] omap_i2c omap_i2c.1: addr: 0x0048, len: 2, flags: 0x0, stop: 1
[   77.551635] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   77.556823] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.562042] i2c i2c-1: master_xfer[0] W, addr=0x48, len=1
[   77.567779] i2c i2c-1: master_xfer[1] R, addr=0x48, len=1
[   77.573516] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x0, stop: 0
[   77.580841] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   77.586029] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.591217] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x1, stop: 1
[   77.598663] omap_i2c omap_i2c.1: IRQ (ISR = 0x0008)
[   77.603820] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.609039] i2c i2c-1: master_xfer[0] W, addr=0x48, len=2
[   77.614746] omap_i2c omap_i2c.1: addr: 0x0048, len: 2, flags: 0x0, stop: 1
[   77.622100] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   77.627319] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.632507] i2c i2c-1: master_xfer[0] W, addr=0x48, len=1
[   77.638244] i2c i2c-1: master_xfer[1] R, addr=0x48, len=1
[   77.643981] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x0, stop: 0
[   77.651306] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   77.656524] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.661682] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x1, stop: 1
[   77.669128] omap_i2c omap_i2c.1: IRQ (ISR = 0x0008)
[   77.674285] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.679504] i2c i2c-1: master_xfer[0] W, addr=0x48, len=1
[   77.685211] i2c i2c-1: master_xfer[1] R, addr=0x48, len=1
[   77.690979] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x0, stop: 0
[   77.698272] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   77.703491] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.708679] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x1, stop: 1
[   77.716125] omap_i2c omap_i2c.1: IRQ (ISR = 0x0008)
[   77.721282] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.726501] i2c i2c-1: master_xfer[0] W, addr=0x48, len=1
[   77.732208] i2c i2c-1: master_xfer[1] R, addr=0x48, len=1
[   77.737976] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x0, stop: 0
[   77.745269] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   77.750488] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.755676] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x1, stop: 1
[   77.763122] omap_i2c omap_i2c.1: IRQ (ISR = 0x0008)
[   77.768280] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.773498] i2c i2c-1: master_xfer[0] W, addr=0x48, len=2
[   77.779205] omap_i2c omap_i2c.1: addr: 0x0048, len: 2, flags: 0x0, stop: 1
[   77.786560] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   77.791778] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.796966] i2c i2c-1: master_xfer[0] W, addr=0x48, len=2
[   77.802703] omap_i2c omap_i2c.1: addr: 0x0048, len: 2, flags: 0x0, stop: 1
[   77.810028] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   77.815246] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.820465] i2c i2c-1: master_xfer[0] W, addr=0x48, len=2
[   77.826171] omap_i2c omap_i2c.1: addr: 0x0048, len: 2, flags: 0x0, stop: 1
[   77.833526] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   77.838714] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.843933] i2c i2c-1: master_xfer[0] W, addr=0x48, len=1
[   77.849670] i2c i2c-1: master_xfer[1] R, addr=0x48, len=1
[   77.855407] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x0, stop: 0
[   77.862731] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   77.867919] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.873107] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x1, stop: 1
[   77.880554] omap_i2c omap_i2c.1: IRQ (ISR = 0x0008)
[   77.885711] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.890930] i2c i2c-1: master_xfer[0] W, addr=0x48, len=2
[   77.896667] omap_i2c omap_i2c.1: addr: 0x0048, len: 2, flags: 0x0, stop: 1
[   77.903991] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   77.909210] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.914428] i2c i2c-1: master_xfer[0] W, addr=0x48, len=1
[   77.920135] i2c i2c-1: master_xfer[1] R, addr=0x48, len=1
[   77.925872] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x0, stop: 0
[   77.933197] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   77.938415] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.943572] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x1, stop: 1
[   77.951019] omap_i2c omap_i2c.1: IRQ (ISR = 0x0008)
[   77.956176] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   77.961395] twl4030_usb twl4030_usb: twl4030_phy_resume
[   77.966949] musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
[   77.978118] musb-hdrc: MHDRC RTL version 1.400 
[   77.982910] musb-hdrc: setup fifo_mode 4
[   77.987091] musb-hdrc: 28/31 max ep, 16384/16384 memory
[   77.994110] i2c i2c-1: master_xfer[0] W, addr=0x48, len=1
[   77.999908] i2c i2c-1: master_xfer[1] R, addr=0x48, len=1
[   78.005645] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x0, stop: 0
[   78.012969] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   78.018188] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.038726] mousedev: PS/2 mouse device common for all mice
[   78.055084] input: TWL4030 Keypad as /devices/platform/omap_i2c.1/i2c-1/1-004a/twl4030_keypad/input/input0
[   78.069946] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x1, stop: 1
[   78.077362] omap_i2c omap_i2c.1: IRQ (ISR = 0x0008)
[   78.082550] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.088623] i2c i2c-1: master_xfer[0] W, addr=0x4a, len=2
[   78.098663] i2c i2c-1: master_xfer[0] W, addr=0x48, len=2
[   78.104644] omap_i2c omap_i2c.1: addr: 0x004a, len: 2, flags: 0x0, stop: 1
[   78.112030] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   78.117279] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.122558] i2c i2c-1: master_xfer[0] W, addr=0x4a, len=2
[   78.128356] omap_i2c omap_i2c.1: addr: 0x0048, len: 2, flags: 0x0, stop: 1
[   78.135681] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   78.140899] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.146118] i2c i2c-1: master_xfer[0] W, addr=0x48, len=1
[   78.151855] i2c i2c-1: master_xfer[1] R, addr=0x48, len=1
[   78.157623] omap_i2c omap_i2c.1: addr: 0x004a, len: 2, flags: 0x0, stop: 1
[   78.164947] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   78.170166] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.175384] i2c i2c-1: master_xfer[0] W, addr=0x4a, len=2
[   78.181121] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x0, stop: 0
[   78.188476] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   78.193634] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.198852] omap_i2c omap_i2c.1: addr: 0x0048, len: 1, flags: 0x1, stop: 1
[   78.206176] omap_i2c omap_i2c.1: IRQ (ISR = 0x0008)
[   78.211364] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.216583] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   78.222320] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   78.228088] omap_i2c omap_i2c.1: addr: 0x004a, len: 2, flags: 0x0, stop: 1
[   78.235412] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   78.240631] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.245849] i2c i2c-1: master_xfer[0] W, addr=0x4a, len=2
[   78.251586] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0
[   78.258911] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   78.264099] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.269317] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop: 1
[   78.276733] omap_i2c omap_i2c.1: IRQ (ISR = 0x0008)
[   78.281890] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.287109] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   78.292877] omap_i2c omap_i2c.1: addr: 0x004a, len: 2, flags: 0x0, stop: 1
[   78.300201] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   78.305419] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.310607] i2c i2c-1: master_xfer[0] W, addr=0x4a, len=2
[   78.316375] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop: 1
[   78.323699] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   78.328918] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.334136] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   78.339874] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   78.345642] omap_i2c omap_i2c.1: addr: 0x004a, len: 2, flags: 0x0, stop: 1
[   78.352966] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   78.358154] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.363372] i2c i2c-1: master_xfer[0] W, addr=0x4a, len=2
[   78.369140] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0
[   78.376464] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   78.381652] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.386840] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop: 1
[   78.394287] omap_i2c omap_i2c.1: IRQ (ISR = 0x0008)
[   78.399444] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.404663] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   78.410430] omap_i2c omap_i2c.1: addr: 0x004a, len: 2, flags: 0x0, stop: 1
[   78.417755] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   78.422973] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.428161] i2c i2c-1: master_xfer[0] W, addr=0x4a, len=2
[   78.433929] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop: 1
[   78.441253] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   78.446472] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.451660] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=1
[   78.457397] i2c i2c-1: master_xfer[1] R, addr=0x4b, len=1
[   78.463165] omap_i2c omap_i2c.1: addr: 0x004a, len: 2, flags: 0x0, stop: 1
[   78.470520] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   78.475708] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.480926] i2c i2c-1: master_xfer[0] W, addr=0x4a, len=1
[   78.486663] i2c i2c-1: master_xfer[1] R, addr=0x4a, len=8
[   78.492401] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop: 0
[   78.499725] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   78.504913] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.510131] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop: 1
[   78.517547] omap_i2c omap_i2c.1: IRQ (ISR = 0x0008)
[   78.522705] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.527923] i2c i2c-1: master_xfer[0] W, addr=0x4b, len=2
[   78.533691] omap_i2c omap_i2c.1: addr: 0x004a, len: 1, flags: 0x0, stop: 0
[   78.541015] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   78.546203] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.551391] omap_i2c omap_i2c.1: addr: 0x004a, len: 8, flags: 0x1, stop: 1
[   78.558837] omap_i2c omap_i2c.1: IRQ (ISR = 0x0008)
[   78.563995] omap_i2c omap_i2c.1: IRQ (ISR = 0x0008)
[   78.569152] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.574493] i2c i2c-1: master_xfer[0] W, addr=0x4a, len=2
[   78.580261] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop: 1
[   78.587585] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   78.592803] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.597991] twl4030_usb twl4030_usb: twl4030_phy_suspend
[   78.603729] omap_i2c omap_i2c.1: addr: 0x004a, len: 2, flags: 0x0, stop: 1
[   78.611053] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[   78.616271] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[   78.638244] input: TSC2005 touchscreen as /devices/platform/omap2_mcspi.1/spi_master/spi1/spi1.0/input/input1

A.

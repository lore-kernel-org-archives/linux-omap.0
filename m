From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Fri, 19 Oct 2012 22:38:47 +0300
Message-ID: <20121019193847.GJ1613@blackmetal.musicnaut.iki.fi>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
 <20121019190358.GI1613@blackmetal.musicnaut.iki.fi>
 <20121019190136.GA4229@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:41144 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757994Ab2JSTiv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Oct 2012 15:38:51 -0400
Content-Disposition: inline
In-Reply-To: <20121019190136.GA4229@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Fri, Oct 19, 2012 at 10:01:36PM +0300, Felipe Balbi wrote:
> On Fri, Oct 19, 2012 at 10:03:58PM +0300, Aaro Koskinen wrote:
> > FYI, I saw I2C hangs also on Nokia N900 with v3.7-rc1 (omap_i2c
> > omap_i2c.1: timeout waiting for bus ready). After several reboots they
> > disappered (kernel binary was the same), and I have been unable to
> > reproduce them since.
> 
> any change you have those logs saved somewhere ? Want to see if it's the
> same problem triggered by RTC.

I did not save the logs, but now I tried again, I managed to reproduce
it after couple boots. The log is below, and after that the there's also
one from OK boot for comparison.

In the error case, the boot never reaches userspace, just silently hangs
(or maybe I just didn't wait enough long).

...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.7.0-rc1-n9xx (aaro@blackmetal) (gcc version 4.7.2 (GCC) ) #1 Wed Oct 17 00:28:59 EEST 2012
[    0.000000] Ignoring unrecognised tag 0x414f4d50
[    0.000000] Reserving 16777216 bytes SDRAM for VRAM
[    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
[    0.000000] Clocking rate (Crystal/Core/MPU): 19.2/332/500 MHz
[    0.000000] Kernel command line: console=tty console=ttyO2,115200
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 239MB = 239MB total
[    0.000000] Memory: 233420k/233420k available, 28724k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc03c0000   (3808 kB)
[    0.000000]       .init : 0xc03c0000 - 0xc078569c   (3862 kB)
[    0.000000]       .data : 0xc0786000 - 0xc07b9880   ( 207 kB)
[    0.000000]        .bss : 0xc07b98a4 - 0xc08ced10   (1110 kB)
[    0.000000] SLUB: Genslabs=11, HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] console [tty0] enabled
[    0.000854] Calibrating delay loop... 331.40 BogoMIPS (lpj=1296384)
[    0.054687] pid_max: default: 32768 minimum: 301
[    0.054901] Mount-cache hash table entries: 512
[    0.055664] CPU: Testing write buffer coherency: ok
[    0.056060] Setting up static identity map for 0x802d23e8 - 0x802d2440
[    0.057128] devtmpfs: initialized
[    0.063995] omap_hwmod: mcbsp2: cannot be enabled for reset (3)
[    0.069488] pinctrl core: initialized pinctrl subsystem
[    0.070953] regulator-dummy: no parameters
[    0.071380] NET: Registered protocol family 16
[    0.072875] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.073699] omap-gpmc omap-gpmc: GPMC revision 5.0
[    0.078308] OMAP GPIO hardware version 2.5
[    0.085357] omap_mux_init: Add partition: #1: core, flags: 0
[    0.089172] Reprogramming SDRC clock to 332000000 Hz
[    0.095092] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.100860] Reserving DMA channels 0 and 1 for HS ROM code
[    0.100891] OMAP DMA hardware revision 4.0
[    0.103057]  arm-pmu: alias fck already exists
[    0.121765] bio: create slab <bio-0> at 0
[    0.160278] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.162811] SCSI subsystem initialized
[    0.163360] usbcore: registered new interface driver usbfs
[    0.163665] usbcore: registered new interface driver hub
[    0.164031] usbcore: registered new device driver usb
[    0.164733] musb-omap2430 musb-omap2430: invalid resource
[    0.190460] twl 1-0048: PIH (irq 23) chaining IRQs 338..346
[    0.190612] twl 1-0048: power (irq 343) chaining IRQs 346..353
[    0.191833] twl4030_gpio twl4030_gpio: gpio (irq 338) chaining IRQs 354..371
[    1.203124] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    2.218749] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    2.218780] twl: i2c_write failed to transfer all messages
[    3.234374] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    3.234405] twl: i2c_write failed to transfer all messages
[    3.235748] VUSB1V5: 1500 mV normal standby
[    4.249999] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    4.250030] twl: i2c_write failed to transfer all messages
[    4.250701] VUSB1V8: 1800 mV normal standby
[    5.265624] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    5.265655] twl: i2c_write failed to transfer all messages
[    5.266296] VUSB3V1: 3100 mV normal standby
[    6.281249] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    6.281280] twl: i2c_write failed to transfer all messages
[    7.296874] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    7.296905] twl: i2c_write failed to transfer all messages
[    8.312499] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    8.312530] twl: i2c_write failed to transfer all messages
[    9.328124] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    9.328155] twl: i2c_write failed to transfer all messages
[   10.343749] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   10.343780] twl: i2c_write failed to transfer all messages
[   11.359374] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   11.359405] twl: i2c_write failed to transfer all messages
[   12.374999] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   12.375030] twl: i2c_write failed to transfer all messages
[   13.390624] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   13.390655] twl: i2c_write failed to transfer all messages
[   14.406249] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   14.406280] twl: i2c_write failed to transfer all messages
[   15.421874] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   15.421905] twl: i2c_write failed to transfer all messages
[   16.437499] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   16.437530] twl: i2c_write failed to transfer all messages
[   17.453124] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   17.453155] twl: i2c_write failed to transfer all messages
[   17.453186] twl4030: twl4030_sih_bus_sync_unlock, write --> -110
[   18.468749] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   18.468780] twl: i2c_read failed to transfer all messages
[   18.468811] twl4030: twl4030_sih_bus_sync_unlock, read --> -110
[   19.484374] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   19.484405] twl: i2c_read failed to transfer all messages
[   19.484466] twl4030_usb twl4030_usb: USB link status err -110
[   19.484497] twl4030_usb twl4030_usb: Initialized TWL4030 USB module
[   20.499999] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   20.500030] twl: i2c_read failed to transfer all messages
[   21.515624] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   21.515655] twl: i2c_write failed to transfer all messages
[   21.515686] VPLL: failed to apply 1800000uV constraint
[   21.516021] twl_reg twl_reg.4: can't register VPLL1, -110
[   21.516052] twl_reg: probe of twl_reg.4 failed with error -110
[   22.531249] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   22.531280] twl: i2c_read failed to transfer all messages
[   22.531311] VIO: failed to enable
[   22.531616] twl_reg twl_reg.2: can't register VIO, -110
[   22.531646] twl_reg: probe of twl_reg.2 failed with error -110
[   22.532287] vdd_mpu_iva: 600 <--> 1450 mV normal 
[   23.546874] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   23.546905] twl: i2c_write failed to transfer all messages
[   23.547546] vdd_core: 600 <--> 1450 mV normal 
[   24.562499] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   24.562530] twl: i2c_write failed to transfer all messages
[   25.578124] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   25.578155] twl: i2c_read failed to transfer all messages
[   25.578186] VMMC1: 1850 <--> 3150 mV normal standby
[   26.593749] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   26.593780] twl: i2c_read failed to transfer all messages
[   27.609374] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   27.609405] twl: i2c_write failed to transfer all messages
[   28.624999] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   28.625030] twl: i2c_read failed to transfer all messages
[   29.640624] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   29.640655] twl: i2c_write failed to transfer all messages
[   29.640686] VDAC: failed to apply 1800000uV constraint
[   29.640991] twl_reg twl_reg.3: can't register VDAC, -110
[   29.641021] twl_reg: probe of twl_reg.3 failed with error -110
[   29.641662] VCSI: 1800 mV normal standby
[   30.656249] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   30.656280] twl: i2c_read failed to transfer all messages
[   31.671874] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   31.671905] twl: i2c_write failed to transfer all messages
[   32.687499] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   32.687530] twl: i2c_read failed to transfer all messages
[   32.687561] VINTANA1: failed to enable
[   32.687835] twl_reg twl_reg.14: can't register VINTANA1, -110
[   32.687896] twl_reg: probe of twl_reg.14 failed with error -110
[   33.703124] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   33.703155] twl: i2c_read failed to transfer all messages
[   34.718749] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   34.718780] twl: i2c_write failed to transfer all messages
[   34.718811] VINTANA2: failed to apply 2750000uV constraint
[   34.719085] twl_reg twl_reg.15: can't register VINTANA2, -110
[   34.719146] twl_reg: probe of twl_reg.15 failed with error -110
[   35.734374] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   35.734405] twl: i2c_read failed to transfer all messages
[   35.734436] VINTDIG: failed to enable
[   35.734710] twl_reg twl_reg.16: can't register VINTDIG, -110
[   35.734771] twl_reg: probe of twl_reg.16 failed with error -110
[   36.749999] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   36.750030] twl: i2c_read failed to transfer all messages
[   37.765624] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   37.765655] twl: i2c_write failed to transfer all messages
[   37.765686] VSDI_CSI: failed to apply 1800000uV constraint
[   37.765960] twl_reg twl_reg.5: can't register VPLL2, -110
[   37.766021] twl_reg: probe of twl_reg.5 failed with error -110
[   38.781249] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   38.781280] twl: i2c_read failed to transfer all messages
[   38.781311] V28_A: failed to enable
[   38.781585] twl_reg twl_reg.7: can't register VMMC2, -110
[   38.781646] twl_reg: probe of twl_reg.7 failed with error -110
[   39.796874] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   39.796905] twl: i2c_read failed to transfer all messages
[   40.812499] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   40.812530] twl: i2c_write failed to transfer all messages
[   40.812561] VMMC2_IO_18: failed to apply 1800000uV constraint
[   40.812835] twl_reg twl_reg.8: can't register VSIM, -110
[   40.812896] twl_reg: probe of twl_reg.8 failed with error -110
[   41.828124] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   41.828155] twl: i2c_read failed to transfer all messages
[   41.828186] V28: failed to enable
[   41.828460] twl_reg twl_reg.9: can't register VAUX1, -110
[   41.828521] twl_reg: probe of twl_reg.9 failed with error -110
[   42.843749] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   42.843780] twl: i2c_read failed to transfer all messages
[   42.843811] VMMC2_30: 2800 <--> 3000 mV normal standby
[   43.859374] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   43.859405] twl: i2c_read failed to transfer all messages
[   44.874999] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   44.875030] twl: i2c_write failed to transfer all messages
[   45.890624] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   45.890655] twl: i2c_read failed to transfer all messages
[   46.906249] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   46.906280] twl: i2c_write failed to transfer all messages
[   46.906311] VCAM_ANA_28: failed to apply 2800000uV constraint
[   46.906585] twl_reg twl_reg.13: can't register VAUX4, -110
[   46.906646] twl_reg: probe of twl_reg.13 failed with error -110
[   46.906707] omap_i2c omap_i2c.1: bus 1 rev1.3.12 at 2200 kHz
[   46.908630] omap_i2c omap_i2c.2: bus 2 rev1.3.12 at 100 kHz
[   46.909271] omap_i2c omap_i2c.3: bus 3 rev1.3.12 at 400 kHz
[   46.912200] Switching to clocksource 32k_counter
[   46.938690] NET: Registered protocol family 2
[   46.939422] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
[   46.939666] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[   46.939819] TCP: Hash tables configured (established 8192 bind 8192)
[   46.939971] TCP: reno registered
[   46.940032] UDP hash table entries: 256 (order: 0, 4096 bytes)
[   46.940063] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[   46.984313] CPU PMU: probing PMU on CPU 0
[   46.984374] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, 5 counters available
[   47.340698] msgmni has been set to 455
[   47.349639] io scheduler noop registered
[   47.350799] io scheduler cfq registered (default)
[   47.371429] OMAP DSS rev 2.0
[   47.382049] omapdss SDI error: can't get VDDS_SDI regulator
[   47.382110] omapdss SDI error: device lcd init failed: -517
[   47.392883] omapdss VENC error: can't get VDDA_DAC regulator
[   47.392944] omapdss VENC error: device tv init failed: -517
[   47.403137] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   47.438934] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq = 88) is a OMAP UART0
[   47.443847] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq = 89) is a OMAP UART1
[   47.450317] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq = 90) is a OMAP UART2
[   48.737792] console [ttyO2] enabled
[   48.777343] mtdoops: mtd device (mtddev=name/number) must be supplied
[   48.793426] OneNAND driver initializing
[   48.798004] omap2-onenand omap2-onenand: initializing on CS0, phys base 0x04000000, virtual base d0880000, freq 66 MHz
[   48.809417] Muxed OneNAND 256MB 1.8V 16-bit (0x40)
[   48.814514] OneNAND version = 0x0121
[   48.820068] Scanning device for bad blocks
[   48.903167] OneNAND eraseblock 1229 is an initial bad block
[   48.965820] Creating 6 MTD partitions on "omap2-onenand":
[   48.971679] 0x000000000000-0x000000020000 : "bootloader"
[   48.994049] 0x000000020000-0x000000080000 : "config"
[   49.020263] 0x000000080000-0x0000000c0000 : "log"
[   49.046173] 0x0000000c0000-0x0000002c0000 : "kernel"
[   49.072509] 0x0000002c0000-0x0000004c0000 : "initfs"
[   49.098693] 0x0000004c0000-0x000010000000 : "rootfs"
[   49.140594] omap-dma-engine omap-dma-engine: allocating channel for 40
[   49.147644] omap-dma-engine omap-dma-engine: allocating channel for 39
[   49.159637] omap-dma-engine omap-dma-engine: allocating channel for 36
[   49.166656] omap-dma-engine omap-dma-engine: allocating channel for 35
[   49.193847] omap-dma-engine omap-dma-engine: allocating channel for 71
[   49.200805] omap-dma-engine omap-dma-engine: allocating channel for 70
[   49.214599] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
[   49.245239] mousedev: PS/2 mouse device common for all mice
[   49.261505] input: TWL4030 Keypad as /devices/platform/omap_i2c.1/i2c-1/1-004a/twl4030_keypad/input/input0
[   49.298553] input: TSC2005 touchscreen as /devices/platform/omap2_mcspi.1/spi_master/spi1/spi1.0/input/input1

The good case:

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.7.0-rc1-n9xx (aaro@blackmetal) (gcc version 4.7.2 (GCC) ) #1 Wed Oct 17 00:28:59 EEST 2012
[    0.000000] Ignoring unrecognised tag 0x414f4d50
[    0.000000] Reserving 16777216 bytes SDRAM for VRAM
[    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
[    0.000000] Clocking rate (Crystal/Core/MPU): 19.2/332/500 MHz
[    0.000000] Kernel command line: console=tty console=ttyO2,115200
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 239MB = 239MB total
[    0.000000] Memory: 233420k/233420k available, 28724k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc03c0000   (3808 kB)
[    0.000000]       .init : 0xc03c0000 - 0xc078569c   (3862 kB)
[    0.000000]       .data : 0xc0786000 - 0xc07b9880   ( 207 kB)
[    0.000000]        .bss : 0xc07b98a4 - 0xc08ced10   (1110 kB)
[    0.000000] SLUB: Genslabs=11, HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] console [tty0] enabled
[    0.000823] Calibrating delay loop... 331.40 BogoMIPS (lpj=1296384)
[    0.054656] pid_max: default: 32768 minimum: 301
[    0.054870] Mount-cache hash table entries: 512
[    0.055633] CPU: Testing write buffer coherency: ok
[    0.056060] Setting up static identity map for 0x802d23e8 - 0x802d2440
[    0.057128] devtmpfs: initialized
[    0.063995] omap_hwmod: mcbsp2: cannot be enabled for reset (3)
[    0.067474] pinctrl core: initialized pinctrl subsystem
[    0.068878] regulator-dummy: no parameters
[    0.069305] NET: Registered protocol family 16
[    0.070831] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.071685] omap-gpmc omap-gpmc: GPMC revision 5.0
[    0.076263] OMAP GPIO hardware version 2.5
[    0.083374] omap_mux_init: Add partition: #1: core, flags: 0
[    0.087158] Reprogramming SDRC clock to 332000000 Hz
[    0.092987] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.098846] Reserving DMA channels 0 and 1 for HS ROM code
[    0.098907] OMAP DMA hardware revision 4.0
[    0.101013]  arm-pmu: alias fck already exists
[    0.119781] bio: create slab <bio-0> at 0
[    0.158294] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.160827] SCSI subsystem initialized
[    0.161407] usbcore: registered new interface driver usbfs
[    0.161682] usbcore: registered new interface driver hub
[    0.162017] usbcore: registered new device driver usb
[    0.162689] musb-omap2430 musb-omap2430: invalid resource
[    0.188476] twl 1-0048: PIH (irq 23) chaining IRQs 338..346
[    0.188659] twl 1-0048: power (irq 343) chaining IRQs 346..353
[    0.189849] twl4030_gpio twl4030_gpio: gpio (irq 338) chaining IRQs 354..371
[    0.192382] VUSB1V5: 1500 mV normal standby
[    0.193176] VUSB1V8: 1800 mV normal standby
[    0.193969] VUSB3V1: 3100 mV normal standby
[    0.198425] musb-omap2430 musb-omap2430: musb core is not yet ready
[    0.198486] twl4030_usb twl4030_usb: Initialized TWL4030 USB module
[    0.200286] VPLL: 1800 mV normal standby
[    0.201354] VIO: 1800 mV normal standby
[    0.202239] vdd_mpu_iva: 600 <--> 1450 mV normal 
[    0.203033] vdd_core: 600 <--> 1450 mV normal 
[    0.203979] VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
[    0.205139] VDAC: 1800 mV normal standby
[    0.206024] VCSI: 1800 mV normal standby
[    0.207122] VINTANA1: 1500 mV normal standby
[    0.208404] VINTANA2: 2750 mV normal standby
[    0.209503] VINTDIG: 1500 mV normal standby
[    0.210754] VSDI_CSI: 1800 mV normal standby
[    0.211975] V28_A: 2800 <--> 3000 mV at 2600 mV normal standby
[    0.213195] VMMC2_IO_18: 1800 mV normal standby
[    0.214294] V28: 2800 mV normal standby
[    0.215332] VMMC2_30: 2800 <--> 3000 mV at 2800 mV normal standby
[    0.216552] VCAM_ANA_28: 2800 mV normal standby
[    0.216857] omap_i2c omap_i2c.1: bus 1 rev1.3.12 at 2200 kHz
[    0.218841] omap_i2c omap_i2c.2: bus 2 rev1.3.12 at 100 kHz
[    0.219543] omap_i2c omap_i2c.3: bus 3 rev1.3.12 at 400 kHz
[    0.222442] Switching to clocksource 32k_counter
[    0.248962] NET: Registered protocol family 2
[    0.249725] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
[    0.250000] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[    0.250152] TCP: Hash tables configured (established 8192 bind 8192)
[    0.250305] TCP: reno registered
[    0.250335] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.250396] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.294677] CPU PMU: probing PMU on CPU 0
[    0.294769] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, 5 counters available
[    0.650421] msgmni has been set to 455
[    0.659210] io scheduler noop registered
[    0.660369] io scheduler cfq registered (default)
[    0.681091] OMAP DSS rev 2.0
[    0.722259] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.757598] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq = 88) is a OMAP UART0
[    0.763275] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq = 89) is a OMAP UART1
[    0.768859] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq = 90) is a OMAP UART2
[    1.345886] console [ttyO2] enabled
[    1.385345] mtdoops: mtd device (mtddev=name/number) must be supplied
[    1.401428] OneNAND driver initializing
[    1.405975] omap2-onenand omap2-onenand: initializing on CS0, phys base 0x04000000, virtual base d0880000, freq 66 MHz
[    1.417388] Muxed OneNAND 256MB 1.8V 16-bit (0x40)
[    1.422485] OneNAND version = 0x0121
[    1.428039] Scanning device for bad blocks
[    1.510833] OneNAND eraseblock 1229 is an initial bad block
[    1.573272] Creating 6 MTD partitions on "omap2-onenand":
[    1.579101] 0x000000000000-0x000000020000 : "bootloader"
[    1.601562] 0x000000020000-0x000000080000 : "config"
[    1.627746] 0x000000080000-0x0000000c0000 : "log"
[    1.653228] 0x0000000c0000-0x0000002c0000 : "kernel"
[    1.679840] 0x0000002c0000-0x0000004c0000 : "initfs"
[    1.705993] 0x0000004c0000-0x000010000000 : "rootfs"
[    1.747772] omap-dma-engine omap-dma-engine: allocating channel for 40
[    1.754791] omap-dma-engine omap-dma-engine: allocating channel for 39
[    1.766784] omap-dma-engine omap-dma-engine: allocating channel for 36
[    1.773803] omap-dma-engine omap-dma-engine: allocating channel for 35
[    1.800994] omap-dma-engine omap-dma-engine: allocating channel for 71
[    1.807983] omap-dma-engine omap-dma-engine: allocating channel for 70
[    1.821685] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
[    1.850494] mousedev: PS/2 mouse device common for all mice
[    1.866729] input: TWL4030 Keypad as /devices/platform/omap_i2c.1/i2c-1/1-004a/twl4030_keypad/input/input0
[    1.903717] input: TSC2005 touchscreen as /devices/platform/omap2_mcspi.1/spi_master/spi1/spi1.0/input/input1
[    1.935546] input: twl4030_pwrbutton as /devices/platform/omap_i2c.1/i2c-1/1-0049/twl4030_pwrbutton/input/input2
[    1.957153] twl_rtc twl_rtc: Enabling TWL-RTC
[    1.974426] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    1.986541] i2c /dev entries driver
[    2.010467] Driver for 1-wire Dallas network protocol.
[    2.041320] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
[    2.058074] twl4030_wdt twl4030_wdt: Failed to register misc device
[    2.064819] twl4030_wdt: probe of twl4030_wdt failed with error -16
[    2.087432] omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
[    2.093872] omap-dma-engine omap-dma-engine: allocating channel for 62
[    2.100860] omap-dma-engine omap-dma-engine: allocating channel for 61
[    2.324615] omap_hsmmc omap_hsmmc.0: mmc0: cover is open, card is now inaccessible
[    2.488739] omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
[    2.495086] omap-dma-engine omap-dma-engine: allocating channel for 48
[    2.502075] omap-dma-engine omap-dma-engine: allocating channel for 47
[    2.574462] usbcore: registered new interface driver usbhid
[    2.580383] usbhid: USB HID core driver
[    2.594512] oprofile: using arm/armv7
[    2.598815] TCP: cubic registered
[    2.602355] NET: Registered protocol family 17
[    2.607177] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
[    2.626220] ThumbEE CPU extension supported.
[    2.630889] clock: disabling unused clocks to save power
[    2.650207] VCSI: disabling
[    2.676544] input: gpio-keys as /devices/platform/gpio-keys/input/input3
[    2.696746] twl_rtc twl_rtc: setting system clock to 2000-01-01 00:00:12 UTC (946684812)
[    2.716003] Freeing init memory: 3860K
[    2.848114] acx565akm spi1.2: omapfb: acx565akm rev 8a LCD detected
[    2.868896] mmc1: new high speed MMC card at address 0001
[    2.894683] mmcblk0: mmc1:0001 MMC32G 29.8 GiB 
[    2.902282] mmcblk0boot0: mmc1:0001 MMC32G partition 1 512 KiB
[    2.923126] mmcblk0boot1: mmc1:0001 MMC32G partition 2 512 KiB
[    2.947784]  mmcblk0: p1 p2 p3
[    2.952819] Console: switching to colour frame buffer device 100x30
[    2.994689]  mmcblk0boot1: unknown partition table
[    3.020538]  mmcblk0boot0: unknown partition table
[    3.120727]  gadget: using random self ethernet address
[    3.129394]  gadget: using random host ethernet address
[    3.148956] usb0: MAC a6:c2:85:ce:e5:0b
[    3.155944] usb0: HOST MAC ee:48:89:41:f9:74
[    3.163299]  gadget: Ethernet Gadget, version: Memorial Day 2008
[    3.172271]  gadget: g_ether ready
[    3.190399] musb-hdrc musb-hdrc.0: MUSB HDRC host driver
[    3.198913] musb-hdrc musb-hdrc.0: new USB bus registered, assigned bus number 1
[    3.209655] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.219604] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.230041] usb usb1: Product: MUSB HDRC host driver
[    3.238067] usb usb1: Manufacturer: Linux 3.7.0-rc1-n9xx musb-hcd
[    3.247283] usb usb1: SerialNumber: musb-hdrc.0
[    3.261840] hub 1-0:1.0: USB hub found
[    3.268707] hub 1-0:1.0: 1 port detected
[719] Jan 01 00:00:13 Not backgrounding
[    3.706481]  gadget: high-speed config #1: CDC Ethernet (ECM)

A.

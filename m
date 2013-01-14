From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: OMAP baseline test results for v3.8-rc3
Date: Mon, 14 Jan 2013 20:40:18 +0200
Message-ID: <20130114184018.GA18224@blackmetal.musicnaut.iki.fi>
References: <alpine.DEB.2.00.1301141756460.20390@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:40091 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756163Ab3ANSkX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jan 2013 13:40:23 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1301141756460.20390@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jan 14, 2013 at 05:59:12PM +0000, Paul Walmsley wrote:
> Here are some basic OMAP test results for Linux v3.8-rc3.
> Logs and other details at:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.8-rc3/20130109222058/
> 
> 
> Test summary
> ------------
> 
> Boot to userspace:
>     Pass ( 9/11): 2420n800, 2430sdp, 3517evm, 3530es3beagle,
>   	   	  3730beaglexm, 37xxevm, 4430es2panda, 5912osk,
> 		  4460pandaes
>     FAIL ( 2/11): am335xbone, cmt3517 

N900 boot is unstable again, I2C issues are back.

Boot succeeds and fails randomly. Let's see if this can be bisected.
The same kernel works on N950.

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.8.0-rc3-n9xx (aaro@blackmetal) (gcc version 4.7.2 (GCC) ) #1 Sun Jan 13 16:01:49 EET 2013
[    0.000000] Ignoring unrecognised tag 0x414f4d50
[    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
[    0.000000] Clocking rate (Crystal/Core/MPU): 19.2/332/500 MHz
[    0.000000] Kernel command line: console=tty console=ttyO2,115200
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] Memory: 255MB = 255MB total
[    0.000000] Memory: 246248k/246248k available, 15896k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc03d4fcc   (3892 kB)
[    0.000000]       .init : 0xc03d5000 - 0xc0af9fc8   (7316 kB)
[    0.000000]       .data : 0xc0afa000 - 0xc0b31d20   ( 224 kB)
[    0.000000]        .bss : 0xc0b31d20 - 0xc0c4765c   (1111 kB)
[    0.000000] SLUB: Genslabs=11, HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] console [tty0] enabled
[    0.000885] Calibrating delay loop... 331.40 BogoMIPS (lpj=1296384)
[    0.054687] pid_max: default: 32768 minimum: 301
[    0.054901] Mount-cache hash table entries: 512
[    0.055633] CPU: Testing write buffer coherency: ok
[    0.056091] Setting up static identity map for 0x802de0a8 - 0x802de100
[    0.057189] devtmpfs: initialized
[    0.064453] omap_hwmod: mcbsp2: cannot be enabled for reset (3)
[    0.088714] pinctrl core: initialized pinctrl subsystem
[    0.090179] regulator-dummy: no parameters
[    0.090637] NET: Registered protocol family 16
[    0.092132] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.092987] omap-gpmc omap-gpmc: GPMC revision 5.0
[    0.097656] OMAP GPIO hardware version 2.5
[    0.104827] omap_mux_init: Add partition: #1: core, flags: 4
[    0.108581] Reprogramming SDRC clock to 332000000 Hz
[    0.114715] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.121215] Reserving DMA channels 0 and 1 for HS ROM code
[    0.121276] OMAP DMA hardware revision 4.0
[    0.123168]  arm-pmu: alias fck already exists
[    0.142547] bio: create slab <bio-0> at 0
[    0.181976] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.184570] SCSI subsystem initialized
[    0.185150] usbcore: registered new interface driver usbfs
[    0.185455] usbcore: registered new interface driver hub
[    0.185821] usbcore: registered new device driver usb
[    0.186492] musb-omap2430 musb-omap2430: invalid resource
[    0.212890] twl 1-0048: PIH (irq 23) chaining IRQs 338..346
[    0.213073] twl 1-0048: power (irq 343) chaining IRQs 346..353
[    0.214294] twl4030_gpio twl4030_gpio: gpio (irq 338) chaining IRQs 354..371
[    1.226562] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    2.242187] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    2.242248] twl: Write failed (mod 2, reg 0x12 count 1)
[    3.257812] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    3.257843] twl: Write failed (mod 2, reg 0x12 count 1)
[    3.259277] VUSB1V5: 1500 mV normal standby
[    4.273437] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    4.273498] twl: Write failed (mod 21, reg 0x73 count 1)
[    4.274139] VUSB1V8: 1800 mV normal standby
[    5.289062] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    5.289093] twl: Write failed (mod 21, reg 0x76 count 1)
[    5.289764] VUSB3V1: 3100 mV normal standby
[    6.304687] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    6.304718] twl: Write failed (mod 21, reg 0x79 count 1)
[    7.320312] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    7.320373] twl: Write failed (mod 20, reg 0x0e count 1)
[    8.335937] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    8.335968] twl: Write failed (mod 20, reg 0x0e count 1)
[    9.351562] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    9.351593] twl: Write failed (mod 21, reg 0x7d count 1)
[   10.367187] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   10.367218] twl: Write failed (mod 21, reg 0x77 count 1)
[   11.382812] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   11.382843] twl: Write failed (mod 21, reg 0x78 count 1)
[   12.398437] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   12.398468] twl: Write failed (mod 21, reg 0x71 count 1)
[   13.414062] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   13.414093] twl: Write failed (mod 21, reg 0x72 count 1)
[   14.429687] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   14.429718] twl: Write failed (mod 21, reg 0x74 count 1)
[   15.445312] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   15.445343] twl: Write failed (mod 21, reg 0x75 count 1)
[   16.460937] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   16.460968] twl: Write failed (mod 20, reg 0x0e count 1)
[   17.476562] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   17.476593] twl: Write failed (mod 19, reg 0x01 count 1)
[   17.476623] twl4030: twl4030_sih_bus_sync_unlock, write --> -110
[   18.492187] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   18.492218] twl: Read failed (mod 19, reg 0x05 count 2)
[   18.492248] twl4030: twl4030_sih_bus_sync_unlock, read --> -110
[   19.507812] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   19.507843] twl: Read failed (mod 20, reg 0x0f count 1)
[   19.507904] twl4030_usb twl4030_usb: USB link status err -110
[   19.507965] twl4030_usb twl4030_usb: Initialized TWL4030 USB module
[   20.523437] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   20.523498] twl: Read failed (mod 21, reg 0x2f count 1)
[   21.539062] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   21.539093] twl: Write failed (mod 21, reg 0x32 count 1)
[   21.539123] VPLL: failed to apply 1800000uV constraint
[   21.539459] twl_reg twl_reg.4: can't register VPLL1, -110
[   21.539520] twl_reg: probe of twl_reg.4 failed with error -110
[   22.554687] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   22.554748] twl: Read failed (mod 21, reg 0x4b count 1)
[   22.554779] VIO: failed to enable
[   22.555053] twl_reg twl_reg.2: can't register VIO, -110
[   22.555114] twl_reg: probe of twl_reg.2 failed with error -110
[   22.555755] vdd_mpu_iva: 600 <--> 1450 mV normal 
[   23.570312] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   23.570343] twl: Write failed (mod 21, reg 0x57 count 1)
[   23.571014] vdd_core: 600 <--> 1450 mV normal 
[   24.585937] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   24.585968] twl: Write failed (mod 21, reg 0x65 count 1)
[   25.601562] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   25.601623] twl: Read failed (mod 21, reg 0x2a count 1)
[   25.601654] VMMC1: 1850 <--> 3150 mV normal standby
[   26.617187] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   26.617218] twl: Read failed (mod 21, reg 0x2a count 1)
[   27.632812] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   27.632843] twl: Write failed (mod 21, reg 0x29 count 1)
[   28.648437] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   28.648468] twl: Read failed (mod 21, reg 0x3b count 1)
[   29.664062] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   29.664093] twl: Write failed (mod 21, reg 0x3e count 1)
[   29.664123] VDAC: failed to apply 1800000uV constraint
[   29.664428] twl_reg twl_reg.3: can't register VDAC, -110
[   29.664489] twl_reg: probe of twl_reg.3 failed with error -110
[   29.665130] VCSI: 1800 mV normal standby
[   30.679687] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   30.679718] twl: Read failed (mod 21, reg 0x1e count 1)
[   31.695312] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   31.695343] twl: Write failed (mod 21, reg 0x1d count 1)
[   32.710937] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   32.710998] twl: Read failed (mod 21, reg 0x3f count 1)
[   32.711029] VINTANA1: failed to enable
[   32.711303] twl_reg twl_reg.14: can't register VINTANA1, -110
[   32.711364] twl_reg: probe of twl_reg.14 failed with error -110
[   33.726562] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   33.726623] twl: Read failed (mod 21, reg 0x43 count 1)
[   34.742187] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   34.742218] twl: Write failed (mod 21, reg 0x46 count 1)
[   34.742248] VINTANA2: failed to apply 2750000uV constraint
[   34.742553] twl_reg twl_reg.15: can't register VINTANA2, -110
[   34.742614] twl_reg: probe of twl_reg.15 failed with error -110
[   35.757812] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   35.757843] twl: Read failed (mod 21, reg 0x47 count 1)
[   35.757873] VINTDIG: failed to enable
[   35.758178] twl_reg twl_reg.16: can't register VINTDIG, -110
[   35.758209] twl_reg: probe of twl_reg.16 failed with error -110
[   36.773437] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   36.773468] twl: Read failed (mod 21, reg 0x33 count 1)
[   37.789062] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   37.789093] twl: Write failed (mod 21, reg 0x36 count 1)
[   37.789123] VSDI_CSI: failed to apply 1800000uV constraint
[   37.789428] twl_reg twl_reg.5: can't register VPLL2, -110
[   37.789459] twl_reg: probe of twl_reg.5 failed with error -110
[   38.804687] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   38.804718] twl: Read failed (mod 21, reg 0x2b count 1)
[   38.804748] V28_A: failed to enable
[   38.805053] twl_reg twl_reg.7: can't register VMMC2, -110
[   38.805084] twl_reg: probe of twl_reg.7 failed with error -110
[   39.820312] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   39.820343] twl: Read failed (mod 21, reg 0x37 count 1)
[   40.835937] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   40.835968] twl: Write failed (mod 21, reg 0x3a count 1)
[   40.835998] VMMC2_IO_18: failed to apply 1800000uV constraint
[   40.836303] twl_reg twl_reg.8: can't register VSIM, -110
[   40.836364] twl_reg: probe of twl_reg.8 failed with error -110
[   41.851562] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   41.851623] twl: Read failed (mod 21, reg 0x17 count 1)
[   41.851623] V28: failed to enable
[   41.851928] twl_reg twl_reg.9: can't register VAUX1, -110
[   41.851959] twl_reg: probe of twl_reg.9 failed with error -110
[   42.867187] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   42.867218] twl: Read failed (mod 21, reg 0x22 count 1)
[   42.867279] VMMC2_30: 2800 <--> 3000 mV normal standby
[   43.882812] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   43.882843] twl: Read failed (mod 21, reg 0x22 count 1)
[   44.898437] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   44.898468] twl: Write failed (mod 21, reg 0x21 count 1)
[   45.914062] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   45.914123] twl: Read failed (mod 21, reg 0x23 count 1)
[   46.929687] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   46.929718] twl: Write failed (mod 21, reg 0x26 count 1)
[   46.929748] VCAM_ANA_28: failed to apply 2800000uV constraint
[   46.930053] twl_reg twl_reg.13: can't register VAUX4, -110
[   46.930114] twl_reg: probe of twl_reg.13 failed with error -110
[   46.930175] omap_i2c omap_i2c.1: bus 1 rev3.3 at 2200 kHz
[   46.932159] omap_i2c omap_i2c.2: bus 2 rev3.3 at 100 kHz
[   46.932830] omap_i2c omap_i2c.3: bus 3 rev3.3 at 400 kHz
[   46.935821] Switching to clocksource 32k_counter
[   46.962829] NET: Registered protocol family 2
[   46.963562] TCP established hash table entries: 2048 (order: 2, 16384 bytes)
[   46.963684] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[   46.963745] TCP: Hash tables configured (established 2048 bind 2048)
[   46.963897] TCP: reno registered
[   46.963958] UDP hash table entries: 256 (order: 0, 4096 bytes)
[   46.963989] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[   47.036743] CPU PMU: probing PMU on CPU 0
[   47.036804] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, 5 counters available
[   47.399627] msgmni has been set to 480
[   47.408660] io scheduler noop registered
[   47.409759] io scheduler cfq registered (default)
[   47.435668] OMAP DSS rev 2.0
[   47.446533] omapdss SDI error: can't get VDDS_SDI regulator
[   47.446624] omapdss SDI error: device lcd init failed: -517
[   47.457244] omapdss VENC error: can't get VDDA_DAC regulator
[   47.457305] omapdss VENC error: device tv init failed: -517
[   47.477661] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   47.513946] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq = 88) is a OMAP UART0
[   47.519775] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq = 89) is a OMAP UART1
[   47.525665] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq = 90) is a OMAP UART2
[   48.804534] console [ttyO2] enabled
[   48.844818] mtdoops: mtd device (mtddev=name/number) must be supplied
[   48.861083] OneNAND driver initializing
[   48.865600] omap2-onenand omap2-onenand: initializing on CS0, phys base 0x04000000, virtual base d0880000, freq 66 MHz
[   48.876953] Muxed OneNAND 256MB 1.8V 16-bit (0x40)
[   48.882049] OneNAND version = 0x0121
[   48.887603] Scanning device for bad blocks
[   48.970550] OneNAND eraseblock 1229 is an initial bad block
[   49.033142] Creating 6 MTD partitions on "omap2-onenand":
[   49.039001] 0x000000000000-0x000000020000 : "bootloader"
[   49.061614] 0x000000020000-0x000000080000 : "config"
[   49.087982] 0x000000080000-0x0000000c0000 : "log"
[   49.114257] 0x0000000c0000-0x0000002c0000 : "kernel"
[   49.140106] 0x0000002c0000-0x0000004c0000 : "initfs"
[   49.167175] 0x0000004c0000-0x000010000000 : "rootfs"
[   49.209228] omap-dma-engine omap-dma-engine: allocating channel for 40
[   49.216247] omap-dma-engine omap-dma-engine: allocating channel for 39
[   49.228393] omap-dma-engine omap-dma-engine: allocating channel for 36
[   49.235382] omap-dma-engine omap-dma-engine: allocating channel for 35
[   49.263488] omap-dma-engine omap-dma-engine: allocating channel for 71
[   49.270507] omap-dma-engine omap-dma-engine: allocating channel for 70
[   49.283508] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
[   49.315521] mousedev: PS/2 mouse device common for all mice
[   49.332122] input: TWL4030 Keypad as /devices/platform/omap_i2c.1/i2c-1/1-004a/twl4030_keypad/input/input0
[   49.369415] input: TSC2005 touchscreen as /devices/platform/omap2_mcspi.1/spi_master/spi1/spi1.0/input/input1

My test defconfig (cp to .config && make oldnoconfig):

CONFIG_EXPERIMENTAL=y
CONFIG_LOCALVERSION="-n9xx"
CONFIG_KERNEL_LZMA=y
CONFIG_SYSVIPC=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_BLK_DEV_INITRD=y
# CONFIG_RD_GZIP is not set
CONFIG_EXPERT=y
CONFIG_KALLSYMS_ALL=y
CONFIG_PROFILING=y
CONFIG_OPROFILE=y
CONFIG_KPROBES=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_BLK_DEV_BSG is not set
CONFIG_PARTITION_ADVANCED=y
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_ARCH_OMAP=y
CONFIG_OMAP_RESET_CLOCKS=y
CONFIG_OMAP_MUX_DEBUG=y
# CONFIG_MACH_OMAP_GENERIC is not set
# CONFIG_ARCH_OMAP2 is not set
# CONFIG_ARCH_OMAP4 is not set
# CONFIG_SOC_TI81XX is not set
# CONFIG_SOC_AM33XX is not set
# CONFIG_MACH_OMAP3_BEAGLE is not set
# CONFIG_MACH_DEVKIT8000 is not set
# CONFIG_MACH_OMAP_LDP is not set
# CONFIG_MACH_OMAP3530_LV_SOM is not set
# CONFIG_MACH_OMAP3_TORPEDO is not set
# CONFIG_MACH_OVERO is not set
# CONFIG_MACH_OMAP3EVM is not set
# CONFIG_MACH_OMAP3517EVM is not set
# CONFIG_MACH_OMAP3_PANDORA is not set
# CONFIG_MACH_OMAP_3430SDP is not set
# CONFIG_MACH_OMAP_ZOOM2 is not set
# CONFIG_MACH_OMAP_ZOOM3 is not set
# CONFIG_MACH_CM_T35 is not set
# CONFIG_MACH_CM_T3517 is not set
# CONFIG_MACH_IGEP0020 is not set
# CONFIG_MACH_IGEP0030 is not set
# CONFIG_MACH_SBC3530 is not set
# CONFIG_MACH_OMAP_3630SDP is not set
CONFIG_ARM_THUMBEE=y
CONFIG_ARM_ERRATA_720789=y
CONFIG_ZBOOT_ROM_TEXT=0x0
CONFIG_ZBOOT_ROM_BSS=0x0
CONFIG_CMDLINE="console=tty console=ttyO2,115200"
CONFIG_CMDLINE_FORCE=y
CONFIG_KEXEC=y
CONFIG_BINFMT_MISC=y
CONFIG_PM_DEBUG=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_INET=y
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
# CONFIG_INET_LRO is not set
# CONFIG_INET_DIAG is not set
# CONFIG_IPV6 is not set
# CONFIG_WIRELESS is not set
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
CONFIG_MTD=y
CONFIG_MTD_CMDLINE_PARTS=y
# CONFIG_MTD_OF_PARTS is not set
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLOCK=y
CONFIG_MTD_OOPS=y
CONFIG_MTD_CFI=y
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_NAND=y
CONFIG_MTD_NAND_OMAP2=y
CONFIG_MTD_ONENAND=y
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_OMAP2=y
CONFIG_MTD_UBI=y
# CONFIG_BLK_DEV is not set
CONFIG_EEPROM_93CX6=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_SCAN_ASYNC=y
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_TWL4030=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_ADS7846=y
CONFIG_TOUCHSCREEN_TSC2005=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_TWL4030_PWRBUTTON=y
CONFIG_VT_HW_CONSOLE_BINDING=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_RSA=y
CONFIG_HW_RANDOM=y
CONFIG_I2C_CHARDEV=y
CONFIG_SPI=y
CONFIG_SPI_OMAP24XX=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_TWL4030=y
CONFIG_W1=y
CONFIG_POWER_SUPPLY=y
CONFIG_WATCHDOG=y
CONFIG_OMAP_WATCHDOG=y
CONFIG_TWL4030_WATCHDOG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TWL4030=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
CONFIG_OMAP2_DSS=y
# CONFIG_OMAP2_DSS_DPI is not set
CONFIG_OMAP2_DSS_SDI=y
CONFIG_FB_OMAP2=m
# CONFIG_FB_OMAP2_DEBUG_SUPPORT is not set
CONFIG_PANEL_ACX565AKM=m
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_LOGO_LINUX_CLUT224 is not set
CONFIG_USB=y
CONFIG_USB_DEBUG=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
CONFIG_USB_SUSPEND=y
CONFIG_USB_OTG=y
# CONFIG_USB_OTG_WHITELIST is not set
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_OMAP2PLUS=y
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_GADGET=y
CONFIG_USB_GADGET_DEBUG=y
CONFIG_USB_GADGET_DEBUG_FILES=y
CONFIG_USB_ETH=m
# CONFIG_USB_ETH_RNDIS is not set
CONFIG_TWL4030_USB=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_MMC=y
CONFIG_MMC_UNSAFE_RESUME=y
CONFIG_SDIO_UART=y
CONFIG_MMC_OMAP=y
CONFIG_MMC_OMAP_HS=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_DRV_TWL4030=y
CONFIG_DMADEVICES=y
CONFIG_DMA_OMAP=y
# CONFIG_FILE_LOCKING is not set
# CONFIG_DNOTIFY is not set
# CONFIG_INOTIFY_USER is not set
CONFIG_TMPFS=y
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_PRINTK_TIME=y
CONFIG_DEFAULT_MESSAGE_LOGLEVEL=7
CONFIG_MAGIC_SYSRQ=y
# CONFIG_SCHED_DEBUG is not set
# CONFIG_DEBUG_BUGVERBOSE is not set
CONFIG_DEBUG_INFO=y
# CONFIG_FTRACE is not set
# CONFIG_ARM_UNWIND is not set
CONFIG_DEBUG_LL=y
CONFIG_EARLY_PRINTK=y
CONFIG_CRC16=y

A.

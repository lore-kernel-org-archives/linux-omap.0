From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: 4430SDP boot failure - solved + SPI bug fix
Date: Fri, 7 Jan 2011 20:24:04 +0000
Message-ID: <20110107202404.GA2488@n2100.arm.linux.org.uk>
References: <20110106235203.GA14425@n2100.arm.linux.org.uk> <d540408e2df154cf13932e79d3a11ceb@mail.gmail.com> <20110107092800.GJ1198@n2100.arm.linux.org.uk> <86f60bc5418ca1d3e87db960e5e2c48f@mail.gmail.com> <729152acd9ee0c3e3e3cd505e84f8865@mail.gmail.com> <20110107125132.GM1198@n2100.arm.linux.org.uk> <48cbfb338be4d33a8a19e070430d015b@mail.gmail.com> <20110107142432.GO1198@n2100.arm.linux.org.uk> <c71399f20609c539b8c335344963253f@mail.gmail.com> <20110107154920.GQ1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60925 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab1AGUYS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 15:24:18 -0500
Content-Disposition: inline
In-Reply-To: <20110107154920.GQ1198@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Fri, Jan 07, 2011 at 03:49:20PM +0000, Russell King - ARM Linux wrote:
> And, with one ARM errata disabled, the kernel finally boots.  So the
> "X-Loader hangs" message means that we did something that non-secure
> mode prevented us from doing.

Here's the dmesg with as many things as I could find enabled.

Linux version 2.6.37+ (rmk@rmk-PC) (gcc version 4.3.5 (GCC) ) #67 SMP PREEMPT Fri Jan 7 19:38:30 GMT 2011
CPU: ARMv7 Processor [410fc091] revision 1 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: OMAP4430 4430SDP board
vmalloc area is too big, limiting to 864MB
Memory policy: ECC disabled, Data cache writealloc
OMAP4430 ES1.0
SRAM: Mapped pa 0x40300000 to va 0xfe400000 size: 0xe000
FIXME: omap44xx_sram_init not implemented
On node 0 totalpages: 131072
free_area_init_node: node 0, pgdat c035f540, node_mem_map c0381000
  Normal zone: 64 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 8128 pages, LIFO batch:0
  HighMem zone: 960 pages used for memmap
  HighMem zone: 121920 pages, LIFO batch:31
PERCPU: Embedded 7 pages/cpu @c0786000 s4192 r8192 d16288 u32768
pcpu-alloc: s4192 r8192 d16288 u32768 alloc=8*4096
pcpu-alloc: [0] 0 [0] 1 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: root=/dev/mmcblk0p2 ip=dhcp rw mem=512M vmalloc=1G console=ttyO2,115200n8 rootdelay=2
PID hash table entries: 128 (order: -3, 512 bytes)
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 512MB = 512MB total
Memory: 516492k/516492k available, 7796k reserved, 491520K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xc2800000 - 0xf8000000   ( 856 MB)
    lowmem  : 0xc0000000 - 0xc2000000   (  32 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)
      .init : 0xc0008000 - 0xc002f000   ( 156 kB)
      .text : 0xc002f000 - 0xc0334000   (3092 kB)
      .data : 0xc0334000 - 0xc035ff00   ( 176 kB)
SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Preemptable hierarchical RCU implementation.
	RCU-based detection of stalled CPUs is disabled.
	Verbose stalled-CPUs detection is disabled.
NR_IRQS:402
powerdomain: waited too long for powerdomain dss_pwrdm to complete transition
------------[ cut here ]------------
WARNING: at arch/arm/mach-omap2/clockdomain.c:868 omap2_clkdm_deny_idle+0x58/0xcc()
clockdomain: OMAP4 wakeup/sleep dependency support is not yet implemented
Modules linked in:
Backtrace: 
[<c003ebe0>] (dump_backtrace+0x0/0x10c) from [<c027d188>] (dump_stack+0x18/0x1c)
 r7:c0335f30 r6:c004a7f0 r5:c02f6189 r4:00000364
[<c027d170>] (dump_stack+0x0/0x1c) from [<c005d3d8>] (warn_slowpath_common+0x58/0x70)
[<c005d380>] (warn_slowpath_common+0x0/0x70) from [<c005d494>] (warn_slowpath_fmt+0x38/0x40)
 r8:c0347860 r7:c03464c4 r6:00000060 r5:c0346f4c r4:c036032c
[<c005d45c>] (warn_slowpath_fmt+0x0/0x40) from [<c004a7f0>] (omap2_clkdm_deny_idle+0x58/0xcc)
 r3:00000000 r2:c02f61c7
[<c004a798>] (omap2_clkdm_deny_idle+0x0/0xcc) from [<c004ab6c>] (clkdm_init+0x144/0x17c)
 r5:c0347860 r4:c0346f4c
[<c004aa28>] (clkdm_init+0x0/0x17c) from [<c000f170>] (omap2_init_common_hw+0x20/0xa0)
[<c000f150>] (omap2_init_common_hw+0x0/0xa0) from [<c0010aa8>] (omap_4430sdp_init_irq+0x34/0x54)
[<c0010a74>] (omap_4430sdp_init_irq+0x0/0x54) from [<c000bafc>] (init_IRQ+0x1c/0x24)
 r4:c035ff00
[<c000bae0>] (init_IRQ+0x0/0x24) from [<c0008d04>] (start_kernel+0x18c/0x2fc)
[<c0008b78>] (start_kernel+0x0/0x2fc) from [<80008038>] (0x80008038)
 r7:c0345cb4 r6:c0029120 r5:c0342bf0 r4:10c53c7d
---[ end trace 1b75b31a2719ed1c ]---
omap_hwmod: dpll_mpu_m2_ck: missing clockdomain for dpll_mpu_m2_ck.
GPMC revision 6.0
OMAP GPIO hardware version 0.1
OMAP clockevent source: GPTIMER1 at 32768 Hz
Console: colour dummy device 80x30
Calibrating delay loop... 2013.49 BogoMIPS (lpj=7864320)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
L310 cache controller enabled
l2x0: 16 ways, CACHE_ID 0x410000c2, AUX_CTRL 0x0e050000, Cache size: 524288 B
CPU1: Booted secondary processor
CPU1: Unknown IPI message 0x1
Brought up 2 CPUs
SMP: Total of 2 processors activated (4026.98 BogoMIPS).
regulator: core version 0.5
regulator: dummy: 
NET: Registered protocol family 16
OMAP DMA hardware revision 0.0
sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
bio: create slab <bio-0> at 0
i2c_omap i2c_omap.1: bus 1 rev4.0 at 400 kHz
Skipping twl internal clock init and using bootloader value (unknown osc rate)
twl6030: PIH (irq 39) chaining IRQs 368..387
regulator: VMMC: 1200 <--> 3000 mV at 3000 mV normal standby
regulator: VPP: 1800 <--> 2500 mV at 1900 mV normal standby
regulator: VUSIM: 1200 <--> 2900 mV at 1800 mV normal standby
regulator: VANA: 2100 mV normal standby
regulator: VCXIO: 1800 mV normal standby
regulator: VDAC: 1800 mV normal standby
regulator: VUSB: 3300 mV normal standby
regulator: VAUX1_6030: 1000 <--> 3000 mV at 2800 mV normal standby
regulator: VAUX2_6030: 1200 <--> 2800 mV at 1800 mV normal standby
regulator: VAUX3_6030: 1000 <--> 3000 mV at 1200 mV normal standby
i2c_omap i2c_omap.2: bus 2 rev4.0 at 400 kHz
i2c_omap i2c_omap.3: bus 3 rev4.0 at 400 kHz
i2c_omap i2c_omap.4: bus 4 rev4.0 at 400 kHz
DMA-API: preallocated 4096 debug entries
DMA-API: debugging enabled by kernel config
Switching to clocksource 32k_counter
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 1, 12288 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
UDP hash table entries: 128 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 128 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NetWinder Floating Point Emulator V0.97 (double precision)
------------[ cut here ]------------
WARNING: at arch/arm/mach-omap2/pm.c:64 _init_omap_device+0x8c/0xac()
_init_omap_device: could not find omap_hwmod for iva
Modules linked in:
Backtrace: 
[<c003ebe0>] (dump_backtrace+0x0/0x10c) from [<c027d188>] (dump_stack+0x18/0x1c)
 r7:c1829f38 r6:c0046d84 r5:c02f579e r4:00000040
[<c027d170>] (dump_stack+0x0/0x1c) from [<c005d3d8>] (warn_slowpath_common+0x58/0x70)
[<c005d380>] (warn_slowpath_common+0x0/0x70) from [<c005d494>] (warn_slowpath_fmt+0x38/0x40)
 r8:c000ffac r7:c0342bc0 r6:c03602f0 r5:c02f5825 r4:c0027b34
[<c005d45c>] (warn_slowpath_fmt+0x0/0x40) from [<c0046d84>] (_init_omap_device+0x8c/0xac)
 r3:c02818ff r2:c02f57d3
[<c0046cf8>] (_init_omap_device+0x0/0xac) from [<c000ffd0>] (omap2_common_pm_init+0x24/0x88)
 r6:c0345648 r5:c0027cf0 r4:c0027b34
[<c000ffac>] (omap2_common_pm_init+0x0/0x88) from [<c002f550>] (do_one_initcall+0xd0/0x19c)
[<c002f480>] (do_one_initcall+0x0/0x19c) from [<c000881c>] (kernel_init+0x15c/0x224)
[<c00086c0>] (kernel_init+0x0/0x224) from [<c0060ba4>] (do_exit+0x0/0x5fc)
 r8:00000000 r7:00000013 r6:c0060ba4 r5:c00086c0 r4:00000000
---[ end trace 1b75b31a2719ed1d ]---
------------[ cut here ]------------
WARNING: at arch/arm/mach-omap2/pm.c:64 _init_omap_device+0x8c/0xac()
_init_omap_device: could not find omap_hwmod for dsp
Modules linked in:
Backtrace: 
[<c003ebe0>] (dump_backtrace+0x0/0x10c) from [<c027d188>] (dump_stack+0x18/0x1c)
 r7:c1829f38 r6:c0046d84 r5:c02f579e r4:00000040
[<c027d170>] (dump_stack+0x0/0x1c) from [<c005d3d8>] (warn_slowpath_common+0x58/0x70)
[<c005d380>] (warn_slowpath_common+0x0/0x70) from [<c005d494>] (warn_slowpath_fmt+0x38/0x40)
 r8:c000ffac r7:c0342bc0 r6:c03602f8 r5:c02f3839 r4:c0027b34
[<c005d45c>] (warn_slowpath_fmt+0x0/0x40) from [<c0046d84>] (_init_omap_device+0x8c/0xac)
 r3:c02818ff r2:c02f57d3
[<c0046cf8>] (_init_omap_device+0x0/0xac) from [<c0010004>] (omap2_common_pm_init+0x58/0x88)
 r6:c0345648 r5:c0027cf0 r4:c0027b34
[<c000ffac>] (omap2_common_pm_init+0x0/0x88) from [<c002f550>] (do_one_initcall+0xd0/0x19c)
[<c002f480>] (do_one_initcall+0x0/0x19c) from [<c000881c>] (kernel_init+0x15c/0x224)
[<c00086c0>] (kernel_init+0x0/0x224) from [<c0060ba4>] (do_exit+0x0/0x5fc)
 r8:00000000 r7:00000013 r6:c0060ba4 r5:c00086c0 r4:00000000
---[ end trace 1b75b31a2719ed1e ]---
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
msgmni has been set to 48
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
omap-hsuart.0: ttyO0 at MMIO 0x4806a000 (irq = 104) is a OMAP UART0
omap-hsuart.1: ttyO1 at MMIO 0x4806c000 (irq = 105) is a OMAP UART1
omap-hsuart.2: ttyO2 at MMIO 0x48020000 (irq = 106) is a OMAP UART2
console [ttyO2] enabled
omap-hsuart.3: ttyO3 at MMIO 0x4806e000 (irq = 102) is a OMAP UART3
brd: module loaded
loop: module loaded
ks8851 spi1.0: message enable is 0
ks8851 spi1.0: eth0: revision 0, MAC ce:b7:60:a5:a7:10, IRQ 194
input: gpio-keys as /devices/platform/gpio-keys/input/input0
twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
twl_rtc twl_rtc: Power up reset detected.
twl_rtc twl_rtc: Enabling TWL-RTC.
i2c /dev entries driver
lm75 3-0048: hwmon0: sensor 'tmp105'
i2c_omap i2c_omap.1: controller timed out
i2c_omap i2c_omap.1: controller timed out
i2c_omap i2c_omap.2: controller timed out
i2c_omap i2c_omap.2: controller timed out
i2c_omap i2c_omap.2: controller timed out
i2c_omap i2c_omap.2: controller timed out
i2c_omap i2c_omap.3: controller timed out
i2c_omap i2c_omap.3: controller timed out
i2c_omap i2c_omap.3: controller timed out
i2c_omap i2c_omap.4: controller timed out
i2c_omap i2c_omap.4: controller timed out
i2c_omap i2c_omap.4: controller timed out
i2c_omap i2c_omap.4: controller timed out
Registered led device: omap4:green:debug0
Registered led device: omap4:green:debug1
Registered led device: omap4:green:debug2
Registered led device: omap4:green:debug3
Registered led device: omap4:green:debug4
Registered led device: omap4:blue:user
Registered led device: omap4:red:user
Registered led device: omap4:green:user
TCP cubic registered
NET: Registered protocol family 17
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 0
Power Management for TI OMAP4.
regulator_init_complete: incomplete constraints, leaving VAUX3_6030 on
regulator_init_complete: incomplete constraints, leaving VAUX2_6030 on
regulator_init_complete: incomplete constraints, leaving VUSB on
regulator_init_complete: incomplete constraints, leaving VDAC on
regulator_init_complete: incomplete constraints, leaving VCXIO on
regulator_init_complete: incomplete constraints, leaving VANA on
regulator_init_complete: incomplete constraints, leaving VUSIM on
regulator_init_complete: incomplete constraints, leaving VPP on
twl_rtc twl_rtc: hctosys: invalid date/time
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new high speed SD card at address 0002
mmcblk0: mmc0:0002 00000 971 MiB 
 mmcblk0: p1 p2
mmc1: new high speed MMC card at address 0001
mmcblk1: mmc1:0001 MMC32G 29.8 GiB 
 mmcblk1: p1
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 0.0.0.0, my address is 192.168.0.152
IP-Config: Complete:
     device=eth0, addr=192.168.0.152, mask=255.255.255.0, gw=192.168.0.1,
     host=192.168.0.152, domain=arm.linux.org.uk, nis-domain=(none),
     bootserver=0.0.0.0, rootserver=0.0.0.0, rootpath=
Waiting 2sec before mounting root device...
EXT3-fs: barriers not enabled
kjournald starting.  Commit interval 5 seconds
EXT3-fs (mmcblk0p2): warning: maximal mount count reached, running e2fsck is recommended
EXT3-fs (mmcblk0p2): using internal journal
EXT3-fs (mmcblk0p2): recovery complete
EXT3-fs (mmcblk0p2): mounted filesystem with writeback data mode
VFS: Mounted root (ext3 filesystem) on device 179:2.
Freeing init memory: 156K
udevd (458): /proc/458/oom_adj is deprecated, please use /proc/458/oom_score_adj instead.
udevd version 124 started
EXT3-fs (mmcblk0p2): error: unrecognized mount option "relatime" or missing value


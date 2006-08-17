From: "Anand SVR" <anand.svr@gmail.com>
Subject: modprobe omap gives segmentation fault
Date: Thu, 17 Aug 2006 14:45:47 +0530
Message-ID: <48a4d13c0608170215t70c1cee2te6b9b1d87b5924f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I am using imate-kjam and was able to boot up Linux. I am trying to
bring up Mini SD card using the latest omap driver from
http://linux-omap.bkbits.net:8080/main/src?nav=index.html.

After  modprobe mmc_core,  modprobe omap gives Segmentation Fault. The
entire dmesg dump is given below.

Can you let me know where things are going wrong ?

Anand

---------------------------------------------------------------------------------------------------------------------

Jan 1 00:00:09 uclibc syslog.info syslogd started: BusyBox v1.2.0
Jan 1 00:00:09 uclibc user.notice kernel: Kernel command line:
root=/dev/ram0 init=/linuxrc
Jan 1 00:00:09 uclibc user.warn kernel: tornado_init_irq.
Jan 1 00:00:09 uclibc user.warn kernel: Clocks: ARM_SYSST: 0x1040
DPLL_CTL: 0x2793 ARM_CKCTL: 0x6506
Jan 1 00:00:09 uclibc user.info kernel: Clocking rate
(xtal/DPLL1/MPU): 13.0/195.0/195.0 MHz
Jan 1 00:00:09 uclibc user.warn kernel: Total of 96 interrupts in 3
interrupt banks
Jan 1 00:00:09 uclibc user.info kernel: OMAP730 GPIO hardware
Jan 1 00:00:09 uclibc user.warn kernel: PID hash table entries: 512
(order: 9, 8192 bytes)
Jan 1 00:00:09 uclibc user.warn kernel: Console: colour dummy device
80x30
Jan 1 00:00:09 uclibc user.warn kernel: Dentry cache hash table
entries: 16384 (order: 4, 65536 bytes)
Jan 1 00:00:09 uclibc user.warn kernel: Inode-cache hash table
entries: 8192 (order: 3, 32768 bytes)
Jan 1 00:00:09 uclibc user.info kernel: Memory: 104MB = 104MB total
Jan 1 00:00:09 uclibc user.notice kernel: Memory: 101532KB available
(1644K code, 360K data, 88K init)
Jan 1 00:00:09 uclibc user.debug kernel: Calibrating delay loop...
89.70 BogoMIPS (lpj=448512)
Jan 1 00:00:09 uclibc user.warn kernel: Mount-cache hash table
entries: 512
Jan 1 00:00:09 uclibc user.info kernel: CPU: Testing write buffer
coherency: okJan 1 00:00:09 uclibc user.info kernel: checking if image is
initramfs...it isn't (no cpio magic); looks like an initrd
Jan 1 00:00:09 uclibc user.info kernel: Freeing initrd memory: 1710K
Jan 1 00:00:09 uclibc user.info kernel: NET: Registered protocol
family 16
Jan 1 00:00:09 uclibc user.warn kernel: Tornado init.
Jan 1 00:00:09 uclibc user.warn kernel: OMAP730 Watchdog seems to be
activated, disabling it for now.
Jan 1 00:00:09 uclibc user.warn kernel: trying to enable USB.
Jan 1 00:00:09 uclibc user.warn kernel: USB_EN to 0 after 0 tries.
Jan 1 00:00:09 uclibc user.warn kernel: MMC host reset done: remaining
tries: 100
Jan 1 00:00:09 uclibc user.info kernel: OMAP DMA hardware version 1
Jan 1 00:00:09 uclibc user.info kernel: DMA capabilities:
000c0000:00000000:01ff:003f:007f
Jan 1 00:00:09 uclibc user.warn kernel: Initializing OMAP McBSP system
Jan 1 00:00:09 uclibc user.err kernel: mcbsp: could not acquire dsp_ck
handle.
Jan 1 00:00:09 uclibc user.err kernel: omapdsp: unsupported omap
architecture.
Jan 1 00:00:09 uclibc user.warn kernel: USB: hmc 4, usb0 2 wires (dev)
Jan 1 00:00:09 uclibc user.warn kernel: NetWinder Floating Point
Emulator V0.97 (double precision)
Jan 1 00:00:09 uclibc user.info kernel: io scheduler noop registered
Jan 1 00:00:09 uclibc user.info kernel: io scheduler deadline
registered (default)
Jan 1 00:00:09 uclibc user.warn kernel: HTC Tornado Backlight driver.
Jan 1 00:00:09 uclibc user.warn kernel: VSFB Frame buffer driver for
HTC OMAP Based Phones.
Jan 1 00:00:09 uclibc user.info kernel: vsfb: framebuffer at
0x20001020, mapped to 0xc7000020, size 150k
Jan 1 00:00:09 uclibc user.warn kernel: Console: switching to colour
frame buffer device 40x29
Jan 1 00:00:09 uclibc user.info kernel: TI OMAP Watchdog Timer for
OMAP730
Jan 1 00:00:09 uclibc user.warn kernel: HTC Tornado Vibrator driver.
Jan 1 00:00:09 uclibc user.warn kernel: HTC Tornado led driver.
Jan 1 00:00:09 uclibc user.warn kernel: RAMDISK driver initialized: 1
RAM disks of 16384K size 1024 blocksize
Jan 1 00:00:09 uclibc user.info kernel: udc: OMAP UDC driver, version:
4 October 2004 (iso)
Jan 1 00:00:09 uclibc user.info kernel: udc: OMAP UDC rev 3.6
Jan 1 00:00:09 uclibc user.info kernel: udc: hmc mode 4, integrated
transceiverJan 1 00:00:09 uclibc user.info kernel: udc: fifo mode 3, 648
bytes not used
Jan 1 00:00:09 uclibc user.info kernel: usb0: Ethernet Gadget,
version: May Day 2005
Jan 1 00:00:09 uclibc user.info kernel: usb0: using omap_udc, OUT
ep2out-bulk IN ep1in-bulk STATUS ep3in-int
Jan 1 00:00:09 uclibc user.info kernel: usb0: MAC 46:73:ee:44:f4:36
Jan 1 00:00:09 uclibc user.info kernel: usb0: HOST MAC
b2:64:ad:56:e2:34
Jan 1 00:00:09 uclibc user.info kernel: mice: PS/2 mouse device common
for all mice
Jan 1 00:00:09 uclibc user.warn kernel: HTC Tornado Keypad Driver.
Jan 1 00:00:09 uclibc user.warn kernel: Using HTC Tornado keymap.
Jan 1 00:00:09 uclibc user.info kernel: input: tornado-keypad as
/class/input/input0
Jan 1 00:00:09 uclibc user.info kernel: NET: Registered protocol
family 2
Jan 1 00:00:09 uclibc user.warn kernel: IP route cache hash table
entries: 1024 (order: 0, 4096 bytes)
Jan 1 00:00:09 uclibc user.warn kernel: TCP established hash table
entries: 4096 (order: 2, 16384 bytes)
Jan 1 00:00:09 uclibc user.warn kernel: TCP bind hash table entries:
4096 (order: 2, 16384 bytes)
Jan 1 00:00:09 uclibc user.info kernel: TCP: Hash tables configured
(established 4096 bind 4096)
Jan 1 00:00:09 uclibc user.info kernel: TCP reno registered
Jan 1 00:00:09 uclibc user.info kernel: TCP bic registered
Jan 1 00:00:09 uclibc user.info kernel: NET: Registered protocol
family 1
Jan 1 00:00:09 uclibc user.info kernel: NET: Registered protocol
family 17
Jan 1 00:00:09 uclibc user.info kernel: NET: Registered protocol
family 15
Jan 1 00:00:09 uclibc user.notice kernel: RAMDISK: Compressed image
found at block 0
Jan 1 00:00:09 uclibc user.info kernel: udc: USB reset done, gadget
ether
Jan 1 00:00:09 uclibc user.info kernel: udc: USB reset done, gadget
ether
Jan 1 00:00:09 uclibc user.info kernel: udc: USB reset done, gadget
ether
Jan 1 00:00:09 uclibc user.info kernel: usb0: full speed config #1:
100 mA, Ethernet Gadget, using CDC Ethernet
Jan 1 00:00:09 uclibc user.warn kernel: VFS: Mounted root (ext2
filesystem).
Jan 1 00:00:09 uclibc user.info kernel: Freeing init memory: 88K
Jan 1 00:01:40 uclibc auth.warn portmap[708]: user rpc not found,
reverting to user bin
Jan 1 00:01:44 uclibc user.notice kernel: portmap: server localhost
not responding, timed out
Jan 1 00:01:44 uclibc user.warn kernel: RPC: failed to contact portmap
(errno -5).
Jan 1 00:03:56 uclibc user.debug kernel: mmc0: clock 0Hz busmode 1
powermode 0 cs 0 Vdd 0 width 0
Jan 1 00:03:56 uclibc user.alert kernel: Unable to handle kernel
paging request at virtual address fdfb780c
Jan 1 00:03:56 uclibc user.alert kernel: pgd = c5acc000
Jan 1 00:03:56 uclibc user.alert kernel: [fdfb780c] *pgd=00000000
Jan 1 00:03:56 uclibc user.warn kernel: Internal error: Oops: 805 [#1]
Jan 1 00:03:56 uclibc user.warn kernel: Modules linked in: omap
mmc_core
Jan 1 00:03:56 uclibc user.warn kernel: Process modprobe (pid: 728,
stack limit = 0xc5a56198)
Jan 1 00:03:56 uclibc user.warn kernel: Stack: (0xc5a57e04 to
0xc5a58000)
Jan 1 00:03:56 uclibc user.warn kernel: 7e00: c5a3ee00
c5a3eeac 00000000 00000000 00000000 c5a57e54 c5a57e28
Jan 1 00:03:56 uclibc user.warn kernel: 7e20: bf000814 bf0071a8
00000000 00000000 00000000 00000000 c5a3ee00 00000000
Jan 1 00:03:56 uclibc user.warn kernel: 7e40: c5a3ee00 c04b94c0
c5a57e6c c5a57e58 bf00181c bf0007ac c5a3ef20 c01bf4fc
Jan 1 00:03:56 uclibc user.warn kernel: 7e60: c5a57ea0 c5a57e70
bf00a3c4 bf001808 c5a3ef20 c5a57e90 c01bf504 00000000
Jan 1 00:03:56 uclibc user.warn kernel: 7e80: 00000000 bf00889c
c001ef44 c5a56000 00000000 c5a57eb0 c5a57ea4 c010bfa4
Jan 1 00:03:56 uclibc user.warn kernel: 7ea0: bf00a010 c5a57ed0
c5a57eb4 c010a1bc c010bf94 c01bf5c8 c01bf504 c010a2b0
Jan 1 00:03:56 uclibc user.warn kernel: 7ec0: bf00889c c5a57ee8
c5a57ed4 c010a330 c010a140 00000000 c5a57eec c5a57f14
Jan 1 00:03:56 uclibc user.warn kernel: 7ee0: c5a57eec c01096c8
c010a2c0 c01c98a8 c01c98a8 c01bf54c bf0088b0 bf00889c
Jan 1 00:03:56 uclibc user.warn kernel: 7f00: c01bfeac c01c97c0
c5a57f24 c5a57f18 c010a3b0 c0109688 c5a57f4c c5a57f28
Jan 1 00:03:56 uclibc user.warn kernel: 7f20: c0109c1c c010a3a0
bf00889c bf0089a0 c01bfeac 00000000 c001ef44 00000000
Jan 1 00:03:56 uclibc user.warn kernel: 7f40: c5a57f64 c5a57f50
c010a8a0 c0109bc0 c0023394 c01bfebc c5a57f74 c5a57f68
Jan 1 00:03:56 uclibc user.warn kernel: 7f60: c010c0a4 c010a818
c5a57f84 c5a57f78 bf00a48c c010c048 c5a57fa4 c5a57f88
Jan 1 00:03:56 uclibc user.warn kernel: 7f80: c005452c bf00a488
bee6fe74 00000001 00000000 00000080 00000000 c5a57fa8
Jan 1 00:03:56 uclibc user.warn kernel: 7fa0: c001eda0 c00543d4
bee6fe74 00000001 40018000 00003edc 00016128 00000000
Jan 1 00:03:56 uclibc user.warn kernel: 7fc0: bee6fe74 00000001
00000000 00000000 000160e0 000160d0 00000000 000160ec
Jan 1 00:03:56 uclibc user.warn kernel: 7fe0: 400d50f0 bee6fb20
0000a2a0 400d50fc 60000010 40018000 5cfce237 e766d124
Jan 1 00:03:56 uclibc user.warn kernel: Backtrace:
Jan 1 00:03:56 uclibc user.warn kernel: (mmc_omap_set_ios+0x0/0x128
[omap]) r8 = 00000000 r7 = 00000000 r6 = 00000000 r5 = C5A3EEAC
Jan 1 00:03:56 uclibc user.warn kernel: r4 = C5A3EE00
Jan 1 00:03:56 uclibc user.warn kernel: (mmc_power_off+0x0/0x84
[mmc_core]) r7 = C04B94C0 r6 = C5A3EE00 r5 = 00000000 r4 = C5A3EE00
Jan 1 00:03:56 uclibc user.warn kernel: (mmc_add_host+0x0/0x38
[mmc_core]) r5 = C01BF4FC r4 = C5A3EF20
Jan 1 00:03:56 uclibc user.warn kernel: (mmc_omap_probe+0x0/0x478
[omap]) (platform_drv_probe+0x0/0x24) (driver_probe_device+0x0/0xd4) r7 =
BF00889C r6 = C010A2B0 r5 = C01BF504 r4 = C01BF5C8
Jan 1 00:03:56 uclibc user.warn kernel: (__driver_attach+0x0/0xe0) r5
= C5A57EEC r4 = 00000000
Jan 1 00:03:56 uclibc user.warn kernel: (bus_for_each_dev+0x0/0x84)
r7 = C01C97C0 r6 = C01BFEAC r5 = BF00889C r4 = BF0088B0
Jan 1 00:03:56 uclibc user.warn kernel: (driver_attach+0x0/0x28)
(bus_add_driver+0x0/0x138) (driver_register+0x0/0xa8) r4 = C01BFEBC
Jan 1 00:03:56 uclibc user.warn kernel:
(platform_driver_register+0x0/0x88) (mmc_omap_init+0x0/0x1c [omap])
(sys_init_module+0x0/0x320) r7 =
00000080 r6 = 00000000 r5 = 00000001 r4 = BEE6FE74
Jan 1 00:03:56 uclibc user.warn kernel: Code: e5d73038 e5c73039
eb40a873 e597302c (e1c360bc)

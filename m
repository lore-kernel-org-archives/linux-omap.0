From: "mohammed shareef" <mdshareef@gmail.com>
Subject: Re: enabling audio on omap5912 osk
Date: Thu, 5 Jun 2008 15:35:51 +0530
Message-ID: <a1d91fa0806050305n35cf616ewa4c731e34efc4919@mail.gmail.com>
References: <a1d91fa0806050236k403bd6ax19a4d472aff46c9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:55943 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbYFEKF4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jun 2008 06:05:56 -0400
Received: by ti-out-0910.google.com with SMTP id b6so150080tic.23
        for <linux-omap@vger.kernel.org>; Thu, 05 Jun 2008 03:05:52 -0700 (PDT)
In-Reply-To: <a1d91fa0806050236k403bd6ax19a4d472aff46c9c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omap <linux-omap@vger.kernel.org>

sorry, i attached the wrong boot-up log.. here is my boot-up log after
enabling aic23 in kernel before compiling:

Linux version 2.6.18-omap1 (root@localhost.localdomain) (gcc version
3.4.1) #11 Thu Jun 5 15:25:31 IST 2008
CPU: ARM926EJ-S [41069263] revision 3 (ARMv5TEJ), cr=00053177
Machine: TI-OSK
Memory policy: ECC disabled, Data cache writeback
OMAP162123 revision 2 handled as 16xx id: 350594085990091f
SRAM: Mapped pa 0x20000000 to va 0xd0000000 size: 0x100000
CPU0: D VIVT write-back cache
CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
CPU0: D cache: 8192 bytes, associativity 4, 32 byte lines, 64 sets
Built 1 zonelists.  Total pages: 8192
Kernel command line: console=ttyS0,115200n8 noinitrd
ip=10.114.4.1:10.114.5.48:10.114.12.1:255.255.0.0:osk:eth0:off
root=/dev/nfs rw nfsroot=10.114.5.48:/data/rootfs2.6,nolock mem=32M
Clocks: ARM_SYSST: 0x1000 DPLL_CTL: 0x2833 ARM_CKCTL: 0x3000
Clocking rate (xtal/DPLL1/MPU): 12.0/192.0/192.0 MHz
Total of 128 interrupts in 4 interrupt banks
OMAP GPIO hardware version 1.0
MUX: initialized M7_1610_GPIO62
PID hash table entries: 256 (order: 8, 1024 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 32MB = 32MB total
Memory: 29748KB available (2089K code, 456K data, 112K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
MUX: initialized P20_1610_GPIO4

shareef: spi registering
OMAP DMA hardware version 1
DMA capabilities: 000c0000:00000000:01ff:003f:007f
Initializing OMAP McBSP system
omap_dsp_init() done
USB: hmc 16, usb0 2 wires
i2c_omap i2c_omap.1: bus 0 rev2.2 at 100 kHz
tps65010: version 2 May 2005
No IRQF_TRIGGER set_type function for IRQ 353 (MPUIO)
MUX: initialized N14_1610_UWIRE_CS0
MUX: initialized P15_1610_UWIRE_CS3

shareef: spi init
NET: Registered protocol family 2
IP route cache hash table entries: 256 (order: -2, 1024 bytes)
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 1024 bind 512)
TCP reno registered
Power Management for TI OMAP.
MUX: initialized T20_1610_LOW_PWR
NetWinder Floating Point Emulator V0.97 (double precision)
OMAP OCPI interconnect driver loaded
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
omapfb: configured for panel osk
omapfb: LCDC initialized
omapfb omapfb: Pixel clock divider value is obsolete.
Try to set pixel_clock to 8000 and pcd to 0 in
drivers/video/omap/lcd_osk.c and submit a patch.
MUX: initialized PWL
Console: switching to colour frame buffer device 30x40
omapfb: Framebuffer initialized. Total vram 155648 planes 1
omapfb: Pixclock 8000 kHz hfreq 20.1 kHz vfreq 63.3 Hz
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xfffb0000 (irq = 46) is a ST16654
serial8250.0: ttyS1 at MMIO 0xfffb0800 (irq = 47) is a ST16654
serial8250.0: ttyS2 at MMIO 0xfffb9800 (irq = 15) is a ST16654
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
eth0: SMC91C94 (rev 9) at c2850300 IRQ 160 [nowait]
eth0: Ethernet addr: 00:0e:99:02:0d:60
i2c /dev entries driver
Clock enabled to MCBSP1 & 3
TLV320AIC23 I2C version 1.8 (10-Feb-2006)
omapflash.0: Found 1 x16 devices at 0x0 in 16-bit bank
omapflash.0: Found 1 x16 devices at 0x1000000 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
Creating 4 MTD partitions on "omapflash.0":
0x00000000-0x00020000 : "bootloader"
0x00020000-0x00040000 : "params"
0x00040000-0x00240000 : "kernel"
0x00240000-0x02000000 : "filesystem"
TI TSC2102 driver initializing
MUX: initialized W11_1610_CF_CD1
MUX: initialized P11_1610_CF_CD2
MUX: initialized R11_1610_CF_IOIS16
MUX: initialized V10_1610_CF_IREQ
MUX: initialized W10_1610_CF_RESET
omap_cf: cs2 on irq 222
mice: PS/2 mouse device common for all mice
ts: Compaq touchscreen protocol output
OMAP Keypad Driver
input: omap-keypad as /class/input/input0

shareef: ads7846 probing
ads7846 spi2.0: touchscreen + hwmon, irq 164
input: ADS784x Touchscreen as /class/input/input1
Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22
13:55:50 2006 UTC).
audio support initialized
ALSA device list:
  #0: OSK AIC23
TCP bic registered
NET: Registered protocol family 1
Disabling unused clock "usb_dc_ck"...  done
FIXME: Clock "tc2_ck" seems unused
Disabling unused clock "tc1_ck"...  done
Skipping reset check for DSP domain clock "dsptim_ck"
Skipping reset check for DSP domain clock "dspper_ck"
eth0: link up
IP-Config: Complete:
      device=eth0, addr=10.114.4.1, mask=255.255.0.0, gw=10.114.12.1,
     host=osk, domain=, nis-domain=(none),
     bootserver=10.114.5.48, rootserver=10.114.5.48, rootpath=
Looking up port of RPC 100003/2 on 10.114.5.48
Looking up port of RPC 100005/1 on 10.114.5.48
VFS: Mounted root (nfs filesystem).
Freeing init memory: 112K
init started:  BusyBox v1.00-pre8 (2004.03.05-22:18+0000) multi-call binary

******************************************
Starting System Init for OMAP5912OSK
******************************************

Please press Enter to activate this console.

On Thu, Jun 5, 2008 at 3:06 PM, mohammed shareef <mdshareef@gmail.com> wrote:
> Hi,
>
> Am trying to run audio on my oma5912-osk.
>
> i followed the instructions given in the below link..
>
> http://oskfordummies.hp.infoseek.co.jp/howto/audio.html
>
> my .config file of the kernel looks like this (regarding audio..)
>
> #
> # Sound
> #
> CONFIG_SOUND=m
>
> #
> # Advanced Linux Sound Architecture
> #
> CONFIG_SND=m
> CONFIG_SND_TIMER=m
> CONFIG_SND_PCM=m
> # CONFIG_SND_SEQUENCER is not set
> # CONFIG_SND_MIXER_OSS is not set
> # CONFIG_SND_PCM_OSS is not set
> # CONFIG_SND_DYNAMIC_MINORS is not set
> CONFIG_SND_SUPPORT_OLD_API=y
> CONFIG_SND_VERBOSE_PROCFS=y
> CONFIG_SND_VERBOSE_PRINTK=y
> # CONFIG_SND_DEBUG is not set
>
> #
> # Generic devices
> #
> # CONFIG_SND_DUMMY is not set
> # CONFIG_SND_MTPAV is not set
>
> #
> # ALSA ARM devices
> #
> CONFIG_SND_OMAP_AIC23=m
> # CONFIG_SND_OMAP_TSC2101 is not set
> # CONFIG_SND_OMAP_TSC2102 is not set
>
> #
> # PCMCIA devices
> #
> # CONFIG_SND_VXPOCKET is not set
> # CONFIG_SND_PDAUDIOCF is not set
>
> #
> # Open Sound System
> #
> CONFIG_SOUND_PRIME=m
> # CONFIG_OSS_OBSOLETE_DRIVER is not set
> # CONFIG_SOUND_MSNDCLAS is not set
> # CONFIG_SOUND_MSNDPIN is not set
>
>
>
> i configured the kernel for aic23 codec on the osk..
> then i created the nodes..
>
> # mknod /dev/mixer c 14 0
> # mknod /dev/dsp c 14 3
>
> but when i run the audio configuration file(mentioned in the
> tutorial), the system doesnt respond at all..
>
> i dont get back the prompt after i run this file..
>
> could someone tell me whats wrong..
>
>
>
> thank you,
> regards,
> Shareef
>

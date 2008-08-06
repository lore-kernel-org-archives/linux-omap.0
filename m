From: Josh Karabin <gkarabin@vocollect.com>
Subject: Re: About to tag v2.6.26-omap1, patch queue deleted, please check
 and	repost
Date: Wed, 06 Aug 2008 17:31:13 -0400
Message-ID: <489A1821.6080300@vocollect.com>
References: <20080805143519.GS7193@atomide.com> <5A47E75E594F054BAF48C5E4FC4B92AB02569B8A85@dbde02.ent.ti.com> <489897CD.6040802@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx4.vocollect.com ([64.212.175.114]:3076 "EHLO
	mx4.vocollect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763473AbYHFVbP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 17:31:15 -0400
In-Reply-To: <489897CD.6040802@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


On an omap3evm with the defconfig, the kernel is failing to identify a=20
jffs2 filesystem.  It's booting from NFS just fine.

I had built the latest code checked into linux-omap last week - file=20
system booting had been working, IIRC.  Loading TI reference 2.6.22=20
kernel finds the file system just fine as well.  I'll begin looking int=
o=20
this next week if someone else doesn't beat me to it.


----

Texas Instruments X-Loader 1.41

Detected Samsung MuxOneNAND1G Flash

Starting OS Bootloader...





U-Boot 1.1.4 (Jun  6 2008 - 18:25:31)



OMAP3-GP rev 2, CPU-OPP2 L3-165MHz

OMAP3EVM 1.0 Version + mPOP (Boot ONND)

DRAM:  128 MB

OneNAND Manufacturer: Samsung (0xec)

Muxed OneNAND 128MB 1.8V 16-bit (0x30)

OneNAND version =3D 0x0221

Scanning device for bad blocks

num of blocks =3D 2048

In:    serial

Out:   serial

Err:   serial

Reseting CHIP... Done

LAN9x18 (0x01150002) detected.

Setting mac address: 00:50:c2:7e:86:9f

start Auto negotiation... (take ~2sec)

Auto negotiation complete, 100BaseTX, full duplex

Hit any key to stop autoboot:  0

OMAP3EVM # run boot_fs

Done

## Booting image at 80000000 ...

    Image Name:   Linux-2.6.26-omap1-04784-g040378

    Image Type:   ARM Linux Kernel Image (uncompressed)

    Data Size:    1515692 Bytes =3D  1.4 MB

    Load Address: 80008000

    Entry Point:  80008000

    Verifying Checksum ... OK

OK



Starting kernel ...



Uncompressing
Linux.............................................................
=2E.................................... done, booting the kernel.

<5>Linux version 2.6.26-omap1-04784-g040378c-dirty
(gkarabin@gkarabin-f9) (gcc v
ersion 4.2.1 (CodeSourcery Sourcery G++ Lite 2007q3-51)) #3 Tue Aug 5
14:45:54 E
DT 2008

CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=3D00c5387f

Machine: OMAP3 EVM

Memory policy: ECC disabled, Data cache writeback

<7>On node 0 totalpages: 32768

<7>  DMA zone: 256 pages used for memmap

<7>  DMA zone: 0 pages reserved

<7>  DMA zone: 32512 pages, LIFO batch:7

<7>  Normal zone: 0 pages used for memmap

<7>  Movable zone: 0 pages used for memmap

<6>OMAP3430 ES2.2

<6>SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000

CPU0: D VIPT write-through cache

CPU0: cache: 768 bytes, associativity 1, 8 byte lines, 64 sets

Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
32512
<5>Kernel command line: mem=3D128M console=3DttyS0,115200n8 noinitrd
root=3D/dev/mtdbl
ock4 rw rootfstype=3Djffs2
ip=3D10.51.0.10:10.51.0.30:10.2.8.1:255.255.252.0:omap-ev
m0:eth0:on

<6>Clocking rate (Crystal/DPLL/ARM core): 26.0/332/500 MHz

<6>GPMC revision 5.0

<6>IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts

<6>Total of 96 interrupts on 1 active controller

<6>OMAP34xx GPIO hardware version 2.5

PID hash table entries: 512 (order: 9, 2048 bytes)

Console: colour dummy device 80x30

<6>Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)

<6>Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)

<6>Memory: 128MB =3D 128MB total

<5>Memory: 126720KB available (2776K code, 230K data, 116K init)

<7>Calibrating delay loop... 498.87 BogoMIPS (lpj=3D1945600)

Mount-cache hash table entries: 512

<6>CPU: Testing write buffer coherency: ok

<6>net_namespace: 192 bytes

<6>NET: Registered protocol family 16

<4>Warning: L2 cache not enabled. Check your bootloader. L2 off results
in perfo
rmance loss

<6>OMAP DMA hardware revision 4.0

<3>USB: No board-specific platform config found

<6>i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz

<6>i2c_omap i2c_omap.2: bus 2 rev3.12 at 400 kHz

<6>i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz

<6>TWL4030: TRY attach Slave TWL4030-ID0 on Adapter OMAP I2C adapter [1=
]

<6>TWL4030: TRY attach Slave TWL4030-ID1 on Adapter OMAP I2C adapter [1=
]

<6>TWL4030: TRY attach Slave TWL4030-ID2 on Adapter OMAP I2C adapter [1=
]

<6>TWL4030: TRY attach Slave TWL4030-ID3 on Adapter OMAP I2C adapter [1=
]

<6>Initialized TWL4030 USB module

<5>SCSI subsystem initialized

<6>NET: Registered protocol family 2

<7>Switched to high resolution mode on CPU 0

<6>IP route cache hash table entries: 1024 (order: 0, 4096 bytes)

<6>TCP established hash table entries: 4096 (order: 3, 32768 bytes)

<6>TCP bind hash table entries: 4096 (order: 2, 16384 bytes)

<6>TCP: Hash tables configured (established 4096 bind 4096)

<6>TCP reno registered

<6>NET: Registered protocol family 1

<4>NetWinder Floating Point Emulator V0.97 (double precision)

<5>VFS: Disk quotas dquot_6.5.1

Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)

<6>JFFS2 version 2.2. (NAND) =EF=BF=BD=C2=A9 2001-2006 Red Hat, Inc.

<6>msgmni has been set to 247

<6>io scheduler noop registered

<6>io scheduler anticipatory registered (default)

<6>io scheduler deadline registered

<6>io scheduler cfq registered

<6>omapfb: configured for panel omap3evm

<6>omapfb: DISPC version 3.0 initialized

<6>omapfb: Framebuffer initialized. Total vram 614400 planes 1

<6>omapfb: Pixclock 24000 kHz hfreq 45.2 kHz vfreq 70.3 Hz

<6>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
enabled
<6>serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654

<6>console [ttyS0] enabled

Linux version 2.6.26-omap1-04784-g040378c-dirty (gkarabin@gkarabin-f9)
(gcc vers
ion 4.2.1 (CodeSourcery Sourcery G++ Lite 2007q3-51)) #3 Tue Aug 5
14:45:54 EDT
2008

CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=3D00c5387f

Machine: OMAP3 EVM

Memory policy: ECC disabled, Data cache writeback

OMAP3430 ES2.2

SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000

CPU0: D VIPT write-through cache

CPU0: cache: 768 bytes, associativity 1, 8 byte lines, 64 sets

Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
32512
Kernel command line: mem=3D128M console=3DttyS0,115200n8 noinitrd
root=3D/dev/mtdblock
4 rw rootfstype=3Djffs2
ip=3D10.51.0.10:10.51.0.30:10.2.8.1:255.255.252.0:omap-evm0:
eth0:on

Clocking rate (Crystal/DPLL/ARM core): 26.0/332/500 MHz

GPMC revision 5.0

IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts

Total of 96 interrupts on 1 active controller

OMAP34xx GPIO hardware version 2.5

PID hash table entries: 512 (order: 9, 2048 bytes)

Console: colour dummy device 80x30

Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)

Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)

Memory: 128MB =3D 128MB total

Memory: 126720KB available (2776K code, 230K data, 116K init)

Mount-cache hash table entries: 512

CPU: Testing write buffer coherency: ok

net_namespace: 192 bytes

NET: Registered protocol family 16

Warning: L2 cache not enabled. Check your bootloader. L2 off results in
performa
nce loss

OMAP DMA hardware revision 4.0

USB: No board-specific platform config found

i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz

i2c_omap i2c_omap.2: bus 2 rev3.12 at 400 kHz

i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz

TWL4030: TRY attach Slave TWL4030-ID0 on Adapter OMAP I2C adapter [1]

TWL4030: TRY attach Slave TWL4030-ID1 on Adapter OMAP I2C adapter [1]

TWL4030: TRY attach Slave TWL4030-ID2 on Adapter OMAP I2C adapter [1]

TWL4030: TRY attach Slave TWL4030-ID3 on Adapter OMAP I2C adapter [1]

Initialized TWL4030 USB module

SCSI subsystem initialized

NET: Registered protocol family 2

IP route cache hash table entries: 1024 (order: 0, 4096 bytes)

TCP established hash table entries: 4096 (order: 3, 32768 bytes)

TCP bind hash table entries: 4096 (order: 2, 16384 bytes)

TCP: Hash tables configured (established 4096 bind 4096)

TCP reno registered

NET: Registered protocol family 1

NetWinder Floating Point Emulator V0.97 (double precision)

VFS: Disk quotas dquot_6.5.1

Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)

JFFS2 version 2.2. (NAND) =EF=BF=BD=C2=A9 2001-2006 Red Hat, Inc.

msgmni has been set to 247

io scheduler noop registered

io scheduler anticipatory registered (default)

io scheduler deadline registered

io scheduler cfq registered

omapfb: configured for panel omap3evm

omapfb: DISPC version 3.0 initialized

omapfb: Framebuffer initialized. Total vram 614400 planes 1

omapfb: Pixclock 24000 kHz hfreq 45.2 kHz vfreq 70.3 Hz

Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enable=
d

serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654

console [ttyS0] enabled

<6>serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654

serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654

<6>serial8250.0: ttyS2 at MMIO 0x49020000 (irq =3D 74) is a ST16654

serial8250.0: ttyS2 at MMIO 0x49020000 (irq =3D 74) is a ST16654

<6>brd: module loaded

brd: module loaded

<6>loop: module loaded

loop: module loaded

eth0: LAN9115 (rev 2) at 0xc8850000 IRQ 336eth0: LAN9115 (rev 2) at
0xc8850000 I
RQ 336



eth0: Ethernet addr: eth0: Ethernet addr:
00:00:50:50:c2:c2:7e:7e:86:86:9f
9f

<7>eth0: LAN911x Internal PHY

<6>i2c /dev entries driver

i2c /dev entries driver

<6>TWL4030 GPIO Demux: IRQ Range 384 to 402, Initialization Success

TWL4030 GPIO Demux: IRQ Range 384 to 402, Initialization Success

<4>Driver 'sd' needs updating - please use bus_type methods

Driver 'sd' needs updating - please use bus_type methods

<6>OMAP2 OneNAND driver initializing

OMAP2 OneNAND driver initializing

<6>omap2-onenand omap2-onenand: initializing on CS0, phys base
0x20000000, virtu
al base c8880000

omap2-onenand omap2-onenand: initializing on CS0, phys base 0x20000000,
virtual
base c8880000

<7>OneNAND Manufacturer: Samsung (0xec)

<6>Muxed OneNAND 128MB 1.8V 16-bit (0x30)

Muxed OneNAND 128MB 1.8V 16-bit (0x30)

<6>OneNAND version =3D 0x0221

OneNAND version =3D 0x0221

<7>Chip support all block unlock

<6>Scanning device for bad blocks

Scanning device for bad blocks

<6>TCP cubic registered

TCP cubic registered

<6>NET: Registered protocol family 17

NET: Registered protocol family 17

<6>NET: Registered protocol family 15

NET: Registered protocol family 15

<6>RPC: Registered udp transport module.

RPC: Registered udp transport module.

<6>RPC: Registered tcp transport module.

RPC: Registered tcp transport module.

<3>Power Management for TI OMAP3.

Power Management for TI OMAP3.

<6>VFP support v0.3: VFP support v0.3: implementor 41 architecture 3
part 30 var
iant c rev 1

implementor 41 architecture 3 part 30 variant c rev 1

<6>eth0: link down

eth0: link down

<3>IP-Config: Gateway not on directly connected network.

IP-Config: Gateway not on directly connected network.

<5>Looking up port of RPC 100003/2 on 10.51.0.30

Looking up port of RPC 100003/2 on 10.51.0.30

<6>eth0: link up, 100Mbps, full-duplex, lpa 0x03E1

eth0: link up, 100Mbps, full-duplex, lpa 0x03E1

<5>Looking up port of RPC 100005/1 on 10.51.0.30

Looking up port of RPC 100005/1 on 10.51.0.30

<3>Root-NFS: Server returned error -13 while mounting
/tftpboot/omap-evm0
Root-NFS: Server returned error -13 while mounting /tftpboot/omap-evm0

<3>VFS: Unable to mount root fs via NFS, trying floppy.

VFS: Unable to mount root fs via NFS, trying floppy.

List of all partitions:

List of all partitions:

No filesystem could mount root, tried: No filesystem could mount root,
tried:  j
ffs2 jffs2



<0>Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(2,0
)

Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(2,0)



Dirk Behme wrote:
>=20
> Gadiyar, Anand wrote:
>>> Hi all,
>>>
>>> I've pushed all the patches I have in my omap inbox, except for
>>> the omap serial driver that I want to look more.
>>>
>>> I've tried to comment on the ones that did not get pushed, then
>>> erased everything from my omap inbox. Some drivers should get
>>> integrated via other mailing lists, and some debug patches can
>>> probably stay as debug patches, and some patches I probably
>>> have accidentally deleted :) And the PM patches I lost track of,
>>> so those should be reposted.
>>>
>>> So please check your patches, and repost your patches if something
>>> is left out. Also please check that things work for your board,
>>> let's try to tag v2.6.26-omap1 within next few days so we can
>>> move on again.
>>>
>>> Cheers,
>>>
>>> Tony
>>
>>
>> Boot tested on 3430SDP with the defconfig. Things work okay so far.
>=20
> Same with BeagleBoard.
>=20
> Dirk
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

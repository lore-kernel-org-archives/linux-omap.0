From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: 2430 minimal support patch (fix for ether nfs boot, ++)
Date: Mon, 12 Jun 2006 15:56:11 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A506200D65@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C68E62.A34C1C36"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C68E62.A34C1C36
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Looks like the gz was stripped, lets try with a dummy.

Regards,
Richard W.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Woodruff, Richard
> Sent: Monday, June 12, 2006 3:44 PM
> To: Komal Shah; linux-omap-open-source@linux.omap.com
> Subject: 2430 minimal support patch (fix for ether nfs boot, ++)
>=20
> Hello,
>=20
> I took your patch and took an hour and tweaked it a little bit so that
> Ethernet and NFS work.  Here are a couple comments on making it work.
>=20
> - the mux_config base address is so your OMAP24XX_CTRL_BASE is wrong.
It
> is at a different offset than 2420.
> 	- at any rate the pin muxing and balls don't match up so any mux
> settings are wrong. There should be 242x and 243x defines.
> 	- mcbsp had an init call which needed to be defined off.
>=20
> - Ether board chip select base was set wrongly, its CS5 not CS1.  You
> were creating a conflicting map.
>=20
> - Ether interrupt polarity was wrong, it needs to be LEVEL_LOW.
>=20
> - The patch didn't apply right off as there was a simple mismatch with
> the current clock code.  A couple bug fixes should be brought it.
>=20
> - All and all the register access method patch is pretty simple.
Still
> doesn't seem necessary, but it is not so intrusive.
>=20
> - I just applied this against the tree I have here which I tried on
2420
> a few days back, so there are a couple of other differences but I
doubt
> any of them are strictly required.
>=20
> With the modified patch I could boot from OneNAND on my 2430 up to a
> shell with NFS (OMAP=3D330/L3=3D165MHz).  Hopefully, with NFS going =
things
> will get a bit easier.  I've attached a boot log below on the sdp2430.
>=20
> Regards,
> Richard W.
>=20
> -------------------
> Texas Instruments X-Loader 1.40
> Detected Samsung MuxOneNAND1G Flash
> Starting OS Bootloader...
>=20
>=20
> U-Boot 1.1.3 (May 10 2006 - 10:53:52)
>=20
> U-Boot code: 80E80000 -> 80EA22F0  BSS: -> 80EA8494
> OMAP2430C-GP revision 1, PRCM #2
> TI 2430SDP 0.1 Version + mDDR (Boot ONND)
> RAM Configuration:
> Bank #0: 80000000 128 MB
> Bank #1: 88000000  0 kB
> Flash: 192 MB
> Muxed OneNAND 128MB 1.8V 16-bit (0x30)
> Scanning device for bad blocks
> num of blocks =3D 2048
> Bad eraseblock 169 at 0x01520000
> Bad eraseblock 876 at 0x06d80000
> In:    serial
> Out:   serial
> Err:   serial
> OMAP243X SDP # dhcp 80300000 8x/uImage-git
>=20
> *** Warning: ethaddr is not set properly, ignoring!!
> Using MAC Address 08:00:28:01:01:2D
> BOOTP broadcast 1
> *** Unhandled DHCP Option in OFFER/ACK: 43
> *** Unhandled DHCP Option in OFFER/ACK: 44
> *** Unhandled DHCP Option in OFFER/ACK: 46
> *** Unhandled DHCP Option in OFFER/ACK: 43
> *** Unhandled DHCP Option in OFFER/ACK: 44
> *** Unhandled DHCP Option in OFFER/ACK: 46
> DHCP client bound to address 128.247.77.90
> TFTP from server 128.247.77.43; our IP address is 128.247.77.90
> Filename '8x/uImage-git'.
> Load address: 0x80300000
> Loading:
> #################################################################
>=20
> #################################################################
>=20
> #################################################################
>          ###########################
> done
> Bytes transferred =3D 1133901 (114d4d hex)
> OMAP243X SDP # bootm
> ## Booting image at 80300000 ...
>    Image Name:   2430 2.6.17
>    Image Type:   ARM Linux Kernel Image (gzip compressed)
>    Data Size:    1133837 Bytes =3D  1.1 MB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>=20
> Starting kernel ...
>=20
> Linux version 2.6.17-rc5-omap1 (a0384864@dta0384864.sc.ti.com) (gcc
> version 3.4.
> 0 20040409 (CodeSourcery ARM Q1A 2004)) #1 Mon Jun 12 14:49:08 CDT
2006
> CPU: Some Random V6 Processor [4107b362] revision 2 (ARMv6TEJ)
> Machine: OMAP2430 sdp2430 board
> Memory policy: ECC disabled, Data cache writeback
> OMAP2430
> SRAM: Mapped pa 0x4020f000 to va 0xd0000000 size: 0x1000
> CPU0: D VIPT write-back cache
> CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
> CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
> Built 1 zonelists
> Kernel command line: mem=3D32M console=3DttyS0,115200n8 noinitrd
> root=3D/dev/nfs rw nf
>
sroot=3D128.247.77.43:/home/a0384864/wtbu/rootfs/mobilinux,rsize=3D1024,w=
siz
> e=3D1024,n
> olock ip=3Ddhcp
> OMAP PRCM hardware version 1.0
> Clocking rate (Crystal/DPLL/MPU): 13.0/660/330 MHz
> clock.c: Enable for dpll_ck without enable code
> IRQ: Found an INTC at 0x480fe000 (revision 3.0) with 96 interrupts
> Total of 96 interrupts on 1 active controller
> OMAP24xx GPIO hardware version 2.2
> PID hash table entries: 256 (order: 8, 1024 bytes)
> OMAP2 GP timer (HW version 1.6)
> Console: colour dummy device 80x30
> Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
> Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
> Memory: 32MB =3D 32MB total
> Memory: 29992KB available (1880K code, 454K data, 92K init)
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency: ok
> NET: Registered protocol family 16
> OMAP DMA hardware revision 3.0
> Initializing OMAP McBSP system
> omapdsp: unsupported omap architecture.
> USB: No board-specific platform config found
> NET: Registered protocol family 2
> IP route cache hash table entries: 256 (order: -2, 1024 bytes)
> TCP established hash table entries: 1024 (order: 0, 4096 bytes)
> TCP bind hash table entries: 512 (order: -1, 2048 bytes)
> TCP: Hash tables configured (established 1024 bind 512)
> TCP reno registered
> NetWinder Floating Point Emulator V0.97 (double precision)
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> Initializing Cryptographic API
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
enabled
> serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
> serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
> serial8250.0: ttyS2 at MMIO 0x4806e000 (irq =3D 74) is a ST16654
> RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
> loop: loaded (max 8 devices)
> smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
> eth0: SMC91C94 (rev 9) at c2800300 IRQ 309 [nowait]
> eth0: Ethernet addr: 08:00:28:01:01:2d
> omapflash.0: Found 1 x16 devices at 0x0 in 16-bit bank
> omapflash.0: Found 1 x16 devices at 0x2000000 in 16-bit bank
>  Intel/Sharp Extended Query Table at 0x010A
>  Intel/Sharp Extended Query Table at 0x010A
>  Intel/Sharp Extended Query Table at 0x010A
>  Intel/Sharp Extended Query Table at 0x010A
>  Intel/Sharp Extended Query Table at 0x010A
>  Intel/Sharp Extended Query Table at 0x010A
> Using buffer write method
> cfi_cmdset_0001: Erase suspend on write enabled
> Creating 4 MTD partitions on "omapflash.0":
> 0x00000000-0x00040000 : "bootloader"
> 0x00040000-0x00060000 : "params"
> 0x00060000-0x00260000 : "kernel"
> 0x00260000-0x04000000 : "filesystem"
> TCP bic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> VFP support v0.3: implementor 41 architecture 1 part 20 variant b rev
2
> eth0: link up
> Sending DHCP requests ., OK
> IP-Config: Got DHCP answer from 255.255.255.255, my address is
> 128.247.77.90
> IP-Config: Complete:
>       device=3Deth0, addr=3D128.247.77.90, mask=3D255.255.254.0,
> gw=3D128.247.76.1,
>      host=3D128.247.77.90, domain=3Dsc.ti.com, nis-domain=3D(none),
>      bootserver=3D255.255.255.255, rootserver=3D128.247.77.43, =
rootpath=3D
> Looking up port of RPC 100003/2 on 128.247.77.43
> Looking up port of RPC 100005/1 on 128.247.77.43
> VFS: Mounted root (nfs filesystem).
> Freeing init memory: 92K
> INIT: version 2.85 booting
> Mounting a tmpfs over /dev...done.
> Creating initial device nodes...done.
> Activating swap...done.
> Remounting root filesystem...done.
> Calculating module dependencies
> WARNING: Couldn't open directory /lib/modules/2.6.17-rc5-omap1: No
such
> file or
> directory
> FATAL: Could not open /lib/modules/2.6.17-rc5-omap1/modules.dep.temp
for
> writing
> : No such file or directory
> Loading modules:
> Checking all file systems: fsck
> fsck 1.35 (28-Feb-2004)
> /etc/init.d/rcS: line 57:   291 Segmentation fault      ( trap - INT
> QUIT TSTP;
> set start; . $i )
> Mounting local filesystems: mount nothing was mounted
> Cleaning: /etc/network/ifstate.
> Setting up IP spoofing protection: rp_filter.
> Disable TCP/IP Explicit Congestion Notification: done.
> Starting network interfaces: done.
> Starting hotplug subsystem:
>    pci
>    pci      [success]
>    usb
>    usb      [success]
>    isapnp
>    isapnp   [success]
>    ide
>    ide      [success]
>    input
>    input    [success]
>    scsi
>    scsi     [success]
> done.
> Starting portmap daemon: portmap.
> /etc/init.d/rcS: line 57:   370 Segmentation fault      ( trap - INT
> QUIT TSTP;
> set start; . $i )
> INIT: Entering runlevel: 3  3
> Starting NFS common utilities: statd lockdlockdsvc: Function not
> implemented
>  failed (1: ).
> Starting internet superserver: inetd.
> Starting MontaVista target tools daemon: mvltdmvltd version 2.1
> MontaVista Softw
> are,Inc.
> mvltd[398]: started on port 34577
> .
> Mobilinux(TM) 4.0
>=20
> 128.247.77.90 login: root
> Last login: Thu Jan  1 00:00:31 1970 on console
> Linux 128.247.77.90 2.6.10_mobilinux410 #2 Fri Jun 9 19:07:17 CDT 2006
> armv6l GN
> U/Linux
>=20
> Mobilinux(TM) 4.0
>=20
> root@128.247.77.90:~# uname -a
> Linux 128.247.77.90 2.6.17-rc5-omap1 #1 Mon Jun 12 14:49:08 CDT 2006
> armv6l GNU/
> Linux
> root@128.247.77.90:~# cat /proc/interrupts
>            CPU0
>  12:          0   DMA
>  38:       3772   gp timer
>  72:        218   serial
> 309:      13406   eth0
> Err:          0
> root@128.247.77.90:~# cat /proc/cpuinfo
> Processor       : Some Random V6 Processor rev 2 (v6l)
> BogoMIPS        : 329.31
> Features        : swp half thumb fastmult vfp edsp java
> CPU implementer : 0x41
> CPU architecture: 6TEJ
> CPU variant     : 0x0
> CPU part        : 0xb36
> CPU revision    : 2
> Cache type      : write-back
> Cache clean     : cp15 c7 ops
> Cache lockdown  : format C
> Cache format    : Harvard
> I size          : 32768
> I assoc         : 4
> I line length   : 32
> I sets          : 256
> D size          : 32768
> D assoc         : 4
> D line length   : 32
> D sets          : 256
>=20
> Hardware        : OMAP2430 sdp2430 board
> Revision        : 24300024
> Serial          : 0000000000000000
> root@128.247.77.90:~#
>=20
> > -----Original Message-----
> > From: linux-omap-open-source-bounces@linux.omap.com
> [mailto:linux-omap-
> > open-source-bounces@linux.omap.com] On Behalf Of Komal Shah
> > Sent: Monday, June 12, 2006 11:25 AM
> > To: linux-omap-open-source@linux.omap.com
> > Subject: [PATCH] ARM: OMAP: Add minimal OMAP2430 support V2
> >
> > Tony/Juha/Richard,
> >
> > Attached patch is re-worked with PRCM and SDRC changes
> > to prcm/sdrc_read/write_reg fashion. I have tested it on OMAP2420
> > H4 EVM. I still need to test it on SDP2430.
> >
> > - Moved prcm.c to clock.c.
> >
> > Please review.
> >
> > ---
> > [PATCH] ARM: OMAP: Add Minimal OMAP2430 support and
> > added read/write_reg functions for PRCM and SDRC.
> >
> > Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>
> >
> > --
> > http://www.fastmail.fm - Email service worth paying for. Try it for
> free


------_=_NextPart_001_01C68E62.A34C1C36
Content-Type: application/octet-stream;
	name="prcm-min2430-1206_rkw.patch.gz.dummy"
Content-Transfer-Encoding: base64
Content-Description: prcm-min2430-1206_rkw.patch.gz.dummy
Content-Disposition: attachment;
	filename="prcm-min2430-1206_rkw.patch.gz.dummy"

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

------_=_NextPart_001_01C68E62.A34C1C36
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C68E62.A34C1C36--

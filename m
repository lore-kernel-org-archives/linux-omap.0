From: Zou Tao <zoutao51@gmail.com>
Subject: omap ldp board(3430) failed to read/write NAND flash device after
 booting from nfs
Date: Tue, 05 Aug 2008 23:06:06 +0800
Message-ID: <48986C5E.7090206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:8091 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756386AbYHEPMU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 11:12:20 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2292002fkq.5
        for <linux-omap@vger.kernel.org>; Tue, 05 Aug 2008 08:12:19 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi:
I have booted the omap ldp board with nfs. I want to bootup from flash.
so I want to test if linux kernel could read/write flash device.
I used
make omap_ldp_defconfig
make uImage
to build kernel.
After kernel booting, I can't read/write flash device. Anyone has bootup
the ldp board with Flash device?


> > <6>console [ttyS2] enabled
> > Linux version 2.6.26-rc8-omap1 (ztao@ZouTao) (gcc version 4.2.3
> > (Sourcery G++ Lite 2008q1-126)) #2 Thu Jul 31 16:50:54 CST 2008
> > CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=00c5387f
> > Machine: OMAP LDP board
> > Memory policy: ECC disabled, Data cache writeback
> > OMAP3430 ES2.2
> > SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
> > CPU0: D VIPT write-through cache
> > CPU0: cache: 768 bytes, associativity 1, 8 byte lines, 64 sets
> > Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
> > 32512
> > Kernel command line: mem=128M console=ttyS2,115200n8 noinitrd
> > root=/dev/nfs rw
> > 
> nfsroot=128.247.77.91:/home/ztao/tftproot/arm-linux,nolock,tcp,rsize=4096,wsize=4096 
>
> > ip=128.247.77.90
> > Clocking rate (Crystal/DPLL/ARM core): 26.0/266/500 MHz
> > GPMC revision 5.0
> > IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
> > Total of 96 interrupts on 1 active controller
> > OMAP34xx GPIO hardware version 2.5
> > PID hash table entries: 512 (order: 9, 2048 bytes)
> > Console: colour dummy device 80x30
>   

> > omap2-nand driver initializing
> > <6>NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron NAND
> > 256MiB 1,8V 16-bit)
> > NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron NAND 256MiB
> > 1,8V 16-bit)
> > <5>Creating 6 MTD partitions on "omap2-nand.0":
> > Creating 6 MTD partitions on "omap2-nand.0":
> > <5>0x00000000-0x00080000 : "X-Loader-NAND"
> > 0x00000000-0x00080000 : "X-Loader-NAND"
> > <5>0x00080000-0x00100000 : "U-Boot-NAND"
> > 0x00080000-0x00100000 : "U-Boot-NAND"
> > <5>0x00100000-0x00140000 : "Boot Env-NAND"
> > 0x00100000-0x00140000 : "Boot Env-NAND"
> > <5>0x00140000-0x00540000 : "Kernel-NAND"
> > 0x00140000-0x00540000 : "Kernel-NAND"
> > <5>0x00540000-0x00940000 : "root file system- NAND"
> > 0x00540000-0x00940000 : "root file system- NAND"
> > <5>0x00940000-0x10000000 : "File System - NAND"
> > 0x00940000-0x10000000 : "File System - NAND"
> > <5>usbmon: debugfs is not available
> > / # dd if=/dev/mtblock4 of=test2  count=1
> > <3>end_request: I/O error, dev mtdblock4, sector 0
> > end_request: I/O error, dev mtdblock4, sector 0
> > <3>Buffer I/O error on device mtdblock4, logical block 0
> > Buffer I/O error on device mtdblock4, logical block 0
> > <3>end_request: I/O error, dev mtdblock4, sector 16
> > end_request: I/O error, dev mtdblock4, sector 16
> > <3>Buffer I/O error on device mtdblock4, logical block 2
> > Buffer I/O error on device mtdblock4, logical block 2
> > <3>end_request: I/O error, dev mtdblock4, sector 24
> > end_request: I/O error, dev mtdblock4, sector 24
> > <3>Buffer I/O error on device mtdblock4, logical block 3
> > Buffer I/O error on device mtdblock4, logical block 3
> > <3>end_request: I/O error, dev mtdblock4, sector 0
> > end_request: I/O error, dev mtdblock4, sector 0
> > <3>Buffer I/O error on device mtdblock4, logical block 0
> > Buffer I/O error on device mtdblock4, logical block 0
> > dd: /dev/mtdblock4: Input/output error
>   

> > / # / # dd if=ext2.img of=/dev/mtdblock5 count=4
> > <4>mtdblock: erase of region [0x0, 0x20000] on "File System - NAND"
> > failed
> > mtdblock: erase of region [0x0, 0x20000] on "File System - NAND" failed
> > 4+0 records in
> > 4+0 records out
> > / #
>   
I checked the schematic, the Flash type is PC28F640P30T85, it should be
Intel flash. I'm not sure if the config file using wrong flash driver.

Any suggestion will be appreciated.

Best Regards


Tao




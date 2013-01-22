From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: OMAP baseline test results for v3.8-rc4
Date: Tue, 22 Jan 2013 13:02:54 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECF3D4E@DBDE01.ent.ti.com>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
	<50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna>
	<f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
	<20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk>
	<alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
 <87sj5t61hq.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60218 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab3AVNDN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jan 2013 08:03:13 -0500
In-Reply-To: <87sj5t61hq.fsf@dell.be.48ers.dk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>, Paul Walmsley <paul@pwsan.com>
Cc: "Porter, Matt" <mporter@ti.com>, Richard Cochran <richardcochran@gmail.com>, "Menon, Nishanth" <nm@ti.com>, Mark Jackson <mpfj-list@mimc.co.uk>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

On Tue, Jan 22, 2013 at 14:25:13, Peter Korsgaard wrote:
> >>>>> "Paul" == Paul Walmsley <paul@pwsan.com> writes:
> 
>  Paul> Hi guys,
> 
>  Paul> Regarding the AM33xx test failures with appended DTBs, it would
>  Paul> be very helpful if especially the TI people could try reproducing
>  Paul> the problem.  Otherwise it's going to cause problems with merging
>  Paul> any new AM33xx patches, since I won't be able to test them
>  Paul> without additional work.  Plus, this is something that used to
>  Paul> work up until d01e4afd, so something isn't right.
> 
>  Paul> You'll need to use the bootloader that TI originally shipped with
>  Paul> the BeagleBones:
> 
>  Paul> U-Boot 2011.09-00009-gcf6e04d (Mar 08 2012 - 17:15:43)
> 
> FYI, my beaglebone came with a slightly different U-Boot:
> 
> U-Boot 2011.09-00000-gf63b270-dirty (Nov 14 2011 - 10:37:14)
> 
> But I have the same behaviour. Recent kernels work with a modern U-Boot,
> but not the original. The build I'm doing is very similar to yours:
> 
> git describe
> v3.8-rc4-71-g9a92841
> 
> make ARCH=arm CROSS_COMPILE=arm-linux- omap2plus_defconfig
> echo CONFIG_ARM_APPENDED_DTB=y >> .config
> echo CONFIG_ARM_ATAG_DTB_COMPAT=y >> .config
> yes ''| make ARCH=arm CROSS_COMPILE=arm-linux- oldconfig
> make ARCH=arm CROSS_COMPILE=arm-linux-
> cat arch/arm/boot/dts/am335x-bone.dtb >> arch/arm/boot/zImage
> make ARCH=arm CROSS_COMPILE=arm-linux- uImage
> 
> # old u-boot (ethernet not stable here, so load from sd)
> 
> U-Boot SPL 2011.09-00000-gf63b270-dirty (Nov 14 2011 - 10:37:14)
> Texas Instruments Revision detection unimplemented
> No AC power, disabling frequency switch
> OMAP SD/MMC: 0
> reading u-boot.img
> reading u-boot.img
> 
> 
> U-Boot 2011.09-00000-gf63b270-dirty (Nov 14 2011 - 10:37:14)
> 
> I2C:   ready
> DRAM:  256 MiB
> No daughter card present
> NAND:  HW ECC Hamming Code selected
> nand_get_flash_type: unknown NAND device: Manufacturer ID: 0x10, Chip ID: 0x10
> No NAND device found!!!
> 0 MiB
> MMC:   OMAP SD/MMC: 0
> *** Warning - readenv() failed, using default environment
> 
> Net:   cpsw
> Hit any key to stop autoboot:  0
> U-Boot# mmc rescan
> U-Boot# fatload mmc 0:1 0x80200000 uImage.new
> reading uImage.new
> 
> 3945127 bytes read
> U-Boot# setenv bootargs console=$console
> U-Boot# bootm 0x80200000
> ## Booting kernel from Legacy Image at 80200000 ...
>    Image Name:   Linux-3.8.0-rc4-00071-g9a92841
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    3945063 Bytes = 3.8 MiB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
> 
> Starting kernel ...
> 
> And it hangs. With a reasonably modern U-Boot it works:
> 

I just re-built U-Boot from f63b270 and the kernel from 9a92841
using commands similar to Peter's and the kernel boots for me with
the appended DTB.

(For some reason U-Boot version string doesn't have the commit id
and I can't recollect what causes this)

U-Boot SPL 2011.09 (Jan 22 2013 - 18:06:56)
Texas Instruments Revision detection unimplemented
OMAP SD/MMC: 0
reading u-boot.img
reading u-boot.img


U-Boot 2011.09 (Jan 22 2013 - 16:00:25)

I2C:   ready
DRAM:  256 MiB
WARNING: Caches not enabled
No daughter card present
NAND:  HW ECC Hamming Code selected
nand_get_flash_type: unknown NAND device: Manufacturer ID: 0x10, Chip ID: 0x10
No NAND device found!!!
0 MiB
MMC:   OMAP SD/MMC: 0
*** Warning - readenv() failed, using default environment

Net:   cpsw
Hit any key to stop autoboot:  0
U-Boot#
U-Boot#
U-Boot# setenv bootargs console=$console
U-Boot# setenv serverip 172.24.133.119
U-Boot# setenv bootfile uImage
U-Boot# dhcp 80200000
link up on port 0, speed 100, full duplex
BOOTP broadcast 1
DHCP client bound to address 172.24.190.59
Using cpsw device
TFTP from server 172.24.133.119; our IP address is 172.24.190.59; sending through gateway 172.24.188.1
Filename 'uImage'.
Load address: 0x80200000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         ###################################################
done
Bytes transferred = 3917327 (3bc60f hex)
U-Boot# bootm 0x80200000
## Booting kernel from Legacy Image at 80200000 ...
   Image Name:   Linux-3.8.0-rc4-00071-g9a92841
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3917263 Bytes = 3.7 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.8.0-rc4-00071-g9a92841 (a0393953@psplinux063) (gcc version 4.5.3 20110311 (prerelease) (GCC) ) #1 SMP Tue Jan 22 17:50:24 IST 2013
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: TI AM335x BeagleBone
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] AM335X ES1.0 (neon )
[    0.000000] PERCPU: Embedded 9 pages/cpu @c0f24000 s12992 r8192 d15680 u36864
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64768
[    0.000000] Kernel command line: console=ttyO0,115200n8
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] Memory: 255MB = 255MB total
[    0.000000] Memory: 245376k/245376k available, 16768k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc06d80d8   (6977 kB)
[    0.000000]       .init : 0xc06d9000 - 0xc072b2c0   ( 329 kB)
[    0.000000]       .data : 0xc072c000 - 0xc07bd9b8   ( 583 kB)
[    0.000000]        .bss : 0xc07bd9b8 - 0xc0d186b0   (5484 kB)
[    0.000000] Hierarchical RCU implementation.
...


Paul,

The commit-id of U-Boot that you have is not present in my local tree. Will
need to track down which tree your U-Boot came from before experimenting.

Regards,
Vaibhav

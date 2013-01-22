From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: OMAP baseline test results for v3.8-rc4
Date: Tue, 22 Jan 2013 09:55:13 +0100
Message-ID: <87sj5t61hq.fsf@dell.be.48ers.dk>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
	<50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna>
	<f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
	<20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk>
	<alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:34539 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221Ab3AVIzT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jan 2013 03:55:19 -0500
Received: by mail-wg0-f52.google.com with SMTP id 12so1939808wgh.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Jan 2013 00:55:17 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com> (Paul
	Walmsley's message of "Tue, 22 Jan 2013 02:24:44 +0000 (UTC)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Matt Porter <mporter@ti.com>, Richard Cochran <richardcochran@gmail.com>, "Menon, Nishanth" <nm@ti.com>, Mark Jackson <mpfj-list@mimc.co.uk>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

>>>>> "Paul" == Paul Walmsley <paul@pwsan.com> writes:

 Paul> Hi guys,

 Paul> Regarding the AM33xx test failures with appended DTBs, it would
 Paul> be very helpful if especially the TI people could try reproducing
 Paul> the problem.  Otherwise it's going to cause problems with merging
 Paul> any new AM33xx patches, since I won't be able to test them
 Paul> without additional work.  Plus, this is something that used to
 Paul> work up until d01e4afd, so something isn't right.

 Paul> You'll need to use the bootloader that TI originally shipped with
 Paul> the BeagleBones:

 Paul> U-Boot 2011.09-00009-gcf6e04d (Mar 08 2012 - 17:15:43)

FYI, my beaglebone came with a slightly different U-Boot:

U-Boot 2011.09-00000-gf63b270-dirty (Nov 14 2011 - 10:37:14)

But I have the same behaviour. Recent kernels work with a modern U-Boot,
but not the original. The build I'm doing is very similar to yours:

git describe
v3.8-rc4-71-g9a92841

make ARCH=arm CROSS_COMPILE=arm-linux- omap2plus_defconfig
echo CONFIG_ARM_APPENDED_DTB=y >> .config
echo CONFIG_ARM_ATAG_DTB_COMPAT=y >> .config
yes ''| make ARCH=arm CROSS_COMPILE=arm-linux- oldconfig
make ARCH=arm CROSS_COMPILE=arm-linux-
cat arch/arm/boot/dts/am335x-bone.dtb >> arch/arm/boot/zImage
make ARCH=arm CROSS_COMPILE=arm-linux- uImage

# old u-boot (ethernet not stable here, so load from sd)

U-Boot SPL 2011.09-00000-gf63b270-dirty (Nov 14 2011 - 10:37:14)
Texas Instruments Revision detection unimplemented
No AC power, disabling frequency switch
OMAP SD/MMC: 0
reading u-boot.img
reading u-boot.img


U-Boot 2011.09-00000-gf63b270-dirty (Nov 14 2011 - 10:37:14)

I2C:   ready
DRAM:  256 MiB
No daughter card present
NAND:  HW ECC Hamming Code selected
nand_get_flash_type: unknown NAND device: Manufacturer ID: 0x10, Chip ID: 0x10
No NAND device found!!!
0 MiB
MMC:   OMAP SD/MMC: 0
*** Warning - readenv() failed, using default environment

Net:   cpsw
Hit any key to stop autoboot:  0
U-Boot# mmc rescan
U-Boot# fatload mmc 0:1 0x80200000 uImage.new
reading uImage.new

3945127 bytes read
U-Boot# setenv bootargs console=$console
U-Boot# bootm 0x80200000
## Booting kernel from Legacy Image at 80200000 ...
   Image Name:   Linux-3.8.0-rc4-00071-g9a92841
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3945063 Bytes = 3.8 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

And it hangs. With a reasonably modern U-Boot it works:

U-Boot SPL 2012.10 (Oct 29 2012 - 23:39:02)
OMAP SD/MMC: 0
reading u-boot.img
reading u-boot.img


U-Boot 2012.10 (Oct 29 2012 - 23:39:02)

I2C:   ready
DRAM:  256 MiB
WARNING: Caches not enabled
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
Using default environment

Net:   cpsw
Hit any key to stop autoboot:  0
U-Boot# dhcp
link up on port 0, speed 100, full duplex
BOOTP broadcast 1
DHCP client bound to address 172.16.1.2
Using cpsw device
TFTP from server 172.16.1.1; our IP address is 172.16.1.2
Filename 'uImage'.
Load address: 0x80200000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #########
done
Bytes transferred = 3945127 (3c32a7 hex)
U-Boot# setenv bootargs console=$console
U-Boot# bootm
## Booting kernel from Legacy Image at 80200000 ...
   Image Name:   Linux-3.8.0-rc4-00071-g9a92841
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3945063 Bytes = 3.8 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.8.0-rc4-00071-g9a92841 (peko@dell) (gcc version 3
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instructie
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: TI AM335e
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] AM335X ES1.0 (neon )
...

For the failing case, __log_buf doesn't contain anything sensible so I
guess it crashes early:

grep __log_buf System.map
c07cc450 b __log_buf
U-Boot# md 807cc450
807cc450: e5749fbf ef220eff 3df957df acebffbd    ..t..."..W.=....
807cc460: 61dfffff 7e93c5ef ddbafdfd bb2ac2fd    ...a...~......*.
807cc470: 7ffffff1 f7fafd7f 717ddf7f 3feecfbc    ..........}q...?
807cc480: bddb573d beeaba9b c57f7b99 f77dfbfe    =W.......{....}.
807cc490: 6b7dde97 ebffcfaf fdf62df5 77e5f7bb    ..}k.....-.....w
807cc4a0: 5fdffdf5 7bc2d8be 7d977ddd feafafff    ..._...{.}.}....
807cc4b0: f7429df5 76e2fd6d dedffd3d cf6769ff    ..B.m..v=....ig.
807cc4c0: fb5644dd bdcf3a69 ffbfffd9 befff9ae    .DV.i:..........
807cc4d0: f7537fd7 feafe2f2 f37c7c2f fe5ffded    ..S...../||..._.
807cc4e0: d757dcff 4aefffbf f5dfdbdf febccbef    ..W....J........
807cc4f0: 0efff5fd 9effca7a f757ffff 07fffeff    ....z.....W.....
807cc500: deffd1db edbe5ef7 d5e7e579 bf63deef    .....^..y.....c.
807cc510: edbece57 7cfdebbf f5371f9e f0ffffb3    W......|..7.....
807cc520: 3fa4ffdf cae9fd66 f6f71d4f ab777d5f    ...?f...O..._}w.
807cc530: ed9df97d f7fcfeee dff7fb7c 3dbacafe    }.......|......=
807cc540: 47effd7c b9f9b78e ddc5f7b7 fe2f2bea    |..G.........+/.

Any ideas?

--
Bye, Peter Korsgaard

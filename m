From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP baseline test results for v3.7-rc3
Date: Tue, 6 Nov 2012 06:16:21 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB63609@DBDE01.ent.ti.com>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com>
 <508FB226.20604@mimc.co.uk>
 <alpine.DEB.2.00.1210301143420.12697@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EB51E84@DBDE01.ent.ti.com>
 <508FE8BA.1080404@ti.com> <50912A6F.1040501@mimc.co.uk>
 <79CD15C6BA57404B839C016229A409A83EB563F8@DBDE01.ent.ti.com>
 <5097EF44.5030706@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57666 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164Ab2KFGQa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 01:16:30 -0500
In-Reply-To: <5097EF44.5030706@mimc.co.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Nov 05, 2012 at 22:24:28, Mark Jackson wrote:
> On 31/10/12 13:57, Hiremath, Vaibhav wrote:
> > On Wed, Oct 31, 2012 at 19:11:03, Mark Jackson wrote:
> >> On 30/10/12 14:48, Vaibhav Hiremath wrote:
> >>
> >> Okay, so I'm now coming up against a brick wall regarding U-Boot.
> >>
> >> The Kernel boots fine (as per the tree + patch above) provided I build U-Boot using the
> >> v2011.09_AM335xPSP_04.06.00.06 branch from git://arago-project.org/git/projects/u-boot-am33x.git
> >>
> >> If I try the latest mainline U-Boot (or the TI branch), I just get to "Starting kernel ..." and then
> >> hangs.
> >>
> >> I'm going to raise this query on the U-Boot ML, but can you let me know which U-Boot image you're
> >> using ?
> >>
> > 
> > 
> > I am using Mainline u-boot and it works for me. Can you paste u-boot boot 
> > log and environment variable here?
> > 
> > Thanks,
> > Vaibhav
> 
> So I've now spent several days trying to fix this problem, but still no joy.
> 
> Did my previous emails give any clue as to where I'm going wrong ?
> 
> Thanks for any help you can provide.
> 

Sorry for delayed response, I was really got pulled into other things, now I 
am back.

I looked at your boot-log, didn't understand how it was booting earlier for 
you -


------------------------
mainline U-Boot boot log
------------------------
U-Boot SPL 2012.10-00434-ged296d2 (Oct 31 2012 - 14:18:50)
OMAP SD/MMC: 0
reading u-boot.img
reading u-boot.img


> ------------------------
> mainline U-Boot boot log
> ------------------------
> U-Boot SPL 2012.10-00434-ged296d2 (Oct 31 2012 - 14:18:50)
> OMAP SD/MMC: 0
> reading u-boot.img
> reading u-boot.img
> 
> 
> U-Boot 2012.10-00434-ged296d2 (Oct 31 2012 - 14:18:50)
> 
> I2C:   ready
> DRAM:  256 MiB

This is important, since u-boot relocated DTB file.

> WARNING: Caches not enabled
> MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
> Using default environment
> 
> Net:   cpsw
> Hit any key to stop autoboot:  0
> mmc0 is current device
> SD/MMC found on device 0
> reading uEnv.txt
> 29 bytes read
> Loaded environment from uEnv.txt
> Importing environment from mmc ...
> 4315695 bytes read
> Booting from mmc ...
> ## Booting kernel from Legacy Image at 80200000 ...
>    Image Name:   Linux-3.7.0-rc1-47802-ge7289dc-d
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    4308448 Bytes = 4.1 MiB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
> 

Where is your DTB? Is it appended to Kernel image?
Can you try below sequence/commands from u-boot?


mmc rescan 0
fatload mmc 0 80000000 am335x-bone.dtb
fatload mmc 0 81000000 uImage
setenv bootargs console=ttyO0,115200n8 mem=256M root=/dev/mmcblk0p2 rw noinitrd rootfstype=ext3 rootwait earlyprink=serial
sendln 'bootm 81000000 - 80000000'



To build DTB files, use "make dtbs" command on your kernel home directory.

Thanks,
Vaibhav

> Starting kernel ...
> Mark J.
> 


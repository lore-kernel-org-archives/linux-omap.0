From: Nishanth Menon <nm@ti.com>
Subject: OMAP3: Linux Without a Boot Loader?
Date: Mon, 26 Apr 2010 18:19:25 -0500
Message-ID: <4BD61F7D.3060208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55482 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622Ab0DZXT3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Apr 2010 19:19:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Greg Ungerer <gerg@snapgear.com>

Hi,
Before I start, a Disclaimer:
	This is more of a "can it be done" project, Don't do this to a 
production device and flame me.. at least not yet, IMHO ;)

In ELC2010(SFO), Greg Ungerer showed how to do a boot of kernel without 
the need for a bootloader.
	http://elinux.org/ELC_2010_Presentations
	http://elinux.org/images/7/7b/LinuxWithoutABootLoader.pdf

How does this help?
a) Use kernel as a bootloader in itself:
	http://elinux.org/images/2/2f/ELC-2010-Damm-Kexec.pdf
b) One more way to shift to using Device trees to describe connectivity 
and peripherals (Grant Likely's work)
	http://elinux.org/images/b/b6/ARM_Device_Tree_Status_Report.pdf
c) Today some features are assumed(wrongly) to be already set in the 
bootloader (such as pin muxing etc..). as a community whose code is used 
in many products, we all know the variant bootloaders folks use (some 
properitary and some community). kernel assumptions are sometimes proven 
wrong when someone tries the kernel on thier own inhouse bootloader.
d) Reduce dependency on numerous u-boot, x-loader versions.
e) many bootloaders dont have advanced support such as filesystem, usb 
host etc.. kinda a pain when you have to do things twice - do it once in 
kernel, then again for a bootloader..

Few more things I can think about, but I was interested in seeing if I 
could get it running on OMAP3..

What was done:
As a proof of concept for OMAP3 (SDP3630 with OMAP3630), I formatted a 
standard kernel build (bzImage) as I describe below and flashed it to 
nand partition 0 using mmc boot. Then switched to nand boot and I have 
kernel booting off the flash without x-loader.

Configuration header allows any image to boot off a I/O device such as 
MMC/NAND device straight into SDRAM and proceed execution. ARM kernel 
has a few additional requirements that CH is unable to cater to, 
including disabling Caches/interrupts, setting up ATAGs, r0,r1,r2 
settings with mach-id etc..

So I wrote a small code, which I called sty which setups the environment 
for the kernel piggy to start off on.. sty is something you'd put in the 
arch/arm/boot/head-xyz.S except I have kept it away from the kernel to 
allow for independent development given multiple boards out there..

to describe the board, omap-uboot-utils has a configuration file in 
configs/ which describes the machine ID, bootargs, sdrc config, dpll 
settings etc.. things like sdrc_config, mach_id etc could potentially 
change for platforms, but is mostly a copy paste from existing file..

The final image looks as follows:
	+---------------------+
	| Configuration       |
	| Header              |
	+---------------------+
	| "Sty"               |
	+---------------------+
	| kernel piggy        |
	| bzImage             |
	+---------------------+

Image creation steps:
make bzImage, copy the arch/arm/boot/zImage to required location,
./tagger -c configs/sample-3630.cfg -f zImage
./gpsign -c configs/sample-3630.cfg -f zImage.tag

I need to probably add some decent documentation around it, but please 
feel free to poke around - it is pretty simple code..

Risks:
* Nand flash is pretty notorious for generating bad blocks run time.. 
since the image written is pretty big, flash blocks in that area could 
effectively kill you boot till u reflash again..


Future work:
[3] shows how to boot from an MMC card with u-boot (and no MLO). I 
expect this to work with kernel as well..
* maybe more.. left to everyone's imagination ofcourse ;)

References:
-----------
Arm booting requirements: 
http://www.arm.linux.org.uk/developer/booting.php (or you can use the 
google's cached version while Russel gets his network back)

Logs:
[1] Flashing Steps: http://pastebin.mozilla.org/718671
[2] Power on in NAND boot log: http://pastebin.mozilla.org/718674

Kernel used: 	
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git 
(pm branch)
	Commit: 5914a1c9bd8083c65dcdaccae2c458e254573afb

Omap-uboot-utils used:
	git://github.com/nmenon/omap-u-boot-utils.git (wip-taggersty branch)
	Commit: 76a4328253fd53dbebea517f2339a7389d8242e1
	(the utlity tagger is mostly a collection of code snippets from 
u-boot.. so the licensing remains the same.. in case you are wondering.. 
;) )..

MMC boot without x-loader:
[3] 
http://omapedia.org/wiki/E-MMC_boot#You_can_boot_omap3630_without_x-loader
-- 
Regards,
Nishanth Menon

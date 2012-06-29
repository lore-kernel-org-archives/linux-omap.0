From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Current state of AM33xx patches
Date: Fri, 29 Jun 2012 17:56:03 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA5FC34@DBDE01.ent.ti.com>
References: <4FD5BA4C.9070706@gmail.com>	<4FD5FD9E.5040203@ti.com>
 <CADjby3UTVBKWRZUBRNTX9Bh4TqQJsoWQrrBxW6HuqSNZCUcvCw@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA5B7DE@DBDE01.ent.ti.com>
 <4FEDB9BD.7060405@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37847 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab2F2R4P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 13:56:15 -0400
In-Reply-To: <4FEDB9BD.7060405@mimc.co.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: Domenico Andreoli <cavokz@gmail.com>, Daniel Mack <zonque@gmail.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jun 29, 2012 at 19:50:45, Mark Jackson wrote:
> On 27/06/12 13:07, Hiremath, Vaibhav wrote:
> > 
> > Omap2plus_defconfig should work for you, you should get linux prompt with 
> > ramdisk image (which I use). Just to be more clear, and for your reference I am pasting steps which I use for testing, 
> > 
> > Build Steps:
> > ============
> >  - make ARCH=arm CROSS_COMPILE=<toolchain> distclean
> >  - make ARCH=arm CROSS_COMPILE=<toolchain> omap2plus_defconfig
> >  - Enable option CONFIG_ARM_APPENDED_DTB and CONFIG_ARM_ATAG_DTB_COMPAT
> >  - make ARCH=arm CROSS_COMPILE=<toolchain> uImage-dtb.am335x-evm
> >    (Since I am not using DT aware u-boot)
> > 
> > Use the ramdisk image to boot kernel, since we do not have support for any 
> > storage devices in the mainline.
> > 
> > U-Boot commands to boot:
> > ========================
> > setenv bootcmd 'mmc rescan 0; fatload mmc 0 81000000 uImage; fatload mmc 0 82000000 ramdisk-pm.gz; bootm 81000000'
> > setenv bootargs 'console=ttyO0,115200n8 mem=128M root=/dev/ram rw initrd=0x82000000,16MB ramdisk_size=65536 earlyprintk=serial'
> > boot
> > 
> > 
> > Hope this will help you to boot the kernel on BeagleBone.
> 
> This does appear to work using the ramdisk, but there seems to be no support for booting off MMC.
> 

This is known thing and clearly mentioned/highlighted above.

"Use the ramdisk image to boot kernel, since we do not have support for any 
storage devices in the mainline."



> Here's a section from my boot log:-
> 
> [    1.526156] omap_hsmmc mmc.18: Failed to get debounce clk
> [    1.577266] omap_hsmmc mmc.19: Failed to get debounce clk
> [    1.583961] mmc0: mmc_rescan_try_freq: trying to init card at 400000 Hz
> [    1.600184] mmc0: host doesn't support card's voltages
> [    1.605606] mmc0: error -22 whilst initialising SD card
> [    1.639743] omap_hsmmc mmc.20: Failed to get debounce clk
> [    1.646051] mmc1: mmc_rescan_try_freq: trying to init card at 400000 Hz
> [    1.694232] mmc2: mmc_rescan_try_freq: trying to init card at 400000 Hz
> 
> AFAIKT there's no direct support for the AM335x EVM or BeagleBone, and we're just running off
> existing non-specific code.
> 

What do you mean by non-specific code? 
Mainline support may or may not happens in one-shot, where you have compete 
board support in one kernel version.

> Buildroot currently references koenkooi repo[1], which has a large number of code changes to add
> proper support, and we have a nice working system running on a BeagleBone.
> 

If I understand correctly, it is based ontop of PSP release; and as I said 
before we are working on upstreaming every feature from PSP release.

> But, going back to some other previous emails in this thread, the Wiki[2] states many of the support
> required will only be put into the mainline kernel at 3.7.
> 

Yes, that's correct and that's where we are heading.

> Is this still the case ?  Or is it possible that the koenkooi code will be pushed up earlier ?

I do not track this repo/tree, so may not be right person to comment 
anything on this.


> 
> All in all, the AM335x code does seem to be very fragmented.  Is that just because these are
> non-trivial changes going in ?
> 

Not really true.

The answer is simple, if you are looking for production quality code then 
certainly you should use something based on PSP release (SDK) and if you 
want to stay close to Mainline and would like to contribute towards it, you 
have to understand the process, dependencies, development and discussions 
happening on the list.


Thanks,
Vaibahv


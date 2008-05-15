From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: N810: linux-2.6.26-rc2-omap1 with muru.com N810 patches
Date: Thu, 15 May 2008 11:14:58 -0500
Message-ID: <4530c67662adea689bad79e193a9323a@felipebalbi.com>
References: <20080515140914.GA30594@swansys>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60988 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756985AbYEOQPB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 12:15:01 -0400
In-Reply-To: <20080515140914.GA30594@swansys>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: green <greenfreedom10@gmail.com>
Cc: Linux-OMAP List <linux-omap@vger.kernel.org>



On Thu, 15 May 2008 09:09:14 -0500, green <greenfreedom10@gmail.com> wrote:
> Hello, I am trying to run Debian Sid on a Nokia N810.  I have tried
several
> 
> different kernel sources and lots of different configs without seeing
> anything 
> but the NOKIA splash screen.  Therefore, my current goal has been reduced
> to 
> simply booting a kernel and seeing some text output from it so I know it
> is at 
> least attempting to boot.  Once I've succeeded in that I'll continue
> toward my 
> ultimate goal of running Debian Sid.
> 
> I have built a Debian Sid armel chroot on the N810 and have compiled many

> kernels in the chroot.  I send the kernels to the N810 using the flasher
> (-f 
> -k $IMAGE -R).
> 
> I have used these three different kernel sources with two results.
>  maemo 2008 kernel
>   http://repository.maemo.org/pool/maemo4.0.1/free/k/kernel-source-rx-34/
>  2.6.25-omap1
>   http://www.muru.com/linux/omap/patches/patch-2.6.25-omap1.bz2
>  2.6.26-rc2-omap1 with muru.com N810 patches
>   http://source.mvista.com/git/?p=linux-omap-2.6.git
>   http://www.muru.com/linux/n8x0/n8x0-2008-05-12.tar.gz
> 
> Always, one of these two happens after I flash the compiled zImage:
>  - The NOKIA splash screen is displayed for about 20 seconds and then the
> N810 
> powers off.
>  - The splash screen is shown for <1 second and the device resets (loop);
> I 
> have to remove the battery.

flasher --enable-rd-mode --set-rd-flags=serial-console,no-lifeguard-reset
-f

> 
> I have enabled CONFIG_FRAMEBUFFER_CONSOLE and disabled 
> CONFIG_FB_OMAP_MANUAL_UPDATE.  The last config I've tried (with 
> linux-2.6.26-rc2-omap1 +N810) is attached.
> 
> I'm using gcc 4.3.0-4 and binutils 2.18.1~cvs20080103-4 in Debian Sid.
> 
> I have enable R&D mode on the N810 and disabled the lifeguard-reset flag.
> 
> One of the N810 patches from muru.com changes the N810 machine number to
> 5555; 
> I've tried both that and the 1548, on the assumption that perhaps a
> bootloader 
> update has fixed the machine number.
> 
> I've used 'make n800_defconfig' (2.6.26-rc2-omap1 +N810) and changed only
> the 
> default cmdline without success.  Also I've used 'make
> nokia_2420_defconfig' 
> with the maemo kernel.

try also
flasher --set-root-device mmc

> 
> Note that the initfs, X-Loader, NOLO secondary bootloader, and NOLO cold 
> flasher ("2nd") images are all from the 
> RX-44_2008SE_2.2007.51-3_PR_COMBINED_MR0_ARM.bin maemo FIASCO (I guess)
> image.  
> The rootfs is probably from an older one (I never updated it) but I'm
> assuming 
> that the rootfs doesn't matter anyway.
> 
> Please ask for any more information that might be helpful.
> 
> Oh, and one more question that I ought to know the answer to by now:
> Is it okay to do 'make zImage', then change the config, then 'make
zImage'
> 
> again without doing a 'make clean', so long as nothing in the source has
> been 
> changed?  That saves a lot of time.

Yes, it's ok. ;-)

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com


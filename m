From: "Anil Sasidharan" <anilvpr@gmail.com>
Subject: Re: android on omap
Date: Tue, 7 Oct 2008 10:05:38 +0530
Message-ID: <f6c5b8d90810062135r79f033d0n33c7b6e3f5caa0dd@mail.gmail.com>
References: <906b1beb-5854-44a6-8bcf-9ad9c0a22a35@d45g2000hsc.googlegroups.com>
	 <f6c5b8d90810040640y1f43ac00id1c1a674e3747564@mail.gmail.com>
	 <d340f382-935f-4ce3-8ebe-cf73d3e87a80@l64g2000hse.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:20280 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbYJGEfk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 00:35:40 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1428473wri.5
        for <linux-omap@vger.kernel.org>; Mon, 06 Oct 2008 21:35:38 -0700 (PDT)
In-Reply-To: <d340f382-935f-4ce3-8ebe-cf73d3e87a80@l64g2000hse.googlegroups.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: Anil S <anils@mistralsolutions.com>, linux-omap@vger.kernel.org

twebb,

           As far as I know Android root file system cannot reside on
jffs2 partition as jffs2 does not have support for memory mapped IO.
One workaround may be to create an EXT2 image for the Android root FS
and place it in the jffs2 partition and try mounting it as loop
device. A brief procedure can be as shown here:

1. create EXT2/EXT3 image for android root FS
2. store the image under the jffs2 partition in NAND (booting out of
NFS, mount MTD partition and place the image file)
3. Boot your device using NFS or ramdisk
4. After boot completes, mount the EXT2/EXT3 image as loop device
5. chroot into that mounted directory and run android.

NB: i've tried the above steps for an SD card formatted as FAT but
never tried this for NAND/jffs2 combination.

Warm Regards,
Anil

On Tue, Oct 7, 2008 at 3:11 AM, twebb <taliaferro62@gmail.com> wrote:
>
> > Does the root file system reside on NFS? Have you enabled "Networking" while
> > configuring the kernel?
> >
>
> Anil,
> I've now moved filesystem to target (jffs2).  Things are a little
> better, and different.  Using logcat, I'm now seeing dalvikvm errors
> and warnings as shown below.  It's particularly odd since I wasn't
> seeing this error when rootfs mounted via NFS.  Any ideas?
>
> I really appreciate your input.
>
> Thanks,
> twebb
>
> D/dalvikvm(  483): DexOpt: --- BEGIN 'core.jar' (bootstrap=1)
> ---
> E/dalvikvm(  501): unable to mmap DEX cache: Invalid
> argument
> E/dalvikvm(  501): Optimization
> failed
> D/dalvikvm(  483): DexOpt: waiting for verify+opt,
> pid=501
> W/dalvikvm(  483): DexOpt: --- END 'core.jar' --- status=0xff00,
> process failed
> E/dalvikvm(  483): Unable to extract+optimize DEX from '/system/
> framework/
> core.jar'
> D/dalvikvm(  483): Failed on '/system/framework/
> core.jar' (boot=1)
> D/dalvikvm(  483): VM cleaning
> up
> D/dalvikvm(  483): LinearAlloc 0x0 used 4100 of 4194304
> (0%)
> W/dalvikvm(  483): JNI_CreateJavaVM
> failed
> E/AndroidRuntime(  483): JNI_CreateJavaVM
> failed
>

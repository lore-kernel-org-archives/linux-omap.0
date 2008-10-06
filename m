From: "Deacon, Keith" <kdeacon@ti.com>
Subject: RE: android on omap
Date: Mon, 6 Oct 2008 18:36:19 -0500
Message-ID: <36DDB8F8BC2C8F4E98C848C74F03F883141B5408@dlee03.ent.ti.com>
References: <dbdb2ea60810030751j2cd9bb88h82b5a91eecbbaf50@mail.gmail.com>
	 <36DDB8F8BC2C8F4E98C848C74F03F88314130EAD@dlee03.ent.ti.com>
	 <dbdb2ea60810031121q4a4ee20fjbe7a2b420a3e9fea@mail.gmail.com>
	 <36DDB8F8BC2C8F4E98C848C74F03F883141311BA@dlee03.ent.ti.com>
	 <dbdb2ea60810031417o307a4e4h329da2855ea66dd0@mail.gmail.com>
	 <36DDB8F8BC2C8F4E98C848C74F03F8831413145B@dlee03.ent.ti.com>
 <dbdb2ea60810061445n532e361fj5a188e0898baca24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34202 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939AbYJFXg2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 19:36:28 -0400
In-Reply-To: <dbdb2ea60810061445n532e361fj5a188e0898baca24@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>


Haven't seen that error - sorry.

Unable to mmap stands out.  I know there was a lot of updates to the shared memory subsystem and there was some Android share memory driver introduced with the Android patch set.  Seems like it's trying to mmap some shared memory and failing.  The rest just seems to be fallout because it can't do what it wants to now.

...Kd


> -----Original Message-----
> From: twebb [mailto:taliaferro62@gmail.com]
> Sent: Monday, October 06, 2008 4:46 PM
> To: Deacon, Keith; linux-omap@vger.kernel.org Mailing List
> Subject: Re: android on omap
>
> >
> > Had problems with using NFS because Android tries to set specific
> permission and ownership of files - and has a nasty habit of testing those
> permissions frequently.  If you have any local storage options - that
> would help.  Also, check your init.rc file for things like mount trying to
> remount the filesystem readonly - Android assumes a very specific
> partition layout - which can be consolidated into one partition as long as
> init.rc is adjusted to match.
> >
>
> > Does the root file system reside on NFS? Have you enabled "Networking"
> while
> > configuring the kernel?
> >
>
> I've now moved filesystem to target (jffs2).  Things are a little
> better, and different.  Using logcat, I'm now seeing dalvikvm errors
> and warnings as shown below.  Particularly odd since I wasn't seeing
> this error when rootfs was mounted via NFS.  Any ideas?
>
> I really appreciate your input.
>
> Thanks,
> twebb
>
> D/dalvikvm(  483): DexOpt: --- BEGIN 'core.jar' (bootstrap=1) ---
> E/dalvikvm(  501): unable to mmap DEX cache: Invalid argument
> E/dalvikvm(  501): Optimization failed
> D/dalvikvm(  483): DexOpt: waiting for verify+opt, pid=501
> W/dalvikvm(  483): DexOpt: --- END 'core.jar' --- status=0xff00, process
> failed
> E/dalvikvm(  483): Unable to extract+optimize DEX from
> '/system/framework/core.jar'
> D/dalvikvm(  483): Failed on '/system/framework/core.jar' (boot=1)
> D/dalvikvm(  483): VM cleaning up
> D/dalvikvm(  483): LinearAlloc 0x0 used 4100 of 4194304 (0%)
> W/dalvikvm(  483): JNI_CreateJavaVM failed
> E/AndroidRuntime(  483): JNI_CreateJavaVM failed


From: twebb <taliaferro62@gmail.com>
Subject: Re: android on omap
Date: Mon, 6 Oct 2008 17:45:56 -0400
Message-ID: <dbdb2ea60810061445n532e361fj5a188e0898baca24@mail.gmail.com>
References: <dbdb2ea60810030751j2cd9bb88h82b5a91eecbbaf50@mail.gmail.com>
	 <36DDB8F8BC2C8F4E98C848C74F03F88314130EAD@dlee03.ent.ti.com>
	 <dbdb2ea60810031121q4a4ee20fjbe7a2b420a3e9fea@mail.gmail.com>
	 <36DDB8F8BC2C8F4E98C848C74F03F883141311BA@dlee03.ent.ti.com>
	 <dbdb2ea60810031417o307a4e4h329da2855ea66dd0@mail.gmail.com>
	 <36DDB8F8BC2C8F4E98C848C74F03F8831413145B@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:40605 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbYJFVp5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 17:45:57 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1596978wah.21
        for <linux-omap@vger.kernel.org>; Mon, 06 Oct 2008 14:45:56 -0700 (PDT)
In-Reply-To: <36DDB8F8BC2C8F4E98C848C74F03F8831413145B@dlee03.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Deacon, Keith" <kdeacon@ti.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

>
> Had problems with using NFS because Android tries to set specific permission and ownership of files - and has a nasty habit of testing those permissions frequently.  If you have any local storage options - that would help.  Also, check your init.rc file for things like mount trying to remount the filesystem readonly - Android assumes a very specific partition layout - which can be consolidated into one partition as long as init.rc is adjusted to match.
>

> Does the root file system reside on NFS? Have you enabled "Networking" while
> configuring the kernel?
>

I've now moved filesystem to target (jffs2).  Things are a little
better, and different.  Using logcat, I'm now seeing dalvikvm errors
and warnings as shown below.  Particularly odd since I wasn't seeing
this error when rootfs was mounted via NFS.  Any ideas?

I really appreciate your input.

Thanks,
twebb

D/dalvikvm(  483): DexOpt: --- BEGIN 'core.jar' (bootstrap=1) ---
E/dalvikvm(  501): unable to mmap DEX cache: Invalid argument
E/dalvikvm(  501): Optimization failed
D/dalvikvm(  483): DexOpt: waiting for verify+opt, pid=501
W/dalvikvm(  483): DexOpt: --- END 'core.jar' --- status=0xff00, process failed
E/dalvikvm(  483): Unable to extract+optimize DEX from
'/system/framework/core.jar'
D/dalvikvm(  483): Failed on '/system/framework/core.jar' (boot=1)
D/dalvikvm(  483): VM cleaning up
D/dalvikvm(  483): LinearAlloc 0x0 used 4100 of 4194304 (0%)
W/dalvikvm(  483): JNI_CreateJavaVM failed
E/AndroidRuntime(  483): JNI_CreateJavaVM failed

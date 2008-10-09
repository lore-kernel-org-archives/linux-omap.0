From: "Deacon, Keith" <kdeacon@ti.com>
Subject: RE: android on omap
Date: Thu, 9 Oct 2008 16:17:11 -0500
Message-ID: <36DDB8F8BC2C8F4E98C848C74F03F883142DA75D@dlee03.ent.ti.com>
References: <dbdb2ea60810030751j2cd9bb88h82b5a91eecbbaf50@mail.gmail.com>
	 <36DDB8F8BC2C8F4E98C848C74F03F88314130EAD@dlee03.ent.ti.com>
	 <dbdb2ea60810031121q4a4ee20fjbe7a2b420a3e9fea@mail.gmail.com>
	 <36DDB8F8BC2C8F4E98C848C74F03F883141311BA@dlee03.ent.ti.com>
	 <dbdb2ea60810031417o307a4e4h329da2855ea66dd0@mail.gmail.com>
	 <36DDB8F8BC2C8F4E98C848C74F03F8831413145B@dlee03.ent.ti.com>
	 <dbdb2ea60810061445n532e361fj5a188e0898baca24@mail.gmail.com>
	 <36DDB8F8BC2C8F4E98C848C74F03F883141B5408@dlee03.ent.ti.com>
	 <48EB5D2A.1010605@nokia.com>
 <dbdb2ea60810090808m4c867635y961c3c6e3d024929@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45624 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024AbYJIVRX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 17:17:23 -0400
In-Reply-To: <dbdb2ea60810090808m4c867635y961c3c6e3d024929@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>, Adrian Hunter <ext-adrian.hunter@nokia.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, "anilvpr@gmail.com" <anilvpr@gmail.com>, Mat Johnson <seevion@aol.com>


Ashmem is the Android shared memory subsystem.  You can find it in the kernel under mm/ashmem.c.  There is a config option to turn it on and off.  The error indicates that it's having trouble with the driver - although it's not specific as to exactly what.  Make sure it's enabled, the device is present (/dev/ashmem), etc..

...Kd


> -----Original Message-----
> From: twebb [mailto:taliaferro62@gmail.com]
> Sent: Thursday, October 09, 2008 10:09 AM
> To: Adrian Hunter
> Cc: Deacon, Keith; linux-omap@vger.kernel.org Mailing List;
> anilvpr@gmail.com; Mat Johnson
> Subject: Re: android on omap
>
> >
> > JFFS2 supports only read-only mmap.  If that is a problem, you could try
> > UBIFS.
> >
>
> Now when mounting rootfs as yaffs2, the servicemanager dies/exits
> almost immediately on android startup, and logcat output is shown
> below.  However, when mounting same rootfs via NFS, I don't see this
> problem (though I do have other issues).  Does the error
>
> E/dalvikvm-gc(  483): Could not create 176128-byte ashmem mark stack
>
> indicate a specific problem?  Might there be a way to dump more
> specific/verbose output at startup to get a better understanding of
> what's wrong?
>
> Thanks,
> twebb
>
>
> I/DEBUG   (  481): debuggerd: Aug 14 2008 18:58:32
> E/mountd  (  480): could not read initial mass storage state
> D/AndroidRuntime(  483):
> D/AndroidRuntime(  483): >>>>>>>>>>>>>> AndroidRuntime START
> <<<<<<<<<<<<<<
> D/AndroidRuntime(  483): CheckJNI is ON
> D/AndroidRuntime(  483): --- registering native functions ---
> I/Zygote  (  483): Preloading classes...
> E/dalvikvm-gc(  483): Could not create 176128-byte ashmem mark stack


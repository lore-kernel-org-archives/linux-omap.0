From: twebb <taliaferro62@gmail.com>
Subject: Re: android on omap
Date: Thu, 9 Oct 2008 11:08:44 -0400
Message-ID: <dbdb2ea60810090808m4c867635y961c3c6e3d024929@mail.gmail.com>
References: <dbdb2ea60810030751j2cd9bb88h82b5a91eecbbaf50@mail.gmail.com>
	 <36DDB8F8BC2C8F4E98C848C74F03F88314130EAD@dlee03.ent.ti.com>
	 <dbdb2ea60810031121q4a4ee20fjbe7a2b420a3e9fea@mail.gmail.com>
	 <36DDB8F8BC2C8F4E98C848C74F03F883141311BA@dlee03.ent.ti.com>
	 <dbdb2ea60810031417o307a4e4h329da2855ea66dd0@mail.gmail.com>
	 <36DDB8F8BC2C8F4E98C848C74F03F8831413145B@dlee03.ent.ti.com>
	 <dbdb2ea60810061445n532e361fj5a188e0898baca24@mail.gmail.com>
	 <36DDB8F8BC2C8F4E98C848C74F03F883141B5408@dlee03.ent.ti.com>
	 <48EB5D2A.1010605@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:5184 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717AbYJIPIp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 11:08:45 -0400
Received: by wf-out-1314.google.com with SMTP id 27so108130wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 09 Oct 2008 08:08:44 -0700 (PDT)
In-Reply-To: <48EB5D2A.1010605@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <ext-adrian.hunter@nokia.com>
Cc: "Deacon, Keith" <kdeacon@ti.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, anilvpr@gmail.com, Mat Johnson <seevion@aol.com>

>
> JFFS2 supports only read-only mmap.  If that is a problem, you could try
> UBIFS.
>

Now when mounting rootfs as yaffs2, the servicemanager dies/exits
almost immediately on android startup, and logcat output is shown
below.  However, when mounting same rootfs via NFS, I don't see this
problem (though I do have other issues).  Does the error

E/dalvikvm-gc(  483): Could not create 176128-byte ashmem mark stack

indicate a specific problem?  Might there be a way to dump more
specific/verbose output at startup to get a better understanding of
what's wrong?

Thanks,
twebb


I/DEBUG   (  481): debuggerd: Aug 14 2008 18:58:32
E/mountd  (  480): could not read initial mass storage state
D/AndroidRuntime(  483):
D/AndroidRuntime(  483): >>>>>>>>>>>>>> AndroidRuntime START <<<<<<<<<<<<<<
D/AndroidRuntime(  483): CheckJNI is ON
D/AndroidRuntime(  483): --- registering native functions ---
I/Zygote  (  483): Preloading classes...
E/dalvikvm-gc(  483): Could not create 176128-byte ashmem mark stack

From: twebb <taliaferro62@gmail.com>
Subject: Re: android on omap
Date: Thu, 9 Oct 2008 18:00:25 -0400
Message-ID: <dbdb2ea60810091500u6adf5ce9l5aee1fd885049164@mail.gmail.com>
References: <dbdb2ea60810030751j2cd9bb88h82b5a91eecbbaf50@mail.gmail.com>
	 <dbdb2ea60810031121q4a4ee20fjbe7a2b420a3e9fea@mail.gmail.com>
	 <36DDB8F8BC2C8F4E98C848C74F03F883141311BA@dlee03.ent.ti.com>
	 <dbdb2ea60810031417o307a4e4h329da2855ea66dd0@mail.gmail.com>
	 <36DDB8F8BC2C8F4E98C848C74F03F8831413145B@dlee03.ent.ti.com>
	 <dbdb2ea60810061445n532e361fj5a188e0898baca24@mail.gmail.com>
	 <36DDB8F8BC2C8F4E98C848C74F03F883141B5408@dlee03.ent.ti.com>
	 <48EB5D2A.1010605@nokia.com>
	 <dbdb2ea60810090808m4c867635y961c3c6e3d024929@mail.gmail.com>
	 <36DDB8F8BC2C8F4E98C848C74F03F883142DA75D@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:36378 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755950AbYJIWA0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 18:00:26 -0400
Received: by wa-out-1112.google.com with SMTP id v27so116772wah.21
        for <linux-omap@vger.kernel.org>; Thu, 09 Oct 2008 15:00:25 -0700 (PDT)
In-Reply-To: <36DDB8F8BC2C8F4E98C848C74F03F883142DA75D@dlee03.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Deacon, Keith" <kdeacon@ti.com>
Cc: Adrian Hunter <ext-adrian.hunter@nokia.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, "anilvpr@gmail.com" <anilvpr@gmail.com>, Mat Johnson <seevion@aol.com>

> Ashmem is the Android shared memory subsystem.  You can find it in the kernel under mm/ashmem.c.  There is a config option to turn it on and off.  The error indicates that it's having trouble with the driver - although it's not specific as to exactly what.  Make sure it's enabled, the device is present (/dev/ashmem), etc..
>
> ...Kd
>

I have ashmem properly configured and it works when the FS is mounted
via NFS.  However as pointed out previously that seemed to be causing
other issues so I moved the FS into JFFS2.  That too had it's issues
(where mmap was failing under certain conditions) that Adrian and Anil
pointed out were due to JFFS2.  So I moved it to YAFFS2.  Now I'm
seeing this "ashmem" issue.  Up to this point, ashmem has worked fine
so I don't believe it's really the culprit.  I feel like it has to do
with permissions or the filesystem.  One difference is that the
emulator uses three different yaffs2 partitions (userdata, system, and
cache) while I currently have all of these on a single partition.

Any other ideas as to what might cause the ...

E/dalvikvm-gc(  483): Could not create 176128-byte ashmem mark stack

message?

Thanks,
twebb

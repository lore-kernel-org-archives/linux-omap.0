From: twebb <taliaferro62@gmail.com>
Subject: android on omap, yaffs2 or init problem
Date: Mon, 13 Oct 2008 12:37:13 -0400
Message-ID: <dbdb2ea60810130937j28f5d13cy489330acc73dca64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:28545 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756636AbYJMQhO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Oct 2008 12:37:14 -0400
Received: by wa-out-1112.google.com with SMTP id v27so900153wah.21
        for <linux-omap@vger.kernel.org>; Mon, 13 Oct 2008 09:37:13 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>
Cc: swetland@google.com

The issue I'm running into (see further below) in trying to start
android on an OMAP is a dalvikvm-gc error during an ashmem allocation
immediately at startup.  An older posting indicates some differences
in the android init/boot model.  Can anyone expand on the android
init/boot model?

I see on the emulator that rootfs is mounted on / and is not yaffs2,
while /system, /data, and /cache are yaffs2.  I can successfully mount
the rootfs (including system, data, and cache) via yaffs2 but run into
the issue described below.  Since I've got the yaffs2 mounts OK for
system, data and cache (init.rc seems to automatically handle that)
how can I configure file system and kernel args such that linux mounts
rootfs on / like on emulator?  I feel like I'm missing something very
simple since (as described below in snippet from separate thread) I
get much further into the android startup when mounting rootfs via NFS
or JFFS2.

And, when creating the android filesystem (per elinux.org's 'android
on omap') should ramdisk.img instead be left in file form and used as
an initrd image?  I'm not very familiar with booting linux via
initrd/initramfs.

Thanks,
twebb


****** from old linux-omap post (2008-04-29) ******
[Jonathan Herriott <herriojr@gmail.com>]
> I had it confirmed in another thread that the issue is that the local
> filesystem for the N810 is jffs, which is unsupported and I need to
> install it on an mini SD card with ext2/ext3 on it.

I think what you're seeing here is the property service in init
failing to create and mmap it's arena, which it tries to do in /,
which in our world is initramfs.  The android init/boot model is a
little different in that we don't pivot over to a root filesystem,
we mount the system, data, etc partitions under the ramfs on /

You might be able to hack around this by editing the string
"/system_properties" to "/tmp/em_properties" or something like
that, assuming you have tmpfs mounted on /tmp.

Brian
******


---------- Forwarded message ----------
From: twebb <taliaferro62@gmail.com>
Date: Thu, Oct 9, 2008 at 6:00 PM
Subject: Re: android on omap
To: "Deacon, Keith" <kdeacon@ti.com>
Cc: Adrian Hunter <ext-adrian.hunter@nokia.com>,
"linux-omap@vger.kernel.org Mailing List"
<linux-omap@vger.kernel.org>, "anilvpr@gmail.com" <anilvpr@gmail.com>,
Mat Johnson <seevion@aol.com>


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

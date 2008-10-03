From: "Deacon, Keith" <kdeacon@ti.com>
Subject: RE: android on omap
Date: Fri, 3 Oct 2008 11:38:33 -0500
Message-ID: <36DDB8F8BC2C8F4E98C848C74F03F88314130EAD@dlee03.ent.ti.com>
References: <dbdb2ea60810030751j2cd9bb88h82b5a91eecbbaf50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56963 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627AbYJCQil convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 12:38:41 -0400
In-Reply-To: <dbdb2ea60810030751j2cd9bb88h82b5a91eecbbaf50@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>


There is too little information to say much.  Try running logcat (or just cat /dev/log/main) to get more info.  Since dalvik started, it probably has something to do with the input config files or runtime database.  File permissions can also be and issue.  Cleaning out the /data and /system/data directories can also help.

...Kd


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of twebb
> Sent: Friday, October 03, 2008 9:51 AM
> To: linux-omap@vger.kernel.org Mailing List
> Subject: android on omap
>
> I'm using linux-2.6.26 from the l-o git on an omap3 based target, and
> have patched it with android-0.9 patch derived as described in various
> forums about porting android to real hardware.  I'm also using the android
> filesystem and binaries as extracted from 0.9 release.  I can start target
> and
> all seems OK - to a point.  Kernel starts OK, android init starts OK,
> all processes appear to start OK.  However, when process
> 'system_server' starts, screen changes from "ANDROID_" to blank, and
> about 45-60 seconds later 'system_server' goes away and process
> 'zygote' restarts.  When started with strace, I see the error output
> below.
>
> Can anyone make any sense of this error/exception?  By the way, the
> target does not have network connectivity via USB, but does have it
> via ethernet.  Might this be an issue?
>
> Thanks,
> twebb
>
> java.lang.RuntimeException: ANDROID_SOCKET_zygote unset or invalid
>        at
> com.android.internal.os.ZygoteInit.registerZygoteSocket(ZygoteInit.java:15
> 6)
>        at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:461)
>        at dalvik.system.NativeStart.main(Native Method)
> Caused by: java.lang.NumberFormatException: unable to parse 'null' as
> integer
>        at java.lang.Integer.parseInt(Integer.java:362)
>        at java.lang.Integer.parseInt(Integer.java:341)
>        at
> com.android.internal.os.ZygoteInit.registerZygoteSocket(ZygoteInit.java:15
> 4)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


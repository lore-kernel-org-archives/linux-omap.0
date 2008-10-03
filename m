From: twebb <taliaferro62@gmail.com>
Subject: android on omap
Date: Fri, 3 Oct 2008 10:51:22 -0400
Message-ID: <dbdb2ea60810030751j2cd9bb88h82b5a91eecbbaf50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:56177 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbYJCOvX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 10:51:23 -0400
Received: by wa-out-1112.google.com with SMTP id v27so812638wah.21
        for <linux-omap@vger.kernel.org>; Fri, 03 Oct 2008 07:51:22 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

I'm using linux-2.6.26 from the l-o git on an omap3 based target, and
have patched it with android-0.9 patch derived as described in various
forums about porting android to real hardware.  I'm also using the android
filesystem and binaries as extracted from 0.9 release.  I can start target and
all seems OK - to a point.  Kernel starts OK, android init starts OK,
all processes appear to start OK.  However, when process
'system_server' starts, screen changes from "ANDROID_" to blank, and
about 45-60 seconds later 'system_server' goes away and process
'zygote' restarts.  When started with strace, I see the error output
below.

Can anyone make any sense of this error/exception?  By the way, the
target does not have network connectivity via USB, but does have it
via ethernet.  Might this be an issue?

Thanks,
twebb

java.lang.RuntimeException: ANDROID_SOCKET_zygote unset or invalid
       at com.android.internal.os.ZygoteInit.registerZygoteSocket(ZygoteInit.java:156)
       at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:461)
       at dalvik.system.NativeStart.main(Native Method)
Caused by: java.lang.NumberFormatException: unable to parse 'null' as integer
       at java.lang.Integer.parseInt(Integer.java:362)
       at java.lang.Integer.parseInt(Integer.java:341)
       at com.android.internal.os.ZygoteInit.registerZygoteSocket(ZygoteInit.java:154)

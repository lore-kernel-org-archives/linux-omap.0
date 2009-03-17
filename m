From: david.hagood@gmail.com
Subject: Getting accelerated X server running
Date: Tue, 17 Mar 2009 11:57:40 -0500 (CDT)
Message-ID: <6de78edf1444a5dafbb7f3ae453a90ef.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f122.google.com ([209.85.221.122]:54397 "EHLO
	mail-qy0-f122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbZCQQ5v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 12:57:51 -0400
Received: by qyk28 with SMTP id 28so204876qyk.33
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 09:57:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by Deathwish.hagood.sktc.net (Postfix) with ESMTP id AB499C7B8015
	for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 11:57:40 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

OK, I've managed to get the PowerVR driver compiled and loaded, created
the appropriate /dev/ entry, and now when I try to run the Xsgx as
supplied by the TI GFX SDK, I get the following:

beagleboard:/usr/X11R6_SGX# bin/Xsgx
PVR_K:(Error): BridgedDispatchKM: Driver initialisation not completed yet.
[4890, /USER/src/omap3-sgx/services4/srvkm/bridged/bridged_pvr_brid]
PVR_K:(Error): BridgedDispatchKM: Driver initialisation not completed yet.
[4890, /USER/src/omap3-sgx/services4/srvkm/bridged/bridged_pvr_brid]
sgxScreenInit: ERROR - can't enumerate pvr2d devices
Could not find the driver.  Make sure that the powervr driver has been loaded
Backtrace (1 deep):
0: bin/Xsgx [0x48038]

Fatal server error:
Segmentation fault caught

Aborted
beagleboard:/usr/X11R6_SGX# lsmod
Module                  Size  Used by
omaplfb                 8488  0
pvrsrvkm              292280  1 omaplfb
ipv6                  247228  24
beagleboard:/usr/X11R6_SGX# ls -la /dev/pvrsrvkm
crw-r--r-- 1 root root 249, 0 2009-03-17 11:41 /dev/pvrsrvkm
beagleboard:/usr/X11R6_SGX#


---------

No other X server is running. This is all begin done as root, so I don't
think there are permission issues. strace'ing the server shows that it
opens the driver file, then attempts a couple of IOCTLs that fail.

So, what am I missing? Is there some firmware/slushware/??? file that
needs to be be made available to initialize the hardware?



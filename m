From: Paul Walmsley <paul@pwsan.com>
Subject: commit 6797b4f causes boot hangs with nfsroot
Date: Sat, 16 Mar 2013 19:39:48 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303161925410.26959@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:33955 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab3CPTjt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Mar 2013 15:39:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jon-hunter@ti.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org


Hi Jon,

Looks like commit 6797b4fe0e554ce71f47038fd929c9ca929a9f3c ("ARM: OMAP2+: 
Prevent potential crash if GPMC probe fails") causes hangs on boot.  I 
suspect it may only occur when the root filesystem is on NFS over 
GPMC-based Ethernet.

Here's the current state of affairs at v3.9-rc1 on the two boards that 
show the problem:

http://www.pwsan.com/omap/testlogs/test_v3.9-rc1/20130312100243/boot/2430sdp/2430sdp_log.txt
http://www.pwsan.com/omap/testlogs/test_v3.9-rc1/20130312100243/boot/37xxevm/37xxevm_log.txt

and here are the bootlogs after reverting 6797b4f:

http://www.pwsan.com/omap/testlogs/trace_boot_hang_3.9-rc/20130316132833/boot/2430sdp/2430sdp_log.txt
http://www.pwsan.com/omap/testlogs/trace_boot_hang_3.9-rc/20130316132833/boot/37xxevm/37xxevm_log.txt

... where the boards at least boot to userspace.  I don't know what's up 
with the NFS-related lock problems.  Those look like yet another bug that 
is presumably not OMAP-specific :-(

Care to take a look at the commit 6797b4f bug?


- Paul

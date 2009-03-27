From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Latest l-o and usb gadget + NFS root problems
Date: Fri, 27 Mar 2009 11:40:21 +0200
Message-ID: <1238146821.28118.36.camel@tubuntu>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:58747 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177AbZC0Jk4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Mar 2009 05:40:56 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2R9ejL1010754
	for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2009 04:40:53 -0500
Received: from [172.21.42.218] (esdhcp042218.research.nokia.com [172.21.42.218])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n2R9eMIF014105
	for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2009 11:40:22 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

There seems to be something wrong with latest l-o, usb gadget ethernet
and nfsroot. I'm not sure when it broke, but 2.6.29-rc3 worked fine.
This happens to me with beagleboard and a non-public omap3 board:

g_ether gadget: high speed config #1: CDC Ethernet (ECM)
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
     device=usb0, addr=192.168.2.15, mask=255.255.255.0, gw=255.255.255.255,
     host=192.168.2.15, domain=, nis-domain=(none),
     bootserver=255.255.255.255, rootserver=192.168.2.14, rootpath=
Looking up port of RPC 100003/2 on 192.168.2.14
Looking up port of RPC 100005/1 on 192.168.2.14
VFS: Mounted root (nfs filesystem) on device 0:12.
Freeing init memory: 140K
nfs: server 192.168.2.14 not responding, still trying
nfs: server 192.168.2.14 not responding, still trying
...

With the nonpublic board I was able to boot up occasionally, but it
failed after doing something heavier on the nfs filesystem.

 Tomi



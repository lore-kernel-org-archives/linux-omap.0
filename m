From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Latest l-o and usb gadget + NFS root problems
Date: Fri, 27 Mar 2009 13:07:06 +0200
Message-ID: <1238152026.28118.38.camel@tubuntu>
References: <1238146821.28118.36.camel@tubuntu>
	 <7945E68B-8E2E-4B15-9198-3B3F16F0D10E@student.utwente.nl>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:43566 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166AbZC0LHl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Mar 2009 07:07:41 -0400
In-Reply-To: <7945E68B-8E2E-4B15-9198-3B3F16F0D10E@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Hi,

On Fri, 2009-03-27 at 11:38 +0100, ext Koen Kooi wrote:
> Op 27 mrt 2009, om 10:40 heeft Tomi Valkeinen het volgende geschreven:
> 
> > Hi,
> >
> > There seems to be something wrong with latest l-o, usb gadget ethernet
> > and nfsroot. I'm not sure when it broke, but 2.6.29-rc3 worked fine.
> > This happens to me with beagleboard and a non-public omap3 board:
> >
> > g_ether gadget: high speed config #1: CDC Ethernet (ECM)
> > IP-Config: Guessing netmask 255.255.255.0
> > IP-Config: Complete:
> >    device=usb0, addr=192.168.2.15, mask=255.255.255.0,  
> > gw=255.255.255.255,
> >    host=192.168.2.15, domain=, nis-domain=(none),
> >    bootserver=255.255.255.255, rootserver=192.168.2.14, rootpath=
> > Looking up port of RPC 100003/2 on 192.168.2.14
> > Looking up port of RPC 100005/1 on 192.168.2.14
> > VFS: Mounted root (nfs filesystem) on device 0:12.
> > Freeing init memory: 140K
> > nfs: server 192.168.2.14 not responding, still trying
> > nfs: server 192.168.2.14 not responding, still trying
> > ...
> >
> > With the nonpublic board I was able to boot up occasionally, but it
> > failed after doing something heavier on the nfs filesystem.
> 
> Are you running with lockdep enabled or disabled?

I was using default beagle defconfig, plus gadget eth compiled into
kernel. DEBUG_LOCKDEP seems to be off.

 Tomi



From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: USB slightly broken
Date: Fri, 19 Dec 2008 14:37:24 +0200
Message-ID: <20081219123724.GD7125@gandalf.research.nokia.com>
References: <1229682316.18039.12.camel@tubuntu> <20081219115838.GB7125@gandalf.research.nokia.com> <1229689738.18039.15.camel@tubuntu>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63921 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbYLSMiL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Dec 2008 07:38:11 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mBJCc2WX022939
	for <linux-omap@vger.kernel.org>; Fri, 19 Dec 2008 14:38:09 +0200
Content-Disposition: inline
In-Reply-To: <1229689738.18039.15.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: felipe.balbi@nokia.com, linux-omap <linux-omap@vger.kernel.org>

On Fri, Dec 19, 2008 at 02:28:58PM +0200, Tomi Valkeinen wrote:
> On Fri, 2008-12-19 at 13:58 +0200, Felipe Balbi wrote:
> > On Fri, Dec 19, 2008 at 12:25:16PM +0200, ext Tomi Valkeinen wrote:
> > > Yesterday's "Merge branch 'musb'" broke the USB slightly on our board. I
> > > use NFS root via USB gadget ethernet and if I have the usb cable
> > > connected when the device boots up, the network does not go up
> > > correctly. If I disconnect and connect the cable the USB starts working.
> > > 
> > > I can't currently test this on other boards, but I will test it on
> > > beagle later. 
> > > 
> > > g_ether gadget: high speed config #1: CDC Ethernet (ECM)
> > > IP-Config: Guessing netmask 255.255.255.0
> > > IP-Config: Complete:
> > >      device=usb0, addr=192.168.2.15, mask=255.255.255.0, gw=255.255.255.255,
> > >      host=192.168.2.15, domain=, nis-domain=(none),
> > >      bootserver=255.255.255.255, rootserver=192.168.2.14, rootpath=
> > > Looking up port of RPC 100003/2 on 192.168.2.14
> > > 
> > > (at this point the interface is up on PC side, but pings don't go through)
> > 
> > Could you try this patch: (untested)
> 
> This patch randomly fixes the problem and randomly crashes (usually
> crashes):

Will look at it. Thanks

-- 
balbi

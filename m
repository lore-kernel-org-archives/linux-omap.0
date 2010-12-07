From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: beagleboard-xm network with mainline?
Date: Tue, 7 Dec 2010 10:56:45 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1012071054430.10621@axis700.grange>
References: <Pine.LNX.4.64.1012071042220.10621@axis700.grange>
 <20101207094924.GP2576@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:60634 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755036Ab0LGJ4t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 04:56:49 -0500
In-Reply-To: <20101207094924.GP2576@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Felipe

On Tue, 7 Dec 2010, Felipe Balbi wrote:

> Hi,
> 
> On Tue, Dec 07, 2010 at 10:42:45AM +0100, Guennadi Liakhovetski wrote:
> > I managed to bring a mainline 2.6.36 kinda kernel to run on my bbxm,
> > Debian rootfs in mmcblk0p2, but I'm getting no connection - neither over
> > the SMSC chip, nor over usb-device in gadget mode, nor can I power on the
> > on-board hub to plug in a usb-to-eth dongle. What's the catch? How do I
> > configure the kernel to get any of those to work?
> 
> how about you try with current linux-omap HEAD ? Or linux-mainline HEAD ?

Sure, can try, but do you have a specific change in mind or is it just a 
general suggestion? Which interface should work then?

> Lots has changed since 2.6.36.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

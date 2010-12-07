From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: beagleboard-xm network with mainline?
Date: Tue, 7 Dec 2010 12:27:02 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1012071226130.10621@axis700.grange>
References: <Pine.LNX.4.64.1012071042220.10621@axis700.grange>
 <F7140194-3689-4011-A495-27480DAC0618@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:58416 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502Ab0LGL1E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 06:27:04 -0500
In-Reply-To: <F7140194-3689-4011-A495-27480DAC0618@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: linux-omap@vger.kernel.org

On Tue, 7 Dec 2010, Koen Kooi wrote:

> 
> Op 7 dec 2010, om 10:42 heeft Guennadi Liakhovetski het volgende geschreven:
> 
> > Hi
> > 
> > I managed to bring a mainline 2.6.36 kinda kernel to run on my bbxm, 
> > Debian rootfs in mmcblk0p2, but I'm getting no connection - neither over 
> > the SMSC chip, nor over usb-device in gadget mode, nor can I power on the 
> > on-board hub to plug in a usb-to-eth dongle. What's the catch? How do I 
> > configure the kernel to get any of those to work?
> 
> Give 
> http://gitorious.org/angstrom/angstrom-linux/commit/c908140c053071789dfa72f34bee76223ba9bdb7 
> a try.

Great, that works, thanks!

> The branch at 
> http://gitorious.org/angstrom/angstrom-linux/commits/koen/beagle-next 
> has a dozen or so patches to get all beagleboards working with 2.6.37rcX 
> from Tony.

Regards
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

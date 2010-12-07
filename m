From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: beagleboard-xm network with mainline?
Date: Tue, 7 Dec 2010 11:35:43 +0100
Message-ID: <F7140194-3689-4011-A495-27480DAC0618@dominion.thruhere.net>
References: <Pine.LNX.4.64.1012071042220.10621@axis700.grange>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59903 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413Ab0LGKft convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 05:35:49 -0500
Received: by wyb28 with SMTP id 28so13072593wyb.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 02:35:45 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1012071042220.10621@axis700.grange>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-omap@vger.kernel.org


Op 7 dec 2010, om 10:42 heeft Guennadi Liakhovetski het volgende geschreven:

> Hi
> 
> I managed to bring a mainline 2.6.36 kinda kernel to run on my bbxm, 
> Debian rootfs in mmcblk0p2, but I'm getting no connection - neither over 
> the SMSC chip, nor over usb-device in gadget mode, nor can I power on the 
> on-board hub to plug in a usb-to-eth dongle. What's the catch? How do I 
> configure the kernel to get any of those to work?

Give http://gitorious.org/angstrom/angstrom-linux/commit/c908140c053071789dfa72f34bee76223ba9bdb7 a try. The branch at http://gitorious.org/angstrom/angstrom-linux/commits/koen/beagle-next has a dozen or so patches to get all beagleboards working with 2.6.37rcX from Tony.

regards,

Koen
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: beagleboard-xm network with mainline?
Date: Tue, 7 Dec 2010 10:42:45 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1012071042220.10621@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56989 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730Ab0LGJmr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 04:42:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by axis700.grange (Postfix) with ESMTP id B5D45189AE2
	for <linux-omap@vger.kernel.org>; Tue,  7 Dec 2010 10:42:45 +0100 (CET)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi

I managed to bring a mainline 2.6.36 kinda kernel to run on my bbxm, 
Debian rootfs in mmcblk0p2, but I'm getting no connection - neither over 
the SMSC chip, nor over usb-device in gadget mode, nor can I power on the 
on-board hub to plug in a usb-to-eth dongle. What's the catch? How do I 
configure the kernel to get any of those to work?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

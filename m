From: Sung Hee Park <shpark7@stanford.edu>
Subject: omapfb: no driver for display
Date: Thu, 17 Feb 2011 19:17:24 -0800
Message-ID: <AANLkTi=f=SKE=QR97ttPnBrpW=2wNGd03+q4agmu6Uap@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49064 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020Ab1BRDRZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 22:17:25 -0500
Received: by wwa36 with SMTP id 36so3323358wwa.1
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 19:17:24 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, sumit.semwal@ti.com

Hi,

I found my frame buffer is not working while I'm testing the linux
kernel 2.6.38-rc5 on omap3evm, which used to work fine with 2.6.37.

Kernel command line: mem=128M console=ttyO0,115200n8 noinitrd rw
root=/dev/mmcblk0p2 rootfstype=ext3 rootwait omapfb.rot
ate=3 omapfb.vrfb=y vram=8M earlyprintk=serial,uart0,115200n8
omapdss.debug=1 omapfb.debug=1
OMAPFB: omapfb_init
OMAPFB: omapfb_probe
omapfb omapfb: no driver for display
omapfb omapfb: failed to setup omapfb

I found Kevin reported the similar issue here (
http://www.spinics.net/lists/linux-omap/msg44384.html ), and wondering
about whether I has been patched. Sumit, could you please let me know
if one of your recent patches would solve this problem? If it does,
which patches am I supposed to apply on 2.6.38-rc5?


Regards,
Sung Hee

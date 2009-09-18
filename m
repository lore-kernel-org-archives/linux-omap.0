From: Ming Lei <tom.leiming@gmail.com>
Subject: [BUG]: v2.6.31: always output black in beagle DVI LCD
Date: Fri, 18 Sep 2009 23:52:25 +0800
Message-ID: <d82e647a0909180852u13dc1751pc1ae88413707706@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f179.google.com ([209.85.222.179]:55100 "EHLO
	mail-pz0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbZIRPwV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Sep 2009 11:52:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Linux-ARM Kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-embedded@vger.kernel.org

Board: beagle B5
LCD: can show beagle logo in uboot

Once I upgrade to v2.6.31 from
         git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git

and apply the patch:
          omapfb: Reorder Register_framebuffer call
          http://marc.info/?l=linux-omap&m=125277326104621&w=2

the dvi lcd can't show anything but black colour. And from view of the monitor,
there is video signal outputed from beagle, which can be indicated the
green-led of
monitor.

Also the fb device(/dev/fb0) can be accessed well by my test code.

I can provide more information if anyone needs.

Thanks.

-- 
Lei Ming

From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: linux 3.6-rc2, undefined reference to omap_musb_mailbox
Date: Sat, 18 Aug 2012 18:04:19 +0200 (CEST)
Message-ID: <alpine.DEB.2.01.1208181741450.32497@pmeerw.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:52813 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772Ab2HRQEU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 18 Aug 2012 12:04:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org


3.6-rc2 fails to compile with
CONFIG_USB_MUSB_HDRC=m
CONFIG_USB_MUSB_OMAP2PLUS=m

  LD      init/built-in.o
drivers/built-in.o: In function `twl4030_usb_irq': 
/home/pmeerw/linux-3.6-rc2/drivers/usb/otg/twl4030-usb.c:518: undefined reference to `omap_musb_mailbox'
drivers/built-in.o: In function `twl4030_usb_phy_init':
/home/pmeerw/linux-3.6-rc2/drivers/usb/otg/twl4030-usb.c:540: undefined reference to `omap_musb_mailbox'
make[1]: *** [vmlinux] Error 1
make[1]: Leaving directory 
`/home/pmeerw/linux-3.6-rc2'

thanks, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)

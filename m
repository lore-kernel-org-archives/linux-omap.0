From: Kalle Valo <kalle.valo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] stlc45xx: wi-fi driver for stlc4550/4560 chipset
Date: Sat, 06 Dec 2008 19:32:05 +0200
Message-ID: <20081206173056.6853.95209.stgit@tikku>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

I would like to submit stlc45xx for inclusion to wireless-testing
tree. Currently the main users are Nokia N800 and N810 products.

Even though this driver has similarities with p54, I still think it
would be a good idea to have the driver in Linux mainline. Linux omap
community would benefit from this, having a wi-fi driver in the kernel
would make the use of N800 and N810 a lot easier. p54 support for these
chipsets is not finished yet.

There is still some work to do, for example, add necessary client power
save support to mac80211 and modify stlc45xx to use it. Also stlc45xx
does not yet use platform data to get all board specific settings, but
I will fix that later. And countless others which I don't list here.

Please consider including this driver to the wireless-testing tree.

---

Kalle Valo (1):
      Add stlc45xx, wi-fi driver for stlc4550/4560


 MAINTAINERS                          |    8 
 drivers/net/wireless/Kconfig         |    9 
 drivers/net/wireless/Makefile        |    2 
 drivers/net/wireless/stlc45xx.c      | 2594 ++++++++++++++++++++++++++++++++++
 drivers/net/wireless/stlc45xx.h      |  285 ++++
 drivers/net/wireless/stlc45xx_lmac.h |  434 ++++++
 6 files changed, 3332 insertions(+), 0 deletions(-)
 create mode 100644 drivers/net/wireless/stlc45xx.c
 create mode 100644 drivers/net/wireless/stlc45xx.h
 create mode 100644 drivers/net/wireless/stlc45xx_lmac.h

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

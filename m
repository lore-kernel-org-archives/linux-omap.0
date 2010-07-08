From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [patch-2.6.35-rc4+ 0/4] musb and ehci_omap patches
Date: Thu,  8 Jul 2010 14:02:58 +0530
Message-ID: <1278577982-30046-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Greg,

These are the bug fix patches recently acked by Felipe except one
on ULPI (PATCH 3/4) which is trivial.

Thanks,
Ajay

Ajay Kumar Gupta (3):
  usb: musb: fix compilation warning in host only mode
  usb: ulpi: fix compilation warning
  usb: ehci_omap: fix device detect issue with modules

Anand Gadiyar (1):
  usb: musb: use correct register widths in register dumps

 drivers/usb/host/ehci-omap.c    |   36 ++++++++++++++++++++++++++++++++++++
 drivers/usb/musb/musb_core.c    |    7 +++----
 drivers/usb/musb/musb_debugfs.c |   32 ++++++++++++++++----------------
 include/linux/usb/ulpi.h        |    1 +
 4 files changed, 56 insertions(+), 20 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/2] Fix rmmod for musb omap2430 glue layer
Date: Mon, 30 Nov 2015 21:37:11 -0800
Message-ID: <1448948233-31804-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

Here are two patches to fix rmmod for musb omap2430. This makes any
further work on this driver a bit easier.

Regards,

Tony


Tony Lindgren (2):
  usb: musb: core: Fix handling of the phy notifications
  usb: musb: Fix unbalanced pm_runtime_enable

 drivers/phy/phy-twl4030-usb.c     | 32 ++++++++++++++++----------------
 drivers/usb/musb/musb_core.c      | 21 +++++++++++++++++++++
 drivers/usb/musb/musb_core.h      |  2 ++
 drivers/usb/musb/omap2430.c       | 30 +++++++++++++++++-------------
 drivers/usb/phy/phy-twl6030-usb.c | 30 +++++++++++++++---------------
 include/linux/usb/musb-omap.h     | 30 ------------------------------
 include/linux/usb/musb.h          | 15 +++++++++++++++
 7 files changed, 86 insertions(+), 74 deletions(-)
 delete mode 100644 include/linux/usb/musb-omap.h

-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

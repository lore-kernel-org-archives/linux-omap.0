From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 00/10] Get MUSB PM runtime working again
Date: Thu, 28 Apr 2016 10:33:10 -0700
Message-ID: <1461864800-29979-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here's a series of fixes to get MUSB PM runtime working again.

I can now test PM runtime with the 2430 glue layer with this set,
so adding PM runtime support for other glue layers should be
possible.

Regards,

Tony


Tony Lindgren (10):
  usb: phy: Fix initial state for twl6030
  usb: musb: Fix idling after host mode by increasing autosuspend delay
  usb: musb: Fix PM runtime handling for connected cable
  usb: musb: Remove unnecessary shutdown function
  usb: musb: Fix PM runtime autosuspend
  usb: musb: Split PM runtime between wrapper IP and musb core
  usb: musb: Manage USB phy from PM runtime calls
  usb: musb: Remove try_idle for 2430 glue layer
  usb: musb: Fix PM runtime with delayed work
  usb: musb: Remove pm_runtime_set_irq_safe

 drivers/usb/musb/musb_core.c      |  67 ++++++----------
 drivers/usb/musb/musb_core.h      |   1 +
 drivers/usb/musb/musb_gadget.c    |  26 +++++--
 drivers/usb/musb/omap2430.c       | 155 +++++++++-----------------------------
 drivers/usb/phy/phy-twl6030-usb.c |  17 ++++-
 5 files changed, 93 insertions(+), 173 deletions(-)

-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
